resource "aws_iam_policy" "allow_vpc_rds" {
  name        = "AllowVPCRDS"
  description = "Allow creating VPC and RDS resources"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = [
          "ec2:CreateVpc",
          "ec2:DescribeVpcs",
          "ec2:CreateSubnet",
          "ec2:DescribeSubnets",
          "rds:CreateDBInstance",
          "rds:DescribeDBInstances",
          "rds:CreateDBSubnetGroup",
          "rds:DescribeDBSubnetGroups"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_user_policy_attachment" "attach_policy" {
  user       = "kk_labs_user_642095"
  policy_arn = aws_iam_policy.allow_vpc_rds.arn
}
