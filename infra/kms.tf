resource "aws_kms_key" "ssm" {
  enable_key_rotation     = false
  description             = "KMS Key for Redwood Tutorial SSM"
}

resource "aws_kms_alias" "ssm" {
  name          = "alias/redwood-tutorial-ssm"
  target_key_id = join("", aws_kms_key.ssm.*.id)
}