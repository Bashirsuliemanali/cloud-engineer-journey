resource "aws_eks_cluster" "main" {
  name     = "${var.project_name}-cluster"
  role_arn = aws_iam_role.eks_cluster_role.arn
  version  = "1.31"

  vpc_config {
    subnet_ids = [
      aws_subnet.private_1.id,
      aws_subnet.private_2.id,
      aws_subnet.public_1.id,
      aws_subnet.public_2.id,
    ]
    endpoint_private_access = true
    endpoint_public_access  = true
  }

  tags = {
    Name        = "${var.project_name}-cluster"
    Environment = var.environment
  }
}

resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = "${var.project_name}-node-group"
  node_role_arn   = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    aws_subnet.public_1.id,
    aws_subnet.public_2.id,
  ]

  scaling_config {
    desired_size = 2
    min_size     = 1
    max_size     = 3
  }

  instance_types = ["t3.micro"]
  disk_size      = 20
  ami_type       = "AL2_x86_64"

  tags = {
    Name        = "${var.project_name}-node-group"
    Environment = var.environment
  }
}