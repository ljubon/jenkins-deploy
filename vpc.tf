# Creating Virtual Private Cloud
resource "aws_vpc" "jenkins_vpc" {
	enable_dns_hostnames = true
	cidr_block = "${var.vpc_cidr}"
    tags { Name = "Jenkins VPC" }
}

# Public available subnet
resource "aws_subnet" "public_subnet" {
    vpc_id = "${aws_vpc.jenkins_vpc.id}"
    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1b"
    tags {Name = "Public Subnet"}
}

# Security group
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

# Assing public IP to connect from the internet
resource "aws_eip" "jenkins-public" {
	instance = "${aws_instance.jenkins.id}"
	associate_with_private_ip = "10.0.0.99"
	vpc = true
}

# Internet gateway to route traffic to Jenkins machine
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