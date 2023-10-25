variable "fw_ports" {
  type = list(number)
    description = "List of used FW ports"
    default = [ 8080, 80, 21, 22, 443 ]
}

variable "env" {
  type = string
  description = "Environment declaration"
}