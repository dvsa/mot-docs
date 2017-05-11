## MOT Intelligence

Mot Intelligence enables users of the public to submit anonymous intelligence about MOT tests.

![Locical architecture](/images/documentation/moti-logical.png)

### MOT Intelligence Frontend
Mot Intelligence Frontend enables citizens to submit intelligence via web forms. It saves each submission in an S3 bucket. It is implemented using DropWizard and runs as an EC2 instance.

### MOT Intelligence Processor
MOT Intelligence Processor collects submissions from S3 and aggregates them to a single XML document. Processor creates a manifest, and tars and zips the two files. It finally adds them to the S3 bucket storing daily reports.

It is triggered daily by CloudWatch Events.  It is implemented using DropWizard and runs as an EC2 instance.