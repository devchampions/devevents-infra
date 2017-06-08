
resource "aws_codedeploy_app" "dev_events_backend" {
  name = "dev_events_backend"
}

resource "aws_codedeploy_deployment_config" "dev_events_backend" {
  deployment_config_name = "dev_events_backend_deployment"
  minimum_healthy_hosts {
    type  = "HOST_COUNT"
    value = 1
  }
}

resource "aws_iam_role" "code_deployer" {
  name = "code_deployer"
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "codedeploy.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "code_deployer" {
  name       = "code_deployer"
  roles      = ["${aws_iam_role.code_deployer.name}"]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSCodeDeployRole"
}

resource "aws_codedeploy_deployment_group" "dev_events_backend" {

  app_name               = "${aws_codedeploy_app.dev_events_backend.name}"
  deployment_group_name  = "dev_events_deployment_group"
  service_role_arn       = "${aws_iam_role.code_deployer.arn}"
  deployment_config_name = "${aws_codedeploy_deployment_config.dev_events_backend.id}"

  ec2_tag_filter {
    key   = "Name"
    type  = "KEY_AND_VALUE"
    value = "dev_events_api"
  }

}
