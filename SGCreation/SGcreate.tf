# Create a security group
resource "aws_security_group" "Mysg" {
  name        = "Mysg"
  description = "Example security group created with Terraform"
  vpc_id      = "vpc-096fe330fb4667fe1"# Ensure you have a VPC defined or replace with an existing VPC ID

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
    Name = "MySg"
  }
}
