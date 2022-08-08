 # Creating Public Subnets
resource "aws_subnet" "publicsubnets" {
  vpc_id = aws_vpc.Main.id
  cidr_block = "$var.public_subnets"
}

 # Creating Private Subnets
 resource "aws_subnet" "privatesubnets" {
   vpc_id =  aws_vpc.Main.id
   cidr_block = "${var.private_subnets}"          # CIDR block of private subnets
 }