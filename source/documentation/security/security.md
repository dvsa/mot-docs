# Security

## OWASP Top 10

We periodically check the code base against the [OWASP Top 10](https://www.owasp.org/index.php/Category:OWASP_Top_Ten_Project) security risks and vulnerabilities, taking the output of our automated UI regression suite and automatically inspecting every page using [OWASP ZAP](https://www.owasp.org/index.php/OWASP_Zed_Attack_Proxy_Project).  All High category risks are addressed immediately, Medium and Low category risks are assessed and triaged and usually added to an upcoming sprint for remediation.

## HTTP / HTTPS

All communications originating from outside of the MTS AWS VPC are made using TLS.  The TLS certificate is terminated at the publishing layer of the applciation.

All internal communications (comms inside the VPC) are made over HTTP only.