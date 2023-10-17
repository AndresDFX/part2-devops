module "networking" {
  source = "./modules/networking"
}

module "eks" {
  source      = "./modules/eks"
  subnet_ids  = [module.networking.public_subnet_id, module.networking.private_subnet_id]
  ssh_key_name  = "test"
  eks_sg_id = module.networking.eks_sg_id
}

terraform {
  backend "s3" {
    bucket  = "state-devops"
    key     = "status/qa/terraform.tfstate"
    region  = "us-west-1"
    profile = "personal"
  }
}