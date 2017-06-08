
resource "aws_key_pair" "dev_events_key" {
  key_name = "dev_events_admin_key" 
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDqln5qiHnd8NLz60GOGW/Rqv25rK78yiG5kyv2LeBBe0JVVoJ/BOA7T/BuW/GhuT12SE2o4ZiRlgchdzMld4AaAAwTCUC/A5RdcogjktrMAda9UQnDLwfmohJmAskC6ibq05oqDb3RWfIik2psjJJkZasJVI0OuwDf1DpXjDVjId9y2xkM9sVGjzz8ApM/J6YWVEZY0n2V5qT8Xi5orDQgwtrxrEDcpN5AldC5KnovohUqbCyZSKwenWJ4Rq5uM2rccQR4wMWT0aHh8Sf8k1OTdQqEqc86MBNZKhP4ICOfnBb3/U6DIfC6aK6qDjMqXqU3ojyCmQWu0x3N1sF9tay5 admins@dev.events"
}

resource "aws_iam_role" "code_deploy_instance" {
  name               = "code_deploy_instance"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy" "code_deploy_instance" {
  name   = "code_deploy_instance_policy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:Get*",
        "s3:List*"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "code_deploy_instance" {
  name       = "code_deploy"
  roles      = ["${aws_iam_role.code_deploy_instance.name}"]
  policy_arn = "${aws_iam_policy.code_deploy_instance.arn}"
}

resource "aws_iam_instance_profile" "code_deploy_instance" {
  name  = "code_deploy"
  role  = "${aws_iam_role.code_deploy_instance.name}"
}

resource "aws_instance" "dev_events_server" {
  ami = "${data.aws_ami.base_image.id}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.code_deploy_instance.name}"
  tags {
    Name = "dev_events_api"
  }
  root_block_device {
    volume_size = "20"
  }
  key_name = "${aws_key_pair.dev_events_key.key_name}"
  subnet_id = "${aws_subnet.dev_events_subnet_d.id}"
  vpc_security_group_ids = [ "${aws_security_group.dev_events_security.id}" ]
}
