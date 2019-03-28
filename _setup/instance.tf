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
    source      = "config_files/admin_accnt_config.xml"
    destination = "/tmp/admin_accnt_config.xml"
  }

  provisioner "file" {
    source      = "config_files/jenkins_config.xml"
    destination = "/tmp/jenkins_config.xml"
  }

  provisioner "file" {
    source      = "config_files/sonar"
    destination = "/tmp/sonar"
  }

  provisioner "file" {
    source      = "scripts/sonarqube_linux_installation.sh"
    destination = "/tmp/sonarqube_linux_installation.sh"
  }

  provisioner "file" {
    source      = "scripts/theia_installation.sh"
    destination = "/tmp/theia_installation.sh"
  }

  provisioner "file" {
    source      = "scripts/docker_username_configuration.sh"
    destination = "/tmp/docker_username_configuration.sh"
  }

  provisioner "remote-exec" {
    scripts = [
      "scripts/docker_installation.sh",
      "scripts/jenkins.sh",
      "scripts/jenkins_master_config.sh",
      "scripts/jenkins_agent_config.sh",
    ]
  }

  provisioner "remote-exec" {
    inline = [
      "chmod -R 755 /tmp/scripts/sonarqube_linux_installation.sh",
      "/tmp/sonarqube_linux_installation.sh ${var.sonarqube_port_number_ingress}",
      "chmod -R 755 /tmp/docker_username_configuration.sh",
      "/tmp/docker_username_configuration.sh ${var.jenkins_user} ${var.linux_user_1}",
      "chmod -R 755 /tmp/theia_installation.sh",
      "/tmp/theia_installation.sh ${var.theia_port_number_ingress}",
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
