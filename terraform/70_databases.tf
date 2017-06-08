
resource "aws_db_instance" "dev_events_db" {

  allocated_storage      = 20
  storage_type           = "gp2"
  instance_class         = "db.t2.micro"

  engine                 = "postgres"
  engine_version         = "9.6.2"

  identifier             = "devevents-db"
  name                   = "devevents_db"
  username               = "master"
  password               = "${var.db_password}"

  apply_immediately      = true

  vpc_security_group_ids = [ "${aws_security_group.dev_events_security.id}" ]
  db_subnet_group_name   = "${aws_db_subnet_group.default.name}"

}