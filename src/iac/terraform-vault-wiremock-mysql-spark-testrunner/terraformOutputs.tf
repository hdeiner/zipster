output "vault_dns" {
  value = [aws_instance.ec2_vault.*.public_dns]
}

output "wiremock_dns" {
  value = [aws_instance.ec2_wiremock.*.public_dns]
}

output "mysql_dns" {
  value = [aws_instance.ec2_mysql.*.public_dns]
}

output "spark_dns" {
  value = [aws_instance.ec2_spark.*.public_dns]
}

output "spark_elb_dns" {
  value = [aws_elb.elb_spark.dns_name]
}

output "testrunner_dns" {
  value = [aws_instance.ec2_testrunner.*.public_dns]
}

