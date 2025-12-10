Terraform used the selected providers to generate the following
execution plan. Resource actions are indicated with the following
symbols:
  + create

Terraform will perform the following actions:

  # aws_vpc.datacenter_vpc will be created
  + resource "aws_vpc" "datacenter_vpc" {
      + arn                                  = (known after apply)
      + assign_generated_ipv6_cidr_block     = true
      + cidr_block                           = "10.0.0.0/16"
      + default_network_acl_id               = (known after apply)
      + default_route_table_id               = (known after apply)
      + default_security_group_id            = (known after apply)
      + dhcp_options_id                      = (known after apply)
      + enable_dns_hostnames                 = (known after apply)
      + enable_dns_support                   = true
      + enable_network_address_usage_metrics = (known after apply)
      + id                                   = (known after apply)
      + instance_tenancy                     = "default"
      + ipv6_association_id                  = (known after apply)
      + ipv6_cidr_block                      = (known after apply)
      + ipv6_cidr_block_network_border_group = (known after apply)
      + main_route_table_id                  = (known after apply)
      + owner_id                             = (known after apply)
      + tags                                 = {
          + "Name" = "datacenter-vpc"
        }
      + tags_all                             = {
          + "Name" = "datacenter-vpc"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.

Changes to Outputs:
  + vpc_cidr_block      = "10.0.0.0/16"
  + vpc_id              = (known after apply)
  + vpc_ipv6_cidr_block = (known after apply)

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

aws_vpc.datacenter_vpc: Creating...
aws_vpc.datacenter_vpc: Still creating... [10s elapsed]
aws_vpc.datacenter_vpc: Creation complete after 11s [id=vpc-977f9e3432b238443]

Apply complete! Resources: 1 added, 0 changed, 0 destroyed.

Outputs:

vpc_cidr_block = "10.0.0.0/16"
vpc_id = "vpc-977f9e3432b238443"
vpc_ipv6_cidr_block = "2400:6500:e3cb:6c00::/56"
