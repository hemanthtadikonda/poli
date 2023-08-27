resource "aws_instance" "main" {
  ami                     = data.aws_ami.ami.id
  instance_type           = var.instance_type
  vpc_security_group_ids  = [aws_security_group.allow_all.id]
  tags                    = { Name = "chocolux-ec2"}
  user_data               = file("${path.module}/userdata.sh")

}

resource "aws_security_group" "allow_all" {
  name        = "allow_all"
  description = "Allow TLS inbound traffic"
  vpc_id      = var.vpc_id

  ingress {
    description      = "WEB"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "SSH"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_all_sg"
  }
}

resource "aws_route53_record" "main" {
  zone_id = var.zone_id
  name    = "chocolux-tf"
  type    = "A"
  ttl     = 30
  records = [aws_instance.main.public_ip]
}