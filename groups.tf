resource "aws_iam_group" "frontend-prod" {
  name = "frontend-prod"
}

resource "aws_iam_group" "frontend-nonprod" {
  name = "frontend-nonprod"
}

resource "aws_iam_group" "backend-prod" {
  name = "backend-prod"
}

resource "aws_iam_group" "backend-nonprod" {
  name = "backend-nonprod"
}

resource "aws_iam_group" "data-prod" {
  name = "data-prod"
}

resource "aws_iam_group" "data-nonprod" {
  name = "data-nonprod"
}

resource "aws_iam_group" "sre" {
  name = "sre-prod"
}