resource "aws_instance" "ec2_instance" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id
  associate_public_ip_address = true

  tags = {
    Name = "EC2Instance-${count.index}"
  }

  security_groups = [aws_security_group.ec2_sg.name]

  count = var.instance_count
}

resource "aws_security_group" "ec2_sg" {
  name        = "ec2_security_group"
  description = "Allow SSH inbound traffic"

  ingress {
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

output "ec2_public_ip" {
  value = aws_instance.ec2_instance.*.public_ip
}