resource "aws_rds_cluster" "aurora_mysql" {
  cluster_identifier      = "aurora-mysql-cluster"
  engine                  = "aurora-mysql"
  engine_version          = "8.0.mysql_aurora.3.04.0"
  master_username         = "admin"
  master_password         = random_password.db_password.result
  backup_retention_period = 5
  skip_final_snapshot     = true
}

resource "aws_rds_cluster_instance" "aurora_mysql_instance" {
  count               = 1
  identifier          = "aurora-mysql-instance-${count.index}"
  cluster_identifier  = aws_rds_cluster.aurora_mysql.id
  instance_class      = "db.t3.medium"   # <-- updated to a supported instance
  engine              = aws_rds_cluster.aurora_mysql.engine
  publicly_accessible = false
}

resource "random_password" "db_password" {
  length           = 16
  special          = true
  override_special = "!#$%&()*+,-.:;<=>?[]^_{|}~"
}
