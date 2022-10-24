# Terraform to deploy VMware ESXi in Equinix Metal

Terraform module to deploy an ESXi host in Equinix Metal with option to create a Metal Gateway and User SSH key.
> **_NOTE:_** 
> Metal Gateway is required if you need to assign a public IP to a VM running in the VMware ESXi host.

## Prerequisites

Please make sure you have:
- [Equinix Metal account](https://metal.equinix.com/developers/docs/accounts/users/#profile)
- [Equinix Metal project](https://metal.equinix.com/developers/docs/accounts/projects/)
- [Equinix Metal API key or authentication token](https://metal.equinix.com/developers/docs/accounts/users/#api-keys)

To run this module, you will need set the following environment variables

Variables | Description
--- | ---
METAL_AUTH_TOKEN | Equinix API Key or Authentication Token


```bash
export METAL_AUTH_TOKEN="EqU1n1Xm3T4l4UtHt0K3n"
```

## Sample usage

```hcl
module "metal-vmware-esxi" {
  source  = "bayupw/metal-vmware-esxi/equinix"
  version = "1.0.0"

  metal_project_name   = "My Project"
  metro                = "sy"
  plan                 = "c3.small.x86"
  esx_hostname         = "esxi-01a"
  create_metal_gateway = true
  create_user_ssh_key  = false
}

output "metal_device_ip" {
  description = "VMware ESXi Public IP."
  value       = module.metal-vmware-esxi.equinix_metal_device.access_public_ipv4
}

output "metal_device_password" {
  description = "VMware ESXi password."
  value       = module.metal-vmware-esxi.equinix_metal_device.root_password
  sensitive   = true
}

output "metal_gateway_ip" {
  description = "Metal Gateway IP."
  value       = cidrhost(module.metal-vmware-esxi.equinix_metal_reserved_ip_block[0].cidr_notation, 1)
}

output "public_ip_block" {
  description = "Public IP CIDR block"
  value       = module.metal-vmware-esxi.equinix_metal_reserved_ip_block[0].cidr_notation
}

output "usable_public_ip" {
  description = "Usable public IP range"
  value       = "${cidrhost(module.metal-vmware-esxi.equinix_metal_reserved_ip_block[0].cidr_notation, 2)} - ${cidrhost(module.metal-vmware-esxi.equinix_metal_reserved_ip_block[0].cidr_notation, module.metal-vmware-esxi.equinix_metal_reserved_ip_block[0].quantity - 2)}"
}
```

In order to provide internet access to the VMs, the module by default creates an Equinix Metal Gateway. To disable Equinix Metal Gateway createion, set ```create_metal_gateway``` to ```true```.

To create a user ssh key, set ```create_user_ssh_key``` to ```true``` and provide the details in variable ```user_ssh_key_name``` and ```user_public_key```


## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-equinix-metal-vmware-esxi/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-equinix-metal-vmware-esxi/tree/master/LICENSE) for full details.