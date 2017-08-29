provider "aws" {
    access_key 	= "${var.aws_access_key}"
    secret_key 	= "${var.aws_secret_key}"
    region 		= "${var.aws_region}"
}
resource "aws_key_pair" "ljubon-key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_instance" "jenkins" {
    ami = "${var.amis}"
    availability_zone = "us-east-1b"
	private_ip = "10.0.0.99"
    instance_type = "t2.micro"
    key_name = "${var.key_name}"
    #associate_public_ip_address = true
	subnet_id = "${aws_subnet.public_subnet.id}"
	
    tags {Name = "Jenkins server"}
}

resource "aws_vpc" "jenkins-vpc" {
    enable_dns_hostnames = true
	cidr_block = "${var.vpc_cidr}"
    tags { Name = "default VPC" }
}

resource "aws_eip" "jenkins-public" {
    instance = "${aws_instance.jenkins.id}"
    vpc = true
}

resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.jenkins-vpc.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1b"
    tags {Name = "Public Subnet"}
}

resource "aws_security_group" "JenkinsSG" {
    name = "vpc_jenkins"
    description = "Allow incoming HTTP connections."
    vpc_id = "${aws_vpc.jenkins-vpc.id}"
	
    ingress {
		from_port   = 0
		to_port     = 65535
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}    
	
	egress {
		from_port   = 0
		to_port     = 65535
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
    ingress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}    
	
	egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	tags {Name = "JenkinsSG - allow all"}
}

resource "aws_internet_gateway" "jenkins" {
    vpc_id = "${aws_vpc.jenkins-vpc.id}"
	tags {Name = "InternetGateway"}
}

output "Public_Jenkins_IP" {
	value = "${aws_eip.jenkins-public.public_ip}"
}
output "Private_Jenkins_IP" {
	value = "${aws_instance.jenkins.private_ip}"
}

