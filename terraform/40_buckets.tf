
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

resource "aws_s3_bucket_policy" "dev_events_billing_policy" {
  bucket                  = "${aws_s3_bucket.dev_events_billing.id}"
  policy                  = <<EOF
{
  "Version": "2008-10-17",
  "Id": "Policy1335892530063",
  "Statement": [
    {
      "Sid": "Stmt1335892150622",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::386209384616:root"
      },
      "Action": [
        "s3:GetBucketAcl",
        "s3:GetBucketPolicy"
      ],
      "Resource": "arn:aws:s3:::dev-events-billing"
    },
    {
      "Sid": "Stmt1335892526596",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::386209384616:root"
      },
      "Action": [
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::dev-events-billing/*"
    }
  ]
}
EOF
}

resource "aws_s3_bucket" "dev_events_logs" {
  bucket                  = "dev-events-logs"
  acl                     = "private"
  region                  = "${var.aws_region}"
}

