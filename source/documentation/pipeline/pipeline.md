## Introduction

The objective of this document is to cover the transition from the existing means of software delivery to more of a Continuous Delivery Approach. The ultimate objective is to have a pipeline capable of supporting daily releases.

Before describing the proposed strategy, it is worth detailing the existing pipeline. Identifying its areas of weakness and how best to transition to the target state. 

## Existing Pipeline

The promotion into production is illustrated in the flow diagram below. 

![pipeline_current](images/pipeline_current.png)

The process is quite involved and verbose. The steps highlighted in Green are automated, whereas the white boxes are manual steps. The pipeline depicted as a flowchart articulates nicely why the time from *code complete* to production can be more than a week. Additionally, the inertia in the system means the time to respond to change or resolve issues is unecessarily slow.

## Consistent Environments

The reasoning behind such an involved promotion process stems from the fear of inconsistencies between those environments. Historically there have been a number of occassions where problems experienced in one environment could not be replicated in others. Over time, this erodes confidence and when a process finally works, then it becomes doctrine. 

Currently there are designated environments (Continuous Integration, Non Functional Testing, Acceptance, Pre Production and Production ). They all hold a dear position in our hearts and have become family pets. Treating an environment in this way promotes the current process. To break this cycle, environments need to be treated more like cattle. 

Ultimately, the only long living environment should be the one used for the Live Production service. Beyond that, an environment should exist for a specific short term purpose and once that purpose has expired, the environment should be destroyed. 

