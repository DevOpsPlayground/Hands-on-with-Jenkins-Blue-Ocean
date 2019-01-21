/*
The configuration file for defining the output
*/

output "public_ip_1" {
  description = "Public ip of instance 1"
  value       = "${aws_instance.pg_instance_1.*.public_ip}"
}

output "public_ip_1_jenkins" {
  description = "Public ip of Jenkins on instance 1"
  value       = "${formatlist("%s:%s",aws_instance.pg_instance_1.*.public_ip,"8080")}"
}

output "public_ip_1_SonarQube" {
  description = "Public ip of SonarQube on instance 1"
  value       = "${formatlist("%s:%s",aws_instance.pg_instance_1.*.public_ip,"8081")}"
}

output "public_ip_2" {
  description = "Public ip of instance 2"
  value       = "${aws_instance.pg_instance_2.*.public_ip}"
}

output "public_ip_2_Artifactory" {
  description = "Public ip of Artifactory on instance 2"
  value       = "${formatlist("%s:%s",aws_instance.pg_instance_2.*.public_ip,"8081")}"
}

output "artifactory_URL" {
  description = "Artifactory URL for use in Jenkins tool"
  value       = "${formatlist("http://%s:%s/artifactory",aws_instance.pg_instance_2.*.public_ip,"8081")}"
}
