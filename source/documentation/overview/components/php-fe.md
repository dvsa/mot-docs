## PHP Front end

This is the main front end to the MTS system.  It is a PHP application running in the Apache web server using Zend2 as it's MVC framework.  Although the source code is in the same repository as the PHP Back end it is split out during the build process and deployed separately.

The PHP code is the oldest in the codebase and is progressively being re-engineered into other technologies.

In production there are 12 instances of this service running which has been tested to handle up to 30,000 concurrent connections.
