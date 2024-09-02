resource "aws_s3_bucket" "myawsbucket0168" {
  bucket = "myawsbucket0168"  # Ensure this name is globally unique
 
  tags = {
    Name        = "myawsbucket0168"
    Environment = "Dev"
  }
}