/*
Holds the variables used throughout the terraform code
*/

// Instance constants

variable "public_key_1" {
  type        = "string"
  description = "The public key of the AWS key pair used to connect to the instances"
}

variable "private_key_1" {
  type        = "string"
  description = "The private key of the AWS key pair used to connect to the instances"
}

variable "jm_ami_id" {
  type        = "string"
  description = "The AMI id used by the Jenkins Master Linux instance"
}

variable "jm_instance_count_var" {
  type        = "string"
  description = "The number of Jenkins Master Linux instances to be spun up"
  default     = 1
}

variable "jm_instance_type" {
  type        = "string"
  description = "The size used by the Jenkins Master Linux instance"
  default     = "t2.medium"
}

variable "arti_ami_id" {
  type        = "string"
  description = "The AMI id used by the Artifactory Linux instance"
}

variable "arti_instance_count_var" {
  type        = "string"
  description = "The number of Artifactory Linux instances to be spun up"
  default     = 1
}

variable "arti_instance_type" {
  type        = "string"
  description = "The size used by the Artifactory Linux instance"
  default     = "t2.small"
}

variable "ssh_connection_user_1" {
  type        = "string"
  description = "The default SSH user 1 used for the connection, determined by the AMI selected"
}

// Network constants

variable "aws_provider_region" {
  type        = "string"
  description = "The region the AWS provider in which the resources will be running. For example, EU (Ireland) or Asia Pacific (Singapore), with values eu-west-1 and ap-southeast-1 respectively"
}

variable "m_vpc_cidr_block" {
  type        = "string"
  description = "The cidr block range of IP addresses for the virtual private cloud"
  default     = "192.0.0.0/16"
}

variable "m_subnet_cidr_block" {
  type        = "string"
  description = "The cidr block range of IP addresses for the subnet"
  default     = "192.0.0.0/24"
}

variable "m_subnet_availability_zone" {
  type        = "string"
  description = "The availability zone within the provider region the resources will be running. The value will often be the value for the provider region followed by a letter, for e.g. eu-west-1a and ap-southeast-1b"
}

variable "m_d_rt_cidr_block_1" {
  type        = "string"
  description = "The 1st cidr block range of IP addresses used by the default route table"
  default     = "0.0.0.0/0"
}

// Security group ingress and egress constants

variable "ssh_port_number_ingress" {
  type        = "string"
  description = "The SSH port number used in the ingress rule"
  default     = 22
}

variable "ssh_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of SSH cidr blocks used in the ingress rule"
  default     = ["0.0.0.0/0"]
}

variable "jenkins_port_number_ingress" {
  type        = "string"
  description = "The Jenkins port number used in the ingress rule"
  default     = 8080
}

variable "jenkins_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of Jenkins cidr blocks used in the ingress rule"
  default     = ["0.0.0.0/0"]
}

variable "arti_port_number_ingress" {
  type        = "string"
  description = "The Artifactory port number used in the ingress rule"
  default     = 8081
}

variable "arti_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of Artifactory cidr blocks used in the ingress rule"
  default     = ["0.0.0.0/0"]
}

variable "sonarqube_port_number_ingress" {
  type        = "string"
  description = "The SonarQube port number used in the ingress rule"
  default     = 8081
}

variable "sonarqube_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of SonarQube cidr blocks used in the ingress rule"
  default     = ["0.0.0.0/0"]
}

// General constants

variable "tag_purpose_string" {
  type        = "string"
  description = "What is this resource's purpose"
}
