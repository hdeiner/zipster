resource "aws_instance" "ec2_wiremock" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.wiremock_key_pair.key_name
  security_groups = [aws_security_group.wiremock.name]
  tags = {
    Name = "Wiremock Server ${format("%03d", count.index)}"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host        = "${self.public_ip}"
    timeout     = "10m"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/.environment"
    destination = "/home/ubuntu/.environment"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/.vault_dns"
    destination = "/home/ubuntu/.vault_dns"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/.vault_initial_root_token"
    destination = "/home/ubuntu/.vault_initial_root_token"
  }
  provisioner "file" {
    content     = "${self.public_dns}"
    destination = "/home/ubuntu/.wiremock_dns"
  }
  provisioner "remote-exec" {
    inline = ["mkdir -p /home/ubuntu/wiremock"]
  }
  provisioner "file" {
    source      = "../../../wiremock/"
    destination = "/home/ubuntu/wiremock"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/provision_wiremock.sh"
    destination = "/home/ubuntu/provision_wiremock.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision_wiremock.sh"]
  }
}

