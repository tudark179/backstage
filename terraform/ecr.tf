resource "aws_ecr_repository" "backstage_repo" {
  name                 = "backstage-repo"
  image_tag_mutability = "MUTABLE"
}