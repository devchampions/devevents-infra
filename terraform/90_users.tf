
resource "aws_iam_user" "travis_deployer" {
  name = "travis_deployer"
}

resource "aws_iam_access_key" "travis_deployer_key" {
  user = "${aws_iam_user.travis_deployer.name}"
}

resource "aws_iam_user_policy_attachment" "travis_lambda_deployer_policy_attachment" {
  user       = "${aws_iam_user.travis_deployer.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSLambdaFullAccess"
}

resource "aws_iam_user_policy_attachment" "travis_s3_deployer_policy_attachment" {
  user       = "${aws_iam_user.travis_deployer.name}"
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3FullAccess"
}

resource "aws_iam_user_policy_attachment" "travis_cloud_front_deployer_policy_attachment" {
  user       = "${aws_iam_user.travis_deployer.name}"
  policy_arn = "arn:aws:iam::aws:policy/CloudFrontFullAccess"
}

resource "aws_iam_user_policy_attachment" "travis_code_deploy_deployer_policy_attachment" {
  user       = "${aws_iam_user.travis_deployer.name}"
  policy_arn = "arn:aws:iam::aws:policy/AWSCodeDeployFullAccess"
}

