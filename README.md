## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.14.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 3.46 |
| <a name="requirement_spotinst"></a> [spotinst](#requirement\_spotinst) | >= 1.64.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 3.69.0 |
| <a name="provider_spotinst"></a> [spotinst](#provider\_spotinst) | 1.64.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_eip.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eip) | resource |
| [spotinst_managed_instance_aws.this](https://registry.terraform.io/providers/spotinst/spotinst/latest/docs/resources/managed_instance_aws) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_healing"></a> [auto\_healing](#input\_auto\_healing) | Enable the auto healing which auto replaces the instance in case the health check fails, default: 'true'. | `bool` | `true` | no |
| <a name="input_block_device_mappings"></a> [block\_device\_mappings](#input\_block\_device\_mappings) | List of block devices attached into the EC2 instance. | `list(map(string))` | `[]` | no |
| <a name="input_block_devices_mode"></a> [block\_devices\_mode](#input\_block\_devices\_mode) | Determine the way we attach the data volumes to the data devices. Valid values: 'reattach', 'onLaunch'. Default: null | `string` | `null` | no |
| <a name="input_cpu_credits"></a> [cpu\_credits](#input\_cpu\_credits) | cpuCredits can have one of two values: 'unlimited', 'standard'. Default: 'unlimited'. | `string` | `"unlimited"` | no |
| <a name="input_create_eip"></a> [create\_eip](#input\_create\_eip) | Whether to create EIP for the managed instance | `bool` | `false` | no |
| <a name="input_description"></a> [description](#input\_description) | The description of the managed instance | `string` | `"Created by Terraform"` | no |
| <a name="input_domains"></a> [domains](#input\_domains) | List of route53 integrations | `list(map(string))` | `[]` | no |
| <a name="input_draining_timeout"></a> [draining\_timeout](#input\_draining\_timeout) | The time in seconds to allow the instance be drained from incoming TCP connections and detached from ELB before terminating it, during a scale down operation | `string` | `"120"` | no |
| <a name="input_ebs_optimized"></a> [ebs\_optimized](#input\_ebs\_optimized) | Enable EBS optimization for supported instance which is not enabled by default. Note - additional charges will be applied. | `bool` | `false` | no |
| <a name="input_elastic_ip"></a> [elastic\_ip](#input\_elastic\_ip) | Elastic IP Allocation Id to associate to the instance. | `string` | `null` | no |
| <a name="input_enable_monitoring"></a> [enable\_monitoring](#input\_enable\_monitoring) | Describes whether instance Enhanced Monitoring is enabled. Default: false. | `bool` | `false` | no |
| <a name="input_fallback_to_ondemand"></a> [fallback\_to\_ondemand](#input\_fallback\_to\_ondemand) | In case of no spots available, Managed Instance will launch an On-demand instance instead. Default: 'true' | `bool` | `true` | no |
| <a name="input_grace_period"></a> [grace\_period](#input\_grace\_period) | The amount of time, in seconds, after the instance has launched to starts and check its health. | `string` | `"120"` | no |
| <a name="input_health_check_type"></a> [health\_check\_type](#input\_health\_check\_type) | The service to use for the health check. Valid values: 'EC2', 'ELB', 'TARGET\_GROUP', 'MULTAI\_TARGET\_SET'. Default: 'EC2'. | `string` | `"EC2"` | no |
| <a name="input_iam_instance_profile"></a> [iam\_instance\_profile](#input\_iam\_instance\_profile) | Set IAM profile to instance. Set only one of ARN or Name. | `string` | `""` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | The ID of the image used to launch the instance. | `string` | n/a | yes |
| <a name="input_instance_types"></a> [instance\_types](#input\_instance\_types) | Comma separated list of available instance types for instance. | `list(string)` | n/a | yes |
| <a name="input_key_pair"></a> [key\_pair](#input\_key\_pair) | Specify a Key Pair to attach to the instances. | `string` | `""` | no |
| <a name="input_life_cycle"></a> [life\_cycle](#input\_life\_cycle) | Set lifecycle, valid values: 'spot', 'on\_demand'. Default 'spot' | `string` | `"spot"` | no |
| <a name="input_load_balancers"></a> [load\_balancers](#input\_load\_balancers) | List of load balancers | `list(map(string))` | `[]` | no |
| <a name="input_managed_instance_action"></a> [managed\_instance\_action](#input\_managed\_instance\_action) | Managed instance action. With type: 'pause', 'resume', 'recycle' | `map(string)` | `{}` | no |
| <a name="input_minimum_instnace_lifetime"></a> [minimum\_instnace\_lifetime](#input\_minimum\_instnace\_lifetime) | Defines the preferred minimum instance lifetime. Markets which comply with this preference will be prioritized. Optional values: 1, 3, 6, 12, 24 | `string` | `24` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the managed instance | `string` | n/a | yes |
| <a name="input_network_interfaces"></a> [network\_interfaces](#input\_network\_interfaces) | List of network interfaces in the EC2 instance. A primary network interface has a device index of 0 | `list(map(string))` | <pre>[<br>  {<br>    "associate_ipv6_address": false,<br>    "associate_public_ip_address": null,<br>    "device_index": 0<br>  }<br>]</pre> | no |
| <a name="input_optimization_windows"></a> [optimization\_windows](#input\_optimization\_windows) | When performAt is 'timeWindow': must specify a list of 'timeWindows' with at least one time window Each string is in the format of - ddd:hh:mm-ddd:hh:mm ddd = day of week = Sun \| Mon \| Tue \| Wed \| Thu \| Fri \| Sat hh = hour 24 = 0 -23 mm = minute = 0 - 59. | `list(string)` | <pre>[<br>  "Mon:00:00-Mon:23:59",<br>  "Tue:00:00-Tue:23:59",<br>  "Wed:00:00-Wed:23:59",<br>  "Thu:00:00-Thu:23:59",<br>  "Fri:00:00-Fri:23:59",<br>  "Sat:00:00-Sat:23:59",<br>  "Sun:00:00-Sun:23:59"<br>]</pre> | no |
| <a name="input_orientation"></a> [orientation](#input\_orientation) | Select a prediction strategy. Valid values: 'balanced', 'costOriented', 'availabilityOriented', 'cheapest'. Default: 'availabilityOriented' | `string` | `"availabilityOriented"` | no |
| <a name="input_perform_at"></a> [perform\_at](#input\_perform\_at) | Valid values: 'always', 'never', 'timeWindow' | `string` | `"always"` | no |
| <a name="input_persist_block_devices"></a> [persist\_block\_devices](#input\_persist\_block\_devices) | Should the instance maintain its Data volumes. | `bool` | `true` | no |
| <a name="input_persist_private_ip"></a> [persist\_private\_ip](#input\_persist\_private\_ip) | Should the instance maintain its private IP. | `bool` | `false` | no |
| <a name="input_persist_root_device"></a> [persist\_root\_device](#input\_persist\_root\_device) | Should the instance maintain its root device volumes. | `bool` | `true` | no |
| <a name="input_placement_tenancy"></a> [placement\_tenancy](#input\_placement\_tenancy) | Valid values: 'default', 'dedicated' | `string` | `"default"` | no |
| <a name="input_preferred_type"></a> [preferred\_type](#input\_preferred\_type) | Preferred instance types for the instance. We will automatically select optional similar instance types to ensure optimized cost efficiency. | `string` | n/a | yes |
| <a name="input_private_ip"></a> [private\_ip](#input\_private\_ip) | Private IP Allocation Id to associate to the instance. | `string` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | Operation system type. Valid values: 'Linux/UNIX', 'SUSE Linux', 'Windows', 'Red Hat Enterprise Linux', 'Linux/UNIX (Amazon VPC)', 'SUSE Linux (Amazon VPC)', 'Windows (Amazon VPC)', 'Red Hat Enterprise Linux (Amazon VPC)'. | `string` | `"Linux/UNIX"` | no |
| <a name="input_region"></a> [region](#input\_region) | The aws region of the managed instance | `string` | `"us-west-2"` | no |
| <a name="input_resource_tag_specification"></a> [resource\_tag\_specification](#input\_resource\_tag\_specification) | User will specify which resources should be tagged with group tags. | `list(map(string))` | <pre>[<br>  {<br>    "should_tag_amis": true,<br>    "should_tag_snapshots": true,<br>    "should_tag_volumes": true<br>  }<br>]</pre> | no |
| <a name="input_scheduled_tasks"></a> [scheduled\_tasks](#input\_scheduled\_tasks) | List of scheduled tasks | `list(map(string))` | `[]` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | One or more security group IDs. | `list(string)` | `[]` | no |
| <a name="input_shutdown_script"></a> [shutdown\_script](#input\_shutdown\_script) | The Base64-encoded shutdown script to execute prior to instance termination. | `string` | `null` | no |
| <a name="input_spotinst_account"></a> [spotinst\_account](#input\_spotinst\_account) | Spotinst account ID | `string` | n/a | yes |
| <a name="input_spotinst_token"></a> [spotinst\_token](#input\_spotinst\_token) | Spotinst Personal Access token | `string` | n/a | yes |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | A comma-separated list of subnet identifiers for the instance. | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Set tags for the instance. Items should be unique. | `list(map(string))` | `[]` | no |
| <a name="input_unhealthy_duration"></a> [unhealthy\_duration](#input\_unhealthy\_duration) | The amount of time, in seconds, an existing instance should remain active after becoming unhealthy. After the set time out the instance will be replaced. | `string` | `"120"` | no |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | The Base64-encoded MIME user data to make available to the instances. | `string` | `null` | no |
| <a name="input_utilize_reserved_instances"></a> [utilize\_reserved\_instances](#input\_utilize\_reserved\_instances) | In case of any available Reserved Instances, Managed Instance will utilize them before purchasing Spot instances. Default: 'false' | `bool` | `true` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC id for your instance. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_eip"></a> [eip](#output\_eip) | The Elastic IP ID of the managed instance |
| <a name="output_iam_instance_profile"></a> [iam\_instance\_profile](#output\_iam\_instance\_profile) | The IAM instance profile of the managed instance |
| <a name="output_id"></a> [id](#output\_id) | The ID of the managed instance |
| <a name="output_image_id"></a> [image\_id](#output\_image\_id) | The AMI ID of the managed instance |
| <a name="output_key_pair"></a> [key\_pair](#output\_key\_pair) | The SSH key pair used for the managed instance |
| <a name="output_load_balancers"></a> [load\_balancers](#output\_load\_balancers) | The Load balancer used for the managed instance |
| <a name="output_name"></a> [name](#output\_name) | The name of the managed instance |
| <a name="output_private_ip"></a> [private\_ip](#output\_private\_ip) | The private ip of the managed instance |
| <a name="output_scheduled_task"></a> [scheduled\_task](#output\_scheduled\_task) | The scheduled tasks used for the managed instance |
| <a name="output_security_group_ids"></a> [security\_group\_ids](#output\_security\_group\_ids) | The security group ids used for the managed instance |
| <a name="output_subnet_ids"></a> [subnet\_ids](#output\_subnet\_ids) | The Subnet IDs used for the managed instance |
