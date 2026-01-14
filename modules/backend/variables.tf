# Backend Module - Variables
variable "container_name" {
  type = string
}

variable "image" {
  type = string
}

variable "port" {
  type = number
}

variable "network_id" {
  type = string
}

variable "env" {
  description = "Lista de variables de entorno para el contenedor"
  type        = list(string)
  default     = []
}