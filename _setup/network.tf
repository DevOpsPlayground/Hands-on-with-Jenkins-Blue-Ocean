/*
The configuration file for setting up the initial network configurations
*/

provider "aws" {
  region = "${var.aws_provider_region}"
}

resource "aws_vpc" "m_vpc" {
  cidr_block = "${var.m_vpc_cidr_block}"

  tags {
    Name = "${var.tag_purpose_string} virtual private network"
  }
}

resource "aws_subnet" "m_subnet" {
  vpc_id            = "${aws_vpc.m_vpc.id}"
  cidr_block        = "${var.m_subnet_cidr_block}"
  availability_zone = "${var.m_subnet_availability_zone}"

  map_public_ip_on_launch = true

  tags {
    Name = "${var.tag_purpose_string} subnet"
  }
}

resource "aws_internet_gateway" "m_igw" {
  vpc_id = "${aws_vpc.m_vpc.id}"

  tags {
    Name = "${var.tag_purpose_string} internet gateway"
  }
}

resource "aws_default_security_group" "m_d_sg" {
  vpc_id = "${aws_vpc.m_vpc.id}"

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = "${var.ssh_port_number_ingress}"
    to_port     = "${var.ssh_port_number_ingress}"
    cidr_blocks = "${var.ssh_cidr_blocks_ingress}"
    description = "SSH port"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = "${var.jenkins_port_number_ingress}"
    to_port     = "${var.jenkins_port_number_ingress}"
    cidr_blocks = "${var.jenkins_cidr_blocks_ingress}"
    description = "Jenkins port"
  }

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = "${var.arti_port_number_ingress}"
    to_port     = "${var.arti_port_number_ingress}"
    cidr_blocks = "${var.arti_cidr_blocks_ingress}"
    description = "Artifactory and SonarQube port"
  }

  /*
      ingress {
        protocol    = "tcp"
        self        = true
        from_port   = "${var.sonarqube_port_number_ingress}"
        to_port     = "${var.sonarqube_port_number_ingress}"
        cidr_blocks = "${var.sonarqube_cidr_blocks_ingress}"
        description = "SonarQube port"
      }
    */

  ingress {
    protocol    = "tcp"
    self        = true
    from_port   = "${var.theia_port_number_ingress}"
    to_port     = "${var.theia_port_number_ingress}"
    cidr_blocks = "${var.theia_cidr_blocks_ingress}"
    description = "Theia port"
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags {
    Name = "${var.tag_purpose_string} default security group"
  }
}

resource "aws_default_route_table" "m_d_rt" {
  default_route_table_id = "${aws_vpc.m_vpc.default_route_table_id}"

  route {
    cidr_block = "${var.m_d_rt_cidr_block_1}"
    gateway_id = "${aws_internet_gateway.m_igw.id}"
  }

  tags {
    Name = "${var.tag_purpose_string} default route table"
  }
}
