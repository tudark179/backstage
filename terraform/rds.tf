
module "db" {
  source    = "terraform-aws-modules/rds/aws"
  version   = "2.22.0"

  identifier = "backstage-db"

  engine            = "postgres"
  engine_version    = "13.2"
  instance_class    = "db.t3.micro"
  allocated_storage = 20

  name     = "backstagedb"
  username = var.db_username
  password = var.db_password
  port     = "5432"

  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_ids             = module.vpc.private_subnets

  maintenance_window = "Mon:00:00-Mon:03:00"
  backup_window      = "03:00-06:00"
}
