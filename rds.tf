resource "random_password" "db_password" {
  length  = 16
  special = true
}

resource "aws_db_instance" "mysql" {
  allocated_storage    = 20
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  db_name              = "appdb"
  username             = "admin"
  password             = random_password.db_password.result
  skip_final_snapshot  = true
  publicly_accessible  = false
}