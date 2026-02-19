variable "my_ip" {
  type        = string
  description = "My IP addr to whitelist for bastion host SSH conn"
  default     = "127.0.0.1/32"
}


variable "internet_cidr" {
  type        = string
  description = "CIDR value for internet"
  default     = "0.0.0.0/0"
}

variable "serv_type" {
  type        = map(string)
  description = "Map of server and its instance type"
  default = {
    bastion = "t2.micro"
    app     = "t2.micro"
  }
}

variable "pubkey_path" {
  type        = string
  description = "Path for public key file"
  default     = "~/.ssh/bastion/bastion.pub"
}
