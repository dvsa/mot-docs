## Vehicle Service

Vehicle service is a private MTS service used for fetching and manipulating vehicles used for conducting MOT tests in MTS.

Vehicle service uses authorisation service for permission checking.

It is implemented using DropWizard and runs as an EC2 instance. In production there are 3 instances of this service running.
