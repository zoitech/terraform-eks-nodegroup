variable "nodegroups" {
  type = map(object(
    {
      node_role_arn           = string,
      subnet_ids              = list(string),
      version                 = string,
      instance_types          = list(string),
      spot                    = bool
      tags                    = map(string),
      launch_template_id      = string,
      launch_template_version = number,
      desired_size            = number,
      max_size                = number,
      min_size                = number,
      taints                  = set(any)
    }
  ))
  description = "a map of objects containing the desired groups (each object name is the nodegroup name)"
}

variable "cluster_name" {
  type = string
  description = "the EKS cluster name"
}