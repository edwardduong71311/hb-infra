resource "aws_ecr_repository" "app" {
  name                 = "${var.env}-health-buddy-repo"
  image_tag_mutability = "MUTABLE"
  tags                 = { Name = "${var.env}-ecr" }
}