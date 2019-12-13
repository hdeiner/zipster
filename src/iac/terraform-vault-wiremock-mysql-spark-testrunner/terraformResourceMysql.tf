resource "aws_instance" "ec2_mysql" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.mysql_key_pair.key_name
  security_groups = [aws_security_group.mysql.name]
  tags = {
    Name = "Mysql Server ${format("%03d", count.index)}"
  }
}

