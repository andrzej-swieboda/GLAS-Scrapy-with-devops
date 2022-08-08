#This terraform script provisions a VPC for production environment
#complete with a NAT and Internet Gateways

resource "aws_vpc" "Main" {
  cidr_block           = var.main_vpc_cidr
  enable_dns_hostnames = true
}

resource "aws_internet_gateway" "igw-main" {
  vpc_id = aws_vpc.Main.id

  tags = {
    Name = "igw-Main"
  }
}

 resource "aws_eip" "nateIP" {
   vpc   = true
 }

 #Creating the NAT Gateway using subnet_id and allocation_id
 resource "aws_nat_gateway" "NATgw" {
   allocation_id = aws_eip.nateIP.id
   subnet_id = aws_subnet.publicsubnets.id
 }