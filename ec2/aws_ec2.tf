terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 2.70"
    }
  }
}

provider "aws" {
  profile = "default"
  region  = "us-east-1"
}

resource "aws_key_pair" "aws_ec2" {
  key_name   = "ec2_test"
  public_key = file("./ec2_test.pub")
}


resource "aws_security_group" "aws_ec2" {
  name        = "aws_ec2-security-group"
  description = "Allow HTTP, HTTPS and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform"
  }
}


resource "aws_instance" "aws_ec2" {
  key_name      = aws_key_pair.aws_ec2.key_name
  ami           = "ami-06b263d6ceff0b3dd"
  instance_type = "t2.micro"
  monitoring    = true

  tags = {
    Name        = "Application Server"
    Environment = "production"

  }

  vpc_security_group_ids = [
    aws_security_group.aws_ec2.id
  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./ec2_test.pem")
    host        = self.public_ip
  }



  ebs_block_device {
    device_name = "/dev/sda1"
    volume_type = "gp2"
    volume_size = 30
  }

  provisioner "local-exec" {
    command = "echo ${aws_instance.aws_ec2.public_ip} > ip_address.txt"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y install nginx",
      "sudo systemctl start nginx"
    ]
  }
}

# EIP = Elastic IP resource
resource "aws_eip" "aws_ec2" {
  vpc      = true
  instance = aws_instance.aws_ec2.id
}