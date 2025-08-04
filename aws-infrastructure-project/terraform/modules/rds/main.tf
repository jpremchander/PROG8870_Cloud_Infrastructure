resource "aws_db_instance" "default" {
  allocated_storage    = 20
  storage_type       = "gp2"
  engine            = "mysql"
  engine_version     = "8.0"
  instance_class     = var.instance_class
  db_subnet_group_name = aws_db_subnet_group.default.name
  vpc_security_group_ids = [aws_security_group.default.id]
  db_name            = var.db_name
  username           = var.username
  password           = var.password
  skip_final_snapshot = true
  publicly_accessible = true

  tags = {
    Name = "MySQL-RDS-Instance"
  }
}

resource "aws_db_subnet_group" "default" {
  name       = "my-db-subnet-group"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "MyDBSubnetGroup"
  }
}

resource "aws_security_group" "default" {
  name        = "rds-sg"
  description = "Allow MySQL access"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # For this project only, restrict in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "RDS-Security-Group"
  }
}