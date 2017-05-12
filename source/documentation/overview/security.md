# Security

## OWASP Top 10

We periodically check the code base against the [OWASP Top 10](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) security risks and vulnerabilities, proxying traffic  of our automated UI regression suite and automatically inspecting every page using [Burp Suite](https://portswigger.net/burp/). All High category risks are addressed immediately, Medium and Low category risks are assessed and triaged and usually added to an upcoming sprint for remediation.

## HTTP / HTTPS

All communications originating from outside of the MTS AWS VPC are made using TLS.  The TLS certificate is terminated at the publishing layer of the application.

All internal communications (traffic inside the VPC) are made over HTTP only.


