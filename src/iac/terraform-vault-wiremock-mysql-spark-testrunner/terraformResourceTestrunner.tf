resource "aws_instance" "ec2_testrunner" {
  count           = 1
  ami             = "ami-759bc50a"
  instance_type   = "t2.small"
  key_name        = aws_key_pair.testrunner_key_pair.key_name
  security_groups = [aws_security_group.testrunner.name]
  tags = {
    Name = "Testrunner Server ${format("%03d", count.index)}"
  }
}

