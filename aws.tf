provider "aws" {
    access_key 	= "${var.aws_access_key}"
    secret_key 	= "${var.aws_secret_key}"
    region 		= "${var.aws_region}"
}

resource "aws_key_pair" "ljubon-key" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

resource "aws_vpc" "jenkins_vpc" {
	enable_dns_hostnames = true
	cidr_block = "${var.vpc_cidr}"
    tags { Name = "default VPC" }
}

resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.jenkins_vpc.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1b"
    tags {Name = "Public Subnet"}
}

resource "aws_security_group" "JenkinsSG" {
    name = "vpc_jenkins"
    description = "Allow all"
    vpc_id = "${aws_vpc.jenkins_vpc.id}"

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

resource "aws_eip" "jenkins-public" {
	instance = "${aws_instance.jenkins.id}"
	associate_with_private_ip = "10.0.0.99"
	vpc = true
}

resource "aws_internet_gateway" "jenkins" {
	vpc_id = "${aws_vpc.jenkins_vpc.id}"
	tags {Name = "InternetGateway"}
}

resource "aws_route_table" "public_subnet" {
    vpc_id = "${aws_vpc.jenkins_vpc.id}"

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = "${aws_internet_gateway.jenkins.id}"
    }
	tags {Name = "Public Subnet"}
}

resource "aws_route_table_association" "public_subnet" {
    subnet_id = "${aws_subnet.public_subnet.id}"
    route_table_id = "${aws_route_table.public_subnet.id}"
}

resource "aws_instance" "jenkins" {
	ami = "${var.amis}"
	availability_zone = "us-east-1b"
	private_ip = "10.0.0.99"
	instance_type = "t2.micro"
	key_name = "${var.key_name}"
	associate_public_ip_address = true
	source_dest_check = false
	subnet_id = "${aws_subnet.public_subnet.id}"
	vpc_security_group_ids = ["${aws_security_group.JenkinsSG.id}"]
	tags {Name = "Jenkins server"}
}

output "Public_Jenkins_IP" {
	value = "${aws_eip.jenkins-public.public_ip}"
}

output "Private_Jenkins_IP" {
	value = "${aws_instance.jenkins.private_ip}"
}

