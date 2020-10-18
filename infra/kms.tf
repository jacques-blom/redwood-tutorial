resource "aws_kms_key" "main" {
  description = "Main key"

  policy = <<POLICY
{
"Version": "2012-10-17",
"Id": "key-consolepolicy-2",
"Statement": [
  {
    "Sid": "Enable IAM User Permissions",
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${data.terraform_remote_state.master_env.aws_account_ids[terraform.workspace]}:root"
    },
    "Action": "kms:*",
    "Resource": "*"
  },
  {
    "Sid": "Allow access for Key Administrators",
    "Effect": "Allow",
    "Principal": {
      "AWS": "arn:aws:iam::${data.terraform_remote_state.master_env.aws_account_ids[terraform.workspace]}:role/administrator"
    },
    "Action": [
      "kms:Create*",
      "kms:Describe*",
      "kms:Enable*",
      "kms:Encrypt",
      "kms:List*",
      "kms:Put*",
      "kms:Update*",
      "kms:Revoke*",
      "kms:Disable*",
      "kms:Get*",
      "kms:Delete*",
      "kms:ScheduleKeyDeletion",
      "kms:CancelKeyDeletion"
    ],
    "Resource": "*"
  }
]
}
POLICY
}