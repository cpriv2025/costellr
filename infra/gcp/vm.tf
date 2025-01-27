resource "google_compute_instance" "OS_bench_instance" {
 name         = "ubuntu-instance"
 machine_type = "e2-micro"
 zone         = "us-west1-a"

 metadata = {
    ssh-keys = "your-username:${file("~/.ssh/google_compute_engine.pub")}"
 }

 boot_disk {
   initialize_params {
     image = "ubuntu-os-cloud/ubuntu-2204-lts"
   }
 }

 network_interface {
   network = "default"
   access_config {
     // Ephemeral public IP
   }
 }
}

resource "google_project_service" "project" {
 project = "constellr2025"
 service = "compute.googleapis.com"

 disable_on_destroy = false
}
