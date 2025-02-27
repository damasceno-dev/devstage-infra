/*
IMPORTANT: Before executing this CI flow, you must manually create an S3 bucket to store the Terraform state.
The bucket name must follow this naming convention: "${var.prefix}-terraform-state-unique1029"
For example, if your project prefix is "myproject", create an S3 bucket named "myproject-terraform-state-unique1029" in the us-east-1 region.
Do NOT let Terraform manage (create or destroy) this bucket—manage it separately via the AWS Console.
*/

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket         = "devstage-terraform-state-unique1029"  # This bucket must be created manually.
    key            = "1-admin/terraform.tfstate"        # The path within the bucket for the state file.
    region         = "us-east-1"                      # The region where your bucket is located.
    encrypt        = true                             # Encrypt the state file at rest.
  }
}

provider "aws" {
  region  = "us-east-1"
  # for github actions or act (ci), its going to take the profile from the aws_id used in the credentials step
  # profile = var.admin_profile
}

module "iam" {
  source     = "./modules/iam" # Ensure this points to the relevant module
  prefix     = var.prefix
  resources_creator_profile = var.resources_creator_profile
}
/*
#######################################################################
# IAM PERMISSIONS REQUIRED TO EXECUTE THIS TERRAFORM SCRIPT
#######################################################################

The user executing this Terraform script must have the following IAM permissions 
to create, manage, and delete IAM groups, attach policies, and add users to groups.

# IAM Policy and S3 Required:
# -------------------
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreatePolicy",
        "iam:DeletePolicy",
        "iam:GetPolicy",
        "iam:GetPolicyVersion",
        "iam:ListPolicies",
        "iam:ListPolicyVersions",
        "iam:CreatePolicyVersion",
        "iam:AttachUserPolicy",
        "iam:DetachUserPolicy",
        "iam:ListAttachedUserPolicies",
        "iam:AttachGroupPolicy",
        "iam:DetachGroupPolicy",
        "iam:ListAttachedGroupPolicies",
        "iam:DeletePolicyVersion"
      ],
      "Resource": "arn:aws:iam::533267083060:policy/${var.prefix}-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:AttachUserPolicy",
        "iam:DetachUserPolicy",
        "iam:ListAttachedUserPolicies",
        "iam:AddUserToGroup",
        "iam:RemoveUserFromGroup",
        "iam:ListGroupsForUser"
      ],
      "Resource": "arn:aws:iam::533267083060:user/${var.resources_creator_profile}"
    },
    {
      "Effect": "Allow",
      "Action": [
        "iam:CreateGroup",
        "iam:DeleteGroup",
        "iam:GetGroup",
        "iam:ListGroups",
        "iam:ListGroupPolicies",
        "iam:AttachGroupPolicy",
        "iam:DetachGroupPolicy",
        "iam:PutGroupPolicy",
        "iam:ListAttachedGroupPolicies",
        "iam:AddUserToGroup",
        "iam:RemoveUserFromGroup"
      ],
      "Resource": "arn:aws:iam::533267083060:group/${var.prefix}-*"
    },
    {
      "Effect": "Allow",
      "Action": [
        "s3:ListBucket",
        "s3:GetBucketLocation",
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject",
        "s3:GetBucketVersioning",
        "s3:PutBucketVersioning"
      ],
      "Resource": [
        "arn:aws:s3:::${var.prefix}-terraform-state-unique1029",
        "arn:aws:s3:::${var.prefix}-terraform-state-unique1029/*"
      ]
    }
  ]
}
# WHY IS THIS NEEDED?
# - The Terraform script creates IAM groups and policies for managing AWS services, and permissions to manage the terraform state 
# - The ${var.prefix} ensures that permissions apply only to this specific project.
# - Replace "${var.prefix}" with your project name (e.g., "myproject").

# HOW TO GRANT THESE PERMISSIONS?
# 1. Go to AWS IAM → Policies.
# 2. Create a new Customer Managed Policy.
# 3. Copy & paste the JSON above.
# 4. Attach this policy to the IAM user executing the Terraform script.

# ✅ Once granted, you can run Terraform without permission issues.
*/