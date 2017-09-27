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
	availability_zone = "${var.availability_zone}"
	private_ip = "10.0.0.99"
	instance_type = "t2.micro"
	key_name = "${var.key_name}"
	associate_public_ip_address = true
	source_dest_check = false
	subnet_id = "${aws_subnet.public_subnet.id}"
	vpc_security_group_ids = ["${aws_security_group.JenkinsSG.id}"]

	# Create folder for transfering files
	provisioner "remote-exec" {
		inline = [
			"mkdir /home/ec2-user/script",
			"mkdir /home/ec2-user/jenkins_backup",
			"echo 'Create folders....DONE' "
		]
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
		}
	}

	# Move script/ -> $HOME/script/ on remote machine
	provisioner "file" {
		source      = "script/"
		destination = "$HOME/script"
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
		}
	}

	# Move jenkins-backup/ -> $HOME/jenkins_backup/ on remote machine
	provisioner "file" {
		source      = "jenkins_backup/"
		destination = "$HOME/jenkins_backup"
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
		}
	}

	# $HOME/script execution
	provisioner "remote-exec" {
		inline = [
			"sudo chmod 777 /$HOME/script/*",
			"ls -lart /$HOME/script/",
			"cd /$HOME/script",
			"./install.sh",
			"./install_java.sh",
			"./install_ansible.sh",
			"./install_maven.sh",
			"./install_terraform.sh",
			"./install_jenkins.sh",
			"echo '[Execution scripts DONE]' "
		]
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
		}
	}
	
	tags {Name = "Jenkins server"}
}

output "public-ip" {
	value = "${aws_eip.jenkins-public.public_ip}"
}

output "private-ip" {
	value = "${aws_instance.jenkins.private_ip}"
}