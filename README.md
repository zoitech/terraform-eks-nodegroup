<!-- BEGIN_TF_DOCS -->
## Requirements

The following requirements are needed by this module:

- <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) (>= 0.15)

- <a name="requirement_aws"></a> [aws](#requirement\_aws) (>=3.25.0)

## Providers

The following providers are used by this module:

- <a name="provider_aws"></a> [aws](#provider\_aws) (>=3.25.0)

## Modules

No modules.

## Resources

The following resources are used by this module:

- [aws_eks_node_group.cluster_nodes](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_node_group) (resource)
- [aws_eks_cluster.cluster](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/eks_cluster) (data source)

## Required Inputs

The following input variables are required:

### <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name)

Description: the EKS cluster name

Type: `string`

### <a name="input_nodegroups"></a> [nodegroups](#input\_nodegroups)

Description: a map of objects containing the desired groups (each object name is the nodegroup name)

Type:

```hcl
map(object(
    {
      node_role_arn           = string,
      subnet_ids              = list(string),
      version                 = string,
      instance_types          = list(string),
      spot                    = bool
      tags                    = map(string),
      launch_template_id      = string,
      launch_template_version = string,
      desired_size            = string,
      max_size                = string,
      min_size                = string,
      taint                   = map(string)
    }
  ))
```

## Optional Inputs

No optional inputs.

## Outputs

No outputs.
<!-- END_TF_DOCS -->

## Usage
```
module "eks-nodegroups" {
  source                           = "git::https://dummy.git"
  cluster_name                     = var.cluster-name
  nodegroups                       = {
    group1 = {
      node_role_arn           = "arn:aws:iam::111111222222:role/eks_nodes",
      subnet_ids              = ["subnet1", "subnet2", "subnet3"],
      version                 = "1.21",
      instance_types          = ["c5.xlarge"],
      spot                    = false,
      tags                    = {              
        owner = "example@dummy.com"
        environment = "test"
      },
      launch_template_id      = lt-0e06d290751193123,
      launch_template_version = 2,
      desired_size            = 1,
      max_size                = 0,
      min_size                = 5
      taint                   = {}
    },
    group2 = {
      node_role_arn           = "arn:aws:iam::111111222222:role/eks_nodes",
      subnet_ids              = ["subnet1", "subnet2", "subnet3"],
      version                 = "1.21",
      instance_types          = ["c3.xlarge", "c4.xlarge", "c5.xlarge"],
      spot                    = true,
      tags                    = {              
        owner = "example@dummy.com"
        environment = "test"
      },
      launch_template_id      = "lt-0e06d290751193123",
      launch_template_version = 2,
      desired_size            = 1,
      max_size                = 0,
      min_size                = 5
      taint                   = {
        key = "key1"
        value = "value1"
        effect = "NO_SCHEDULE" ## Valid values: NO_SCHEDULE, NO_EXECUTE, PREFER_NO_SCHEDULE
      }
    }
  }
}
```