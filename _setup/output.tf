/*
The configuration file for defining the output
*/

output "jm_public_ip" {
  description = "Public ip of the Jenkins Master instance"
  value       = "${aws_instance.jm_instance.*.public_ip}"
}

output "jm_public_ip_jenkins" {
  description = "Public ip and port of the Jenkins Master instance"
  value       = "${formatlist("%s:%s",aws_instance.jm_instance.*.public_ip,"${var.jenkins_port_number_ingress}")}"
}

output "jm_public_ip_sonarqube" {
  description = "Public ip and port of SonarQube on the Jenkins Master instance"
  value       = "${formatlist("%s:%s",aws_instance.jm_instance.*.public_ip,"${var.sonarqube_port_number_ingress}")}"
}

output "arti_public_ip" {
  description = "Public ip of the Artifactory instance"
  value       = "${aws_instance.arti_instance.*.public_ip}"
}

output "arti_public_ip_arti" {
  description = "Public ip and port of the Artifactory instance"
  value       = "${formatlist("%s:%s",aws_instance.arti_instance.*.public_ip,"${var.arti_port_number_ingress}")}"
}
