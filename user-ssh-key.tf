# Create User SSH key
resource "equinix_metal_ssh_key" "this" {
  count = var.create_user_ssh_key ? 1 : 0

  name       = var.user_ssh_key_name
  public_key = var.user_public_key
}