# Terraform to deploy VMware ESXi in Equinix Metal

Terraform module to deploy an ESXi host in Equinix Metal with option to create a Metal Gateway and User SSH key.
> **_NOTE:_** 
> Metal Gateway will be required if you need to assign a public IP to a VM running in the VMware ESXi host.

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

output "metal-vmware-esxi" {
  value     = module.metal-vmware-esxi
  sensitive = true
}
```

To create a user ssh key, set ```create_user_ssh_key``` to true and provide the details in variable ```user_ssh_key_name``` and ```user_public_key```

To display output details

```bash
terraform output metal-vmware-esxi
```

## Contributing

Report issues/questions/feature requests on in the [issues](https://github.com/bayupw/terraform-equinix-metal-vmware-esxi/issues/new) section.

## License

Apache 2 Licensed. See [LICENSE](https://github.com/bayupw/terraform-equinix-metal-vmware-esxi/tree/master/LICENSE) for full details.