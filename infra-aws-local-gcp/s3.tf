resource "aws_s3_bucket" "data" {
  bucket = "costellr-data-perf" 

  tags = {
    Name        = "costellr-data-perf"
    Environment = "Dev"
  }
}
