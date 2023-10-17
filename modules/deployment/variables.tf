variable "eks_cluster_name" {
  description = "Nombre del clúster EKS."
  type        = string
}

variable "vpc_id" {
  description = "ID del VPC donde se alojará el ALB."
  type        = string
}

variable "subnets" {
  description = "Subredes para el ALB."
  type        = list(string)
}

variable "app_image" {
  description = "Imagen Docker de la aplicación."
  type        = string
}

variable "app_replica_count" {
  description = "Número de réplicas para la aplicación."
  default     = 2
}
