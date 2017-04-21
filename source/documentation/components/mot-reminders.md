## MOT Reminders (MOTR)

MOTR infrastructure is fully serverless which means that there is no need to manage any underlying infrastructure like ec2 instances and there is no VPC related (networking) configuration.

All  services used to build the MOTR are located in the AWS public cloud but access to them is either limited on the AWS account level or with use of appropriate IAM roles/policies.

MOTR infrastructure consist of two parts:

1. FRONTEND (Online) - allows visitors to subscribe and unsubscribe for reminders, including confirmation links.
1. BACKEND (Offline) - does the subscription processing work, daily determines which subscriptions should get a reminder and delivers reminders via GOV.UK Notify.

MOTR is integrated with two 3rd party services:

1. GOV.UK Notify to notify subscribers using email and potentially text messages in the future.
1. MOTH Trade API to retrieve information about vehicle tests and their expiry dates.

![MOT History](/images/documentation/moth-logical.jpg)

