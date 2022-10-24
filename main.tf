# Retrieve Equinix Metal project data
data "equinix_metal_project" "this" {
  name = var.metal_project_name
}

# Provision ESXi host
resource "equinix_metal_device" "this" {
  project_id       = data.equinix_metal_project.this.id
  billing_cycle    = var.billing
  hostname         = var.esx_hostname
  plan             = var.plan
  metro            = var.metro
  operating_system = var.os
  user_ssh_key_ids = var.create_user_ssh_key ? [equinix_metal_ssh_key.this[0].id] : null
}