Therefore the pre-cursor to improving the pipeline, is defining a single truth of what an 'Environment' is. This is covered in more detail [here] (../infrastructure#aws-target-infrastructure)

Once defined, that definition needs to be delivered into Production. Only at that point can the benefits of Continuous Delivery be realised. This means there are two problems to solve. 

* How to deliver a new Production environment whilst supporting Feature delivery
* What the final Delivery Pipeline looks like once we have consistent environments

In order the frame the first problem, it is vital that the 2nd point is defined and understood. This will be covered in the next section

## Target Delivery Pipeline

It was stated at the outset that it should be possible to deliver software into Production on a daily basis. It is worth being explicit here that the same process should be the same for Application Code (php frontend, java services etc..) and Infrastructure Code (terraform, puppet, hiera). 

The thrust of the new pipeline is not to necessarily remove steps, as Acceptance, Non Functional Testing, Deployment Testing are valid tests. The intention here is to provide an automated way of executing these stages and a means to execute them a lot earlier in the process. 

An adpatation of the existing merging strategy is to move more towards the [Gitflow](https://datasift.github.io/gitflow/IntroducingGitFlow.html) merging strategy. Merging into the 'develop' branch is the trigger for that code to make its way into production. It should only be merged into 'develop' once functional and non-functional testing has been successfully executed. The full flow is defined below.

![pipeline_target](images/pipeline_proposed.png)

Whilst this is a relatively long winded process diagram, the green boxes are assumed to be automated. There should be minimal manual intervention. 

The two key significant manual steps are the PO sign off and the Tech Lead merge into Develop. The point at which the feature is merged into Develop the feature will be live that evening, this is the point of no return and all downstream tasks are automated. 

If, for any reason, there is a failure, either the Soak Test or Live Proving, then the entire suit of commits will be reverted. Again an automated process with zero manual intervention.

## Transition to the New Pipeline

Comparing the two flow diagrams side by side, demonstrates that there is a significant distance to travel to achieve our targeted deployment pipeline. The intention of this section is to identify at a high level the necessary steps to achieve this.

This entire improvement is predicated on consistent environments. The only way to confidently push changes from development through to production is by having complete faith that the application with behave the same in each 'environment'. Whilst tempting to start again and rebuild everything and halting all feature changes, this is not reasonable. The challenge is therefore to deliver continuous delivery, whilst maintaining feature releases.  

Therefore, the first task to consider is adjusting the pipeline to cater for both these requirements in parallel. 

### Adjust Existing Development Pipeline

A new development pipeline has been created, as shown below

![pipe_dev(../images/pipeline_dev_mbp.png)](images/pipeline_dev_mbp.png)

This will deploy our development code into a target consistent environment for each branch and for each commit. More detail about the new development pipeline can be found [here] (#development-pipeline)


The objective is for the live service to operate the same target consistent environment as the one being used by the new development environment. This requires a complete rebuild of the Production environment, but that is impossible to do whilst supporting feature releases and an existing live service. 

Additionally, introducing a new 'consistent' environment into a pipeline of inconsistent, yet well established environments, would dramatically increase the risk of problems arising during promotion from that new environment to an older inconsistent environment. 

Therefore there needs to be a forked deployment pipeline, up until a point by which the Production environment can be built in a consistent image and then there will only be a single consistent pipeline. This is shown below

![step_2](images/pipeline_forked.png)

The two pipelines will co-exist, up until a point where there is sufficient confidence in the new Live/Prd environment that traffic can be switched to it. It is worth stating that until this happens, the full benefits of consistent environments will not be realised.

### Build Live/Production Husk

Now that the existing deployment pipeline has been adjusted. The next step is to build a Husk environment that will ultimately replace the Production environment. For the purposes of clarification this will be referred to as Live/Production (Aws_Account/Environment) Account. Once this is built it will be possible to fork the deployment pipeline to not only deliver changes to the existing environments, but also deliver them to Live/Production

This is covered by the epic [jira ticket](https://jira.i-env.net/browse/OPSTEAM-882)

The pipeline should also be adjusted at this point, to automatically promote from the Int environment through to the Live/Prd environment too. More detailed information about the promotion process can be found [here] (pipeline#promotion-process)

Once we have the forked pipeline, the focus will then need to be on enhancing the pipeline to incorporate as many automated steps as per the target pipeline. Each automated step, removes any manual steps and moves towards a genuine continuous delivery pipeline.

### Performance In Sprint Testing

Currently NFT or more specifically Performance testing is performed in a specific environment post sprint. The major drawback from this approach is that if this identifies a performance problem, the time to resolve the problem usually results in either an acceptance that the service will be ok with the performance degradation or the release gets pushed out. Neither scenario is ideal. If we can identify these situations within a sprint means they can be fixed at source.

The diagram below shows at a resonably high level the process for this particular pipeline. 

![step_2](images/pipeline_performance.png)

The technical detail behind the in-sprint performance test can be found [here] (/documentation/pipeline/performance)

### Live Proving Testing

At present the proving of the system is performed as a manual task by the business post release. There are issues with this on many levels. It is quite a labour intensive process and requires people to be present post release. The live proving tests do not necessarily get executed prior to the release on a like for like environment. There have been instances where a problem has arisen during live proving, which has not been picked up through the standard testing.

It is important to note here that, there is no intention to add this to the development pipeline. This is so not to overburden the developer pipeline by adding additional time. This is really about having a set of tests that can be executed idempotently on an environment to prove it is fully functional.

Therefore the act of Live-Proving becomes the first test for any environment, downstream from development. As release candidates progress through various assurance gates, the live proving tests will be performed prior to the specific assurance gate testing to validate an environment is functionally consistent. 

The upshot is that the assurance tests, post development, follow a similar pattern as depicted below.

![live_proving](images/live_proving.png)

A pre-requiste for any of those assurance gates is an environment with a successful live proving run executed.

For more detail around what is covered in the live proving stage can be found [here] (/documentation/pipeline/live_proving)

### Vulnerability Testing     

There is currently a lack of an automated process of performing vulnerability scans against the application and infrastructure. There are usually IT Healthchecks performed periodically. These are infrequent and as such are not proactively preventing issues being introduced into the application through feature development.

To get to a position of confidence, it requires vulnerability testing to be part of the automated pipeline. The pipeline is about finding a balance between speed and assurance. Executing vulnerability scanning as part of every build will likely result in a significant amount of 'noise' 

The proposition therefore is for this to be only performed on a release candidate. The act of merging a branch into develop will queue a Vulnerability test. The output of which will inform the CAB decision

More information about vulnerability testing can be found [here] (/documentation/pipeline/vulnerability_testing)

### Accessibility Testing     

Much the same as Vulnerability testing, Accessibility testing is done on an adhoc basis and is not part of the standard pipeline. Adding accessibility checks into the application, should be a pre-requisite for a Continuous Delivery pipeline.

In the same way as Vulnerability testing is performed, this will only be triggered on a release candidate and the output of any Accessibility testing will form part of the CAB decision making.


More information about accessibility testing can be found [here] (/documentation/pipeline/accessibility_testing)