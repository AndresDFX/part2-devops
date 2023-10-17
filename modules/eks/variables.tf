variable "cluster_name" {
  description = "The name of the EKS Cluster"
  default     = "eks-cluster"
}

variable "subnet_ids" {
  description = "List of subnet IDs for the EKS Cluster"
  type        = list(string)
}

variable "desired_nodes" {
  description = "The desired number of worker nodes"
  default     = 2
}

variable "min_nodes" {
  description = "The minimum number of worker nodes"
  default     = 1
}

variable "max_nodes" {
  description = "The maximum number of worker nodes"
  default     = 3
}

variable "instance_type" {
  description = "Instance type for the EKS worker nodes"
  default     = "t2.micro"
}

variable "key_name" {
  description = "The key name to use for the worker nodes"
  default     = ""
}

variable "ssh_key_name" {
  description = "The name of the SSH key pair to allow access to the worker nodes"
  type        = string
  default     = "test"
}

variable "eks_sg_id" {
  description = "ID of the EKS security group"
  type        = string
}