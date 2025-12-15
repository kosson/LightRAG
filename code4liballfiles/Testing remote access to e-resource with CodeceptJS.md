---
title: "Testing remote access to e-resource with CodeceptJS"
source: "https://journal.code4lib.org/articles/15297"
author:
  - "Ralf Weber"
published: 2020-08-17
created: 2025-01-10
description: "At the Badische Landesbibliothek Karlsruhe (BLB) we offer a variety of e-resources with different access requirements. On the one hand, there is free access to open access material, no matter where you are. On the other hand, there are e-resources that you can only access when you are in the rooms of the BLB. We also offer e-resources that you can access from anywhere, but you must have a library account for authentication to gain access. To test the functionality of these access methods, we have created a project to automatically test the entire process from searching our catalogue, selecting a hit, logging in to the provider’s site and checking the results. For this we use the End 2 End Testing Framework [CodeceptJS](https://codecept.io/)."
tags:
  - "#e-resource"
  - "#CodeceptJS"
  - "#e-book"
  - "#e-journal"
---
# Testing remote access to e-resource with CodeceptJS
Ralf Weber

At the Badische Landesbibliothek Karlsruhe (BLB) we offer a variety of e-resources with different access requirements. On the one hand, there is free access to open access material, no matter where you are. On the other hand, there are e-resources that you can only access when you are in the rooms of the BLB. We also offer e-resources that you can access from anywhere, but you must have a library account for authentication to gain access. To test the functionality of these access methods, we have created a project to automatically test the entire process from searching our catalogue, selecting a hit, logging in to the provider’s site and checking the results. For this we use the End 2 End Testing Framework [CodeceptJS](https://codecept.io/).

## Introduction and Motivation

The [Badische Landesbibliothek Karlsruhe (BLB)](https://www.blb-karlsruhe.de/) offers their users a variety of e-resources with different access possibilities. Some of these are freely accessible, but many require a login with username and password to ensure that you are a user of the library. In the BLB we use [Shibboleth](https://www.shibboleth.net/) to login. The procedure is always the same: the user usually selects the library as an institution and identifies himself with his user number and password. However, the implementation on the individual portals is not always obvious and often there are functional problems; sometimes access to a source that is actually licensed is denied. From time to time we get feedback from users about problems, but many don’t report them because they suspect the problem to be their own. Therefore we thought about the possibility of automatically testing selected sources for their correct operation by mapping the complete workflow of information retrieval. For instance:

- Search for a specific term in the OPAC
- Expecting to find a specific match
- Login as user
- Access to the full text at the provider

By automating these processes, we hope to discover problems or errors in access to the full text in order to react promptly and correct the error as quickly as possible, either on our side or by contacting the provider.

## What is CodeceptJs? Why did we choose this framework?

[CodeceptJS](https://codecept.io/) is a modern end to end testing framework with a special behavior-driven development (BDD) style syntax for NodeJS. The tests are written as a linear scenario of the user’s action on a site.

It abstracts browser interaction to simple steps that are written from a user perspective.  A simple test that verifies that “Welcome” text is present on a main page of a site will look like this:

[Getting Started with CodeceptJS](https://codecept.io/basics/)

| 1  2  3  4  5 | `Feature(``'CodeceptJS demo'``);`  `Scenario(``'check Welcome page on site'``, (I) =>`  `I.see(``'Welcome'``);`  `});` |
| --- | --- |

CodeceptJS passes execution commands to helpers. Depending on what you intend to test, you choose one of the helpers. In our case, we do not need cross-browser support, we are simply interested in faster testing and therefore chose the Chrome-based [Puppeteer](https://developers.google.com/web/tools/puppeteer) Helper.

Writing the tests for our scenarios can be done by librarians with little to no knowledge of programming. CodeceptJS is simple to use and tests are written from a user’s perspective. There is an actor (represented as I) which contains actions taken from helpers. A test is written as a sequence of actions performed by an actor. Here’s an example:

| 1  2  3  4  5  6  7 | `I.click(``'Sign in'``, ``'//html/body/div[1]/header'``);`  `I.see(``'Sign in to GitHub'``, ``'h1'``);`  `I.fillField(``'Username or email address'``, ``'something@totest.com'``);`  `I.fillField(``'Password'``, ``'123456'``);`  `I.click(``'Sign in'``);`  `I.see(``'Incorrect username or password.'``, ``'.flash-error'``);` |
| --- | --- |

It’s readable and simple and works using the Puppeteer API.

Since our tests are always more or less similar, we decided to create a template that can be used as a basis for each query. CodeceptJS allows us to store often used interactions like common locators and methods in “page objects.” This way the code can be made even more simple and readable. For example, we have created a module to login with Shibboleth in which the access data of a test user is stored, saved as shibboleth.js:

| 1  2  3  4  5  6  7  8  9  10  11  12  13  14  15  16  17  18  19  20 | `const { I } = inject();`  `module.exports = {`  `login () {`  `I.fillField(``"#username"``, ``"XXXXXXXXXX"``);`  `I.fillField(``"#password"``, ``"XXXXXXXXXX"``);`  `I.click(``".bBtn"``);`  `},`  `loginInTab () {`  `I.switchToNextTab();`  `I.fillField(``"#username"``, ``"XXXXXXXXXX"``);`  `I.fillField(``"#password"``, ``"XXXXXXXXXX"``);`  `I.click(``".bBtn"``);`  `I.wait(10);`  `}`  `};` |
| --- | --- |

So for the whole login process, in the test file you only have to enter

Or, if it is necessary to switch to the next tab in the browser

| 1 | `ShibbolethPage.loginInTab();` |
| --- | --- |

We have created a second module, search.js, which contains all further interactions regarding the search for a hit and the access to the full text at the provider. This is best explained using an example.

## Hands On – A practical example

A simple example

If there are no special features necessary, a simple test proceeds as follows:

- Load start page of the OPAC
- Log in via Shibboleth
- Search a chosen title by ID
- Check if title matches expected title
- Click on link to full text
- Log in again
- Test for a text you expect to see at the provider

You can try this live:

- Go to [https://rds-blb.ibs-bw.de/opac/](https://rds-blb.ibs-bw.de/opac/)
- Search for the id 1668499266  
![](https://journal.code4lib.org/media/issue49/weber/Image1.png)
- We expect in our test the title “Die Angezählten” to be there.
- Now we click on the link to the full text (“zum Dokument”)
- Now, as you are not able to login, your journey ends on the Shibboleth Login page
- But in our test, we automatically login and then expect to see the text ‘Lesen’ on the page from the provider

This is a screenshot what the page from the provider looks like after successful login  
![](https://journal.code4lib.org/media/issue49/weber/Image2.png)

You can see the text “Lesen”.

The test itself looks like this:

| 1  2  3  4  5  6  7  8  9  10  11 | `Feature(``'Content-Select Test'``);`  `Scenario(``'Mit Shibboleth Login @content-select'``, (I, ShibbolethPage, SearchPage) => {`  `SearchPage.loadBuecherUndMehrPage();`  `ShibbolethPage.login();`  `SearchPage.searchFor(``'1668499266'``);`  `SearchPage.hopeToSee(``'Die Angezählten'``);`  `SearchPage.clickToDocumentInBuecherUndMehr(``'a.btn:nth-child(1)'``);`  `ShibbolethPage.loginInTab();`  `SearchPage.hopeToSeeFromProvider(``'Lesen'``, ``'div.actions:nth-child(3) > a:nth-child(1)'``);`  `}).retry(3);` |
| --- | --- |

Each line corresponds to one of the instructions listed above.

As the identifiers (CSS/XPath) for the search string and the title in the result list are always the same, you only have to specify their values, so no further CSS/XPath rules are necessary.

In the search.js file these functions look like this:

| 1  2  3  4  5  6  7  8  9  10  11  12 | `searchFor(searchValue) {`  `I.fillField(``"#searchForm_lookfor"``, searchValue);`  `I.click(``"button.btn"``);`  `I.wait(5);`  `},`  `hopeToSee(whatToSee) {`  `I.see(`  `whatToSee,`  `"#result0 > div:nth-child(4) > div:nth-child(2) > div:nth-child(1) > div:nth-child(1) > a:nth-child(1)"`  `);`  `},` |
| --- | --- |

In summary, a librarian writing a simple test only needs to take this template and adjust three things:

1. the values for the Id to be searched
2. the value of the expected title in the result list
3. the text that can only be seen on the provider’s site after successful login, including the (CSS/XPath) identifier that he gets with Firefox/Chrome DevTools.

The test gets called by the following command:

| 1 | `npx codeceptjs run --steps –colors filename_test.js` |
| --- | --- |

The output looks like this (green when everything is fine, red on errors)

![](https://journal.code4lib.org/media/issue49/weber/Image3.png)

## Troubleshooting and Limitations

Normally the tests run as shown in the example above, with no problems.

We have found that it makes sense to take a “break” between the individual steps. Otherwise the test may fail because the page is not yet completely loaded and access to the DOM will not succeed. CodeceptJS offers the command wait(seconds) for this. This ensures that the page is loaded and the complete DOM is available before the next test starts. We use this extensively. The test runs longer, but that doesn’t matter.

We also wanted to avoid recording these test accesses in statistics. CodeceptJS offers MockRequest for this.  
This helper allows you to use mock requests while running tests, so you can block calls to 3rd-party services like Matomo, Google Analytics etc.

| 1 | `I.mockRequest(``'GET'``, ``'/matomo/*'``, 200);` |
| --- | --- |

These calls are also integrated into the functions.

Some sites expect the consent of the privacy policy, which appears in a pop-up window. Access to this was not possible with CodeceptJS via the DOM. But we could solve this by setting the required cookies manually. CodeceptJS also provides a simple method for this:

| 1  2  3  4  5  6  7  8  9 | `I.clearCookie();`  `I.setCookie({`  `name: ``"AccessSessionSignature"``,`  `value: ``"2df0a0adc0a705630e5f62be9f2efdf4b87835094e077dc76e6799dcbdbae627"`  `});`  `I.setCookie({`  `name: ``"AccessSessionTimedSignature"``,`  `value: ``"b2a0050b0df65bab1b16bad39f08507302c0218db8a0c18a55dbd48f8744984c"`  `});` |
| --- | --- |

Fortunately, these cookies do not have to be created each time but can be loaded with fixed values directly from the test file. Therefore no further work or preparation is necessary and these tests can be started by cronjob without problems too.

On some pages you have to select the institution from a dropdown list, sometimes this happens dynamically via AJAX. CodeceptJS is well equipped for this also as you can see here on these examples:

[Filling Fields](https://codecept.io/acceptance/#filling-fields)

| 1  2  3  4  5  6 | `I.selectOption(``'Choose Plan'``, ``'Monthly'``); `  `I.selectOption(``'subscription'``, ``'Monthly'``); `  `I.selectOption(``'subscription'``, ``'0'``); `  `I.selectOption(``'//form/select[@name=account]'``,``'Premium'``);`  `I.selectOption(``'form select[name=account]'``, ``'Premium'``);`  `I.selectOption({css: ``'form select[name=account]'``}, ``'Premium'``);` |
| --- | --- |

To make sure that there are no temporary network problems or other technical failures, we optionally run each test three times. CodeceptJS offers the possibility of [RetrySteps](https://codecept.io/basics/#retry-step). You simply append the function *retry(amount)* to the scenario.

| 1  2  3 | `Scenario(``'Really complex'``, (I) => {`  `}).retry(2);` |
| --- | --- |

The execution is only repeated if the test has failed, very nice!

There is one thing we have not yet been able to solve. There’s a provider who requests a ReCAPTCHA in addition to the login. Maybe we can think of a solution for this in the future.

## Conclusion

Meanwhile our tests are running productively and automated. We only run them from off campus, because if they work there, they also work inside the rooms of the library. For a better organization we have divided them into three groups: database, e-book and e-journals. At the time of writing, we have 83 tests and more will be added.

We have set up a cronjob for each group which calls up the test files once a month, with the result is logged and sent by e-mail to the responsible employees. Additionally, we have activated the [Allure](https://codecept.io/plugins/#allure) plugin CodeceptJS.cThis is a reporting tool that shows a representation of what has been tested in a web report form.

![](https://journal.code4lib.org/media/issue49/weber/Image4.png)

This allows details of the tests to be tracked, and in case of an error there is a screenshot, which often makes troubleshooting extremely easy.

Now that we have been in the production phase for a few months, we can say that we have achieved what we wanted. We can automatically control whether external access to full text works or not, we notice long response times on the part of the providers and can ask them to improve. We can better understand the problems of the users to reach the full text, because now we have to write the whole process as a test. Here we can see how complex the user guidance is. And we notice changes to the user interface of the website on the part of the provider, because then our tests fail, which fortunately is not often.

## About the Author

Ralf Weber is the Information Technologies Librarian at the Badische Landesbibliothek Karlsruhe.  
He cares and develops tools for automation of library workflows and for new services within the context of the library.