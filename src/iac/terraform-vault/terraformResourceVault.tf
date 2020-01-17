resource "aws_instance" "ec2_vault" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.vault_key_pair.key_name
  security_groups = [aws_security_group.vault.name]
  tags = {
    Name = "Vault Server ${format("%03d", count.index)}"
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = "${file("~/.ssh/id_rsa")}"
    host        = "${self.public_ip}"
    timeout     = "10m"
  }
  provisioner "remote-exec" {
    inline = ["mkdir -p /home/ubuntu/vault/config"]
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/vault.init.sh"
    destination = "/home/ubuntu/vault.init.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/vault.init.sh"]
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/vault.local.json"
    destination = "/home/ubuntu/vault/config/vault.local.json"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/vault.initialization.out.parse.sh"
    destination = "/home/ubuntu/vault.initialization.out.parse.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/vault.initialization.out.parse.sh"]
  }
  provisioner "file" {
    source = "../../../part_4_test_in_aws_environment/provisioning_scripts/provision_vault.sh"
    destination = "/home/ubuntu/provision_vault.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision_vault.sh"]
  }
}

