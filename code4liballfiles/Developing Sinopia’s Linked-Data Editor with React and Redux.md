---
title: "Developing Sinopia’s Linked-Data Editor with React and Redux"
source: "https://journal.code4lib.org/articles/14598"
author:
  - "[[The Code4Lib Journal]]"
published: 2019-08-09
created: 2025-01-10
description: "An important software product for the Linked-Data for Production phase 2 grant from the Mellon foundation was the creation of a linked-data editor that professional cataloging staff would use to create original RDF descriptions of their collections. Using the Bibframe Editor from the Library of Congress as inspiration, the Stanford University Library-based software development team [...]"
tags:
  - "clippings"
---
# Developing Sinopia’s Linked-Data Editor with React and Redux
Jeremy Nelson

An important software product for the Linked-Data for Production phase 2 grant from the Mellon foundation was the creation of a linked-data editor that professional cataloging staff would use to create original RDF descriptions of their collections. Using the Bibframe Editor from the Library of Congress as inspiration, the Stanford University Library-based software development team are actively building a React/Redux linked-data editor for use by a cohort of national, academic, and special libraries. A very popular combination for front-end Javascript applications, this article will explain how React and Redux are used with great success in the editor’s implementation of a domain-specific-language (DSL) called Profiles containing one or more resource templates that specify an HTML form-based user interface for cataloging using RDF.

## Background of Sinopia

