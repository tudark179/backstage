
# ECS Cluster
resource "aws_ecs_cluster" "backstage_cluster" {
  name = "backstage-cluster"
}

# ECR Repository for Backstage Docker image
resource "aws_ecr_repository" "backstage_repo" {
  name                 = "backstage-repo"
  image_tag_mutability = "MUTABLE"
}
