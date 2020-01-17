resource "aws_instance" "ec2_testrunner" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.xlarge"
  key_name        = aws_key_pair.testrunner_key_pair.key_name
  security_groups = [aws_security_group.testrunner.name]
  tags = {
    Name = "Testrunner Server ${format("%03d", count.index)}"
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
    destination = "/home/ubuntu/.testrunner_dns"
  }
  provisioner "remote-exec" {
    inline = ["mkdir -p /tmp/config/zipster"]
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/.environment"
    destination = "/tmp/config/zipster/environment"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/.vault_dns"
    destination = "/tmp/config/zipster/vault_addr"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/.vault_initial_root_token"
    destination = "/tmp/config/zipster/vault_token"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/provision_testrunner.sh"
    destination = "/home/ubuntu/provision_testrunner.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision_testrunner.sh"]
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/run_testrunner.sh"
    destination = "/home/ubuntu/run_testrunner.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/run_testrunner.sh"]
  }
#  provisioner "remote-exec" {
#    inline = ["mkdir -p /home/ubuntu/src"]
#  }
#  provisioner "file" {
#    source      = "../../../src/"
#    destination = "/home/ubuntu/src"
#  }
#  provisioner "file" {
#    source      = "../../../pom.xml"
#    destination = "/home/ubuntu/pom.xml"
#  }

}

