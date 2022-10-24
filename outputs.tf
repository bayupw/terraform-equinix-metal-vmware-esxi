output "metal_device_ip" {
  description = "VMware ESXi Public IP."
  value       = equinix_metal_device.this.access_public_ipv4
}

output "metal_device_password" {
  description = "VMware ESXi password."
  value       = equinix_metal_device.this.root_password
  sensitive   = true
}

output "metal_gateway_ip" {
  description = "Metal Gateway IP."
  value       = var.create_metal_gateway ? cidrhost(equinix_metal_reserved_ip_block.this[0].cidr_notation, 1) : null
}

output "public_ip_block" {
  description = "Public IP CIDR block"
  value       = var.create_metal_gateway ? equinix_metal_reserved_ip_block.this[0].cidr_notation : null
}

output "usable_public_ip" {
  description = "Usable public IP range"
  value       = var.create_metal_gateway ? "${cidrhost(equinix_metal_reserved_ip_block.this[0].cidr_notation, 2)} - ${cidrhost(equinix_metal_reserved_ip_block.this[0].cidr_notation, var.num_public_ip - 2)}" : null
}