---
title: "Hacking Summon 2.0 The Elegant Way"
source: "https://journal.code4lib.org/articles/10018"
author:
  - "[[The Code4Lib Journal]]"
published: 2014-10-21
created: 2025-01-10
description: "Libraries have long been adding content and customizations to vendor-provided web-based search interfaces, including discovery systems such as ProQuest’s Summon(™). Unlike solutions based on using an API, these approaches augment the vendor-designed user interface using library-provided JavaScript code. Recently, vendors have been implementing such user interfaces using client-centric model-view-controller (MVC) frameworks such as AngularJS, which [...]"
tags:
  - "clippings"
---
# Hacking Summon 2.0 The Elegant Way

Godmar Back, Annette Bailey

Libraries have long been adding content and customizations to vendor-provided web-based search interfaces, including discovery systems such as ProQuest’s Summon(™). Unlike solutions based on using an API, these approaches augment the vendor-designed user interface using library-provided JavaScript code. Recently, vendors have been implementing such user interfaces using client-centric model-view-controller (MVC) frameworks such as AngularJS, which are characterized by the use of modern software engineering techniques such as domain-specific markup, data binding, encapsulation, and dependency injection.

Consequently, traditional approaches such as reverse-engineering the document model (DOM) have become more difficult or even impossible to use because the DOM is highly dynamic, the templates used are difficult to discern, the vendor-provided JavaScript code is both encapsulated and partially obfuscated, and the data binding mechanisms impose a strict separation of model and view that discourages direct DOM manipulation. In fact, practitioners have started to complain that AngularJS-based websites such as Summon 2.0 are very difficult to enhance with custom content in a robust and efficient manner.

In this article, we show how to reverse-engineer the AngularJS-based Summon 2.0 interface to discover the modules, directives, controllers, and services it uses, and we explain how we can use AngularJS’s built-in mechanisms to create new directives and controllers that integrate with and augment the vendor-provided ones to add desired customization and interactions.

We have implemented several features that demonstrate our approach, such as a click-recording script, COinS and facet customization, and the integration of eBook public notes. Our explanation and code should be of direct use for adoption or as examples for other Summon 2.0 customers, but they may also be useful to anyone faced with the need to add enhancements to other vendor-controlled MVC-based sites.

## Background

In mid-2013, ProQuest released the first preview of Summon 2.0 to customers. Soon after, libraries who had made customizations to their old Summon 1.0 interface discovered that those customizations did not port easily to Summon 2.0 because of the underlying technology upon which Summon 2.0 was built. Summon 2.0 uses AngularJS, a modern model-view-controller (MVC) framework, which has drastically changed the way in which such web applications are built, and thus how they must be expanded and customized. To customize Summon 2.0, the vendor allows customers to include a JavaScript (.js) file in the web application that is being run. This facility was offered in response to customers who exploited an HTML sanitization bug in Summon 1.0’s configuration interface to inject their own JavaScript into the Summon 1.0 user interface. Because the customer-provided JavaScript code executes with the same privileges as the original vendor-provided JavaScript code, it has access to all parts of the user interface and can make arbitrary changes. Thus, this approach provides the (theoretical) ability to control and override any feature of the existing user interface, but doing so in practice in the Summon 2.0 interface turns out to be difficult.

## AngularJS

