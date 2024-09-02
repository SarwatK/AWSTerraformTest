resource "aws_s3_bucket" "myawsbucket0168" {
  bucket = "myawsbucket0168"  # Ensure this name is globally unique
  acl    = "public-read-write"
 
  tags = {
    Name        = "myawsbucket0168"
    Environment = "Dev"
  }
}