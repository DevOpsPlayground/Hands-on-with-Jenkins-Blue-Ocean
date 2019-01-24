/*
Holds the "constants" used throughout the terraform code for ease of changing
*/

// Instance constants

variable "public_key_1" {
  type = "string"
}

variable "private_key_1" {
  type = "string"
}

variable "jm_ami_id" {
  type        = "string"
  description = "The AMI id used by the Jenkins Master instance"
}

variable "jm_instance_count_var" {
  type        = "string"
  description = "The number of Jenkins Master instances to be spun up"
}

variable "jm_instance_type" {
  type        = "string"
  description = "The size used by the Jenkins Master instance"
}

variable "arti_ami_id" {
  type        = "string"
  description = "The AMI id used by the Artifactory instance"
}

variable "arti_instance_count_var" {
  type        = "string"
  description = "The number of Artifactory instances to be spun up"
}

variable "arti_instance_type" {
  type        = "string"
  description = "The size used by the Artifactory instance"
}

variable "ssh_connection_user_1" {
  type        = "string"
  description = "User 1 used for the SSH connection"
}

// Network constants

variable "aws_provider_region" {
  type        = "string"
  description = "The region of the AWS provider"
}

variable "m_vpc_cidr_block" {
  type        = "string"
  description = "The cidr block of m_vpc"
}

variable "m_subnet_cidr_block" {
  type        = "string"
  description = "The cidr block of m_subnet"
}

variable "m_subnet_availability_zone" {
  type        = "string"
  description = "The availability zone of m_subnet"
}

variable "m_d_rt_cidr_block_1" {
  type        = "string"
  description = "The 1st cidr block of m_default route table"
}

// Security group ingress and egress constants

variable "ssh_port_number_ingress" {
  type        = "string"
  description = "The SSH port number used in the ingress rule"
}

variable "ssh_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of SSH cidr blocks used in the ingress rule"
}

variable "jenkins_port_number_ingress" {
  type        = "string"
  description = "The Jenkins port number used in the ingress rule"
}

variable "jenkins_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of Jenkins cidr blocks used in the ingress rule"
}

variable "arti_port_number_ingress" {
  type        = "string"
  description = "The Artifactory port number used in the ingress rule"
}

variable "arti_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of Artifactory cidr blocks used in the ingress rule"
}

variable "sonarqube_port_number_ingress" {
  type        = "string"
  description = "The SonarQube port number used in the ingress rule"
}

variable "sonarqube_cidr_blocks_ingress" {
  type        = "list"
  description = "The list of SonarQube cidr blocks used in the ingress rule"
}

// General constants

variable "tag_purpose_string" {
  type        = "string"
  description = "What is this resource's purpose"
}
