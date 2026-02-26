variable "internet_cidr" {
  type        = string
  description = "Entire IPv4 CIDR"
  default     = "0.0.0.0/0"
}

variable "alb_allow_ports" {
  type        = list(number)
  description = "Allow traffic on ports"
  default     = [80]
}
