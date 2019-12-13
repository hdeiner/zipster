resource "aws_instance" "ec2_wiremock" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.wiremock_key_pair.key_name
  security_groups = [aws_security_group.wiremock.name]
  tags = {
    Name = "Wiremock Server ${format("%03d", count.index)}"
  }
}

