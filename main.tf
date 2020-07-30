provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

resource "spotinst_managed_instance_aws" "this" {
  name        = var.name
  description = var.description
  region      = var.region
  life_cycle  = var.life_cycle
  orientation = var.orientation

  draining_timeout           = var.draining_timeout
  utilize_reserved_instances = var.utilize_reserved_instances

  revert_to_spot {
    perform_at = var.perform_at
  }

  optimization_windows  = var.optimization_windows
  persist_private_ip    = var.persist_private_ip
  persist_block_devices = var.persist_block_devices
  persist_root_device   = var.persist_root_device
  block_devices_mode    = var.block_devices_mode
  health_check_type     = var.health_check_type
  auto_healing          = var.auto_healing
  grace_period          = var.grace_period
  unhealthy_duration    = var.unhealthy_duration

  subnet_ids = var.subnet_ids
  vpc_id     = var.vpc_id
  elastic_ip = var.elastic_ip
  private_ip = var.private_ip

  instance_types       = var.instance_types
  preferred_type       = var.preferred_type
  ebs_optimized        = var.ebs_optimized
  enable_monitoring    = var.enable_monitoring
  placement_tenancy    = var.placement_tenancy
  iam_instance_profile = var.iam_instance_profile
  security_group_ids   = var.security_group_ids
  product              = var.product
  image_id             = var.image_id
  key_pair             = var.key_pair
  cpu_credits          = var.cpu_credits
  user_data            = var.user_data
  shutdown_script      = var.shutdown_script

  #tags = var.tags
  
}