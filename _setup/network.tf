/*
The configuration file for setting up the initial network configurations
*/

provider "aws" {
  region = "ap-southeast-1"
}

resource "aws_vpc" "pg_vpc" {
  cidr_block = "192.0.0.0/16"

  tags {
    Name = "${var.playground_date}_playground virtual private network"
  }
}

resource "aws_subnet" "pg_subnet" {
  vpc_id            = "${aws_vpc.pg_vpc.id}"
  cidr_block        = "192.0.0.0/24"
  availability_zone = "ap-southeast-1a"

  map_public_ip_on_launch = true

  tags {
    Name = "${var.playground_date}_playground subnet"
  }
}

resource "aws_internet_gateway" "pg_igw" {
  vpc_id = "${aws_vpc.pg_vpc.id}"

  tags {
    Name = "${var.playground_date}_playground internet gateway"
  }
}

resource "aws_default_security_group" "pg_d_sg" {
  vpc_id = "${aws_vpc.pg_vpc.id}"

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 22
    to_port     = 22
    cidr_blocks = ["0.0.0.0/0"]
    description = "SSH port"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 8080
    to_port     = 8080
    cidr_blocks = ["0.0.0.0/0"]
    description = "Jenkins port"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 9000
    to_port     = 9000
    cidr_blocks = ["0.0.0.0/0"]
    description = "SonarQube port"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 8081
    to_port     = 8081
    cidr_blocks = ["0.0.0.0/0"]
    description = "JFrog Artifactory port"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = 8082
    to_port     = 8082
    cidr_blocks = ["0.0.0.0/0"]
    description = "Nexus port"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags {
    Name = "${var.playground_date}_playground default security group"
  }
}

resource "aws_default_route_table" "pg_d_rt" {
  default_route_table_id = "${aws_vpc.pg_vpc.default_route_table_id}"

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "${aws_internet_gateway.pg_igw.id}"
  }

  tags {
    Name = "${var.playground_date}_playground default route table"
  }
}
