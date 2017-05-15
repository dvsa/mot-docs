## Authorisation Service

Authorisation service is a private MTS service used for permissions management (check and assignment) as well as manipulation of 2FA (two-factor authentication) cards.

It is implemented using DropWizard and runs as an EC2 instance. In production there are 3 instances of this service running.