Funded by the Andrew W. Mellon Foundation as part of the LD4P (Linked Data for Production) grant, [Sinopia](https://sinopia.io/), available at [sinopia.io](https://sinopia.io/), is an open-source, cloud-based collaborative linked-data cataloging environment that could be used in a production environment. The Sinopia project’s primary software development team are members of the Stanford University Libraries with Michelle Futornick the project owner, prioritizing user needs and requirements in an iterative manner following [Agile](https://github.com/jermnelson/developing-sinopia-editor-react-redux/blob/master/doc/outline.md#AGLE1) software practices.

The Agile development methodology provides an approach and processes for responding to changes in requirements or environment by emphasizing flexibility and adapting to those changes. Specific Agile practices of the Stanford development team include pair programming, testing, stand-up meetings, planning sessions, and sprints. In pair programming two or more developers collaborate together to code or solve specific problems by having one programmer type while both developers talk through the problem together, thereby increasing code comprehension and knowledge transfer within the team. Another critical Agile practice used by the Sinopia development team is creating unit tests for specific Javascript modules in addition to integration tests that test interactions between multiple components and modules in the code base through scripting actions in a headless web browser. The Sinopia development team also has daily stand-up meetings where the developers check-in with each other and the product owner on progress and challenges encountered in the previous day, as well as plan for the upcoming day. Finally, the Sinopia team is organized in one to two week sprints that attempt to accomplish specific goals and tasks within the sprint. Each sprint also includes a planning meeting at the beginning of the sprint and weekly storytime meeting where challenges and issues that often required the project owner’s feedback and decisions that are then incorporated into the sprint development.

At the start of the Sinopia project, the decision made by the team was to build the linked data editor based on the previous development work done by the Library of Congress in the creation of their [BIBFRAME Editor](http://bibframe.org/bfe/) or BFE along with supporting projects like the [BIBFRAME Profile Editor](https://github.com/lcnetdev/profile-edit) and [Verso](https://github.com/lcnetdev/verso). The Library of Congress catalogers have been using the BFE for cataloging books and other materials in specific workflows related to the Library of Congress infrastructure. Christina Harlow, now at Temple University, created Sinopia’s architecture starting with a forked version of the Library of Congress BIBFRAME Profile in [Amazon Web Services](https://aws.amazon.com/) (AWS) with the Linked Data Editor to follow. Because the initial BFE codebase was a monolithic Javascript module and the BFE lacked any unit or integration tests, it was decided that a hard fork of the BFE code base for Sinopa Linked Data Editor was necessary in order to address design and implementation shortcomings present in the BFE. In addition, a new backend architecture was necessary that leveraged AWS services like [Cognito](https://aws.amazon.com/cognito/), a user authentication service, and to host an instance of [Trellis](https://www.trellisldp.org/), a linked-data platform that allows the use of a Postgres relational database to store the output of the Linked Data Editor.

Two partners in the Sinopia project provide an important service called [Questions Authorities](https://github.com/samvera/questioning_authority) (QA), a joint project of Cornell University and the University of Iowa. QA is an API service that queries Lucene indexes of both RDF and non-RDF datastores and returns JSON data of the results. This service provides an intermediary source of lookup data for the Library of Congress [subject](http://id.loc.gov/authorities/subjects.html) and [name](http://id.loc.gov/authorities/names.html) authorities, the Getty Linked Data [vocabularies](http://www.getty.edu/research/tools/vocabularies/lod/) and [ShareVDE](http://www.share-vde.org/).

## Functional Javascript

Within the programming community, the ubiquity of Javascript as the default programming language for scripting websites and applications means most developers have at least a passing knowledge of the language. While client-side manipulation of the HTML DOM (document object model) has changed over the years with the introduction of Javascript libraries like [JQuery](https://jquery.com/) and the continued addition of different supported technologies, Javascript has morphed into a server-side language with the emergence of the [Node.js](https://nodejs.org/en/) ecosystem.

Sinopia uses ECMAScript features and conventions that are then converted into Javascript using the [Babel](https://babeljs.io/) compiler. ECMAScript 6 features used in Sinopia include class declarations such` class Input {...}`, importing of Javascript modules like `import Input from './Input'` and to support the import, using the export feature like `export const Input`. Because Sinopia’s Linked Data Editor communicates in an asynchronous fashion with the Sinopia server back-end, the ECMAScript 7 and 8 features like Promises with `async` and `await` keywords are used in the code. Finally, Sinopia extensively uses the ECMAScript spread operator … for expanding passed arguments or elements to simplify object cloning like this expression `const newState = { ...state }` where newState is a clone of the existing state.  Sinopia also adopted the arrow function syntax `() => {}` throughout the code base.

Javascript supports multiple programming paradigms like imperative, object-oriented, and in the past ten years, the functional programming approach. The popularity of building functional React and Redux code for web browser and native user interfaces has encouraged the use of Javascript built-in `map` and `reduce` operators along with support for currying and other functional-friendly constructs like the `=>` arrow functional form.

The key insight in writing functional Javascript is focusing on functions with minimal side-effects and deterministic expectations that given a set of inputs, the function will always return the same set of outputs.

For example, a traditional Javascript function is declared using the `function` keyword:

| 1  2  3 | `function` `AddTwo (x,y) {`  `return` `x+y;`  `}` |
| --- | --- |

A more functional ECMAScript using the `const` keyword and arrow functional form looks like:

| 1  2  3 | `const AddTwo = (x,y) => {`  `return` `x+y`  `}` |
| --- | --- |

Both of these `AddTwo` functions are equivalent in that they take two input parameters and return a single value. The `const` keyword for the second is a critical difference in that it creates an immutable function that cannot be reassigned to another function or variable in subsequent code, while defining the AddTwo function in the first form can be reassigned without the Babel compiler complaining. The `const` keyword reduces the opportunity for accidentally introducing bugs by preventing the developer from reassigning the function with potentially harmful or unintentional effects.

A Javascript Array is a list-like Object that contains two methods `[map](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/map)` and `[reduce](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Array/Reduce)` that helps in developing functional code for React components and Redux reducers. The `map` method returns a new Javascript array with the results of executing a function on every member in the original array. Using the arrow functional form with the map method results in simpler implementation code and is fully functional by taking two inputs, the array and an anonymous function defined with the arrow functional form, and returns a new array. In the example below, starting with an integer array, performing a `map` call returns a new Array `firstFiveSquared` with each value of the original Array raised to the second power:

| 1  2  3  4  5  6  7 | `const` `firstFive = [``1``,``2``,``3``,``4``,``5``]`  `const` `firstFiveSquared = firstFive.map(row => row**``2``)`  `console.log(firstFiveSquared)`  `Array(``5``) [ ``1``, ``4``, ``9``, ``16``, ``25` `]` |
| --- | --- |

The `reduce` method with the arrow functional form applies an anonymous function that reduces the members of the array to a single member object. In Sinopia, the `reduce` function is used in the `inputPropertySelector` function to go through a complex JSON hierarchy representing the current values of the React components in the user interface and either return the component’s items or an empty array based on the values of the component’s reduxPath.

| 1  2  3  4  5  6  7  8  9  10 | `const` `inputPropertySelector = (state, props) => {`  `const` `reduxPath = props.reduxPath`  `let items = reduxPath.reduce((obj, key) => (obj && obj[key] !== ``'undefined'` `? obj[key] : undefined), state.selectorReducer)`  `if` `(items === undefined) {`  `items = []`  `}`  `return` `items`  `}` |
| --- | --- |

## Resource Templates and Profiles

The Library of Congress’s [Bibframe Editor](http://bibframe.org/editor) is a BIBFRAME-focused linked-data editor that was an important source of inspiration for Sinopia. To support a wide range of cataloging use cases, the BFE followed a two-part strategy. First, a user creates a JSON profile containing one or more resource templates in the BIBFRAME Profile Editor. These templates can vary by the material being cataloged and are saved in the backend Verso middleware server from the Library of Congress. This template is then loaded into the BFE to generate different types of user interfaces depending on the requirements for the material. So, for example, a monograph profile contains resources templates for a BIBFRAME Work and Instance along with any supporting resource templates. A cataloger could then load into the BFE to catalog a Book Instance or Work. The profile JSON file containing one or more Resource Templates is in effect a Domain Specific Language (DSL) for generating the user interface needed by the user to catalog a specific type of BIBFRAME entity. The profile DSL, while developed for the BIBFRAME ontology, is generic enough that other linked-data vocabularies can be used in addition to BIBFRAME, though they must be specified within a resource template.

A resource template contains a number of properties that define properties such as the label to display in the user interface, a URI to use as the RDF type, and one or more properties contained in the propertyTemplate list. Sinopia, following the BFE’s example, only displays one top-level Resource Template at a time in the editor user interface. A source of confusion early on in the project arose when analyzing the Library of Congress set of profiles, as the ID of a profile was often duplicated as one of the IDs of the contained resource templates. This was fixed in later iterations of these Library of Congress profiles.

Here is an example of a resource template for a BIBFRAME Note that could then be referenced by other Resource Templates:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23 | `{`  `"id"``: ``"resourceTemplate:bf2:Note"``,`  `"resourceLabel"``: ``"Note"``,`  `"propertyTemplates"``: [`  `{`  `"propertyLabel"``: ``"Note"``,`  `"mandatory"``: ``"false"``,`  `"repeatable"``: ``"false"``,`  `"type"``: ``"literal"``,`  `"resourceTemplates"``: [],`  `"valueConstraint"``: {`  `"valueTemplateRefs"``: [],`  `"useValuesFrom"``: [],`  `"valueDataType"``: {},`  `"editable"``: ``"true"``,`  `"repeatable"``: ``"false"``,`  `"defaults"``: []`  `}`  `}`  `]`  `}` |
| --- | --- |

The source for constructing the actual React components containing the HTML inputs used by the Sinopia Linked Data Editor are the properties in the `propertyTemplates` list. Each property contains a `propertyURI` attribute that is used as the RDF predicate in the constructed RDF while the `propertyLabel` is displayed in the user interface either as an HTML label or as a placeholder in the HTML input. With the `resourceTemplate:bf2:Note` resource template above, Sinopia’s editor generates the following display:

![](https://journal.code4lib.org/media/issue45/nelson/Figure01-title-note.png)  
**Figure 1.** Title Note Property Panel.

After entering the text, “A great title note”, this resource template generates a RDF graph using a relative URI as seen here (when the user clicks the **Preview RDF button**):

![](https://journal.code4lib.org/media/issue45/nelson/Figure02-title-note-rdf-preview.png)  
**Figure 2.** RDF Preview Modal

Other attributes for the property include *mandatory* set to true if the property is required, and *repeatable* if the property can be duplicated. Early in the development of Sinopia, the decision was to limit and simplify what values are supported in the *type* property, with the simplest being `literal`, and the others being `lookup, list`, and `resource`. The literal property is for string values that are entered by the user, while the list and lookup types references typeahead components for searching and linking external entities and values in the user interface. The *valueConstraint* attribute contains a number of sub-attributes like *defaults*, as a list of one or more values that are used to pre-populate the values in the input fields.

The `resource` type is more complicated in that it references another Resource Template through the *valueConstraint*‘s *valueTemplateRefs* attribute. The *valueTemplateRefs* attribute is a list of one or more Resource Template IDs that are then used to embedded a Resource Template into the user interface so that the values entered act as a separate entity that is then linked to the calling property. When generating the RDF, a URI or blank-node of the embedded Resource Templates is positioned in the RDF object role with the original Resource Template as the RDF subject and the *propertyURI* property functioning as the RDF predicate.

Below is an example of a *propertyTemplate* with a type of resource that references the ID of the Resource Template above, `resourceTemplate:bf2:Note` in the *valueConstraint.valueTemplateRefs* attribute:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `{`  `"propertyLabel"``: ``"Notes about the Work"``,`  `"mandatory"``: ``"false"``,`  `"repeatable"``: ``"true"``,`  `"type"``: ``"resource"``,`  `"resourceTemplates"``: [],`  `"valueConstraint"``: {`  `"valueTemplateRefs"``: [`  `"resourceTemplate:bf2:Note"`  `],`  `"useValuesFrom"``: [],`  `"valueDataType"``: {},`  `"defaults"``: []`  `}`  `}` |
| --- | --- |

## React Components

An open-source project sponsored by Facebook, [React](https://reactjs.org/) is a Javascript library that wraps HTML elements in defined classes and functions for building user interfaces. React classes and functions are often defined in an extension of Javascript called JSX that is used to build components that can be assembled into larger, more complex user interfaces. For example, a relatively simple JSX component could represent a title on a page with an HTML H1 tag with a valid Javascript expression embedded between curly brackets:

| 1  2  3  4 | `const title = `  `<``h1``>Book Title: {title}</``h1``>` |
| --- | --- |

React components also have two important Javascript arrays called `props` and `state`. The `props` array contains read-only properties that can be referenced within the component itself using the curly braces syntax and are set when the component is constructed. Because the component’s `props` are read-only, this enforces the constraint that the `props` are immutable and follow a pure functional form. Creating React components in pure functional form is possible and often desired, using the ES6 Class syntax allows for more comprehensible code that extends the base `React.Component` class. A React component class must implement a `render` method that returns the desired Javascript.

The title Javascript expression above could be refactored as a simple ES6 Class by extending the `React.Component` and returning the HTML snippet with the title prop referenced using the `this` keyword indicating a class instance variable:

| 1  2  3  4  5  6  7  8  9 | `class Title extends React.Component {`  `render() {`  `return (`  `<``h1``>Book Title: {this.props.title}</``h1``>`  `)`  `}`  `}` |
| --- | --- |

If coming from object-oriented languages, the temptation might be to create a hierarchy of React components but this pattern is discouraged by the designers of React because React components are intended more for composition, where more complex React components are made-up of simpler components where the enclosing components pass properties down through the child’s initial props. To illustrate, here is a `Header` React component that contains other React components.

| 1  2  3  4  5  6  7  8  9  10  11  12 | `class Header extends React.Component {`  `render() {`  `return(`  `<``header``>`  `<``Title` `title={"Pride and Prejudice"} />`  `<``Author` `givenName={"Jane"} familyName={"Austen"} />`  `</``header``>`  `)`  `}`  `}` |
| --- | --- |

The `Header` component sets the title prop for the included `<Title>` and the `<Author>`‘s givenName and familyName props.  This could render HTML output to the web browser’s DOM like this:

| 1  2  3  4  5  6  7  8  9 | `<``header``>`  `<``h1``>Book Title: Pride and Prejudice</``h1``>`  `by Jane Austin`  `</``header``>` |
| --- | --- |

## Sinopia’s React Components

Sinopia’s React components are built as pure functions or as JSX Class Components. To build out the user interface for the Linked Data Editor, Sinopia uses a combination of third party React components along with custom React components in a hierarchy of components with  `<RootContainer>` being the top-level React component. The `<RootContainer>`imports the `<OffCanvas>` that is composed of two children, the `<OffCanvasBody>` and the `<OffCanvasMen>` components both from the [react-offcanvas](https://www.npmjs.com/package/react-offcanvas) module. The `<OffCanvasMenu>` presents a list of links to help and third-party resources displayed in a pane which is displayed when the Help and Resources link in the navigation bar is clicked. The other function of the `<RootContainer>` component is to connect the React user interface to the Redux state store.

The `<OffCanvasBody> `contains another React component from the react-router-dom third-party module that allows for the easy generation of a single-page application `<BrowserRouter>` [React](https://reactjs.org/) component that matches specific URL patterns into multiple routes for base route `/` to the homepage, the `/editor` route to editor forms, a `/templates` route that displays a list of available templates and to upload a new resource template. Other supporting routes include the `/login` to allow the user to authenticate using AWS Cognito, the `/menu` for the off-canvas help and resources page, and a *404* route for unmatched routes entered by the user.

```
 
<RootContainer>
  <OffCanvasBody>
    <BrowserRouter>
      <App>
  <OffCanvasMenu>
    <CanvasMenu>
```

On the Sinopia’s homepage, the top level React Components are outlined in the following image when the Help and Resources is clicked and the `OffCanvasMenu` is displayed:

![](https://journal.code4lib.org/media/issue45/nelson/Figure03.png)  
**Figure 3.** Sinopia RootContainer and OffCanvasBody.

## HomePage and User Authentication

When accessing Sinopia’s homepage at [sinopia.io](https://sinopia.io/), the` <App />` React component, using the `<Switch /> `and` <Route />` React components from the react-router-dom package, displays the <HomePage /> and the standard Sinopia `<Footer /> `React components. The `<HomePage />` component contains three children, the `<Header />`, `<NewsPanel />`, and the `<DescPanel />` React components. The homepage’s `<Header />` contains links to the `/templates` route, a link to Sinopia’s Profile Editor, and finally a link that activates the `<OffCanavsMenu />`‘s child’s `<CanvasMenu />`. The `<NewsPanel />` has a `<NewsItem />` that allows the product owner to make announcements by editing and then creating a pull request that can then be reviewed and then pushed to the AWS environments by the developers and system administrators. The `<DescPanel />` contains more general description of the Sinopia project and what the project hopes to accomplish during the grant period and after.

Amazon’s [Amplify SDK](https://aws-amplify.github.io/docs/js/api) is used to authenticate the user to the AWS Cognito service that then generates a valid [JSON Web Token](https://jwt.io/a) for user authentication in Sinopia and in Sinopia’s backend [Trellis](https://www.trellisldp.org/) Linked Data Platform. For the initial release of Sinopia, all catalogers are authorized to add, edit, or delete any resources stored in Trellis. This may change in future releases with more restrictive user rights for resources created in specific group containers within Trellis.

The React Component Hierarchy for the` <App />`‘s `<HomePage />`, `<LoginPanel />`, and `<Footer />` is:

```
 
<App>
  <LoginPanel>
    <Switch />
      <Route /> => <HomePage />
        <Header /> 
 	<NewsPanel />
        <NewsItem /> 
      <DescPanel /> 
  <Footer /> 
```

Below are these React Components diagrammed in a screen shot of Sinopia’s homepage at [sinopia.io](https://sinopia.io/):

![](https://journal.code4lib.org/media/issue45/nelson/Figure04.png)  
**Figure 4.** Sinopia Homepage Components.

#### **<HomePage />** **Child Components**

**`<Header>`**

The `<Header>` component for Sinopia’s homepage has a different navigation bar with links to the `<ImportResourceTemplate >`, Sinopia’s Profile Editor, and a link to activate the `<OffCanvasMenu>` to display the Help and Resources links.

**`<NewsPanel>` and `<NewsItem>`**

The `<NewsPanel>` component is composed of one `<NewsItem>` component that is a list of news items maintained by Sinopia’s product owner and usually includes recent items like new Sinopia releases, conferences or presentations about Sinopia, and other items of interest to the Sinopia’s community.

**`<DescPanel>`**

The `<DescPanel>` component is a short description of the goals for Sinopia and the partner institutions in this project.

### Resource Templates Upload and Listing

From Sinopia’s `<HomePage />`‘s `<Header />`, an authenticated cataloger is taken to the /templates route using the `<ImportResourceTemplate />` component containing a `<Header />` component, an `<ImportFileZone .>` component used to display and handle a button for catalogers to upload a JSON profile file containing one or more resource templates, and a `<SinopiaResourceTemplates />` component displaying an HTML table populated by resource templates contained either in a running instance of the Sinopia Server or the sample resource templates if running the Editor in USE\_FIXURES mode.

```
<App>
  <LoginPanel>
  <Switch />
    <Route /> => <ImportResourceTemplate />
      <Header /> 
      <ImportFileZone /> 
      <SinopiaResourceTemplates /> 
  <Footer />
```

![](https://journal.code4lib.org/media/issue45/nelson/Figure05.png)  
**Figure 5.** Linked Data Editor Resource Templates Tab with Components.

#### **<ImportResourceTemplate />** **Child Components**

**`<Header>`**

For both the `/templates` and `/editor` routes and components, the same <Header> component is used for displaying the navigation bar and the three tabs for the Browser, Editor, and Resource Templates. The `<Header>` component also contains three <NavLink> React components from the react-router-dom package that highlights the correct tab depending on the route being displayed in the editor.

**`<ImportFileZone />`**

The `<ImportFileZone />` component wraps a [third-party React component](https://github.com/jermnelson/developing-sinopia-editor-react-redux/blob/master/doc) that allows the cataloger to use their computer’s drag-and-drop feature to place a JSON Profile file containing one or more resource templates into the application. The Editor validates the profile and resource templates first before uploading the resource templates to the Sinopia Server with the results appearing in the `<SinopiaResourceTemplates />` component.

**`<SinopiaResourceTemplates />`**

The `<SinopiaResourceTemplates />` component is initialized with a call out to Sinopia Server’s Trellis linked data platform and loads all of the available resource templates for selection by the cataloger.

### **Linked Data Editor Tab**

When a user selects a resource template from the `<SinopiaResourceTemplates />` table, Sinopia loads the JSON Resource Template into a new instance of the `<Editor />`‘s `<ResourceTemplate />` component. In the `<ResourceTemplate />` component functioning as a container and connector to the Redux state, a` <ResourceTemplateForm />` creates a `<PropertyPanel />` for each property. The React component hierarchy is outlined below:

```
<PropertyTemplateOutline>
```

![](https://journal.code4lib.org/media/issue45/nelson/Figure06.png)**Figure 6.** Linked Data Editor Components with the Work Title Resource Template.

#### **<Editor /> Child Components**

**<RDFModal />**

Part of the `<Editor/>` is an HTML button labeled Preview RDF that when clicked shows a Bootstrap modal containing the generated RDF based on the Redux state of the application.

**<GroupChoiceModal />**

At any point when adding or editing the RDF for the entity, the cataloger clicks the Save & Publish button that brings up a pop-up modal that displays a drop-down list of institutions and organizations

**<ResourceTemplate />** and **<ResourceTemplateForm />**

The `<ResourceTemplate />` Component includes the label of the loaded resource template, that Preview RDF and Save & Publish buttons, and the `<ResourceTemplateForm />` that wraps one or more `<PropertyPanel />`. The `<PropertyLabel/>` component provides the text in the panel’s header with one or more optional styling using such components as the `<RequiredSuperscript />` to display a red asterisk for a required `<PropertyPanel />`.

#### **<PropertyPanel />** **Component**

For every property template in the loaded resource template, an instance of the `<PropertyPanel />` is rendered. Understanding how the `<PropertyPanel />` React component as a pure function is constructed illustrates how Sinopia is able to build an editing environment for RDF triples.

The first line in the `<PropertyPanel />` source code imports two Javascript classes from the React node.js module. The `PropTypes` import provides a means to check if the `<PropertyPanel />`‘s variable *props* are of a certain type. The third line imports the `<PropertyPanel />` component.

| 1  2  3 | `import` `React from ``'react'`  `import` `PropTypes from ``'prop-types'`  `import` `PropertyLabel from ``'./PropertyLabel'` |
| --- | --- |

The <PropertyPanel /> is a pure function with two constant variables, a *floatClass* that sets the panel div’s Bootstrap floating class to create two columns of <PropertyPanel />s, The *cssClasses* variable sets all of the CSS and includes the *floatClass* variable.

| 1  2  3  4 | `const PropertyPanel = (props) => {`  `const floatClass = props.float > 0 && props.float % 0 > 0 ? ``'pull-right'` `: ``'pull-left'`  `` const cssClasses = `panel panel-property ${floatClass}` ``  `}` |
| --- | --- |

Finally, the <PropertyPanel /> renders a combination of HTML elements and other React components, including any children stored in the props for the component instance. The <PropertyPanel /> doesn’t need to know or care what the children components are, just that the child React component render some content.

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `return` `(`  `<div className={ cssClasses } data-label={ props.pt.propertyLabel }>`  `<div className=``"panel-heading prop-heading"``>`  `<PropertyLabel pt={ props.pt } />`  `</div>`  `<div className=``"panel-body"``>`  `{ props.children }`  `</div>`  `</div>`  `)` |
| --- | --- |

- `<InputLiteral />` Component

The most basic HTML input in Sinopia is part of the `<InputLiteral />` React component. Depending on if the property template’s repeatable is true, the cataloger can enter multiple values that are displayed immediately below the HTML input element or only enter a single value. Each of those values can have a language attribute set and the value can be edited by clicking on the Edit button. Below is an example of a property template literal with multiple items:

![](https://journal.code4lib.org/media/issue45/nelson/Figure07.png)

**Figure 7.** Input Literal Component.

The challenge of representing a resource’s properties that include referencing a target Resource Template needs to be solved in the user interface when using these Profiles. In the Library of Congress BFE, the UI solution was to open a Modal that would render the target Resource Templates propertyTemplates. Those propertyTemplates often reference further Resource Resources that require a new pop-up Modal until the user loses the context with a whole series of Modals layered on top of one  another.

In an early prototype, Astrid Usong, Sinopia’s User Interface designer at Stanford Libraries, came up with different approach. Instead of using Modals, her design represented these relationships as an outline. When demonstrated during a Sinopia-focused pre-conference at the 2019 Code4Lib conference in San Jose, CA., the participants preferred the outline view over the pop-up modal because it was easier to keep the context of the target Resource Template in relation to the original Resource Template when editing a resource’s metadata. The outline view also provide a visual hierarchy built on familiar user interface tree where parent nodes can be expanded to reveal one or more component children.

To support this tree hierarchy of propertyTemplates one or more layers deep, the `<PropertyTemplateOutline>` React component is used and is composed of an `<OutlineHeader>` made-up of a collapsed plus-sign icon that when expanded shows any child components. The `<PropertyTemplateOutline>` contains either `<PropertyComponent>` made up of either `<InputLiteral>`, `<InputLookupQA>`, or `<InputListLOC>` , or a `<ResourceComponent>` that has `<PropertyActionButtons>` (containing an `<AddButton>` if the property template’s repeatable property is true) and one or more `<PropertyTemplateOutline>` components. When the `<ResourceComponent>` is expanded, a network call with the resource template ID is made to the Sinopia Server and the resource template JSON is retrieved and displayed in the expanded view of the resource, with each of the target resource template’s property templates having their own `<PropertyTemplateOutline>`.

## **Linking to Existing Sinopia Entities and Other Sources**

Sinopia is able to link to other sources through one or more custom [React](https://reactjs.org/) components that provide a typeahead input using a third party node.js module called [React Bootstrap Typeahead](http://ericgio.github.io/react-bootstrap-typeahead/).

### `**<InputListLOC>**` **Library of Congress id.loc.gov Component**

The Library of Congress’s Linked Data Service at [http://id.loc.gov](http://id.loc.gov/) provides a number of subjects, thesauri, classifications, and other vocabularies. For large linked data services Sinopia uses Questioning Authorities service, but for smaller vocabularies the `InputListLOC` React component directly connects and retrieves a JSON list that is presented to the end user as a lookahead provided by the ‘react-bootstrap-typeahead'(#RBT) module. These linked data vocabularies are pulled from a JSON configuration object that is shared with the` <InputLookupQA>` and soon the` <InputLookupSinopia />` React components.

Here is a screen shot of the `InputListLOC` component within Sinopia:

![](https://journal.code4lib.org/media/issue45/nelson/Figure08.png)

**Figure 8.** InputListLOC Component with drop-down.

The URI and label is saved in the <InputListLOC> props with the URI becoming an RDF object of the entity as the RDF subject and the propertyTemplate’s propertyURI as the RDF predicate.

### `**<InputLookupQA>**` **Questioning Authorities Component**

From the beginning, the Sinopia project team included close collaboration with Huda Khan of Cornell University who is working the React components to support searching the Questioning Authorities (QA) service. QA is run as a collaborative effort with Lynette Rayle, and David Echimann at the University of Iowa School of Information Science. The QA service has a cache built with Solr and the Fusuki triplestore, with a Swagger API integrated using with Sinopia’s `<InputLookupQA>` component.

![](https://journal.code4lib.org/media/issue45/nelson/Figure09.png)**Figure 9.** InputLookupQA Component.

### `**<InputLookupSinopia />**` **Component**

The `<InputLookupSinopia />` component allows catalogers to reference existing entities created within Sinopia and will look and act in a similar fashion as the `<InputListLOC>` and `<InputLookupQA>`.

## **Editor’s Redux State**

Initially, Sinopia’s React components were structured with extensive props and state changes to represent and respond to actions and user expectations to accepting values both from any parent information and also push state information to any composited child components. As the team became more conversant with Redux, the refactoring implementation of the React components simplified both the component creation as well as what props and state variables are needed at this level of components. The Redux state in Sinopia is a snapshot in time of what data is in the active React components. For example, loading the following Resource Template, a BIBFRAME Work Title, into the Editor and entering a couple of values so the current state of the User Interface looks like:

![](https://journal.code4lib.org/media/issue45/nelson/Figure10.png)**Figure 10.** Populated Work Title Resource Template.

Is represented in this global Redux state:

For the `<InputLiteral >` component instance for the propertyTemplate mainTitle, the values are extracted by using a Redux reducer `inputPropertyReducer` function that takes the `<InputLiteral>`‘s reduxPath as a Javascript array and using the Redux state as the starting point, reduces the Redux state to the Javascript Object containing an items Javascript array. The `reduxPath` for the BIBFRAME Main Title `<InputLiteral>` is in this case:

`['resourceTemplate:bf2:WorkTitle','http://id.loc.gov/ontologies/bibframe/mainTitle'].`

React components in Sinopia, they reflect or mutate the global Redux state through two methods,` mapStateToProps` and `mapDispatchToProps` as recommended in the official React-Redux [documentation](https://github.com/jermnelson/developing-sinopia-editor-react-redux/blob/master/doc/outline.md#redux-ref-01).

### **RDF Generation and the Sinopia Server**

As the Redux state captures the event of a user entering or linking data to when it happens in the React components, Sinopia can generate RDF at any particular point-in-time on demand. From the previous Redux example, clicking on the **Preview RDF** button uses a Redux reducer to create an instance of the RDF `GraphBuilder` class and generate the following RDF graph that can then be saved and published through the backend Sinopia Server:

| 1  2  3  4 | `<> <``http:``//www.w3.org/1999/02/22-rdf-syntax-ns#type> <``http:``//id.loc.gov/ontologies/bibframe/Title> .`  `<> <``http:``//id.loc.gov/ontologies/bibframe/mainTitle> "Pride and Prejudice" .`  `<> <``http:``//id.loc.gov/ontologies/bibframe/note> _:b1 .`  `_:b1 <``http:``//www.w3.org/2000/01/rdf-schema#label> "Many editions, adaptations, and films" .` |
| --- | --- |

## **Next Steps**

The Sinopia Linked Data Editor targeted Minimal Viable Product release is at the end of July 2019. This release will allow the Sinopia Cohorts to start cataloging using the Linked Data Editor and provide valuable sources of requirements, pulled from their usage and experiences, to help the Sinopia team learn and plan for the next work-cycle. As the Sinopia user and developer community expands beyond the Stanford and Cornell development teams, Sinopia as a cataloging tool built as a generic cataloging editor for Linked Data, is a strong base to extend and expand into the future. Currently Sinopia has three linking sources, the Library of Congress, the Questioning Authorities, and internally created entities.

An early requirement of Sinopia is to provide the ability of catalogers to do two different, but related, workflows. For pre-existing graphs of RDF entities either available from third party authorities like Library of Congress, VIAF, or ShareVDE or from internally created entities stored in Sinopia’s server, catalogers will need to be able to either edit, add, or delete triples about these entities or derive a new RDF entity by copying those triples, much like the copy-cataloging current MARC based work-flows in libraries.

Finally, to encourage and broaden adoption of Sinopia beyond AWS specific services, a new Sinopia Server infrastructure based on [Kubernetes](https://kubernetes.io/) or [Docker Swarm](https://docs.docker.com/engine/swarm/) would allow other organizations to run their own version of the Sinopia Stack. In addition, integration with existing open-source library systems like [FOLIO](https://www.folio.org/) will be explored in the future.

## **References**

1. Agile Alliance [agilealliance.org](https://www.agilealliance.org/)
2. React Bootstrap Typeahead Node.js package at [http://ericgio.github.io/react-bootstrap-typeahead](http://ericgio.github.io/react-bootstrap-typeahead/)
3. React Redux Usage Guidelineshttps://react-redux.js.org/using-react-redux/connect-mapstate#usage-guidelines

## **Acknowledgments**

Sinopia would not have been possible without the talents, hard-work, and experience of the current and former members of the development team including Joshua Greben, Naomi Dushay, Sarav Shah, Johnathan Martin, Joseph Atzberger, Michael Giarlo, Justin Coyne, Peter Mangiafico, Justin Littman, and Aaron Collier.

## **About the author**

Jeremy Nelson is a software engineer with the [Stanford University Libraries](https://library.stanford.edu/) and technical lead on the [Sinopia](https://sinopia.io/) project. He is also co-founder and CTO of [KnowledgeLinks.io](http://knowledgelinks.io/).