To help readers understand the techniques we have developed to augment the AngularJS-based Summon 2.0 user interface, we first discuss essential features of AngularJS. AngularJS is an MVC framework that supports the creation of the client side portion of a web application\[[1](https://journal.code4lib.org/articles/#enote1)\]. It has seen tremendous growth in the past few years. Because describing all aspects of AngularJS would exceed the scope of this article, the interested reader is referred to the [official documentation](https://docs.angularjs.org/)\[[2](https://journal.code4lib.org/articles/#enote2)\].

AngularJS uses HTML syntax to express the components of a web application, but it allows HTML to be extended with [custom directives](https://docs.angularjs.org/guide/directive)\[[3](https://journal.code4lib.org/articles/#enote3)\]. The directives can provide additional elements or additional attributes to elements. For instance, <div ng-show=”visible”>…</div> applies the built-in AngularJS directive ng-show to a <div> element, controlling its visibility based on the truth value of the variable visible. AngularJS provides many directives [out of the box](https://docs.angularjs.org/api/ng/directive)\[[4](https://journal.code4lib.org/articles/#enote4)\], but complex applications such as Summon define many more. Once defined, a directive can be reused many times – directives are thus similar to subroutines in ordinary programming.

AngularJS enforces relatively strict model/view separation. In AngularJS, the model state is kept in pure JavaScript objects, attached as properties to an object referred to as “scope.” Whenever the values of these variables change, AngularJS automatically updates any dependent views without the programmer needing to code the behavior explicitly. Using the example above, the programmer would simply set visible = true and the framework would change the visibility of the element in question. The use of pure JavaScript objects – as opposed to special objects provided by the framework – makes this automatic updating a bit more expensive for the framework since it needs to perform “dirty-checking” during so-called digest cycles whenever the values of model variables might have changed. Dirty-checking compares the last known value of a variable to its current value and triggers updates if it has changed. The big advantage to the programmer is that they do not need to change their JavaScript code to be aware of AngularJS. For instance, JavaScript objects obtained from parsing JSON delivered by an external service can be attached directly to scopes.

The ‘view’ in an AngularJS application is an HTML description of the user interface, controlled by model variables. These variables appear in AngularJS expressions and control aspects such as visibility, conditionals, repetition/loops, and others. AngularJS’s expression language is very similar to JavaScript in terms of its syntax and operators. To further simplify MVC-based application development, AngularJS supports two-way data bindings using the ng-model directive. For instance, <textarea ng-model\=“message”\></textarea> binds the variable message to the content of a textarea element displayed on the screen. This binding not only ensures that whatever the user enters into the textarea can be accessed via the current scope’s message property, but it also ensures that setting the scope’s message property from within AngularJS expressions, or from within JavaScript code, will update what is being displayed in the textarea.

AngularJS’s “controller” feature allows the addition of JavaScript code to further control the interaction between model and view. Unlike in other MVC frameworks, a controller is not strictly necessary since AngularJS’s plumbing is often sufficient to keep model and view in sync. AngularJS controllers are used to implement additional logic that cannot be expressed in AngularJS expressions or to interact with outside sources such as APIs. The result is often a single-page application, like Summon 2.0, where resources are loaded dynamically from the server and client-side code renders changes to the DOM on the fly. Compared to a traditional web app or website where the controlling logic is on the server side, like Summon 1.0, this type of application is faster to render and navigate.

Lastly, AngularJS enforces the use of a number of modern software engineering ideas that help with structuring the code in a modular way while providing strong encapsulation of individual modules and components. AngularJS uses “[dependency injection](http://en.wikipedia.org/wiki/Dependency_injection)”\[[5](https://journal.code4lib.org/articles/#enote5)\] – components such as controllers must explicitly declare which other components they intend to use in a given context. At runtime, those dependencies are then passed (“injected”) so that the code can run. Unlike the import feature in the module systems used in languages such as Python, this dependency injection allows control over which instances are injected at runtime. Consequently, a mock instance of a particular dependency can be injected during testing whereas the actual instance of a dependency is used at deployment time.

## Reverse Engineering Summon 2.0

Summon 2.0 currently defines about 84 directives, 71 services (of which 28 are mock services for testing), 21 controllers and about 10 filters. The components are defined in 38 modules (28 of which are solely for providing mock components during testing). We identified the names of these components by grepping the obfuscated JavaScript source code for statements such as

| 1 | `this``.angular.module(``"summonApp.directives"``).directive(``"doiLink"``, DoiLink)` |
| --- | --- |

This statement defines a directive `doi-link` inside the `summonApp.directives` module \[[6](https://journal.code4lib.org/articles/#enote6)\]. The majority of the user interface is expressed as individual directives. AngularJS provides multiple ways of defining directives, but Summon 2.0 mostly defines so-called template expanding directives, which primarily consist of HTML templates. For instance,

| 1  2  3  4  5  6  7  8 | `DoiLink = ``function``() {`  `return` `{`  `replace: ``true``,`  `template: ``'<a ng-href="[http://dx.doi.org/](http://dx.doi.org/){{doi}}" target="_blank">{{doi}}</a>'``,`  `scope: {`  `doi: ``"@"`  `}`  `};` |
| --- | --- |

defines a simple directive which, when invoked, will replace the element in which it occurs with a link to the DOI registry, based on the value passed to a doi attribute. It can be used by other directives, like “detail-row,” here:

| 1  2  3 | `<``li` `detail-row ``row-value``=``"document.dois[0]"` `… >`  `<``a` `… doi-link ``doi``=``"{{rowValue}}"``></``a``>`  `</``li``>` |
| --- | --- |

The camel-cased rowValue refers to the value of the attribute row-value, which in turn is tied directly to the first DOI (Digital Object Identifier) occurring in the API response to which the document variable refers. When the directive is applied, an <a> element that links to dx.doi.org is created.

Since embedding large amounts of HTML in JavaScript code would be awkward, most Summon 2.0 directives are instead defined in small, separate files. These so-called partial templates contain just the HTML for one directive. Each such partial is referred to using a templateURL attribute inside the directive in which it is used. For instance, the directive “detail-row” mentioned above is defined using templateUrl: “/assets/detailRow.html”

Summon currently uses 92 partial templates. To avoid having to fetch many small files during deployment, the Summon 2.0 developers combine all partials as [string literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Values,_variables,_and_literals#String_literals)\[[7](https://journal.code4lib.org/articles/#enote7)\] into a single JavaScript file (e.g., /assets/templates-f1fad2416306a297561379336e1f5644.js). When this file is loaded, the templates so defined are placed into AngularJS’s template cache and thus can be used without fetching the individual small files.

We exploit this design to reverse engineer Summon 2.0’s templates by including the templates into a separate AngularJS-based webpage, which then uses the [highlight.js](https://github.com/pc035860/angular-highlightjs)\[[8](https://journal.code4lib.org/articles/#enote8)\] package to display the templates in [syntax-highlighted form](http://libx.lib.vt.edu/services/summonvis/summon2.0/listtemplates.html)\[[9](https://journal.code4lib.org/articles/#enote9)\], as shown below:

[![Figure 1](https://journal.code4lib.org/media/issue26/back/Figure1.png)](https://journal.code4lib.org/media/issue26/back/Figure1.png)

**Figure 1.**

The figure shows the HTML code for the document-summary directive which displays information about individual documents returned in response to a user’s search. Using this method, we were able to obtain a general understanding of the Summon 2.0 user interface and could zoom in on areas of interest.

To inspect the model state that is accessible in a particular directive, we used a trick: we provided a second definition for the directive. In the AngularJS world, such a redefinition is also referred to as “stacking” directives. For instance, the code below provides a second definition for the document-summary directive:

| 1  2  3  4  5  6  7  8  9 | `angular.module(``'summonApp.directives'``).directive(``"documentSummary"``,`  `function``() {`  `return` `{`  `link:  ``function` `(scope) {`  `console.log(``"scope object in documentSummary directive:"``);`  `console.dir(scope);`  `}`  `}`  `});` |
| --- | --- |

The link method of the object returned by the function passed to the .directive method refers to what is called the  [postLink()](https://docs.angularjs.org/api/ng/service/$compile)\[[10](https://journal.code4lib.org/articles/#enote10)\] function. Invoking the postLink() function of a directive is the last step in AngularJS’s compilation and rendering process. In the postLink() function, a directive writer has the ability to add event handlers to the DOM to achieve desired functionality or to provide the facilities that will update the view if the model state changes. In this example, we simply log a snapshot of the scope object to the console.

AngularJS applies both the original and the added (stacked) directive definition whenever it encounters uses of document-summary in any template it processes. Since all directives applied to an element share the same scope, we can inspect the scope object that is used by the original definition, as shown below using the Chrome JavaScript console:

![Figure 2](https://journal.code4lib.org/media/issue26/back/Figure2.png)

**Figure 2.**

In the example, we see that the scope within a document-summary directive contains a document property that carries the metadata for the Summon document being displayed. This object was returned from the [Summon API](http://api.summon.serialssolutions.com/)\[[11](https://journal.code4lib.org/articles/#enote11)\] using JSON.

This approach to understanding the model state works most successfully if the directive in question either does not create a separate scope or creates a new child scope that prototypically inherits from the parent. [Prototypal inheritance](http://en.wikipedia.org/wiki/Prototype-based_programming)\[[12](https://journal.code4lib.org/articles/#enote12)\] is a feature unique to JavaScript in which scope objects inherit properties from a parent in a prototype chain but are able to override them upon assignment. To support stricter encapsulation, AngularJS also allows directives to create so-called isolate scopes which do not prototypically inherit from their parent scopes. Instead, the directive writer has to specify which properties should be passed into the directive’s scope. The majority of Summon 2.0 directives uses isolated scopes. When these are redefined, the new directive will not have access to the properties defined inside the original directive’s isolated scope. Rather, it will have access only to the properties defined in the scope where it is used. This detail is important to keep in mind, as trying to access properties that occur in an isolated scope is often tempting.

Moreover, if we redefine a directive that is itself used inside a directive that uses an isolated scope, the redefined directive will have access only to those properties that are included in its parent, rather than all properties that exist in ancestor scopes. To find and access such properties, it is necessary to follow the $parent chain of scopes, both when performing manual inspection with the Chrome debugger and when accessing those properties programmatically.

## Example Hacks

It is worth discussing why the traditional approach to adding user interface improvements while ignoring Summon’s use of AngularJS will not work. In static web pages like Summon 1.0, it was possible to trigger some code after the DOM of the page had been built, and for that code to examine the DOM which was then more or less stable until the page was reloaded. This approach fails in AngularJS because the DOM of the page is constantly being updated in response to changes in the model state. Moreover, the DOM is difficult to reverse engineer by inspection since much of it is generated by built-in or custom directives.

It is possible to exploit AngularJS’s scope $watch (or $watchCollection) facility to obtain notifications when the model state changes, for example, after the results of the search API have arrived. The watch listener fires also when the user engages the infinite scroll feature and more results are fetched from the API. However, [there is no way](https://github.com/angular/angular.js/issues/1306)\[[13](https://journal.code4lib.org/articles/#enote13)\] to know when AngularJS has completed updating the DOM in response to this change in model state. A timeout could be used as a work-around, but this is brittle and subject to flickering since the browser might make the changed DOM visible to the user before the timeout is executed. Instead, the modifications need to make use of AngularJS’s facilities.

### Technique 1: Changing templates on the fly

It is possible to change the templates that are placed in the template cache before they are being used. As an example, consider a modification that places [COinS](http://ocoins.info/)\[[14](https://journal.code4lib.org/articles/#enote14)\] inside an invisible container to suppress its display. COinS embed metadata that is processed both by metadata extractors such as Zotero and by accessibility tools such as LibX. LibX processes those COinS and adds a hyperlinked icon (a cue) that links to the OpenURL resolver. This functionality is generally redundant on the Summon page; we wish to suppress it. To achieve this, we need to change the portion of the `document-summary` template that places the COinS, which is shown below

| 1 | `<``span` `class``=``"Z3988"` `title``=``"{{doc.open_url}}"``>``</``span``>` |
| --- | --- |

such that it is wrapped into an outer, invisible span like so

| 1  2  3 | `<``span` `style``=``"display: none"``>`  `<``span` `class``=``"Z3988"` `title``=``"{{doc.open_url}}"``>``</``span``>`  `</``span``>` |
| --- | --- |

The following code accomplishes this via string replacement:

| 1  2  3  4  5  6  7 | `angular.module(``'summonApp'``).run([ ``'$templateCache'``, ``function` `(templateCache) {`  `var` `docSummary = ``"/assets/documentSummary.html"``;`  `var` `v = templateCache.get(docSummary);`  `v = v.replace(/(<span.*Z3988.*COinS --><\/span>)/,`  `"<span style='display: none'>$1</span>"``);`  `templateCache.put(docSummary, v);`  `}]);` |
| --- | --- |

This code is placed in the existing summonApp module as a run block, which is executed after the module has been initialized. The example shows how AngularJS implements dependency injection: access to the AngularJS [templateCache](https://docs.angularjs.org/api/ng/service/$templateCache)\[[15](https://journal.code4lib.org/articles/#enote15)\] service is provided by listing the name $templateCache inside an array whose last element is the function into which the service is passed as an argument.\[[16](https://journal.code4lib.org/articles/#enote16)\]

### Technique 2: Direct DOM Manipulation

In our second example, we wish to record when a user clicks on any of the links Summon 2.0 provides that lead to a discovered item. Summon 2.0 provides a fair number of such links, some of which are marked in red in the screenshot shown below:  
![Figure 3](https://journal.code4lib.org/media/issue26/back/Figure3.png)

**Figure 3.**

We needed to identify those links reliably and add event handlers that are invoked when they are clicked. This required special casing for each location where such links occur. Below we show the directive that handles the primary links occurring in the main and the preview panel.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17 | `function` `recordClicksOnPrimaryLinks() {`  `return` `{`  `link:  ``function` `(scope, iElement, iAttrs, controller, transcludeFn) {`  `iElement.find(``"h1.customPrimaryLinkContainer"``).on(``"click"``, ``function` `(event) {`  `var` `doc = scope.document \|\| (scope.preview && scope.preview.doc);`  `var` `id = doc && doc.id;`  `if` `(id !== undefined)`  `recordClick(id);`  `});`  `}`  `}`  `}`  `angular.module(``'summonApp.directives'``)`  `.directive(``"documentSummary"``, recordClicksOnPrimaryLinks)`  `.directive(``"preview"``, recordClicksOnPrimaryLinks);` |
| --- | --- | --- | --- |

We use the same code in both cases and redefine the document-summary and the preview directives. In this case, the original, template-based document-summary and preview directives have already added the <h1><a class\=“customPrimaryLink” … ></a></h1> element when the redefined directive’s postLink function is called, so an onclick event handler can be attached directly to that element. In the event handler, we retrieve the id of the document in question from the scope. If used inside the document summary, this id will be contained in the property document; for the preview pane, it will be in the preview.doc property. We found those by inspecting the scope object using the Chrome debugger. We used the same technique for the other links displayed on the results page.

The technique of using direct DOM manipulation inside a postLink() method comes with a big caveat, which is that the elements being manipulated must exist when the postLink() method is called. To see that this is not always true, consider the following failed attempt at implementing the COinS-hiding hack discussed earlier using direct DOM manipulation in a redefined document-summary definition:

| 1  2  3  4  5  6  7  8  9  10 | `angular.module(``'summonApp.directives'``).directive(``"documentSummary"``,`  `function``() {`  `return` `{`  `link:  ``function` `(scope, iElement, iAttrs, controller, transcludeFn) {`  `var` `$invisible = $(``"<span></span>"``).css(``"display"``, ``"none"``);`  `iElement.find(``".Z3988"``).wrap($invisible);`  `}`  `}`  `});` |
| --- | --- |

Even though the original, template-expanding document-summary directive had already been applied, the processing of its template was not yet complete. Specifically, an ng-repeat clause (<div ng-repeat\=“doc in availabilityDocs”) in which the COinS spans were nested had not yet been expanded. Since ng-repeat must re-render whenever the collection (here: availabilityDocs) changes, its rendering occurs inside a watcher function that is attached via $watchCollection. Despite the fact that the availabilityDocs field is already initialized when our directive’s postLink function is called, the accompanying DOM elements that result from the expansion of the ng-repeat directive do not yet exist (we discovered this by printing iElement.html()). There also is no way in AngularJS to receive a notification when the rendering of a particular directive is complete.

### Technique 3: Pure Model Interaction

In our third example, we consider how to implement localized logic for the facets Summon displays, as shown in figure 4.

![Figure 4](https://journal.code4lib.org/media/issue26/back/Figure4.png)

**Figure 4.**

When Summon 2.0 performs a search, facets such as Library Location are displayed in collapsed form, leaving some users confused about whether they can restrict their search by library location. One library desired a different behavior in which this facet is, by default, expanded. Once the user learns how to interact with those facets by collapsing or expanding them, it is desirable for the user interface to remember the user’s choice, which requires persisting the user’s choice across page reloads. The code below implements this functionality.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28 | `angular.module(``'summonApp.directives'``)`  `.service(``"facetStateSaverService"``, [``"storeService"``, ``function` `(storeService) {`  `this``.collapsed = storeService.bucket(``"collapsedFacets"``);`  `}])`  `.directive(``"facetField"``,`  `[``"facetsService"``, ``"facetStateSaverService"``, ``function``(facetService, facetState) {`  `return` `{`  `link:  ``function` `(scope) {`  `var` `facet = scope.facet;`  `var` `shouldBeCollapsed = facetState.collapsed.get(facet.label);`  `scope.$watch(``"facet.collapsed"``, ``function` `(nval, oval) {`  `if` `(nval == oval) ``return``;`  `facetState.collapsed.set(facet.label, nval);`  `});`  `if` `(shouldBeCollapsed != ``null``) {`  `if` `(shouldBeCollapsed != facet.collapsed)`  `facetService.toggleCollapsed(facet);`  `} ``else` `{`  `if` `(facet.label == ``"Library"` `&& facet.collapsed)`  `facetService.toggleCollapsed(facet);`  `}`  `}`  `}`  `}]);` |
| --- | --- |

We define a new service facetStateSaverService, which in turns imports a service Summon 2.0 provides (storeService). This service provides a simple facility to save and restore objects using the [HTML5 localStorage](http://diveintohtml5.info/storage.html)\[[17](https://journal.code4lib.org/articles/#enote17)\] facility; we use it here for convenience and to demonstrate how to inject existing Summon services into local customizations. We redefine the directive facet-field, which is used to render each facet. Inside this directive we interact with the AngularJS model state. The scope refers to a facet object whose attribute collapsed denotes whether the facet is currently collapsed. We observe changes of that attribute via scope.$watch, persisting any changes. If the user collapsed or expanded  the facet at least once, its last state is restored when the facet-field directive is rendered. Otherwise, if the facet refers to the Library Location, we expand the facet.

When restoring a facet’s collapse state, we do not simply set facet.collapsed, because we want to avoid collapsing facets that are currently applied. We use Summon’s provided facetService for this purpose. We inject the name and invoke its toggleCollapse() method to that end. The methods provided by this service, as well as others, are undocumented and were obtained by reverse-engineering ProQuest’s code. As such, our code may break if their implementation changes. Any such failure would be localized and result only in the loss of this particular feature.

### Technique 4: Injecting Your Own Directives

Our last example inserts public notes into Summon’s interface. This feature allows librarians to notify the public in a timely manner when a eBook resource goes down, or it allows the display of license restrictions related to accessing an eBook. In the image below, the message framed in green was inserted by our service.

![Figure 5](https://journal.code4lib.org/media/issue26/back/Figure5.png)

**Figure 5.**

We implemented a new directive for this feature, availability-additional-info, shown below:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27 | `angular.module(``'summonApp.directives'``)`  `.directive(``"availabilityAdditionalInfo"``,`  `[``"$http"``, ``function` `($http) {`  `return` `{`  `template: ``"<p ng-repeat='resource in resources'>"`  `+``"  <b>{{resource.name}}:</b>"`  `+``"  <span ng-bind-html='resource.msg'></span>"`  `+``"</p>"``,`  `link:  ``function` `(scope, iElement, iAttrs, controller, transcludeFn) {`  `scope.$watch(``"type"``, ``function` `(type) {`  `switch` `(type) {`  `case` `"rta"``:`  `case` `"fulltext"``:`  `var` `doc = scope.avDoc;`  `if` `(``'isbn'` `in` `doc)`  `+ doc.isbn + ``"?callback=JSON_CALLBACK"``)`  `.success(``function` `(data) {`  `scope.resources = data.resources;`  `});`  `}`  `break``;`  `}`  `});`  `}`  `}`  `}])` |
| --- | --- |

This availability-additional-info directive uses an HTML template and AngularJS directives ($http) in the same way as if we had full control of the Summon 2.0 front-end. It contacts a [JSON-P](http://en.wikipedia.org/wiki/JSONP)\[[18](https://journal.code4lib.org/articles/#enote18)\] service we provide and inserts the resources property of the returned JSON object into the scope so that the corresponding display can be rendered\[[19](https://journal.code4lib.org/articles/#enote19)\]. This directive is added to the availability directive’s template using the template cache technique described earlier:

| 1  2  3  4 | `var` `availability = ``"/assets/availability.html"``;`  `var` `v = templateCache.get(availability);`  `v = v.replace(/(<\/div>)\n$/, ``"<span availability-additional-info></span>$1"``);`  `templateCache.put(availability, v);` |
| --- | --- |

Since this directive will be used inside the availability directive, it must be adapted in two ways: the document whose ISBN should be used must be extracted from the avDoc property of the surrounding scope. In addition, we wish to display this message only if the type of the resource is fulltext. Since the type property is computed inside the postLink function of the surrounding availability directive, we perform this action inside a $watch callback once type becomes available.

## Risks

By now the curious reader may be wondering: What could possibly go wrong with writing code that directly interfaces with vendor code as we have presented? A moderate number of things, it turns out.

First, hosting an external script requires that the server hosting the script is at least as available as the Summon service. Since its JavaScript is executed synchronously (and must be for our techniques to work!), an unavailable server will result in lengthy delays since the client will time out before executing the remaining JavaScript in the Summon page.

Second, any syntax error in the script, or any runtime error thrown in a config or run block that was added to a [module](https://docs.angularjs.org/guide/module)\[[20](https://journal.code4lib.org/articles/#enote20)\], will prevent the initialization of the module, causing the entire UI to fail and the user to see a white page. As a precaution, we recommend wrapping such critical blocks in try/catch clauses to prevent errors from propagating. To avoid syntax errors, we are using a technique where experimental versions of our scripts are seen only by debugging users, which we identify using a cookie whose value determines the version of the script served (via an [Apache mod\_rewrite](http://httpd.apache.org/docs/2.2/rewrite/intro.html#rewritecond)\[[21](https://journal.code4lib.org/articles/#enote21)\] directive). A special value *empty* instructs Apache to serve an empty script, turning off all modifications.

Third, we have encountered rare, but extremely difficult to debug problems in two instances. When we initially deployed Summon 2.0, librarians noticed that the legacy, GET-based Summon 1.0 search boxes had ceased to work. Summon 2.0 implements compatibility with these search forms by examining the URL in its window.location variable and executing a search if necessary. Instead of using the recommended [$location](https://docs.angularjs.org/guide/$location)\[[22](https://journal.code4lib.org/articles/#enote22)\] service, Summon’s implementors directly accessed window.location. In doing so, they introduced a subtle dependency on when the $location service [was first instantiated](https://docs.angularjs.org/guide/services)\[[23](https://journal.code4lib.org/articles/#enote23)\]. When we injected $location into an entirely unrelated run block, we subsequently caused the page not to execute the search. The second instance concerned when a Summon directive’s template uses both the reload: true option (which says that this directive’s template should replace the element to which it is applied) and if it contains an ng-if directive that evaluates to true (see [Issue #8748](https://github.com/angular/angular.js/issues/8748)) \[[24](https://journal.code4lib.org/articles/#enote24)\]. In this case, stacked directives are not executed, causing those techniques that rely upon redefinition of directives not to work.

## Summary

We have presented four techniques we used to extend an existing AngularJS application (Summon 2.0) that was not originally designed for such extensions. Based on limited reverse engineering of the application’s structure, in particular its use of template-expanding directives, we were able to devise a number of ways in which the behavior of this application can be changed and improved in a seamless manner.

Like all code that interacts with web pages whose implementation is controlled by another party, our code is subject to potential failure if their implementation changes. However, any such failure is likely to be local, affecting only features that depend on a particular template or service. Because our techniques rely only on AngularJS features whose behavior is documented, they are likely to work in future versions of AngularJS. Our “hacks” are fully integrated into AngularJS’s processing, specifically its dirty-checking process that provides the plumbing that keeps model state and the rendered view in sync. As a result, flickering effects are minimized and there is no potential for timing dependencies or race conditions.

## Related Work

The idea to mash enhancing content or customizations into vendor-provided interfaces dates back several years ([Schmidt, 2013](https://journal.code4lib.org/articles/#eref12)). For instance, many libraries use tools from LibraryThing to enrich bibliographic records displayed in their OPAC with information that ranges from tables of contents to suggestions of reading based on the item the user is currently viewing ([LibraryThing](https://journal.code4lib.org/articles/#eref6)). Syndetics, a company later acquired by ProQuest, formed a business around including book covers and other information, now offered as Proquest’s Syndetics Solutions Enrichment Elements ([Proquest](https://journal.code4lib.org/articles/#eref9)). Librarians have also used this technique: for instance, Oldham’s work demonstrates how to add user interface improvements to the University of Guelph’s instance of Primo, a discovery product that competes with Summon ([Oldham, 2014](https://journal.code4lib.org/articles/#eref7)). Klein’s article “Hacking Summon” explains how Oregon State University was able to quickly roll “hacks” to improve the Summon 1.0 user experience ([Klein, 2010](https://journal.code4lib.org/articles/#eref5)). Reidsma developed open source code that allows customers to gather click information from the Summon 1.0 interface ([Reidsma, 2012a-b](https://journal.code4lib.org/articles/#eref10)). All of these examples mentioned were implemented using traditional techniques, such as DOM manipulation.

Electronic resource librarians benefit from the ability to modify vendor interfaces not only because it allows them to cosmetically improve their user’s experience, but also to improve collections management tasks and statistics. For instance, Reidsma’s code was used by Pattern at the University of Huddersfield to collect and analyze usage patterns and statistics from Summon users ([Pattern, 2012](https://journal.code4lib.org/articles/#eref8)).

The ability to manipulate a vendor user interface also facilitates the roll-out of entirely new services. For instance, prior to our work, Jing embedded links in Summon 1.0 to a licensing database that she created ([Jing, 2014](https://journal.code4lib.org/articles/#eref4)). This feature allowed users to find detailed license information about the resource being linked to.

Lastly, librarians actively study the features provided by modern discovery systems. As an example, Fyn et al. studied students’ acceptance of and use of the Database Recommender feature in Summon ([Fyn, 2013](https://journal.code4lib.org/articles/#eref1)), which promotes a database from a predefined list at the top of the display of search results.

These examples show that there is a great need for, and tremendous potential benefit from, being able to improve vendor user interfaces to collect data and statistics, implement new services, and facilitate user studies that contribute to a better understanding and improvement of the services librarians provide to their community.

## Acknowledgements

We are indebted to the Summon user community for ideas and discussion regarding the hacks we presented. We would also like to thank Sara Amato for her feedback and help in shepherding the paper, and Jason Thomale for his excellent editing.

## Notes

\[[1](https://journal.code4lib.org/articles/#note1)\] Officially, Google refers to AngularJS as a MVW (“Model-View-Whatever”) framework to sidestep the largely philosophical discussion of whether it is closer to a traditional MVC (“Model-View-Controller”), or a MVVM (“Model-View-ViewModel”) or MVP (“Model-View-Presenter”) approach.

\[[2](https://journal.code4lib.org/articles/#note2)\] [https://docs.angularjs.org/api](https://docs.angularjs.org/api)

\[[3](https://journal.code4lib.org/articles/#note3)\] [https://docs.angularjs.org/guide/directive](https://docs.angularjs.org/guide/directive)

\[[4](https://journal.code4lib.org/articles/#note4)\] [https://docs.angularjs.org/api/ng/directive](https://docs.angularjs.org/api/ng/directive)

\[[5](https://journal.code4lib.org/articles/#note5)\] [http://en.wikipedia.org/wiki/Dependency\_injection](http://en.wikipedia.org/wiki/Dependency_injection)

\[[6](https://journal.code4lib.org/articles/#note6)\] By convention, the camelCased name doiLink in the definition corresponds to the hyphenated directive doi-link when invoked.

\[[7](https://journal.code4lib.org/articles/#note7)\] [https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Values,\_variables,\_and\_literals#String\_literals](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Values,_variables,_and_literals#String_literals)

\[[8](https://journal.code4lib.org/articles/#note8)\] [https://github.com/pc035860/angular-highlightjs](https://github.com/pc035860/angular-highlightjs)

\[[9](https://journal.code4lib.org/articles/#note9)\] [http://libx.lib.vt.edu/services/summonvis/summon2.0/listtemplates.html](http://libx.lib.vt.edu/services/summonvis/summon2.0/listtemplates.html)

\[[10](https://journal.code4lib.org/articles/#note10)\] [https://docs.angularjs.org/api/ng/service/$compile](https://docs.angularjs.org/api/ng/service/$compile)

\[[11](https://journal.code4lib.org/articles/#note11)\] [http://api.summon.serialssolutions.com/](http://api.summon.serialssolutions.com/)

\[[12](https://journal.code4lib.org/articles/#note12)\] [http://en.wikipedia.org/wiki/Prototype-based\_programming](http://en.wikipedia.org/wiki/Prototype-based_programming)

\[[13](https://journal.code4lib.org/articles/#note13)\] [https://github.com/angular/angular.js/issues/1306](https://github.com/angular/angular.js/issues/1306)

\[[14](https://journal.code4lib.org/articles/#note14)\] [http://ocoins.info/](http://ocoins.info/)

\[[15](https://journal.code4lib.org/articles/#note15)\] [https://docs.angularjs.org/api/ng/service/$templateCache](https://docs.angularjs.org/api/ng/service/$templateCache)

\[[16](https://journal.code4lib.org/articles/#note16)\] AngularJS provides multiple methods of achieving the same goal, which can be confusing. They are discussed [here](https://docs.angularjs.org/guide/di) ([https://docs.angularjs.org/guide/di](https://docs.angularjs.org/guide/di)). Our example uses the “Inline Array Annotation” method.

\[[17](https://journal.code4lib.org/articles/#note17)\] [http://diveintohtml5.info/storage.html](http://diveintohtml5.info/storage.html)

\[[18](https://journal.code4lib.org/articles/#note18)\] [http://en.wikipedia.org/wiki/JSONP](http://en.wikipedia.org/wiki/JSONP)

\[[19](https://journal.code4lib.org/articles/#note19)\] We would have liked to use AngularJS’s [$resource](https://docs.angularjs.org/api/ngResource/service/$resource) service, but it is not included in Summon 2.0.

\[[20](https://journal.code4lib.org/articles/#note20)\] [https://docs.angularjs.org/guide/module](https://docs.angularjs.org/guide/module)

\[[21](https://journal.code4lib.org/articles/#note21)\] [http://httpd.apache.org/docs/2.2/rewrite/intro.html#rewritecond](http://httpd.apache.org/docs/2.2/rewrite/intro.html#rewritecond)

\[[22](https://journal.code4lib.org/articles/#note22)\] [https://docs.angularjs.org/guide/$location](https://docs.angularjs.org/guide/$location)

\[[23](https://journal.code4lib.org/articles/#note23)\] [https://docs.angularjs.org/guide/services](https://docs.angularjs.org/guide/services)

\[[24](https://journal.code4lib.org/articles/#note24)\] [https://github.com/angular/angular.js/issues/8748](https://github.com/angular/angular.js/issues/8748)

## References

[Fyn AF, Vera Lux and Robert JS.](https://journal.code4lib.org/articles/#ref1) 2013. Reflections on teaching and tweaking a discovery layer. Reference Services Review 41(1):113-124.

Hevery M. 2009. Building Web Apps with Angular. OOPSLA. Orlando, FL: Association for Computing Machinery.  [http://www.oopsla.org/oopsla2009/program/demonstrations/254-building-web-apps-with-angular-2-of-2](http://www.oopsla.org/oopsla2009/program/demonstrations/254-building-web-apps-with-angular-2-of-2 "http://www.oopsla.org/oopsla2009/program/demonstrations/254-building-web-apps-with-angular-2-of-2")

Hevery M, Abrons A. 2009. Declarative web-applications without server: demonstration of how a fully functional web-application can be built in an hour with only HTML, CSS & Javascript Library. Proceedings of the 24th ACM SIGPLAN conference companion on Object oriented programming systems languages and applications. Orlando, Florida, USA: ACM.

[Jing J. 2014.](https://journal.code4lib.org/articles/#ref4) Adding copyright/license information to different library systems. ALA. Las Vegas, NV. \[cited 2014 September 09\]. Available from: [http://www.slideshare.net/happyrainb/ala2014](http://www.slideshare.net/happyrainb/ala2014)

[Klein MB. 2010.](https://journal.code4lib.org/articles/#ref5) Hacking Summon. The Code4Lib Journal 11. \[cited 2014 September 09\]. Available from: [http://journal.code4lib.org/articles/3655](https://journal.code4lib.org/articles/3655)

[LibraryThing.](https://journal.code4lib.org/articles/#ref6) LibraryThing for Libraries \[Internet\]. \[cited 2014 September 29\]. Available from: [https://www.librarything.com/forlibraries](https://www.librarything.com/forlibraries)

[Oldham R. 2014.](https://journal.code4lib.org/articles/#ref7) Hacking Your Discovery Layer. Computers in Libraries. Washington, DC. \[cited 2014 September 09\]. Available from: [http://www.infotoday.com/cil2014/session.asp?ID=A105](http://www.infotoday.com/cil2014/session.asp?ID=A105)

[Pattern D. 2012.](https://journal.code4lib.org/articles/#ref8) Relevancy Rules. Self-Plagiarism is Style. \[cited 2014 September 09\]. Available from: [http://www.daveyp.com/2012/05/06/relevancy-rules/](http://www.daveyp.com/2012/05/06/relevancy-rules/)

[Proquest.](https://journal.code4lib.org/articles/#ref9) Syndetics Solutions, Enrichment Elements \[Internet\]. \[cited 2014 September 29\]. Available from: [http://proquest.syndetics.com/Marketing/Detail/EnrichmentElement](http://proquest.syndetics.com/Marketing/Detail/EnrichmentElement)

[Reidsma M. 2012a.](https://journal.code4lib.org/articles/#ref10) Guerrilla Analytics. Matthew Reidsma. \[cited 2014 September 09\]. Available from: [http://matthew.reidsrow.com/articles/24](http://matthew.reidsrow.com/articles/24)

[Reidsma M. 2012b.](https://journal.code4lib.org/articles/#ref11) Summon-Stats. \[cited 2014 September 09\]. Available from: [https://github.com/mreidsma/Summon-Stats](https://github.com/mreidsma/Summon-Stats)

[Schmidt K, Elguindi AC.](https://journal.code4lib.org/articles/#ref12) 2013. Discovery systems, layers and tools, and the role of the electronic resources librarian. Electronic Resource Management: Practical Perspectives in a New Technical Services Model. Chandos Publishing. p. 109-139.

## About the Authors

**Godmar Back** is Associate Professor of Computer Science at Virginia Tech, where he has been doing research and teaching in Computer Science since 2004. Dr. Back obtained his PhD from the University of Utah and worked as a post-doctoral scholar at Stanford University. His research interests are diverse, including operating systems, virtualization, web technology, scientific computing, programming languages, and library information systems.

He is an active collaborator with librarians in the area of advancing library technology to ensure that modern technology can find its way into the library sphere. Since 2007, he has been involved in the LibX project, providing technical supervision and input.  Recently, he has been leading the LibFX project ([libfx.lib.vt.edu](http://libfx.lib.vt.edu/)) which creates online visualizations of real-time library usage.

**Annette Bailey** is currently the Assistant Director for Electronic Resources and Emerging Technology Services for the Jean Russell Quible Department of Collections and Technical Services at Virginia Tech. Bailey serves on the Program Planning Committee for the ER&L Conference. She co-developed the open source LibX plug-in, for which she received the 2007 LITA Brett Butler Entrepreneurship Award.  She won a National Leadership Grant in 2006 for LibX and in 2008 for LibX 2.0. Her role in Collections Technical Services is to ensure best practices are implemented as workflows and data change for electronic resources.