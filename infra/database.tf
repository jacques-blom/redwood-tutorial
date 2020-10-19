locals {
  name = "redwood-tutorial"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_security_group" "default" {
  vpc_id = data.aws_vpc.default.id
  name   = "default"
}

data "aws_kms_secrets" "database_password" {
  secret {
    name    = "value"
    payload = "AQICAHglkqt28XQOry5l20Fd7eSn/CUc3Nd2gOMTKTNw2jspYgH/zvKIQLyZyyHB9fOcbln2AAAAcjBwBgkqhkiG9w0BBwagYzBhAgEAMFwGCSqGSIb3DQEHATAeBglghkgBZQMEAS4wEQQMAS8MsuDXd09iJLK1AgEQgC/mwhAbNZNDcbUg/vO5wf49fbKlbP0ZNkA550gm0dL9ukAbwiPbzAFVC+ujHnnXRA=="

    context = {
      service = local.name
    }
  }
}

resource "aws_ssm_parameter" "database_password" {
  name      = "/${local.name}/database/password"
  type      = "SecureString"
  value     = data.aws_kms_secrets.database_password.plaintext["value"]
  key_id    = aws_kms_key.ssm.arn
  overwrite = "true"
}

module "db" {
  source  = "terraform-aws-modules/rds/aws"
  version = "~> 2.0"

  identifier = "redwood-tutorial"
  name       = "redwood-tutorial-postgres-db"

  engine            = "postgres"
  engine_version    = "11.7"
  instance_class    = "db.t3.micro"
  allocated_storage = 1
  storage_encrypted = false

  username = "app"
  password = aws_ssm_parameter.database_password.value
  port     = "5432"

  vpc_security_group_ids = [data.aws_security_group.default.id]
  subnet_ids             = data.aws_subnet_ids.all.ids

  maintenance_window = "Sun:00:00-Sun:03:00"
  backup_window      = "03:00-06:00"

  backup_retention_period = 0

  deletion_protection = false
}