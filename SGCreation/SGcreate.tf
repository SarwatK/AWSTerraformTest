# Create a security group
resource "aws_security_group" "example_sg" {
  name        = "example-sg"
  description = "Example security group created with Terraform"
  vpc_id      = aws_vpc.example_vpc.id # Ensure you have a VPC defined or replace with an existing VPC ID

  # Inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows SSH access from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Allows HTTP access from anywhere
  }

  # Outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # Allows all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Tags (optional)
  tags = {
    Name = "example-security-group"
  }
}

# Define a VPC (if needed)
resource "aws_vpc" "MyVPC" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true

  tags = {
    Name = "Myvpc"
  }
}
