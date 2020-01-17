resource "aws_key_pair" "mysql_key_pair" {
  key_name   = "mysql_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "spark_key_pair" {
  key_name   = "spark_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "testrunner_key_pair" {
  key_name   = "testrunner_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

resource "aws_key_pair" "wiremock_key_pair" {
  key_name   = "wiremock_key_pair"
  public_key = file("~/.ssh/id_rsa.pub")
}

