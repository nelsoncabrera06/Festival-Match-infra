# Variables definitions for dev
variable "db_password" {
  description = "Contraseña de la base de datos"
  type        = string
  sensitive   = true # Esto evita que la contraseña se imprima en la pantalla durante el plan/apply
}