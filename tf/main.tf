module "ecr" {
  source = "terraform-aws-modules/ecr/aws"
  version = "2.0.0"

  create_repository = true
  repository_name = "fluent-${var.stage}"
  repository_type = "private"
  repository_image_tag_mutability = "IMMUTABLE"

  repository_lifecycle_policy = jsonencode({
    rules = [
      {
        rulePriority: 1,
        description = "Keep last 3 images",
        selection = {
          tagStatus = "tagged",
          tagPrefixList = "v",
          countType = "imageCountMoreThan",
          countNumber = 3
        },
        action = {
          type = "expire"
        }
      }
    ]
  })
}