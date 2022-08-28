resource "aws_redshift_cluster" "redshift" {
  cluster_identifier = "tf-redshift-cluster"
  database_name      = "brightwheeldb"
  master_username    = "root"
  master_password    = "Securepassw0rd"
  node_type          = "dc1.large"
  cluster_type       = "single-node"
  number_of_nodes    = 1
}