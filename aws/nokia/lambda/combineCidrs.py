#note - all parts of the whole subnet must be present before netaddr will summarize
import netaddr
from netaddr import IPNetwork
iplist =[
    IPNetwork('10.105.4.0/25'), 
    IPNetwork('10.105.4.128/25'), 
    IPNetwork('10.105.206.0/27'),
    IPNetwork('10.105.206.32/27'),
    IPNetwork('10.105.206.64/27'),
    IPNetwork('10.105.206.96/27'),
    ]

summary = netaddr.cidr_merge(iplist)

print (summary)


