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

Therefore the pre-cursor to improving the pipeline, is defining a single truth of what an 'Environment' is. This is covered in more detail [here] (/documentation/infrastructure#aws-target-infrastructure)

Once defined, that definition needs to be delivered into Production. Only at that point can the benefits of Continuous Delivery be realised. This means there are two problems to solve. 

* How to deliver a new Production environment whilst supporting Feature delivery
* What the final Delivery Pipeline looks like once we have consistent environments

In order the frame the first problem, it is vital that the 2nd point is defined and understood. This will be covered in the next section

## Target Delivery Pipeline

It was stated at the outset that it should be possible to deliver software into Production on a daily basis. It is worth being explicit here that the same process should be the same for Application Code (php frontend, java services etc..) and Infrastructure Code (terraform, puppet, hiera). 

The thrust of the new pipeline is not to necessarily remove steps, as Acceptance, Non Functional Testing, Deployment Testing are valid tests. The intention here is to provide an automated way of executing these stages and a means to execute them a lot earlier in the process. 

An adpatation of the existing merging strategy is to move more towards the Gitflow(https://datasift.github.io/gitflow/IntroducingGitFlow.html) Merging into the 'develop' branch is the trigger for that code to make its way into production. It should only be merged into 'develop' once functional and non-functional testing has been successfully executed. The full flow is defined below.

![pipeline_target](images/pipeline_proposed.png)

Whilst this is a relatively long winded process diagram, the green boxes are assumed to be automated. There should be minimal manual intervention. Redudcing the manual input would allow the automated testing to complete during the day, a final Performance Soak Test to be performed overnight and then appear in Production the next day after sign off.

## Transition to the New Pipeline

Comparing the two flow diagrams side by side, demonstrates that there is a significant distance to travel to achieve our targetted deployment pipeline. The intention of this section is to identify at a high level the necessary steps to achieve this.

The underpinning pre-requisite to achieve all this is a consistent environment, yet this needs to be delivered in a backdrop of running a live service and delivering new features for that service.

The first task therefore is to build a Husk environment that will ultimately replace the Production environment. For the purposes of clarification this will be referred to as Live/Production (Aws_Account/Environment) Account. Once this is built it will be possible to fork the deployment pipeline to not only deliver changes to the existing environments, but also deliver them to Live/Production

![step_1](images/deliver_step_1.png)

Once this dual deployment has been proven, the focus should then be around enhancing the existing process to move towards the target operation. Intially there should be focus on developing the Minimal Viable Product for the following Test Scenarios

* Live Proving Tests
* Performance Tests
* Security Tests
* Accessibility Tests

![step_2](images/deliver_step_2.png)

Once developed, these executions can be performed on a Nightly basis on branches due to be merged. The output can be used to determine whether the feature is ready in a non functional sense. 

![step_3](images/deliver_step_3.png)

Bringing Step 1 and Step 2 together means it is now possible to produce enough evidence to provide information to CAB such that the approval process can become automated. This is the necessary business process step to move towards full Continuous Delivery

![step_4](images/deliver_step_4.png)

Up until this point, whilst the process has been sped up and decision making around releases has improved, the promotion to the production account still has manual steps in it. The next stage is to take out the manual NFT load test and automate a 6hr soak test overnight. This again reduces the manual stages present in the current pipeline. 

![step_5](images/deliver_step_5.png)

Whilst the process has been improved, there is still a lack of consistency within the environment. To realise the benefits of the automation, it requires that the Live/Production account is activated. At this point there is a high degree of confidence that the way the application performs under test, is exactly the way the application will perform in Production.  

