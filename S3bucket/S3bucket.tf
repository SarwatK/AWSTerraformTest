resource "aws_s3_bucket" "SGbackup" {
  bucket = "SGbackup"  # Ensure this name is globally unique
  acl    = "Public"
 
  tags = {
    Name        = "SGbackup"
    Environment = "Dev"
  }
}