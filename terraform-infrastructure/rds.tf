
resource "aws_db_subnet_group" "postgres_subnet_group" {
  name = "postgres-subnet-group"
  subnet_ids = [
    aws_subnet.private_1.id,
    aws_subnet.private_2.id
  ]

  tags = {
    Name = "postgres-subnet-group"
  }
}

# RDS instance
resource "aws_db_instance" "postgres" {
  identifier                 = "my-postgres-db"
  engine                     = "postgres" //var.db_engine
  engine_version             = var.db_engine_version
  instance_class             = var.db_instance_class
  auto_minor_version_upgrade = true
  allocated_storage          = 20

  db_name  = var.db_name
  username = var.db_username
  password = var.db_password

  db_subnet_group_name   = aws_db_subnet_group.postgres_subnet_group.name
  vpc_security_group_ids = [aws_security_group.postgres_sg.id]

  publicly_accessible = false
  skip_final_snapshot = true

  tags = {
    Environment = var.db_environment
  }
}
