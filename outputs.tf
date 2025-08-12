output "instance_name" {
  description = "The name of the VM"
  value       = google_compute_instance.vm.name
}

output "instance_ip" {
  description = "The external IP of the VM"
  value       = google_compute_instance.vm.network_interface[0].access_config[0].nat_ip
}
