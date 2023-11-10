provider "aws" {
  region = "ap-south-1"
}

resource "aws_security_group" "feedbook_sg" {
  name        = "feedbook-sg"
  description = "A security group in Terraform for feedbook"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "feedbook_ec2" {
  ami           = "ami-0aeeebd8d2ab47354"
  instance_type = "t2.micro"
  key_name      = "reader-app" 

  security_groups = [aws_security_group.feedbook_sg.feedbook-sg]

  tags = {
    Name = "feedbookEC2"
  }
}

output "public_ip" {
  value = aws_instance.example.public_ip
}