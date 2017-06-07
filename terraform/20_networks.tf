
resource "aws_vpc" "dev_events_vpc" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
}

resource "aws_subnet" "dev_events_subnet" {
  cidr_block = "${aws_vpc.dev_events_vpc.cidr_block}"
  map_public_ip_on_launch = "true"
  vpc_id = "${aws_vpc.dev_events_vpc.id}"
}

resource "aws_default_security_group" "default" {
  vpc_id = "${aws_vpc.dev_events_vpc.id}"
}

resource "aws_security_group" "dev_events_security" {
  name = "dev_events_security"
  description = "dev.events port openings"
  vpc_id = "${aws_vpc.dev_events_vpc.id}"

  #
  # incoming traffic
  #

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 443
    to_port = 443
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  #
  # outgoing traffic
  #

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_internet_gateway" "dev_events_igw" {
  vpc_id = "${aws_vpc.dev_events_vpc.id}"
}

resource "aws_route_table" "dev_events_routing" {
  vpc_id = "${aws_vpc.dev_events_vpc.id}"
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.dev_events_igw.id}"
  }
}

resource "aws_main_route_table_association" "dev_events_routing_a" {
  vpc_id = "${aws_vpc.dev_events_vpc.id}"
  route_table_id = "${aws_route_table.dev_events_routing.id}"
}

