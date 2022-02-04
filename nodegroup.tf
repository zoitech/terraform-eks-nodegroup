resource "aws_eks_node_group" "cluster_nodes" {
  for_each = var.nodegroups

  cluster_name    = data.aws_eks_cluster.cluster.name
  node_group_name = each.key
  node_role_arn   = each.value.node_role_arn
  subnet_ids      = each.value.subnet_ids
  version         = each.value.version
  instance_types  = each.value.instance_types
  capacity_type   = each.value.spot ? "SPOT" : "ON_DEMAND"
  tags            = each.value.tags

  launch_template {
    id      = each.value.launch_template_id
    version = each.value.launch_template_version
  }

  scaling_config {
    desired_size = each.value.desired_size
    max_size     = each.value.max_size
    min_size     = each.value.min_size
  }

  lifecycle {
    ignore_changes = [scaling_config.0.desired_size]
  }
}


