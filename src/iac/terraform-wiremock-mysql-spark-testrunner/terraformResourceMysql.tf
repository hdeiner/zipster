resource "aws_instance" "ec2_mysql" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.medium"
  key_name        = aws_key_pair.mysql_key_pair.key_name
  security_groups = [aws_security_group.mysql.name]
  tags = {
    Name = "Mysql Server ${format("%03d", count.index)}"
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
    destination = "/home/ubuntu/.mysql_dns"
  }
  provisioner "file" {
    source      = "../../../docker-compose-mysql-and-mysql-data.yml"
    destination = "/home/ubuntu/docker-compose-mysql-and-mysql-data.yml"
  }
  provisioner "file" {
    source      = "../../../mysql-data.tar.gz"
    destination = "/home/ubuntu/mysql-data.tar.gz"
  }
  provisioner "file" {
    source      = "../../../flyway-commandline-4.2.0-linux-x64.tar.gz"
    destination = "/home/ubuntu/flyway-commandline-4.2.0-linux-x64.tar.gz"
  }
  provisioner "file" {
    source      = "../../../flyway-4.2.0/sql/V1_1__Zipcode_Schema.sql"
    destination = "/home/ubuntu/V1_1__Zipcode_Schema.sql"
  }
  provisioner "file" {
    source      = "../../../flyway-4.2.0/sql/V1_2__Zipcode_Static_Data.sql"
    destination = "/home/ubuntu/V1_2__Zipcode_Static_Data.sql"
  }
  provisioner "file" {
    source      = "../../../flyway-4.2.0/sql/V2_1__Add_Spatial_Data.sql"
    destination = "/home/ubuntu/V2_1__Add_Spatial_Data.sql"
  }
  provisioner "file" {
    source      = "../../../flyway-4.2.0/sql/V3_1__Zipcode_Test_Data.sql"
    destination = "/home/ubuntu/V3_1__Zipcode_Test_Data.sql"
  }
  provisioner "file" {
    source      = "../../../flyway-4.2.0/conf/flyway.conf"
    destination = "/home/ubuntu/flyway.conf"
  }
  provisioner "file" {
    source      = "../../../flyway-4.2.0/drivers/mysql-connector-java-8.0.18.jar"
    destination = "/home/ubuntu/mysql-connector-java-8.0.18.jar"
  }
  provisioner "file" {
    source      = "../../../part_4_test_in_aws_environment/provisioning_scripts/provision_mysql.sh"
    destination = "/home/ubuntu/provision_mysql.sh"
  }
  provisioner "remote-exec" {
    inline = ["chmod +x /home/ubuntu/provision_mysql.sh"]
  }
}

