module "kms_key" {
  source                  = "git::https://github.com/cloudposse/terraform-aws-kms-key.git?ref=0.7.0"
  namespace               = "redwood-tutorial"
  stage                   = "prod"
  name                    = "main"
  description             = "Main KMS key for the Redwood Tutorial"
  enable_key_rotation     = false
  alias                   = "alias/redwood-tutorial"
}