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
  name    = "chocolux"
  type    = "A"
  ttl     = 30
  records = [aws_instance.instance.public_ip]
}

resource "null_resource" "content" {

  depends_on = [aws_route53_record.record]

  connection {
    type     = "ssh"
    user     = "root"
    password = "DevOps321"
    host     = aws_instance.instance.public_ip
  }

  provisioner "file" {
    source      = "chocolux.sh"
    destination = "/tmp/chocolux.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/chocolux.sh",
      "/tmp/chocolux.sh args",
    ]
  }
}