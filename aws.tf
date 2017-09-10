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
	
	provisioner "file" {
		# copy all files from 
		# script directory to home directory on remote machine
		source      = "script/"
		destination = "$HOME"
		
		connection {
			type		= "ssh"
			user		= "ec2-user"
			agent		= true
		}
	
	}
	
	provisioner "remote-exec" {
		inline = [
			"mkdir script",
			# now we have jenkins and script folder in $HOME directory
			"mv *.sh /$HOME/script/",
			"echo 'Scripts moved to /$HOME/script/'",
			"echo 'Change permission for exucution'",
			"sudo chmod 777 /$HOME/script/*",
			"echo '[Permission changed succsefully on all files /home/ec2-user]'",
			"ls -lart /$HOME/script/",
			"ls -lart /$HOME/jenkins/",
			"echo '[Start provisining...]'",
			"cd /$HOME/script",
			"./install.sh",
			"./install_java.sh",
			"./install_ansible.sh",
			"./install_maven.sh",
			"./install_jenkins.sh",
			"./install_terraform.sh",
			"echo '[Provisining done]'"
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