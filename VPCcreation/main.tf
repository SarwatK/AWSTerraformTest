resource "aws_vpc" "my_vpc" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
 
  tags = {
    Name = "MyVPC"
  }
}
 
resource "aws_subnet" "my_subnet_public" {
  vpc_id                  = aws_vpc.my_vpc.id
  cidr_block              = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone       = "us-east-1a"
 
  tags = {
    Name = "PublicSubnet"
  }
}
 
resource "aws_subnet" "my_subnet_private" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
 
  tags = {
    Name = "PrivateSubnet"
  }
}
 
resource "aws_internet_gateway" "my_igw" {
  vpc_id = aws_vpc.my_vpc.id
 
  tags = {
    Name = "MyInternetGateway"
  }
}
 
resource "aws_route_table" "my_route_table_public" {
  vpc_id = aws_vpc.my_vpc.id
 
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
 
  tags = {
    Name = "PublicRouteTable"
  }
}
 
resource "aws_route_table_association" "my_rta_public" {
  subnet_id      = aws_subnet.my_subnet_public.id
  route_table_id = aws_route_table.my_route_table_public.id
}
 
# Optional: Route table for the private subnet if you need specific routes
resource "aws_route_table" "my_route_table_private" {
  vpc_id = aws_vpc.my_vpc.id
 
  tags = {
    Name = "PrivateRouteTable"
  }
}
 
resource "aws_route_table_association" "my_rta_private" {
  subnet_id      = aws_subnet.my_subnet_private.id
  route_table_id = aws_route_table.my_route_table_private.id
}