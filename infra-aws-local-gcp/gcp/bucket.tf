resource "google_storage_bucket" "data" {
  name          = "costellr-data-perf"
  location      = "us-west1"
  storage_class = "STANDARD"
  force_destroy = true
}
