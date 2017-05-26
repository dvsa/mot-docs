## Introduction

The objective of this document is to cover the transition from the existing means of software delivery to a more of a Continuous Delivery Approach. The ultimate objective is to have a pipeline capable of supporting daily releases

Before describing the proposed end strategy, it is worth detailing the existing pipeline. Identifying its areas of weakness and how best to transition to the target state. 

## Existing Pipeline

The promotion into production is illustrated in the flow diagram below. 

![pipeline_current](images/pipeline_current.png)

The process is quite involved and verbose. The steps highlighted in Green are automated, whereas the white boxes are manual steps. The pipeline depicted as a flowchart articulates nicely why the time from *code complete* to production can be more than a week. Additionally, the inertia in the system means the time to respond to change or resolve issues is unecessarily slow.

## Consistent Environments

The reasoning behind such an involved promotion process stems from the fear of inconsistencies between those environments. Historically there have been a number of occassions where problems experienced in one environment can not be replicated in others. Over time, that erodes confidence in the process and when a process finally works, then it becomes doctrine. 

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

Merging into the 'develop' branch is the trigger for that code to make its way into production. It should only be merged into 'develop' once functional and non-functional testing has been successfully executed. The full flow is defined below.

![pipeline_target](images/pipeline_proposed.png)

