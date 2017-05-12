## Test Service

Test service is a private MTS service used for fetching information about MOT tests conducted in MTS.

Test service uses authorisation service for permission checking and vehicle service as its data source for vehicles under test.

It is implemented using DropWizard and runs as an EC2 instance. In production there are 5 instances of this service running.
