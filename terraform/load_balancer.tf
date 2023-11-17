"backstage_alb" {
  name               = "backstage-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "backstage_tg" {
  name     = "backstage-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  health_check {
    enabled             = true
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.backstage_alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.backstage_tg.arn
  }
}
resource "aws_s3_bucket" "tech_docs" {
  bucket = "backstage-techdocs-${random_string.suffix.id}"
  acl    = "private"

  versioning {
    enabled = true
  }
}

resource "random_string" "suffix" {
  length  = 8
  special = false
}
resource "aws_iam_role" "ecs_task_execution_role" {
  name = "ecs_task_execution_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        },
      },
    ],
  })
}

resource "aws_iam_policy" "ecs_task_policy" {
  name        = "ecs_task_policy"
  description = "ECS task policy"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "ecr:GetAuthorizationToken",
          "ecr:BatchCheckLayerAvailability",
          "ecr:GetDownloadUrlForLayer",
          "ecr:BatchGetImage",
          "logs:CreateLogStream",
          "logs:PutLogEvents"
        ],
        Effect   = "Allow",
        Resource = "*",
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ecs_task_execution_role_attachment" {
  role       = aws_iam_role.ecs_task_execution_role.name
  policy_arn = aws_iam_policy.ecs_task_policy.arn
}
resource "aws_ecs_task_definition" "backstage_task" {
  family                   = "backstage"
  network_mode             = "awsvpc"
  execution_role_arn       = aws_iam_role.ecs_task_execution_role.arn
  cpu                      = "256"
  memory                   = "512"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = <<EOF
[
  {
    "name": "backstage",
    "image": "${aws_ecr_repository.backstage_repo.repository_url}:latest",
    "essential": true,
    "portMappings": [
      {
        "containerPort": 7000,
        "hostPort": 7000
      }
    ]
  }
]
EOF
}

resource "aws_ecs_service" "backstage_service" {
  name            = "backstage-service"
  cluster         = aws_ecs_cluster.backstage_cluster.id
  task_definition = aws_ecs_task_definition.backstage_task.arn
  launch_type     = "FARGATE"

  network_configuration {
    subnets = module.vpc.private_subnets
    security_groups = [aws_security_group.ecs_sg.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.backstage_tg.arn
    container_name   = "backstage"
    container_port   = 7000
  }

  desired_count = 1
}
resource "aws_security_group" "alb_sg" {
  name        = "backstage-alb-sg"
  description = "Security group for Backstage ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_security_group" "ecs_sg" {
  name        = "backstage-ecs-sg"
  description = "Security group for Backstage ECS tasks"
  vpc_id      = module.vpc.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}