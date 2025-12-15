---
title: "Tree Representations: Graphics Libraries for Displaying Hierarchical Data"
source: "https://journal.code4lib.org/articles/1083"
author:
  - "[[The Code4Lib Journal]]"
published: 2009-03-31
created: 2025-01-10
description: "Tree representations can be useful for presenting hierarchical data on the screen. In this article I’ll briefly describe building trees using the Dojo, Yahoo User Interface, Java Server Faces, and Google Web Toolkit libraries."
tags:
  - "clippings"
---
# Tree Representations: Graphics Libraries for Displaying Hierarchical Data
Mark Wilhelm

Tree representations can be useful for presenting hierarchical data on the screen. In this article I’ll briefly describe building trees using the Dojo, Yahoo User Interface, Java Server Faces, and Google Web Toolkit libraries.


## Introduction

Those of us who write programs that operate on library data will sooner or later have to figure out how to present hierarchical data (i.e., thesauri, LOC subject headings, etc) on the screen. Usually this means some kind of tree representation. In the past, creating a tree for a program’s user interface meant a home grown solution that may or may not have been a great fit. Today, however, the work has already been done for us if we know where to find it. In this article I’ll briefly describe building trees using the Dojo, Yahoo User Interface, Java Server Faces, and Google Web Toolkit libraries.

## Dojo tree

