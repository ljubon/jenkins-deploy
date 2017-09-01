provider "aws" {
    access_key 	= "${var.aws_access_key}"
    secret_key 	= "${var.aws_secret_key}"
    region 		= "${var.aws_region}"
}

# Public key for SSH 
resource "aws_key_pair" "ljubon-key-jenkins" {
  key_name   = "${var.key_name}"
  public_key = "${file(var.public_key_path)}"
}

# RHEL instance for Jenkins server
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
	
	provisioner "file" {
		source      = "script/install.sh"
		destination = "/home/ec2-user/install.sh"
		
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
		}
	
	}
	
	provisioner "remote-exec" {
		inline = [
			"sudo chmod +x /home/ec2-user/install.sh",
			"echo 'CHANGE PERMISION DONE'",
			"./install.sh"
		]
		
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
			#script_path = "/home/ec2-user/install.sh"
		}
	}
	
	tags {Name = "Jenkins server"}
}

output "Public_Jenkins_IP" {
	value = "${aws_eip.jenkins-public.public_ip}"
}

output "Private_Jenkins_IP" {
	value = "${aws_instance.jenkins.private_ip}"
}