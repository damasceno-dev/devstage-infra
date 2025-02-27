resource "random_id" "unique_suffix" {
  byte_length = 4
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.prefix}-rds-subnet-group-${random_id.unique_suffix.hex}"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "${var.prefix}-rds-subnet-group"
    IAC  = "True"
  }
}

resource "aws_security_group" "rds_sg" {
  name        = "${var.prefix}-rds-sg"
  description = "Allow inbound traffic for RDS"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # ⚠️ when the database needs to be accessed not only by the your home ip but by the aws app runner as well
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.prefix}-rds-sg"
    IAC  = "True"
  }
}

resource "aws_db_instance" "rds" {
  allocated_storage    = 15
  storage_type         = "gp2"
  engine              = "postgres"
  engine_version      = "15.7"
  instance_class      = "db.t3.micro" # Free tier eligible
  db_name             = var.db_name
  username           = var.db_username
  password           = var.db_password
  parameter_group_name = "default.postgres15"
  skip_final_snapshot = true
  publicly_accessible = true
  db_subnet_group_name = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids = [aws_security_group.rds_sg.id]
  depends_on = [aws_db_subnet_group.rds_subnet_group, aws_security_group.rds_sg] 
  tags = {
    Name = "${var.prefix}-rds"
    IAC  = "True"
  }
}