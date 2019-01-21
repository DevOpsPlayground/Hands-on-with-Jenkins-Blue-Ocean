/*
The configuration file for setting up instances
*/

variable "jenkins_key" {
  type = "string"
}

variable "jenkins_key_name" {
  type = "string"
}

variable "count_var" {}

resource "aws_instance" "pg_instance_1" {
  ami                    = "ami-08569b978cc4dfa10"
  count                  = "${var.count_var}"
  instance_type          = "t2.medium"
  subnet_id              = "${aws_subnet.pg_subnet.id}"
  vpc_security_group_ids = ["${aws_default_security_group.pg_d_sg.id}"]
  key_name               = "${var.jenkins_key_name}"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("~/.ssh/${var.jenkins_key}")}"
  }

  provisioner "file" {
    source      = "config_files/"
    destination = "/tmp"
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/jenkins.sh",
      "scripts/jenkins_master_config.sh",
      "scripts/jenkins_agent_config.sh",
      "scripts/sonarqube_linux_installation.sh",
    ]
  }

  tags {
    Name = "${var.playground_date}_playground AWS instance 1"
  }
}

resource "aws_instance" "pg_instance_2" {
  ami                    = "ami-08569b978cc4dfa10"
  count                  = "${var.count_var}"
  instance_type          = "t2.small"
  subnet_id              = "${aws_subnet.pg_subnet.id}"
  vpc_security_group_ids = ["${aws_default_security_group.pg_d_sg.id}"]
  key_name               = "${var.jenkins_key_name}"

  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = "${file("~/.ssh/${var.jenkins_key}")}"
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/artifactory_installation.sh",
    ]
  }

  tags {
    Name = "${var.playground_date}_playground AWS instance 2"
  }
}
