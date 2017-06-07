
provider "aws" {
  access_key = "${var.aws_access_key_id}"
  secret_key = "${var.aws_secret_key}"
  region     = "us-east-1"
}

data "aws_availability_zones" "available" {

}

data "aws_ami" "base_image" {
  most_recent = true
  filter {
    name      = "owner-alias"
    values    = ["amazon"]
  }
  filter {
    name      = "name"
    values    = ["amzn-ami-vpc-nat*"]
  }
}
