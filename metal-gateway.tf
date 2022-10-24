# Set Network to Hybrid
resource "equinix_metal_device_network_type" "this" {
  count = var.create_metal_gateway ? 1 : 0

  device_id = equinix_metal_device.this.id
  type      = "hybrid"

  depends_on = [equinix_metal_device.this]
}

# Create VLAN to connect to Metal Gateway
resource "equinix_metal_vlan" "this" {
  count = var.create_metal_gateway ? 1 : 0

  metro       = var.metro
  project_id  = data.equinix_metal_project.this.id
  vxlan       = var.metal_gateway_vlan_id
  description = var.metal_gateway_vlan_description

  depends_on = [equinix_metal_device.this]
}

# Add Metal Gateway VLAN to bond0
resource "equinix_metal_port_vlan_attachment" "this" {
  count = var.create_metal_gateway ? 1 : 0

  device_id = equinix_metal_device_network_type.this[0].device_id
  port_name = "bond0"
  vlan_vnid = equinix_metal_vlan.this[0].vxlan
}

# Reserve a Public IP block
resource "equinix_metal_reserved_ip_block" "this" {
  count = var.create_metal_gateway ? 1 : 0

  project_id = data.equinix_metal_project.this.id
  type       = "public_ipv4"
  metro      = var.metro
  quantity   = var.num_public_ip

  depends_on = [equinix_metal_device.this]
}

# Create a Metal Gateway
resource "equinix_metal_gateway" "this" {
  count = var.create_metal_gateway ? 1 : 0

  project_id        = data.equinix_metal_project.this.id
  vlan_id           = equinix_metal_vlan.this[0].id
  ip_reservation_id = equinix_metal_reserved_ip_block.this[0].id
}