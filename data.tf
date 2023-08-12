data "aws_ami" "ami" {
  name_regex = "Centos-8-DevOps-Practice"
  owners     = ["973714476881"]
}