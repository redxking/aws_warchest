# aws_warchest
Collection of Terraform, Cloudformation and Serverless Framework Resources and Modules for AWS


## ToDo:
    - Automate TGW Peering via Resource Tagging and STNO.
    - Route traffic thru Network Account only via TGW?
    - Conditionally create NAT Gateways or NexGen FW devices in Network VPC?
    - 


### Account(s)
| Account Name | Account Id   | Description                              |
| :----------- | :----------- | :--------------------------------------- |
| master       | 922481319116 | Root and Organization Management Account |
| sandbox      | 535005587294 | Sandbox Environment Account              |
| develop      | 648027066783 | Develop Environment Account              |
| staging      | 875358465253 | Staging Environment Account              |
| product      | 727515289814 | Product Environment Account              |
| network      | 485355486848 | Network Environment Account              |
| commons      | 187739744457 | Commons Environment Account              |

### Account(s) / Region(s) - IP Addressing
| Account Id   | Account Name | Type   | Name          | Region         | Availability Zone | CIDR              | Net Mask        | Range                             | Usable                            | Hosts |
| :----------- | :----------- | :----- | :-----------  | :------------- | :---------------- | :---------------- | :-------------- | :-------------------------------- | :-------------------------------- | :---- |
| 922481319116 | master       | -      | -             | -              | -                 | -                 | -               | -                                 | -                                 | -     |
| 648027066783 | develop      | region | -             | us-east-1      | -                 | 172.16.128.0/17   | 255.255.128.0   | 172.16.128.0   - 172.16.255.255   | 172.16.128.1   - 172.16.255.254   | 32768 |
| -            | -            | vpc    | workload      | us-east-1      | -                 | 172.16.128.0/21   | 255.255.248.0   | 172.16.128.0   - 172.16.135.255   | 172.16.128.1   - 172.16.153.254   | 2048  |
| -            | -            | subnet | transit-1a    | us-east-1      | us-east-1a        | 172.16.128.0/24   | 255.255.255.0   | 172.16.128.0   - 172.16.128.255   | 172.16.128.1   - 172.16.128.254   | 256   |
| -            | -            | subnet | transit-1b    | us-east-1      | us-east-1b        | 172.16.129.0/24   | 255.255.255.0   | 172.16.129.0   - 172.16.129.255   | 172.16.129.1   - 172.16.129.254   | 256   |
| -            | -            | subnet | protected-1a  | us-east-1      | us-east-1a        | 172.16.130.0/24   | 255.255.255.0   | 172.16.130.0   - 172.16.130.255   | 172.16.130.1   - 172.16.130.254   | 256   |
| -            | -            | subnet | protected-1b  | us-east-1      | us-east-1b        | 172.16.131.0/24   | 255.255.255.0   | 172.16.131.0   - 172.16.131.255   | 172.16.131.1   - 172.16.131.254   | 256   |
| -            | -            | subnet | private-1a    | us-east-1      | us-east-1a        | 172.16.132.0/24   | 255.255.255.0   | 172.16.132.0   - 172.16.132.255   | 172.16.132.1   - 172.16.132.254   | 256   |
| -            | -            | subnet | private-1b    | us-east-1      | us-east-1b        | 172.16.133.0/24   | 255.255.255.0   | 172.16.133.0   - 172.16.133.255   | 172.16.133.1   - 172.16.133.254   | 256   |
| -            | -            | subnet | public-1a     | us-east-1      | us-east-1a        | 172.16.134.0/24   | 255.255.255.0   | 172.16.134.0   - 172.16.134.255   | 172.16.134.1   - 172.16.134.254   | 256   |
| -            | -            | subnet | public-1b     | us-east-1      | us-east-1b        | 172.16.135.0/24   | 255.255.255.0   | 172.16.135.0   - 172.16.135.255   | 172.16.135.1   - 172.16.135.254   | 256   |
| 875358465253 | staging      | region | -             | us-east-1      | -                 | 172.16.128.0/17   | 255.255.128.0   | 172.16.128.0   - 172.16.255.255   | 172.16.128.1   - 172.16.255.254   | 32768 |
| -            | -            | vpc    | workload      | us-east-1      | -                 | 172.16.136.0/21   | 255.255.248.0   | 172.16.136.0   - 172.16.143.255   | 172.16.136.1   - 172.16.143.254   | 2048  |
| -            | -            | subnet | transit-1a    | us-east-1      | us-east-1a        | 172.16.136.0/24   | 255.255.255.0   | 172.16.136.0   - 172.16.136.255   | 172.16.136.1   - 172.16.136.254   | 256   |
| -            | -            | subnet | transit-1b    | us-east-1      | us-east-1b        | 172.16.137.0/24   | 255.255.255.0   | 172.16.137.0   - 172.16.137.255   | 172.16.137.1   - 172.16.137.254   | 256   |
| -            | -            | subnet | protected-1a  | us-east-1      | us-east-1a        | 172.16.138.0/24   | 255.255.255.0   | 172.16.138.0   - 172.16.138.255   | 172.16.138.1   - 172.16.138.254   | 256   |
| -            | -            | subnet | protected-1b  | us-east-1      | us-east-1b        | 172.16.139.0/24   | 255.255.255.0   | 172.16.139.0   - 172.16.139.255   | 172.16.139.1   - 172.16.139.254   | 256   |
| -            | -            | subnet | private-1a    | us-east-1      | us-east-1a        | 172.16.140.0/24   | 255.255.255.0   | 172.16.140.0   - 172.16.140.255   | 172.16.140.1   - 172.16.140.254   | 256   |
| -            | -            | subnet | private-1b    | us-east-1      | us-east-1b        | 172.16.141.0/24   | 255.255.255.0   | 172.16.141.0   - 172.16.141.255   | 172.16.141.1   - 172.16.141.254   | 256   |
| -            | -            | subnet | public-1a     | us-east-1      | us-east-1a        | 172.16.142.0/24   | 255.255.255.0   | 172.16.142.0   - 172.16.142.255   | 172.16.142.1   - 172.16.142.254   | 256   |
| -            | -            | subnet | public-1b     | us-east-1      | us-east-1b        | 172.16.143.0/24   | 255.255.255.0   | 172.16.143.0   - 172.16.143.255   | 172.16.143.1   - 172.16.143.254   | 256   |
| 727515289814 | product      | region | -             | us-east-1      | -                 | 172.16.128.0/17   | 255.255.128.0   | 172.16.128.0   - 172.16.255.255   | 172.16.128.1   - 172.16.255.254   | 32768 |
| -            | -            | vpc    | workload      | us-east-1      | -                 | 172.16.144.0/21   | 255.255.192.0   | 172.16.192.0   - 172.16.255.255   | 172.16.192.1   - 172.16.255.254   | 16384 |
| -            | -            | subnet | transit-1a    | us-east-1      | us-east-1a        | 172.16.144.0/24   | 255.255.255.0   | 172.16.192.0   - 172.16.192.63    | 172.16.192.1   - 172.16.192.62    | 62    |
| -            | -            | subnet | transit-1b    | us-east-1      | us-east-1b        | 172.16.145.0/24   | 255.255.255.0   | 172.16.192.64  - 172.16.192.127   | 172.16.192.65  - 172.16.192.126   | 62    |
| -            | -            | subnet | protected-1a  | us-east-1      | us-east-1a        | 172.16.146.0/24   | 255.255.254.0   | 172.16.194.0   - 172.16.195.255   | 172.16.194.1   - 172.16.195.254   | 510   |
| -            | -            | subnet | protected-1b  | us-east-1      | us-east-1b        | 172.16.147.0/24   | 255.255.254.0   | 172.16.196.0   - 172.16.197.255   | 172.16.196.1   - 172.16.197.254   | 510   |
| -            | -            | subnet | private-1a    | us-east-1      | us-east-1a        | 172.16.148.0/24   | 255.255.240.0   | 172.16.208.0   - 172.16.223.255   | 172.16.208.1   - 172.16.223.254   | 4000  |
| -            | -            | subnet | private-1b    | us-east-1      | us-east-1b        | 172.16.149.0/24   | 255.255.240.0   | 172.16.224.0   - 172.16.239.255   | 172.16.224.1   - 172.16.239.254   | 4000  |
| -            | -            | subnet | public-1a     | us-east-1      | us-east-1a        | 172.16.150.0/24   | 255.255.254.0   | 172.16.200.0   - 172.16.201.255   | 172.16.200.1   - 172.16.201.254   | 510   |
| -            | -            | subnet | public-1b     | us-east-1      | us-east-1b        | 172.16.151.0/24   | 255.255.254.0   | 172.16.200.0   - 172.16.203.255   | 172.16.202.1   - 172.16.203.254   | 510   |
| 187739744457 | commons      | region | -             | us-east-1      | -                 | 172.16.128.0/17   | 255.255.128.0   | 172.16.128.0   - 172.16.255.255   | 172.16.128.1   - 172.16.255.254   | 32768 |
| -            | -            | vpc    | automations   | us-east-1      | -                 | 172.16.152.0/21   | 255.255.224.0   | 172.16.160.0   - 172.16.191.255   | 172.16.160.1   - 172.16.191.254   | 8190  |
| -            | -            | subnet | transit-1a    | us-east-1      | us-east-1a        | 172.16.152.0/24   | 255.255.255.0   | 172.16.160.0   - 172.16.160.31    | 172.16.160.1   - 172.16.160.30    | 30    |
| -            | -            | subnet | transit-1b    | us-east-1      | us-east-1b        | 172.16.153.0/24   | 255.255.255.0   | 172.16.160.32  - 172.16.160.63    | 172.16.160.33  - 172.16.160.62    | 30    |
| -            | -            | subnet | private-1a    | us-east-1      | us-east-1a        | 172.16.154.0/21   | 255.255.248.0   | 172.16.168.0   - 172.16.175.255   | 172.16.168.1   - 172.16.175.254   | 2000  |
| -            | -            | subnet | private-1b    | us-east-1      | us-east-1b        | 172.16.155.0/21   | 255.255.248.0   | 172.16.176.0   - 172.16.183.255   | 172.16.176.1   - 172.16.183.254   | 2000  |
| -            | -            | subnet | public-1a     | us-east-1      | us-east-1a        | 172.16.156.0/24   | 255.255.255.0   | 172.16.161.0   - 172.16.161.255   | 172.16.161.1   - 172.16.161.254   | 254   |
| -            | -            | subnet | public-1b     | us-east-1      | us-east-1b        | 172.16.157.0/24   | 255.255.255.0   | 172.16.162.0   - 172.16.162.255   | 172.16.162.1   - 172.16.162.254   | 254   |
| 485355486848 | network      | region | -             | us-east-1      | -                 | 172.16.128.0/17   | 255.255.128.0   | 172.16.128.0   - 172.16.255.255   | 172.16.128.1   - 172.16.255.254   | 32768 |
| -            | -            | vpc    | firewall      | us-east-1      | -                 | 172.16.158.0/21   | 255.255.248.0   | 172.16.144.0   - 172.16.151.256   | 172.16.144.1   - 172.16.151.254   | 2048  |
| -            | -            | subnet | transit-1a    | us-east-1      | us-east-1a        | 172.16.158.0/24   | 255.255.255.0   | 172.16.144.0   - 172.16.144.255   | 172.16.144.1   - 172.16.144.254   | 256   |
| -            | -            | subnet | transit-1b    | us-east-1      | us-east-1b        | 172.16.159.0/24   | 255.255.255.0   | 172.16.145.0   - 172.16.145.255   | 172.16.145.1   - 172.16.145.254   | 256   |
| -            | -            | subnet | management-1a | us-east-1      | us-east-1a        | 172.16.160.0/24   | 255.255.255.0   | 172.16.146.0   - 172.16.146.255   | 172.16.146.1   - 172.16.146.254   | 256   |
| -            | -            | subnet | management-1b | us-east-1      | us-east-1b        | 172.16.161.0/24   | 255.255.255.0   | 172.16.147.0   - 172.16.147.255   | 172.16.147.1   - 172.16.147.254   | 256   |
| -            | -            | subnet | public-1a     | us-east-1      | us-east-1a        | 172.16.162.0/24   | 255.255.255.0   | 172.16.148.0   - 172.16.148.255   | 172.16.148.1   - 172.16.148.254   | 256   |
| -            | -            | subnet | public-1b     | us-east-1      | us-east-1b        | 172.16.163.0/24   | 255.255.255.0   | 172.16.149.1   - 172.16.149.255   | 172.16.149.1   - 172.16.149.254   | 256   |
| 535005587294 | sandbox      | region | -             | us-east-1      | -                 | 172.16.128.0/17   | 255.255.128.0   | 172.16.128.0   - 172.16.255.255   | 172.16.128.1   - 172.16.255.254   | 32768 |
| -            | -            | vpc    | sandbox       | us-east-1      | -                 | 172.16.164.0/21   | 255.255.248.0   | 172.16.150.0   - 172.16.151.256   | 172.16.144.1   - 172.16.151.254   | 2048  |
| -            | -            | subnet | public-1a     | us-east-1      | us-east-1a        | 172.16.164.0/24   | 255.255.255.0   | 172.16.151.0   - 172.16.144.255   | 172.16.144.1   - 172.16.144.254   | 256   |
| -            | -            | subnet | public-1b     | us-east-1      | us-east-1b        | 172.16.165.0/24   | 255.255.255.0   | 172.16.152.0   - 172.16.145.255   | 172.16.145.1   - 172.16.145.254   | 256   |
| -            | -            | subnet | private-1a    | us-east-1      | us-east-1a        | 172.16.166.0/24   | 255.255.255.0   | 172.16.153.0   - 172.16.146.255   | 172.16.146.1   - 172.16.146.254   | 256   |
| -            | -            | subnet | private-1b    | us-east-1      | us-east-1b        | 172.16.167.0/24   | 255.255.255.0   | 172.16.154.0   - 172.16.147.255   | 172.16.147.1   - 172.16.147.254   | 256   |


### Enables AWS Account (Commons) as Delegated Admin for Organization
    - https://docs.aws.amazon.com/accounts/latest/reference/using-orgs-trusted-access.html
    - https://docs.aws.amazon.com/accounts/latest/reference/using-orgs-delegated-admin.html