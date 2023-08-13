resource "aws_instance" "instance" {

  ami                      = data.aws_ami.ami.id
  instance_type            = "t2.micro"
  vpc_security_group_ids  = ["sg-0baa986d8ebb5eeda"]

  tags = {
    Name = "chocolux-server"
  }
}

##output "server_output" {
#  value = aws_instance.instance
#}

resource "aws_route53_record" "record" {
  zone_id = "Z09760323G7SC2VABFTOY"
  name    = "chocolux.tadikonda.onilne"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.private_ip]
}

resource "null_resource" "content" {

  depends_on = [aws_route53_record.record]

  provisioner "local-exec" {
    command = "bash chocolux.sh"
  }
}