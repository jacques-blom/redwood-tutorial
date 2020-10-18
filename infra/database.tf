locals {
  name = "redwood-tutorial"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

data "aws_kms_secrets" "database_password" {
  secret {
    name    = "value"
    payload = ""

    context {
      service = local.name
    }
  }
}

resource "aws_ssm_parameter" "database_password" {
  name      = "/${local.name}/database/password"
  type      = "SecureString"
  value     = "${data.aws_kms_secrets.database_password.plaintext["value"]}"
  key_id    = "${aws_kms_key.main.arn}"
  overwrite = "true"
}

# module "db" {
#   source  = "terraform-aws-modules/rds/aws"
#   version = "~> 2.0"

#   name                            = "redwood-tutorial-postgres-db"

#   engine            = "postgres"
#   engine_version    = "11.7"
#   instance_class    = "db.t3.micro	"
#   allocated_storage = 0.1
#   storage_encrypted = false

#   # kms_key_id        = "arm:aws:kms:<region>:<account id>:key/<kms key id>"
#   name = "redwood-tutorial"

#   username = "redwood-tutorial"
#   password = "YourPwdShouldBeLongAndSecure!"
#   port     = "5432"

#   vpc_security_group_ids = [data.aws_security_group.default.id]

#   maintenance_window = "Mon:00:00-Mon:03:00"
#   backup_window      = "03:00-06:00"

#   # disable backups to create DB faster
#   backup_retention_period = 0

#   tags = {
#     Owner       = "user"
#     Environment = "dev"
#   }

#   enabled_cloudwatch_logs_exports = ["postgresql", "upgrade"]

#   # DB subnet group
#   subnet_ids = data.aws_subnet_ids.all.ids

#   # DB parameter group
#   family = "postgres9.6"

#   # DB option group
#   major_engine_version = "9.6"

#   # Snapshot name upon DB deletion
#   final_snapshot_identifier = "demodb"

#   # Database Deletion Protection
#   deletion_protection = false
# }