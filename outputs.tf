output "id" {
  value       = spotinst_managed_instance_aws.this.id
  description = "The ID of the managed instance"
}

output "name" {
  value       = spotinst_managed_instance_aws.this.name
  description = "The name of the managed instance"
}

output "eip" {
  value       = concat(aws_eip.this.*.public_ip, [""])[0]
  description = "The Elastic IP ID of the managed instance"
}

output "private_ip" {
  value       = spotinst_managed_instance_aws.this.private_ip
  description = "The private ip of the managed instance"
}

output "image_id" {
  value       = spotinst_managed_instance_aws.this.image_id
  description = "The AMI ID of the managed instance"
}

output "load_balancers" {
  value       = spotinst_managed_instance_aws.this.load_balancers
  description = "The Load balancer used for the managed instance"
}

output "scheduled_task" {
  value       = spotinst_managed_instance_aws.this.scheduled_task
  description = "The scheduled tasks used for the managed instance"
}

output "subnet_ids" {
  value       = spotinst_managed_instance_aws.this.subnet_ids
  description = "The Subnet IDs used for the managed instance"
}

output "security_group_ids" {
  value       = spotinst_managed_instance_aws.this.security_group_ids
  description = "The security group ids used for the managed instance"
}

output "key_pair" {
  value       = spotinst_managed_instance_aws.this.key_pair
  description = "The SSH key pair used for the managed instance"
}

output "iam_instance_profile" {
  value       = spotinst_managed_instance_aws.this.iam_instance_profile
  description = "The IAM instance profile of the managed instance"
}