You may have heard of Dojo, the JavaScript library that enables you to do a lot of heavy lifting very quickly. Dojo has, among other things, functions for all kinds of GUI widgets as well as for AJAX communication. Dojo’s tree widget in particular is very useful and easy to set up. (For more information on these libraries, please see the Dojo site at [http://dojotoolkit.org/](http://dojotoolkit.org/).)

(I adapted the below example from Dojo: The Definitive Guide from O’Reilly Media. It’s an excellent primer and I highly recommend it if you plan to fiddle with Dojo at all).

In Dojo, trees are represented by the dojo.dijit.tree object. Dojo elements are described using a dotted notation—thus tree, being in the “dijit” library of dojo is listed as “dojo.dijit.tree.” Dojo comes with several libraries such as base, core, dijit, and util. Dijit is the library that contains many useful user interface widgets including tree.

Dojo tree elements are, true to the Dojo philosophy, easy to use right out of the box. All you need to do is:

1. Have a data source. For purposes of this example, we will use a data store in JSON format, as Dojo provides a data store implementation for this format. (You could also use XML or some other data format). For more info on JSON, see the references at the end of this article.
2. Create an instance of dojo.data.ItemFileReadStore (this is the dojo data store implementation for JSON format) and point it at your JSON data source. Note the “dojo.data” reference here – “data” is another of dojo’s libraries, this one having to do with data abstraction-that is, giving you a uniform interface to access your data no matter what the format. (The library called “dojox.data” also provides canned data store implementations for other formats such as XML.)
3. Create an instance of dojo.tree.TreeStoreModel and point it at your ItemFileReadStore. TreeStoreModel is a bit of abstraction – it is a layer in between the tree and the data, created so the tree itself need not care what format the data is in. TreeStoreModel worries about that. Tree itself is concerned with how to display the data it gets from TreeStoreModel.

Here is what the sample JSON file would look like:

```
{
    identifier : 'name',
    label : 'name',
    items : [
        {
            name : 'Modern European Fine Arts Styles and Movements',
            children: [
                {
                    name : 'Cubist',
                    children: [
                        {
                            name : 'Analytical Cubist'
                        },
                        {
                            name : 'Synthetic Cubist'
                        }
                    ]
                },
                {
                    name : 'Dada'
                },
                {
                    name : 'Impressionist'
                },
                {
                    name : 'Surrealist'
                },
                {
                    name : 'Symbolist'
                }
            ]
        }
    ]
}
```

And here is what the sample HTML would look like:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26  27  28  29 | `<``html``>`  `<``head``>`  `<``title``>Modern European Fine Arts Styles and Movements</``title``>`  `<``link` `rel``=``"stylesheet"` `type``=``"text/css"`  `<``link` `rel``=``"stylesheet"` `type``=``"text/css"`  `<``script`  `type``=``"text/javascript"`  `djConfig``=``"parseOnLoad:true,isDebug:true"``>`  `</``script``>`  `<``script` `type``=``"text/javascript"``>`  `dojo.require("dijit.Tree");`  `dojo.require("dojo.data.ItemFileReadStore");`  `dojo.require("dojo.parser");`  `</``script``>`  `</``head``>`  `<``body` `class``=``"tundra"``>`  `<``div` `dojoType``=``"dojo.data.ItemFileReadStore"` `jsId``=``"dataStore"`  `url``=``"./movements.json"``></``div``>`  `<``div` `dojoType``=``"dijit.tree.TreeStoreModel"` `jsId``=``"model"` `store``=``"dataStore"`  `query``=``"{name:'*'}"``></``div``>`  `<``div` `dojoType``=``"dijit.Tree"` `model``=``"model"``></``div``>`  `</``body``>`  `</``html``>` |
| --- | --- |

Finally, here is what the tree would look like on the web page:  
![Tree from Dojo](https://journal.code4lib.org/wp-content/uploads/2009/03/dojo_tree.jpg "dojo_tree")

And that’s it! Now you have a Dojo tree up and running in your web application. If you haven’t taken a look at the other Dojo widgets, they are worth exploring. They will make your life as a web developer much easier!

## YUI Treeview

Yahoo also has a set of JavaScript based web components intended for out-of- the-box use. This set of components is called the YUI (Yahoo UI) library.

YUI’s implementation of a tree component does not distance itself from the format of the data as the Dojo tree component does. The YUI tree expects to see data in one of two ways: either in HTML list format or in a formatted list of strings when instantiating the tree in JavaScript. In some ways this is simpler than instantiating a tree in Dojo, as the HTML list item format is fairly simple and well-known. However, things may get complicated when you try to squeeze whatever data you have into this particular format.

YUI trees can be implemented in one of three ways. The first method is to instantiate the tree with a DOM id of the HTML element that contains the HTML lists. The second is to actually list a formal representation of the HTML lists inline in the constructor. The third option is to use JavaScript to instantiate a tree from an existing tree.

In this example, an HTML list is used to populate a tree:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18 | `<``div` `id``=``"markup"``>`  `<``ul``>`  `<``li``>Modern European Fine Arts Styles and Movements`  `<``ul``>`  `<``li``>Cubist`  `<``ul``>`  `<``li``>Analytical Cubist</``li``>`  `<``li``>Synthetic Cubist</``li``>`  `</``ul``>`  `</``li``>`  `<``li``>Dada</``li``>`  `<``li``>Impressionist</``li``>`  `<``li``>Surrealist</``li``>`  `<``li``>Symbolist</``li``>`  `</``ul``>`  `</``li``>`  `</``ul``>`  `</``div``>` |
| --- | --- |

YUI JavaScript code is then invoked to generate the tree. Note how the instantiation references the “markup” div so that YUI can find the HTML and use it to build the tree:

| 1  2  3  4 | `<script type=``"text/javascript"``>`  `var` `tree1 = ``new` `YAHOO.widget.TreeView(``"markup"``);`  `tree1.render();`  `</script>` |
| --- | --- |

(Note that I placed the above script within the “body” tags. The script didn’t work when placed within the “head” tags.)  
The tree generated by the above markup and code will look like this:

![tree from YUI](https://journal.code4lib.org/wp-content/uploads/2009/03/yui_tree.jpg "yui_tree")

## Java-based tools

The following two methods for implementing trees are Java-based and therefore assume some familiarity with Java programming and concepts like the Java Bean. If you’re not into learning Java just now, you can just skip down to the list of resources and get moving on Dojo or YUI!

### JSF tomahawk t:tree2

Java Server Faces (JSF) is one of the many Java frameworks available for quickly developing web applications. JSF is described by some as a successor to Struts ([http://struts.apache.org](http://struts.apache.org/)), another Java framework that has gained recent popularity among web developers. As part of the framework for rapid web application development, JSF has libraries of visual components available that (in theory) you can pull in and use.

“Tomahawk” is one such library of visual components. Available on the apache site at myfaces.apache.org, tomahawk is listed under the umbrella of myfaces, which is itself one implementation of Sun’s specification for JSF.

Included with Tomahawk is a tree component. Since the components in JSF take the form of tags to be used in JSP or XHTML pages, the tree component is called t:tree2. (To avoid possible confusion, I must point out that tomahawk has two tree components: “t:tree2,” and “t:tree.” However, for reasons outside the scope of this article, it was much easier to get an example working with t:tree2 than with t:tree. Of course, the readers of this article are free to experiment.)

In JSF, in order to get the tree to display on the view side, we need to do some Java coding on the server side. We need to instantiate a TreeNodeBase class and then add nodes to it as needed. We do this in a server side Java Bean. Here is an example:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16 | `public` `class` `myBean { ...`  `TreeNode treeData = ``new` `TreeNodeBase(``"parentNode"``, ``"Modern European Fine Arts Styles and Movements"``, ``false``);`  `TreeNode childNode1 = ``new` `TreeNodeBase(``"childNode"``,``"Dada"``,``false``);`  `TreeNode childNode2 = ``new` `TreeNodeBase(``"childNode"``,``"Surrealist"``,``false``);`  `TreeNode childNode3 = ``new` `TreeNodeBase(``"childNode"``,``"Symbolist"``,``false``);`  `treeData.getChildren().add(childNode1);`  `treeData.getChildren().add(childNode2);`  `treeData.getChildren().add(childNode3);`  `public` `TreeModel getTreeModel { .. }`  `public` `void` `setTreeModel { .. }`  `}`  `}  ` |
| --- | --- |

As you can see, the TreeNode constructor takes three arguments. The first is a string “type” that matches the string invoked in the client JSP. The second is a “description”—this is actually the string that you want displayed on the tree in your web page. The third argument is a Boolean “isLeaf” parameter—false if you think this node will have sub nodes, true if it is a “leaf” or final node.

In JSF, view side components can be retrieved from the server side (and vice versa) as long as we follow the rule of creating a getter and setter in the Bean for that component. So for the above tree we would set it into our Bean by calling:

| 1 | `this``.setTreeModel(``new` `TreeModelBase(treedata))` |
| --- | --- |

Next, it is time to set things up on the client side. We need to set up a t:tree2 tag and reference an instance of the TreeModel class:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `<t:tree2 value=``"#{myBean.treeModel}"` `var=``"node"` `clientSideToggle=``"true"` `>`  `<f:facet name=``"parentNode"``>`  `<h:panelGroup>`  `<h:outputText value=``"#{node.description}"``/>`  `</h:panelGroup>`  `</f:facet>`  `<f:facet name=``"childNode"``>`  `<h:panelGroup>`  `<h:outputText value=``"#{node.description}"``/>`  `</h:panelGroup>`  `</f:facet>`  `</t:tree2>` |
| --- | --- |

The resulting tree will look like this:

![tree from JSF](https://journal.code4lib.org/wp-content/uploads/2009/03/jsf-tree.jpg "jsf-tree")

Note that we are using three libraries: JSF component tag libraries represented by the prefixes “f” and the “h” in addition to the Tomahawk library represented by the “t.”

Let’s work through this code from the top. First, let’s look at the attributes of the t:tree2 tag. The “value” attribute points to the name of the TreeModel instance in the Bean “myBean.” In that Bean there will be a “getTreeModel” getter method to retrieve the tree for display on the page. “Var” is the local variable name we are giving this instance of TreeModel so that we can reference its attributes locally with dotted notation; e.g., “node.description”. (node.description calls the getDescription method on that instance of treeNode, returning the string we used to name that node). “clientSideToggle” determines whether we want to handle toggling of the tree’s nodes locally (and thus keeping all the data local and loading it all at once when we load the tree) or not (in which case the data for a tree’s node would not be loaded until it was clicked).

After we declare the tree2 tag itself, we then begin laying out the tree nodes using “facet” and “panelgroup” tags. The facet tag in JSF is used within other “container” components. It is used to create a named section within these containers. The panelgroup tag is used to organize the layout of visual components on the web page. The facet “childNode” will include a list of all the TreeNodes we labelled as “childNode” in the server side Java code. The iteration through that list is handled automatically by JSF. Finally, within the panelgroup tags, we output the nodes of the tree using the h:outputText tag. This is how the tree is ultimately fleshed out.

## Google Web Toolkit

The Google Web Toolkit is written in Java, not JavaScript like Dojo or the YUI Library. However, there is a twist. A developer writes their “AJAX front end,” as Google refers to it, in the Java language. The Java code is then compiled by Google into cross-browser JavaScript.

The approach to deploying a tree in GWT is similar to JSF in that it must be done through Java, and each node of the tree must be populated in a Java program. In this sense, it would seem that there is a tad more overhead in getting started with this toolkit than with YUI or Dojo. However, Google makes it very simple to get started – I got the example below working very quickly.

One of the ways Google makes it easy is by giving you tools that make starting a skeletal application extremely simple. If you are using Eclipse, you can generate a project directory easily by doing the following:

1. Open a command prompt and navigate to the directory where you installed the GWT download.
2. Create a directory that will hold your project files. For this example we’ll call it mygwttree.
3. Run the following command: `projectCreator -eclipse mygwttree -out mygwtree`
4. You should see some files such as a .project file in your directory now.
5. Now run the command to finish creating the bare bones GWT project: `applicationCreator -eclipse mygwttree -out mygwttree com.google.gwt.gwttree.client.gwttree`

In the “applicationCreator” command, you specify the name of the class in your new project. Next, you can import this project into Eclipse (using the “Existing projects into workspace” option) and begin adding code.

To build a tree in GWT, you need to create some instances of the TreeItem class and then put them into an instance of the tree class. It’s actually pretty simple. In the code below, both the class and the “onModuleLoad” method stub are auto-generated by GWT. All you need do is fill in the code to create a tree:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20  21  22  23  24  25  26 | `public` `class` `newgwttree ``implements` `EntryPoint {`  `/**`  `* This is the entry point method.`  `*/`  `public` `void` `onModuleLoad() {`  `TreeItem root = ``new` `TreeItem(``"Modern European Fine Arts Styles and Movements"``);`  `TreeItem item0 = root.addItem(``"Cubist"``);`  `root.addItem(``"Dada"``);`  `root.addItem(``"Impressionist"``);`  `root.addItem(``"Surrealist"``);`  `root.addItem(``"Symbolist"``);`  `item0.addItem(``"Analytical Cubist"``);`  `item0.addItem(``"Synthetic Cubist"``);`  `Tree t = ``new` `Tree();`  `t.addItem(root);`  `RootPanel.get().add(t);`  `}`  `}` |
| --- | --- |

GWT then compiles the Java and generates the resulting JavaScript. To test your code, run the shell command generated by GWT in your “mygwtree” project directory. You should see something like this:

![tree from GWT](https://journal.code4lib.org/wp-content/uploads/2009/03/new-gwt-tree.jpg "new-gwt-tree")

## Dynamic or “lazy” loading of tree node data

Of course, there will be situations where a developer does not want to load data for the entire tree at one time but rather “as needed” for a particular node or nodes. Some of the above libraries explicitly provide for this need; others need a little tweaking to achieve it. Here is a quick summary with links to resources where available.

Dojo’s Dijit.tree does not provide an explicit mechanism for lazy loading. However it is possible to enable lazy loading by manipulating the isItemLoaded() method of (dojox.data.DataStore). This article on the IBM developerWorks web site by Scorr Johnson ([http://www.ibm.com/developerworks/websphere/techjournal/0805\_col\_johnson/0805\_col\_johnson.html](http://www.ibm.com/developerworks/websphere/techjournal/0805_col_johnson/0805_col_johnson.html)) describes how.

According to the YUI documentation, YUI treeview “supports dynamic loading of node data (via in-page data or via XMLHttpRequest using Connection Manager) .” The Yahoo documentation provides a detailed example of how to implement lazy loading in a YUI Treeview at [http://developer.yahoo.com/yui/examples/treeview/dynamic\_tree.html](http://developer.yahoo.com/yui/examples/treeview/dynamic_tree.html).

JSF does not have a built in mechanism for lazy loading out of the box. However some developers have shared their custom solutions to this problem at [http://wiki.apache.org/myfaces/Tree2](http://wiki.apache.org/myfaces/Tree2).

Finally, I was not able to find information on whether GWT explicitly supports dynamic loading of data for tree nodes. However, if anyone happens to come across this information, I’d love to hear about it!

## Conclusion

As you can see, there is more than one way to build a tree. Each of the methods of building trees above has their own strengths and weaknesses. For example, JSF has a steeper learning curve, but this is due to the strong data modelling on the server side. GWT and JSF require knowledge of the Java language, while YUI and Dojo require only familiarity with JavaScript. Dojo’s tree has a nicer separation of data and presenetation than YUI’s TreeView, but YUI allows you to use simple HTML markup to populate a tree.

## More Resources

If you haven’t checked these libraries out, I highly recommend that you do. Below are some resources if you want to do some further exploring.

Finally, a note on the data used for the examples above: To populate the trees I used a sample from the Art and Architecture Thesaurus at the Getty Center [http://www.getty.edu/research/conducting\_research/vocabularies/aat/](http://www.getty.edu/research/conducting_research/vocabularies/aat/).

Russell, Matthew. (2008). Dojo: The Definitive Guide. Sebastopol, CA: O’Reilly Media. [COinS](https://journal.code4lib.org/coins)

Geary, D. and Horstmann, C. (2007). Core JavaServer faces. Upper Saddle River, NJ: Prentice Hall. [COinS](https://journal.code4lib.org/coins)

The Dojo Toolkit. (2009). Retrieved January 15, 2009 from [http://dojotoolkit.org/](http://dojotoolkit.org/).

Google Web Toolkit. (2009). Retrieved January 15, 2009 from [http://code.google.com/intl/en/webtoolkit/](http://code.google.com/intl/en/webtoolkit/).

The Yahoo! User Interface Library. (2009). Retrieved January 15, 2009 from [http://developer.yahoo.com/yui/](http://developer.yahoo.com/yui/).

The Apache MyFaces Project. (2009). Retrieved January 15, 2009 from [http://myfaces.apache.org/](http://myfaces.apache.org/).

Introducing JSON. (2009). Retrieved January 15, 2009 from [http://json.org/](http://json.org/).

Johnson, Scott. “Lazily loading your Dojo Dijit tree widget can improve performance.” Retrieved March 1, 2009 from [http://www.ibm.com/developerworks/websphere/techjournal/0805\_col\_johnson/0805\_col\_johnson.html](http://www.ibm.com/developerworks/websphere/techjournal/0805_col_johnson/0805_col_johnson.html).

Mark Wilhelm is a software engineer at an electronic information company in Philadelphia. You can reach him at markcwil at gmail.com, and be sure to follow his Information Sciences blog at [http://infoscinews.blogspot.com/](http://infoscinews.blogspot.com/).