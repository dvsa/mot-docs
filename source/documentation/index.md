# Technical documentation

The MOT Testing Service (MTS) is used to record the results of vehicle tests, a legal requirement for vehicles in the UK.  The service has circa 55,000 external users in test centers plus DVSA internal users and records circa 120,000 tests per day.  On average their are 14,000 concurrent users of the service.

This is an up-to-date living document set for the MTS, broadly covering all technical aspects of the MTS, without delving too much into the detail.  Care should be taken to curate and maintain the validity of the documents it contains to avoid them becoming stale.  These documents are maintained in a Git repository(https://github.com/dvsa/mot-docs) as markdown. This allows the team to track activity and history, and supports export in the future should the need arise.

> There are a number of other technical documents for MTS that are out of date by between 1 and 5 years. In some cases, the team did not know of these documents; in other cases there was not the impetus to invest in updating them.

The key areas covered in this documentation set are:

* **Technologies** Technologies used within the MTS
* **Components** The key components of the MTS
* **Development** MTS software development concepts
* **Infrastructure** The deployment infrastructure
* **CI/CD** Continuous Integration / Continuous Deployment
* **Testing** The various testing techniques and tools used
* **Security** The security implications of the MTS
