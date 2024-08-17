resource "google_container_cluster" "primary"{
    name = "k8s-csci-5409-cluster"
    location = "us-east1-b"
    deletion_protection = false

    remove_default_node_pool = true
    initial_node_count       = 1
} 