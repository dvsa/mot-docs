# Components

The major components of the MTS deployment environment are shown in the diagram below.  The text incluseds links to further detailed descriptions of each of the components.  The shaded area are the components that make up the blue/green stack, each of these stacks can be deployed and tested in isolation to reduce the amount of downtime required for a release.  

![Component Diagram](/images/documentation/MTS-Network.png)

The majority of the MTS is made up of 2 large PHP applications, [PHP-FE](php-fe.md) and [PHP-API](php-api.md).  These handle the web front end tier and the MTS business logic respectively.

Some of the PHP functionality has been extracted into Java services, for [TEST](test-service.md)s, [VEHICLE](vehicle-service.md)s and [AUTHORISATION](authorisation-service.md).

[Elasticache](elasticache.md) is used to cache user sessions. 

User persistence, authentication and session management is handled by [OpenAM and OpenDJ](openam-opendj.md).

Test certificate generation is handled by a Jasper server cluster.

Other internal clients (such as DVLA) communicate with the MTS through the [Open Interface](open-interface.md).

External clients can query data using either the [Trade API](trade-api.md), or the [MOT History](mot-history.md) web application.

The MTS data is persisted in an AWS MariaDB RDS [database](database.md) instance.

Their is a schedule [Jobs Server](jobsserver.md) that handles task such as nightly data updates.

[Consul](consul.md) is used to store configuration values within MTS.