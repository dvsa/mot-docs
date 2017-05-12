## Open Interface 

Open interface service allows fetching information about MOT test passed for a certain vehicle (identified by VRM - Vehicle Registration Mark) with providing an optional upper bound date (returning only tests that were conducted before the provided date).

The service uses MOT PHP Api as its data source (with underlying MOT RDS database). It is implemented using Spring Boot and runs as an EC2 instance. In production there are 3 instances of this service running.
