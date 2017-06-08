
resource "aws_s3_bucket" "dev_events_code" {
  bucket                  = "dev-events-code"
  acl                     = "private"
  region                  = "${var.aws_region}"
}

resource "aws_s3_bucket" "dev_events_billing" {
  bucket                  = "dev-events-billing"
  acl                     = "private"
  region                  = "${var.aws_region}"
}

resource "aws_s3_bucket" "dev_events_logs" {
  bucket                  = "dev-events-logs"
  acl                     = "private"
  region                  = "${var.aws_region}"
}

