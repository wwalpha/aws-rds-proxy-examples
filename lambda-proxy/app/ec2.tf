# locals {
#   user_data = <<EOT
# sudo amazon-linux-extras enable nginx1
# sudo amazon-linux-extras install -y nginx1 
# sudo systemctl enable nginx
# sudo systemctl start nginx
# world
# EOT
# }

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name                   = "rds-instance"
  ami                    = "ami-0404778e217f54308"
  instance_type          = "t3a.medium"
  key_name               = "onecloud"
  monitoring             = false
  vpc_security_group_ids = [module.app_sg.security_group_id]
  subnet_id              = var.private_subnets[0]
  # user_data_base64       = base64encode(local.user_data)
  iam_instance_profile = var.iam_role_profile_ec2_ssm
}
