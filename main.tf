provider "spotinst" {
  token   = var.spotinst_token
  account = var.spotinst_account
}

resource "aws_eip" "this" {
  count  = var.create_eip ? 1 : 0
  domain = "vpc"
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
  minimum_instance_lifetime  = var.minimum_instance_lifetime

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
  elastic_ip = var.create_eip ? try(aws_eip.this[0].id, "") : var.elastic_ip
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
      device_name = try(each.value["device_name"], "/dev/xvda")
      ebs {
        volume_type           = try(each.value["volume_type"], "gp3")
        volume_size           = try(each.value["volume_size"], 20)
        iops                  = try(each.value["iops"], null)
        throughput            = try(each.value["throughput"], null)
        delete_on_termination = try(each.value["delete_on_termination"], true)
      }
    }
  }

  ## Load balancers:
  dynamic "load_balancers" {
    for_each = var.load_balancers
    content {
      name          = try(each.value["name"], null)
      arn           = try(each.value["arn"], null)
      type          = try(each.value["type"], null)
      balancer_id   = try(each.value["balancer_id"], null)
      target_set_id = try(each.value["target_set_id"], null)
      auto_weight   = try(each.value["auto_weight"], null)
      az_awareness  = try(each.value["az_awareness"], null)
    }
  }

  ## Schedules:
  dynamic "scheduled_task" {
    for_each = var.scheduled_tasks
    content {
      is_enabled      = try(each.value["is_enabled"], null)
      task_type       = try(each.value["task_type"], null)
      frequency       = try(each.value["frequency"], null)
      start_time      = try(each.value["start_time"], null)
      cron_expression = try(each.value["cron_expression"], null)
    }
  }

  ## Route53:
  dynamic "integration_route53" {
    for_each = var.domains
    content {
      domains {
        hosted_zone_id   = try(each.value["hosted_zone_id"])
        spotinst_acct_id = try(each.value["spotinst_acct_id"], null)
        record_set_type  = try(each.value["record_set_type"], "a")

        record_sets {
          name           = try(each.value["name"])
          use_public_ip  = try(each.value["use_public_ip"], false)
          use_public_dns = try(each.value["use_public_dns"], false)
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
      key   = try(each.value["key"], null)
      value = try(each.value["value"], null)
    }
  }

  ## Resource tags:
  dynamic "resource_tag_specification" {
    for_each = var.resource_tag_specification
    content {
      should_tag_enis      = try(each.value["should_tag_enis"], null)
      should_tag_volumes   = try(each.value["should_tag_volumes"], null)
      should_tag_snapshots = try(each.value["should_tag_snapshots"], null)
      should_tag_amis      = try(each.value["should_tag_amis"], null)
    }
  }

  ## Managed instance action:
  dynamic "managed_instance_action" {
    for_each = var.managed_instance_action
    content {
      type = try(each.value["type"], null)
    }
  }

}
