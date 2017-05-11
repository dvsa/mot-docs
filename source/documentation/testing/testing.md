# Testing

The first activity that happens before the sprint starts is to create manual test cases for the stories coming into the sprint. Not all of the stories requires written test cases, for example, layout changes, simple stories with well defined acceptance criteria and some of the defects won’t require test cases. These test cases can be in the form of actual test cases or mind maps depending on the team's preferences. That usually happens prior to the sprint start or sprint planning at the latest. Scope of the test cases contains both negative and positive scenarios. Besides the obvious scenarios they aim to cover all edge cases identified after analysis during the grooming sessions and investigation performed by Quality Assistance.  These test cases or mind maps are then attached to the particular stories in [Jira](https://www.atlassian.com/software/jira).

During the sprint the following QA activities take place:

* Manual testing
* Automated testing
* Non functional testing
* Regression testing

## Manual tests
As the developers work on the tickets they will run the manual test cases that have been created during sprint planning.  The test cases are being run first by developers to make sure that the story is ready for testing, and then by QA but with much wider scope including areas that may be affected by the changes but are not directly related to the feature. Developers use test cases also as guidance when programming the solution to assure edge scenarios are incorporated whilst also making sure the code meets the quality conditions. Can be used as for automation tests suite template as well.

In addition to the script based testing exploratory ad-hoc testing performed mostly by QA, which does not follow the common paths and scenarios. It goes beyond the feature under test and verifies the related functionality. When performing exploratory testing, the QA constantly should ask himself - what can go wrong? What may cause unwanted application's behaviour? Exploratory tests are performed on the Feature Build Environment, where the production like synthetic data set is present and it takes place and happens after scenario based testing is complete.

## Automated tests
There is an existing automation test suite.  During the sprint the teams are also responsible for updating and adding to the existing automation suite for each of the sprint stories accordingly. This covers the unit, integration or user interface (UI) layer.  The principle is to push the tests down the stack and have the majority of tests automated on the lowest level (unit) and leave only minimum to be covered by Selenium (UI) tests. Integration layer tests are the one that verifies the most complex scenarios and different combinations, both positive and negative scenarios.

Unit tests aim to cover 100% of the code isolated from external components like database, http, API, etc. Unit tests are the least expensive and take the least time to run, are the easiest to maintain and give the fastest feedback about the changes in the application’s logic.

API tests should cover everything that can be verified in the integration tests and
was not covered in the unit tests.  Every endpoint should have at least
one integration test to verify correct integration between components. These
tests should focus only on the main flows and avoid duplication tests covered
in the unit tests.

UI tests mimic the user’s journey in the system.  They should only cover happy paths and very basic scenarios, to make sure all links, buttons and paths works according to the requirements. These tests take the longest to run, are the least stable, (which is well known problem and an ongoing process of improvement) and the most time consuming when writing.

Writing automated tests is the responsibility of developers and QA engineers, where the QA engineer makes sure that the right tests are being created and that they cover all the required business logic. Developers are responsible for the code of these tests including refactoring where appropriate.

The suite of automated tests are run when a change is merged to any branch.  It is only when all of the automation tests have been executed and passed can the code be merged to the master branch.  Then when the code is merged to the master branch the same automated test suite will be run and only when all tests have passed does the build go green. The build will only be promoted through the pipeline if it is green and hence past the full automated test suite.
