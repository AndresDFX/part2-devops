resource "aws_vpc" "this" {
  cidr_block = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.public_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet"
  }
}

resource "aws_subnet" "private" {
  vpc_id                  = aws_vpc.this.id
  cidr_block              = var.private_cidr_block
  map_public_ip_on_launch = true

  tags = {
    Name = "private-subnet"
  }
}

resource "aws_security_group" "allow_all" {
  vpc_id = aws_vpc.this.id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-all"
  }
}

resource "aws_security_group" "eks_sg" {
  name        = "eks-sg"
  description = "Security Group for EKS Cluster and Worker Nodes"
  vpc_id      = aws_vpc.this.id # Asegúrate de usar el ID de tu VPC

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Esto es solo para pruebas; deberías restringirlo en un entorno de producción
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eks-sg"
  }
}

resource "aws_security_group_rule" "eks_cluster_ingress_from_nodes" {
  security_group_id = aws_security_group.eks_sg.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.allow_all.id
}

resource "aws_security_group_rule" "eks_cluster_egress_to_nodes" {
  security_group_id = aws_security_group.eks_sg.id
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.allow_all.id
}

resource "aws_security_group_rule" "nodes_ingress_from_eks_cluster" {
  security_group_id = aws_security_group.allow_all.id
  type              = "ingress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "nodes_egress_to_eks_cluster" {
  security_group_id = aws_security_group.allow_all.id
  type              = "egress"
  from_port         = 0
  to_port           = 65535
  protocol          = "tcp"
  source_security_group_id = aws_security_group.eks_sg.id
}

resource "aws_security_group_rule" "allow_ssh" {
  security_group_id = aws_security_group.eks_sg.id
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
}
