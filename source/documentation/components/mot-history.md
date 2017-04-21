## MOT History 

Mot History enables users of the public to query vehicle mot history using vehicle's make and registration number.

![Locical architecture](/images/documentation/moth-logical.png)

### MOT History Frontend
Mot History Frontend enables citizens to query MOT database for vehicle MOT history. It is implemented using Zend framework and runs as an EC2 instance.

### MOT History API
MOT History API queries MOT read replica instance to fetch MOT history of a given vehicle. It is implemented using DropWizard and runs as an EC2 instance.