module "ec2" {
  source           = "./modules/ec2"
  subnet_id        = module.vpc.public_subnets[0]
  vpc_id           = module.vpc.vpc_id
  instance_profile = module.iam.instance_profile_name
  alb_sg_id        = module.alb.alb_sg_id
}

module "s3" {
  source = "./modules/s3"
}

module "vpc" {
  source = "./modules/vpc"

}

module "alb" {
  source      = "./modules/alb"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnets
  instance_id = module.ec2.instance_id
}
//statefile 
terraform {
  backend "s3" {
    bucket         = "mystate001"
    region         = "us-east-1"
    key            = "statefile/terraform.tfstate"
    dynamodb_table = "mytable"
    encrypt        = true
  }
}

module "iam" {
  source = "./modules/iam"
}