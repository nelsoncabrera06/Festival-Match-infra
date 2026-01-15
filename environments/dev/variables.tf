# Variables definitions for dev
variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true # Esto evita que la contraseña se imprima en la pantalla durante el plan/apply
}

variable "backend_image" {
  description = "Docker image for backend"
  type        = string
  default     = "festival-backend:latest" # Local default, override for GHCR
}

variable "frontend_image" {
  description = "Docker image for frontend"
  type        = string
  default     = "festival-frontend:latest" # Local default, override for GHCR
}