provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

resource "aws_eip" "this" {
  count = var.create_eip ? 1 : 0
  vpc   = true
  tags = {
    Name = var.name
  }
}

resource "spotinst_managed_instance_aws" "this" {
  name        = var.name
  description = var.description
  region      = var.region
  life_cycle  = var.life_cycle
  orientation = var.orientation

  draining_timeout           = var.draining_timeout
  fall_back_to_od            = var.fall_back_to_od
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
  elastic_ip = var.create_eip ? concat(aws_eip.this.*.id, list(""))[0] : var.elastic_ip
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

  ## Network interfaces:
  dynamic "network_interface" {
    for_each = var.network_interfaces
    content {
      associate_ipv6_address      = lookup(network_interface.value, "associate_ipv6_address", null)
      associate_public_ip_address = lookup(network_interface.value, "associate_public_ip_address", null)
      device_index                = lookup(network_interface.value, "device_index", null)
    }
  }

  ## Block devices:
  dynamic "block_device_mappings" {
    for_each = var.block_device_mappings
    content {
      device_name = lookup(block_device_mappings.value, "device_name")
      ebs {
        volume_type           = lookup(block_device_mappings.value, "volume_type", "gp3")
        volume_size           = lookup(block_device_mappings.value, "volume_size", 20)
        iops                  = lookup(block_device_mappings.value, "iops", null)
        throughput            = lookup(block_device_mappings.throughput, "throughput", null)
        delete_on_termination = lookup(block_device_mappings.value, "delete_on_termination", "true")
      }
    }
  }

  ## Load balancers:
  dynamic "load_balancers" {
    for_each = var.load_balancers
    content {
      name          = lookup(load_balancers.value, "name", null)
      arn           = lookup(load_balancers.value, "arn", null)
      type          = lookup(load_balancers.value, "type", null)
      balancer_id   = lookup(load_balancers.value, "balancer_id", null)
      target_set_id = lookup(load_balancers.value, "target_set_id", null)
      auto_weight   = lookup(load_balancers.value, "auto_weight", null)
      az_awareness  = lookup(load_balancers.value, "az_awareness", null)
    }
  }

  ## Schedules:
  dynamic "scheduled_task" {
    for_each = var.scheduled_tasks
    content {
      is_enabled      = lookup(scheduled_task.value, "is_enabled", null)
      task_type       = lookup(scheduled_task.value, "task_type", null)
      frequency       = lookup(scheduled_task.value, "frequency", null)
      start_time      = lookup(scheduled_task.value, "start_time", null)
      cron_expression = lookup(scheduled_task.value, "cron_expression", null)
    }
  }

  ## Route53:
  dynamic "integration_route53" {
    for_each = var.domains
    content {
      domains {
        hosted_zone_id   = lookup(integration_route53.value, "hosted_zone_id")
        spotinst_acct_id = lookup(integration_route53.value, "spotinst_acct_id", null)
        record_set_type  = lookup(integration_route53.value, "record_set_type", "a")

        record_sets {
          name           = lookup(integration_route53.value, "name")
          use_public_ip  = lookup(integration_route53.value, "use_public_ip", false)
          use_public_dns = lookup(integration_route53.value, "use_public_dns", false)
        }
      }
    }
  }

  ## Tags:
  tags {
    key   = "Name"
    value = var.name
  }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = lookup(tags.value, "key", null)
      value = lookup(tags.value, "value", null)
    }
  }

}