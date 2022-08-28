#####################################################################
# EKS
#####################################################################

resource "aws_iam_group_policy" "eks-nonprod" {
  for_each = local.nonprod_envs
  name     = "eks-nonprod-${each.key}"
  group    = aws_iam_group.backend-nonprod.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["eks:Describe*", "eks:List*"]
        Effect   = "Allow"
        Resource = "arn:aws:eks:${local.region}::cluster/${each.key}"
      },
    ]
  })
}

resource "aws_iam_group_policy" "eks-prod" {
  for_each = local.prod_envs
  name     = "eks-prod-${each.key}"
  group    = aws_iam_group.backend-prod.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["eks:Describe*", "eks:List*"]
        Effect   = "Allow"
        Resource = "arn:aws:eks:${local.region}::cluster/${each.key}"
      },
    ]
  })
}

# resource "kubernetes_role_binding" "eks-user" {
#   metadata {
#     name = "eks-user"
#     namespace = "default"
#   }
#   role_ref {
#     api_group = "rbac.authorization.k8s.io"
#     kind      = "Role"
#     name      = kubernetes_role.namespace-viewer.metadata[0].name
#   }
#   subject {
#     kind      = "User"
#     name      = "developer"
#     api_group = "rbac.authorization.k8s.io"
#   }
# }

#####################################################################
# CloudFront
#####################################################################

resource "aws_iam_group_policy" "cloudfront-nonprod" {
  for_each = local.nonprod_envs
  name     = "cloudfront-nonprod-${each.key}"
  group    = aws_iam_group.frontend-nonprod.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["cloudfront:*Function", "cloudfront:*Invalidation", "cloudfront:Get*", "cloudfront:List*"]
        Effect   = "Allow"
        Resource = "arn:aws:cloudfront:${local.region}::distribution/${each.key}"
      },
    ]
  })
}

resource "aws_iam_group_policy" "cloudfront-prod" {
  for_each = local.prod_envs
  name     = "cloudfront-prod-${each.key}"
  group    = aws_iam_group.frontend-prod.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["cloudfront:*Function", "cloudfront:*Invalidation", "cloudfront:Get*", "cloudfront:List*"]
        Effect   = "Allow"
        Resource = "arn:aws:cloudfront:${local.region}::distribution/${each.key}"
      },
    ]
  })
}

#####################################################################
# Redshift
#####################################################################

resource "aws_iam_group_policy" "redshift-nonprod" {
  for_each = local.nonprod_envs
  name     = "redshift-nonprod-${each.key}"
  group    = aws_iam_group.data-nonprod.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["redshift:CancelQuery", "redshift:CancelQuerySession", "redshift:Describe*", "redshift:List*", "redshift:Get*", "redshift:View*", "redshift:ExecuteQuery"]
        Effect   = "Allow"
        Resource = "arn:aws:redshift:${local.region}::cluster/${each.key}"
      },
    ]
  })
}

resource "aws_iam_group_policy" "redshift-prod" {
  for_each = local.prod_envs
  name     = "redshift-prod-${each.key}"
  group    = aws_iam_group.data-prod.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["redshift:CancelQuery", "redshift:CancelQuerySession", "redshift:Describe*", "redshift:List*", "redshift:Get*", "redshift:View*", "redshift:ExecuteQuery"]
        Effect   = "Allow"
        Resource = "arn:aws:redshift:${local.region}::cluster/${each.key}"
      },
    ]
  })
}

resource "aws_iam_group_policy" "sre-all" {
  name  = "sre-all"
  group = aws_iam_group.sre.name
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action   = ["redshift:*", "cloudfront:*", "eks:*"]
        Effect   = "Allow"
        Resource = "arn:aws::${local.region}::"
      },
    ]
  })
}