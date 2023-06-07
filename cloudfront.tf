data "aws_acm_certificate" "issued" {
  provider = aws.virginia
  domain   = "nyfanilo.photography"
  statuses = ["ISSUED"]
}

data "aws_cloudfront_cache_policy" "cache_optimized" {
  name = "Managed-CachingOptimized"
}

resource "aws_cloudfront_distribution" "s3_distribution" {
  origin {
    domain_name = aws_s3_bucket_website_configuration.redirect_to_instagram.website_endpoint
    origin_id   = aws_s3_bucket_website_configuration.redirect_to_instagram.website_endpoint

    custom_origin_config {
      http_port                = 80
      https_port               = 443
      origin_keepalive_timeout = 5
      origin_protocol_policy   = "http-only"
      origin_read_timeout      = 30
      origin_ssl_protocols = [
        "TLSv1.2",
      ]
    }
  }

  enabled         = true
  is_ipv6_enabled = false

  aliases = var.site_urls

  default_cache_behavior {
    cache_policy_id = data.aws_cloudfront_cache_policy.cache_optimized.id
    target_origin_id = aws_s3_bucket_website_configuration.redirect_to_instagram.website_endpoint

    allowed_methods  = ["GET", "HEAD"]
    cached_methods   = ["GET", "HEAD"]
    compress         = true

    viewer_protocol_policy = "redirect-to-https"
  }

  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
      locations        = []
    }
  }

  viewer_certificate {
    acm_certificate_arn            = data.aws_acm_certificate.issued.arn
    cloudfront_default_certificate = false
    minimum_protocol_version       = "TLSv1.2_2021"
    ssl_support_method             = "sni-only"
  }
}

