## Database

The MOT application employs MySQL MariaDB (10.0.17) databases for its primary persistent data store.

It uses Amazon Relational Database Service (RDS) to host the primary production database and a secondary read replica database for fail-over/disaster recovery.
The primary database and its read replica are an Amazon RDS replica pair configured using RDS out-of-the-box replication.

In addition to the two main databases, there are two other read replicas, one of which serves MOT History (MOTH) application, and the other serves MI Reporting using Tableau.  These additional replicas use manually configured asynchronous MySQL replication. This is because the MOTH and MI Reporting applications are hosted in separate Virtual Private Clouds (VPC) and it is not possible to use the RDS managed replication across VPCs.

The MOTH database replicates directly from the MOT master database.
The MI Reporting database replicates from the MOT read-replica database.

This is depicted in the diagram below:

![Database Diagram](/images/documentation/MTS-Database-Replication.png)

All of these database instances have a storage footprint of 1500GB (roughly 1.5TB). MOTH, though it occupies the same footprint, does not hold all the data that the other instances hold as it uses the MariaDB (and MySQL) 'Blackhole' storage engine for most of the MOT replica tables in order that they store no data at all.

The purpose of this storage engine, in this context, is to allow the MOT database to be fully replicated to the MOTH database but the data stored gets filtered down to just the data the MOTH application requires to function properly.  For example, the MOTH application has no need of MOT's user data, so any data that replicates to the 'user' table is not written to storage, and consequently is not available to the MOTH application.
