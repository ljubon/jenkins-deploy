# /*
  # Jenkins Servers
# */
# resource "aws_vpc" "jenkins" {
    # cidr_block = "${var.vpc_cidr}"
    # enable_dns_hostnames = true
    # tags { Name = "jenkins-public-server" }
# }

# resource "aws_eip" "jenkins-public" {
    # instance = "${aws_instance.jenkins.id}"
    # vpc = true
# }
# resource "aws_subnet" "public_subnet" {
    # vpc_id = "${aws_vpc.jenkins.id}"
    # cidr_block = "${var.public_subnet_cidr}"
    # availability_zone = "us-east-1b"

    # tags {Name = "Public Subnet"}
# }

# resource "aws_security_group" "JenkinsSG" {
    # name = "vpc_jenkins"
    # description = "Allow incoming HTTP connections."
    # vpc_id = "${aws_vpc.jenkins.id}"
	
    # ingress {
        # from_port = 80
        # to_port = 80
        # protocol = "tcp"
        # cidr_blocks = ["0.0.0.0/0"]
    # }
    # ingress {
        # from_port = 443
        # to_port = 443
        # protocol = "tcp"
        # cidr_blocks = ["0.0.0.0/0"]
    # }
    # ingress {
        # from_port = -1
        # to_port = -1
        # protocol = "icmp"
        # cidr_blocks = ["0.0.0.0/0"]
    # }
	# ingress {
        # from_port = 22
        # to_port = 22
        # protocol = "tcp"
        # cidr_blocks = ["${var.vpc_cidr}"]
    # }
	# egress { # SSH
        # from_port = 22
        # to_port = 22
        # protocol = "tcp"
        # cidr_blocks = ["${var.vpc_cidr}"]
    # }
	# tags {Name = "JenkinsSG"}
# }

# resource "aws_internet_gateway" "jenkins" {
    # vpc_id = "${aws_vpc.jenkins.id}"
	# tags {Name = "InternetGateway"}
# }