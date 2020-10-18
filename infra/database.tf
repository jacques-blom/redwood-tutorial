data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = data.aws_vpc.default.id
}

module "db" {
  source  = "terraform-aws-modules/rds-aurora/aws"
  version = "~> 2.0"

  name                            = "redwood-tutorial-aurora-db"

  engine                = "aurora-postgresql"
  engine_mode           = "serverless"
  engine_version        = "10.7"

  replica_scale_enabled = false
  replica_count         = 0

  subnets                         = data.aws_subnet_ids.all.ids
  vpc_id                          = data.aws_vpc.default.id
  instance_type                   = ""
  apply_immediately               = true
  allowed_security_groups         = [aws_security_group.public_access.id]
  publicly_accessible = true

  scaling_configuration = {
    auto_pause               = true
    max_capacity             = 2
    min_capacity             = 2
    seconds_until_auto_pause = 300
    timeout_action           = "ForceApplyCapacityChange"
  }
}

resource "aws_security_group" "public_access" {
  name        = "public-access"
  description = "For application servers"
  vpc_id      = data.aws_vpc.default.id
}