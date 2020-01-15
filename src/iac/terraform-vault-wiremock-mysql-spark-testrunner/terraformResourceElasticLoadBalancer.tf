resource "aws_elb" "elb_spark" {
  security_groups = ["${aws_security_group.spark_elb.id}"]
  listener {
    lb_port           = 9002
    lb_protocol       = "http"
    instance_port     = 9002
    instance_protocol = "http"
  }
  availability_zones          = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400
  name = "elb-spark"
}

resource "aws_elb_attachment" "spark000" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.000.id}"
}

resource "aws_elb_attachment" "spark001" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.001.id}"
}

resource "aws_elb_attachment" "spark002" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.002.id}"
}

resource "aws_elb_attachment" "spark003" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.003.id}"
}

resource "aws_elb_attachment" "spark004" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.004.id}"
}

resource "aws_elb_attachment" "spark005" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.005.id}"
}

resource "aws_elb_attachment" "spark006" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.006.id}"
}

resource "aws_elb_attachment" "spark007" {
  elb      = "${aws_elb.elb_spark.id}"
  instance = "${aws_instance.ec2_spark.007.id}"
}

