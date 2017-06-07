
resource "aws_s3_bucket" "dev_events_code" {
  bucket                  = "dev-events-code"
  acl                     = "private"
  region                  = "${var.aws_region}"
}

