output "equinix_metal_device" {
  description = "Equinix metal device object."
  value       = equinix_metal_device.this
}

output "equinix_metal_vlan" {
  description = "Equinix metal vlan object."
  value       = var.create_metal_gateway ? equinix_metal_vlan.this : null
}

output "equinix_metal_gateway" {
  description = "Equinix metal gateway object."
  value       = var.create_metal_gateway ? equinix_metal_gateway.this : null
}

output "equinix_metal_reserved_ip_block" {
  description = "Equinix metal reserved IP block object."
  value       = var.create_metal_gateway ? equinix_metal_reserved_ip_block.this : null
}