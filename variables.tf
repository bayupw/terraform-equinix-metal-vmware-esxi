variable "create_user_ssh_key" {
  description = "Set to true to create a new user ssh key."
  type        = bool
  default     = false
}

variable "create_metal_gateway" {
  description = "Set to true to create metal gateway."
  type        = bool
  default     = true
}

variable "user_ssh_key_name" {
  description = "User ssh key name."
  type        = string
  default     = null
}

variable "user_public_key" {
  description = "User public key."
  type        = string
  default     = null
}

variable "metal_project_name" {
  description = "Equinix Metal Project Name."
  type        = string
}

variable "metro" {
  description = "Location code."
  type        = string
  default     = "sy"
}

variable "plan" {
  description = "Server config."
  type        = string
  default     = "c3.small.x86"
}

variable "os" {
  description = "Operating System."
  type        = string
  default     = "vmware_esxi_7_0"
}

variable "billing" {
  description = "Deploy type."
  type        = string
  default     = "hourly"
}

variable "esx_hostname" {
  description = "VMware ESXi hostname."
  type        = string
  default     = "esxi-01a"
}

variable "metal_gateway_vlan_id" {
  description = "Metal gateway VLAN ID."
  type        = string
  default     = "255"
}

variable "metal_gateway_vlan_description" {
  description = "Metal gateway VLAN description."
  type        = string
  default     = "Metal Gateway VLAN"
}

variable "num_public_ip" {
  description = "Number of Public IPs."
  type        = number
  default     = 8

  validation {
    condition     = var.num_public_ip >= 8 && var.num_public_ip <= 128 && floor(var.num_public_ip) == var.num_public_ip
    error_message = "Metal Gateways support IP address blocks in the range of 8 IP addresses to 128 IP addresses (/29 to /25)."
  }
}