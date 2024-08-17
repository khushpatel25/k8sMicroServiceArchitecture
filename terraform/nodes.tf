resource "google_service_account" "kubernetes" {
    account_id = "cloud-k8s-427803"
}

resource "google_artifact_registry_repository_iam_member" "repo-iam" {
  location = "northamerica-northeast1"
  repository = "k8s-assignment"
  role   = "roles/artifactregistry.reader"
  member = "serviceAccount:${google_service_account.kubernetes.email}"
}

resource "google_container_node_pool" "general" {
  name = "general"
  cluster = google_container_cluster.primary.id
  node_count = 1

  node_config {
    preemptible = true
    machine_type = "e2-standard-2"
    disk_type = "pd-standard"
    disk_size_gb = 10

    service_account = google_service_account.kubernetes.email
    oauth_scopes    = [
      "https://www.googleapis.com/auth/cloud-platform"
    ]
  }
}