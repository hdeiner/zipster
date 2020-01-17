resource "aws_instance" "ec2_spark" {
  count                    = 8
  ami                      = "ami-759bc50a"
  instance_type            = "t2.small"
  key_name                 = aws_key_pair.spark_key_pair.key_name
  security_groups          = [aws_security_group.spark.name]
  tags = {
    Name = "Spark Server ${format("%03d", count.index)}"
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
    destination = "/home/ubuntu/.spark_dns"
  }
  provisioner "file" {
    content     = "${aws_elb.elb_spark.dns_name}"
    destination = "/home/ubuntu/.spark_elb_dns"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/provision_zipster-spark.sh"
    destination = "/home/ubuntu/provision_zipster-spark.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision_zipster-spark.sh"]
  }
}

