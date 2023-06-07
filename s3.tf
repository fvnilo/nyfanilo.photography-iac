resource "aws_s3_bucket" "bucket" {
  bucket = "nyfanilo.photography"

  tags = {
    Name = "nyfanilo.photography"
  }
}

resource "aws_s3_bucket_website_configuration" "redirect_to_instagram" {
  bucket = aws_s3_bucket.bucket.id

  redirect_all_requests_to {
    host_name = "www.instagram.com/nyfanilo.photography"
    protocol  = "https"
  }
}
