# Configure the Alicloud Provider
#provider "alicloud" {
#  access_key = "LTAINiPpr5MTHT8e"
#  secret_key = "Y3y5SdqExDLipK6qjThUDYNkbsEpzx"
#  region     = "eu-central-1"
#}


#Very basic example of alibaba terraform usage
#Loads of examples here - https://www.terraform.io/docs/providers/alicloud/index.html and here - https://github.com/alibaba/terraform-provider
#Note need to install terraform, goland and then alibab provider (see https://github.com/alibaba/terraform-provider/releases)

resource "alicloud_vpc" "default" { 
    name = "tf-vpc" 
    cidr_block = "${var.vpc_cidr}" 
  } 

