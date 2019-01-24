/*
The configuration file for setting up instances
*/

resource "aws_instance" "jm_instance" {
  ami                    = "${var.jm_ami_id}"
  count                  = "${var.jm_instance_count_var}"
  instance_type          = "${var.jm_instance_type}"
  subnet_id              = "${aws_subnet.m_subnet.id}"
  vpc_security_group_ids = ["${aws_default_security_group.m_d_sg.id}"]
  key_name               = "${var.public_key_1}"

  connection {
    type        = "ssh"
    user        = "${var.ssh_connection_user_1}"
    private_key = "${file("~/.ssh/${var.private_key_1}")}"
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
    Name = "${var.tag_purpose_string} Jenkins Master instance ${count.index + 1}"
  }
}

resource "aws_instance" "arti_instance" {
  ami                    = "${var.arti_ami_id}"
  count                  = "${var.arti_instance_count_var}"
  instance_type          = "${var.arti_instance_type}"
  subnet_id              = "${aws_subnet.m_subnet.id}"
  vpc_security_group_ids = ["${aws_default_security_group.m_d_sg.id}"]
  key_name               = "${var.public_key_1}"

  connection {
    type        = "ssh"
    user        = "${var.ssh_connection_user_1}"
    private_key = "${file("~/.ssh/${var.private_key_1}")}"
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/artifactory_installation.sh",
    ]
  }

  tags {
    Name = "${var.tag_purpose_string} Artifactory instance ${count.index + 1}"
  }
}
