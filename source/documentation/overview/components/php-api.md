## PHP API

The PHP API is the main back end API of the MTS system.  Like the PHP Front end it uses Zend2 to expose the RESTful endpoints and is hosted within an Apache instance.  It communicates with the database using the Doctrine ORM.

There are 36 instances of this in production. We have tested the maximum throughput of this deployment, and it exceeds current and projected maximum demand.
