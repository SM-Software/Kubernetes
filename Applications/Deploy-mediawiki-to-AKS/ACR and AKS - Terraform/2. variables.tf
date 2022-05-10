variable "appname"{
  default = "mediawiki"
  type= string
}

variable "location" {
  default = "east us 2"
  description = "Geographical location"
  type = string
}

variable "resource_group_name"{
    default= "MediaWiki-Aks-RG"
    type= string
}

variable "acr_name"{
    default = "mediawikiACR"
    type= string
}

variable "default_aks_node_count" {
  default = 2
  type= number
}

variable "aks_node_vm_size" {
  default = "Standard_D2_V2"
}

variable "azure_aks_aad_group_name"{
  default = "aks-admins"
}

variable "windows_admin_username"{
  default = "IamAdmin"
  type = string
}

variable "windows_admin_password"{
  default = "VirtualMachine@123"
  type = string
}

variable "ssh_public_key"{
  type=string
}
