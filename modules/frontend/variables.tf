# Frontend Module - Variables
variable "network_id" {
  description = "Docker network ID"
  type        = string
}

variable "container_name" {
  description = "Container name"
  type        = string
}

variable "image" {
  description = "Docker image to use"
  type        = string
}

variable "port" {
  description = "Internal and external ports"
  type        = number
}