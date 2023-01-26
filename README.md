# DNS Takeover Checker

Simple bash script based on the @projectdiscovery article :relaxed:(https://blog.projectdiscovery.io/guide-to-dns-takeovers/) to detect DNS takeover. 

## Usage:
./DNStakeover_checker.sh -d example.com

> ##### If the status is '**REFUSED**' or '**SERVFAIL**' the domain is vulnerable.

## Taking control of the domain

The exact method that is use by ProjectDiscovery to takeover the domain will depend on the DNS provider, but in general, the process looks something like this:

  1.  Register an account with the DNS provider
  2.  Create a DNS zone
  3.  Check the nameservers that we were assigned to the zone
  4.  If the nameservers don't match any of the authoritative nameservers of the domain, delete the DNS zone and return to step 2
  5.  Create DNS records for the domain (e.g. an A record pointing to an IP address that we control)
  6.  Wait for propagation (usually an hour or 2)
