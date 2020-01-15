resource "aws_instance" "ec2_spark" {
  count                    = 8
  ami                      = "ami-759bc50a"
  instance_type            = "t2.small"
  key_name                 = aws_key_pair.spark_key_pair.key_name
  security_groups          = [aws_security_group.spark.name]
  tags = {
    Name = "Spark Server ${format("%03d", count.index)}"
  }
}

