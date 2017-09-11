variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "public_key_path" {}

variable "vpc_cidr" {
    description = "CIDR for the whole VPC"
    default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
    description = "CIDR for the Public Subnet"
    default = "10.0.0.0/24"
}

variable "aws_region" {
    description = "EC2 Region - eu-central-1 Frankfurt"
    default = "eu-central-1" 
	#	us-east-1 		N. Virgina	default 
	#	eu-central-1 	Frankfurt
}

variable "availability_zone" {
	description = "EC2 availability zone"
	#default = "us-east-1b"
	default = "eu-central-1b"

}

variable "amis" {
	description = "AMIs by region" # us-east-1
	default = "ami-d74be5b8"  
	# RedHat 14.04 LTS
	# us-east-1 	RHEL AMI ami-c998b6b2
	# eu-central-1 	RHEL AMI ami-d74be5b8
	
}