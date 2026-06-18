output "vm_ips" {
  description = "Public IPs of created VMs"
  value = {
    for idx, instance in yandex_compute_instance.vm :
    instance.name => instance.network_interface.0.nat_ip_address
  }
}

output "vm_internal_ips" {
  description = "Internal IPs of created VMs"
  value = {
    for idx, instance in yandex_compute_instance.vm :
    instance.name => instance.network_interface.0.ip_address
  }
}
