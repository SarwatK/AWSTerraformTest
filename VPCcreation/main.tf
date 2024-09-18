terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

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

resource "aws_ec2_transit_gateway_vpc_attachment" "newattach" {
  transit_gateway_id = "tgw-0a0dd9319cce0019c"
  vpc_id = aws_vpc.my_vpc.id
  subnet_ids = [aws_subnet.my_subnet_public.id]

  tags = {
    Name = "newattach-tgw-vpc-attachment"
  }
}


# Define the Transit Gateway Route Table (if you don't already have one)
resource "aws_ec2_transit_gateway_route_table" "newrote" {
  transit_gateway_id = "tgw-0a0dd9319cce0019c"
  tags = {
    Name = "example-tgw-route-table"
  }
}

# Add a route to the Transit Gateway Route Table
resource "aws_ec2_transit_gateway_route" "first" {
  destination_cidr_block = "10.0.10.0/24,100.16.0.15/28,172.16.10.0/24" # The CIDR block for the route destination
  transit_gateway_route_table_id = aws_ec2_transit_gateway_route_table.newrote.id
  transit_gateway_attachment_id = aws_ec2_transit_gateway_vpc_attachment.newattach.id

}
