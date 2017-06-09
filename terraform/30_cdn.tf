
resource "aws_cloudfront_origin_access_identity" "origin_access_identity" {

}

resource "aws_cloudfront_distribution" "dev_events_cdn_distribution" {

  origin {
    domain_name = "${aws_s3_bucket.dev_events_web.bucket_domain_name}"
    origin_id   = "S3-${aws_s3_bucket.dev_events_web.bucket}"
    s3_origin_config { 
      origin_access_identity = "${aws_cloudfront_origin_access_identity.origin_access_identity.cloudfront_access_identity_path}"
    }
  }

  enabled             = true
  is_ipv6_enabled     = true
  default_root_object = "index.html"

  aliases             = [ "dev.events" ]

  retain_on_delete    = false

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  logging_config {
    include_cookies = false
    bucket          = "${aws_s3_bucket.dev_events_logs.bucket_domain_name}"
    prefix          = "devevents-cloudfront"
  }

  default_cache_behavior {

    allowed_methods  = ["DELETE", "GET", "HEAD", "OPTIONS", "PATCH", "POST", "PUT"]
    cached_methods   = ["GET", "HEAD"]

    target_origin_id = "S3-${aws_s3_bucket.dev_events_web.bucket}"

    forwarded_values {
      query_string = true
      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "allow-all"

    min_ttl                = 0
    default_ttl            = 60
    max_ttl                = 60

  }

  price_class = "PriceClass_All"

}

