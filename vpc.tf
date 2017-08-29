resource "aws_vpc" "default" {
    cidr_block = "${var.vpc_cidr}"
    enable_dns_hostnames = true
    tags { Name = "Jenkins-aws-vpc" }
}

resource "aws_internet_gateway" "default" {
    vpc_id = "${aws_vpc.default.id}"
	tags {Name = "InternetGateway"}
}


resource "aws_eip" "jenkins" {
    instance = "${aws_instance.jenkins.id}"
    vpc = true
}

/*
  Public Subnet
*/

resource "aws_subnet" "us-east-1-public" {
    vpc_id = "${aws_vpc.default.id}"

    cidr_block = "${var.public_subnet_cidr}"
    availability_zone = "us-east-1b"

    tags {Name = "Public Subnet"}
}
