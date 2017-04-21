# Development

## Agile Development



## Open Source

A growing number of the MTS components are being hosted publicly in GitHub under the MIT open source licence.  All new components are coded in the open.  They are all hosted under the DVSA account, https://github.com/dvsa.

Currently, we are regularly publishing the core MOT repo to GitHub but we are not coding this in the open. This is a confidence-building measure. Specifically, MOT still relies on post-sprint security testing, and not every change that goes live is subject to security testing. Until we have corrected this, we will publish code only once it has been security tested. After we have built security testing into our pipeline, we will move to coding in the open.


## Development Environment

Each Developer (and Tester) has a local environment where they can run the full MTS stack, this is acheived by using Vagrant images hosted in Virtual box on OSX based computers.

The codebase is mapped into the Vagrant images so that the developer can modify the code on their local machines and the changes will be automatically reflected in teh Vagrant image.  This also means that the developers can perform remote debugging into the Vagrant images.

The developers predominantly use Jetbrains products for IDEs, IntelliJ for the Java based components and PHPStorm for the PHP ones.

Typically the developers will run the unit tests and a subset of the integration tests on their local environments, the rest of the tests are automatically executed in the Feature Build environments when the branch is committed to.  This is a much faster-feedback approach (around 30 minutes) than running everything locally which can take upwards of 2.5 hours.


