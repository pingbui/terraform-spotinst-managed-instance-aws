variable "spotinst_token" {
  type        = string
  description = "Spotinst Personal Access token"
}

variable "spotinst_account" {
  type        = string
  description = "Spotinst account ID"
}

variable "name" {
  type        = string
  description = "The name of the managed instance"
}

variable "description" {
  type        = string
  description = "The description of the managed instance"
  default     = "Created by Terraform"
}

variable "region" {
  type        = string
  description = "The aws region of the managed instance"
  default     = "us-west-2"
}

variable "life_cycle" {
  type        = string
  description = "Set lifecycle, valid values: 'spot', 'on_demand'. Default 'spot'"
  default     = "spot"
}

variable "orientation" {
  type        = string
  description = "Select a prediction strategy. Valid values: 'balanced', 'costOriented', 'availabilityOriented', 'cheapest'. Default: 'availabilityOriented'"
  default     = "availabilityOriented"
}

variable "draining_timeout" {
  type        = string
  description = "The time in seconds to allow the instance be drained from incoming TCP connections and detached from ELB before terminating it, during a scale down operation"
  default     = "120"
}

variable "fallback_to_ondemand" {
  type        = bool
  description = "In case of no spots available, Managed Instance will launch an On-demand instance instead. Default: 'true'"
  default     = true
}

variable "utilize_reserved_instances" {
  type        = bool
  description = "In case of any available Reserved Instances, Managed Instance will utilize them before purchasing Spot instances. Default: 'false'"
  default     = true
}

variable "perform_at" {
  type        = string
  description = "Valid values: 'always', 'never', 'timeWindow'"
  default     = "always"
}

variable "optimization_windows" {
  type        = list(string)
  description = "When performAt is 'timeWindow': must specify a list of 'timeWindows' with at least one time window Each string is in the format of - ddd:hh:mm-ddd:hh:mm ddd = day of week = Sun | Mon | Tue | Wed | Thu | Fri | Sat hh = hour 24 = 0 -23 mm = minute = 0 - 59."
}

variable "persist_private_ip" {
  type        = bool
  description = "Should the instance maintain its private IP."
  default     = false
}

variable "persist_block_devices" {
  type        = bool
  description = "Should the instance maintain its Data volumes."
  default     = true
}

variable "persist_root_device" {
  type        = bool
  description = "Should the instance maintain its root device volumes."
  default     = true
}

variable "block_devices_mode" {
  type        = string
  description = "Determine the way we attach the data volumes to the data devices. Valid values: 'reattach', 'onLaunch'. Default: 'onLaunch'"
  default     = "onLaunch"
}

variable "health_check_type" {
  type        = string
  description = "The service to use for the health check. Valid values: 'EC2', 'ELB', 'TARGET_GROUP', 'MULTAI_TARGET_SET'. Default: 'EC2'."
  default     = "EC2"
}

variable "auto_healing" {
  type        = bool
  description = "Enable the auto healing which auto replaces the instance in case the health check fails, default: 'true'."
  default     = true
}

variable "grace_period" {
  type        = string
  description = "The amount of time, in seconds, after the instance has launched to starts and check its health."
  default     = "120"
}

variable "unhealthy_duration" {
  type        = string
  description = "The amount of time, in seconds, an existing instance should remain active after becoming unhealthy. After the set time out the instance will be replaced."
  default     = "120"
}

variable "subnet_ids" {
  type        = list(string)
  description = "A comma-separated list of subnet identifiers for the instance."
}

variable "vpc_id" {
  type        = string
  description = "VPC id for your instance."
}

variable "elastic_ip" {
  type        = string
  description = "Elastic IP Allocation Id to associate to the instance."
  default     = null
}

variable "private_ip" {
  type        = string
  description = "Private IP Allocation Id to associate to the instance."
  default     = null
}

variable "product" {
  type        = string
  description = "Operation system type. Valid values: 'Linux/UNIX', 'SUSE Linux', 'Windows', 'Red Hat Enterprise Linux', 'Linux/UNIX (Amazon VPC)', 'SUSE Linux (Amazon VPC)', 'Windows (Amazon VPC)', 'Red Hat Enterprise Linux (Amazon VPC)'."
  default     = "Linux/UNIX"
}

variable "subnet_ids" {
  type        = list(string)
  description = "Comma separated list of available instance types for instance."
}

variable "preferred_type" {
  type        = string
  description = "Preferred instance types for the instance. We will automatically select optional similar instance types to ensure optimized cost efficiency."
}

variable "ebs_optimized" {
  type        = bool
  description = "Enable EBS optimization for supported instance which is not enabled by default. Note - additional charges will be applied."
  default     = false
}

variable "enable_monitoring" {
  type        = bool
  description = "Describes whether instance Enhanced Monitoring is enabled. Default: false."
  default     = false
}

variable "placement_tenancy" {
  type        = string
  description = "Valid values: 'default', 'dedicated'"
  default     = "default"
}

variable "iam_instance_profile" {
  type        = string
  description = "Set IAM profile to instance. Set only one of ARN or Name."
  default     = ""
}

variable "security_group_ids" {
  type        = list(string)
  description = "One or more security group IDs."
  default     = []
}

variable "image_id" {
  type        = string
  description = "The ID of the image used to launch the instance."
}

variable "key_pair" {
  type        = string
  description = "Specify a Key Pair to attach to the instances."
  default     = ""
}

variable "tags" {
  type        = list(map)
  description = "Set tags for the instance. Items should be unique."
  default     = []
}

variable "user_data" {
  type        = string
  description = "The Base64-encoded MIME user data to make available to the instances."
  default     = null
}

variable "shutdown_script" {
  type        = string
  description = "The Base64-encoded shutdown script to execute prior to instance termination."
  default     = null
}

variable "cpu_credits" {
  type        = string
  description = "cpuCredits can have one of two values: 'unlimited', 'standard'. Default: 'unlimited'."
  default     = "unlimited"
}

variable "network_interface" {
  type        = list(map)
  description = "List of network interfaces in the EC2 instance. A primary network interface has a device index of 0"
  default     = [
    {
      device_index                = 0
      associate_ipv6_address      = false
      associate_public_ip_address = null
    }
  ]
}

variable "scheduled_task" {
  type        = list(map)
  description = "List of scheduled tasks"
  default     = []
}

variable "load_balancers" {
  type        = list(map)
  description = "List of load balancers"
  default     = []
}

variable "integration_route53" {
  type        = list(map)
  description = "Describes the Route53 integration."
  default     = []
}











































