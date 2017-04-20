# CI / CD

The MTS Continuous Integration is branch based. Every feature must pass all the tests in the correlating feature branch before it is merged to the main swimlane. Release candidate is a set of artefacts produced from master branch across all the Git repositories.

Both application and infrastructure code is part of the CI process. MTS utilizes a concept of FBEs (Feature build environment) - a set of environments with production like segregation but with smaller scale.

[Jenkins](https://jenkins.io/) is the CI / CD tool used to build MTS delivery pipelines. It utilize pipeline extension to build the delivery pipelines using groovy. Majority of the MOT stack CI is done in the following fashion:

![CI diagram](/images/documentation/mts-pipeline.png)

Pipeline approach allows builds to fail fasts in case of issues found and feedback loop duration is relatively short. It is worth pointing out that components are rebuild only when a change was applied to it. If a component is not changed during developemnt of a feature a default artefact (build from master branch) will be used.



