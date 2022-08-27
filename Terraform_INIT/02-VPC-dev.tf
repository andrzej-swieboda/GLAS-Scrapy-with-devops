#This terraform script provisions a VPC for production environment
#complete with a NAT and Internet Gateways

#Creating VPC

resource "aws_vpc" "vpc" {
  cidr_block           = var.dev_vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "${var.app_env}-vpc"
  }
}

#Creating Internet gateway and attaching to VPC
resource "aws_internet_gateway" "igw-dev" {
  vpc_id = aws_vpc.vpc.id


  tags = {
    Name = "${var.app_env}-igw"
  }
}

#Create public subnets
resource "aws_subnet" "publicsubnets" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.public_subnets}"
}

#Create private subnets
resource "aws_subnet" "privatesubnets" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "${var.private_subnets}"
}

#Route table for public subnet
resource "aws_route_table" "PublicRT" {    # Creating RT for Public Subnet
  vpc_id =  aws_vpc.vpc.id
    route {
      cidr_block = "0.0.0.0/0"               # Traffic from Public Subnet reaches Internet via Internet Gateway
      gateway_id = aws_internet_gateway.igw-dev.id
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

#Route table for Private Subnet's
  resource "aws_route_table" "PrivateRT" {  
    vpc_id = aws_vpc.vpc.id
      route {
        cidr_block = "0.0.0.0/0"             # Traffic from Private Subnet reaches Internet via NAT Gateway
        nat_gateway_id = aws_nat_gateway.NATgw.id
      }
}

#Route table Association with Public Subnet's
resource "aws_route_table_association" "PublicRTassociation" {
  subnet_id = aws_subnet.publicsubnets.id
  route_table_id = aws_route_table.PublicRT.id
}
 
#Route table Association with Private Subnet's
resource "aws_route_table_association" "PrivateRTassociation" {
  subnet_id = aws_subnet.privatesubnets.id
  route_table_id = aws_route_table.PrivateRT.id
}
