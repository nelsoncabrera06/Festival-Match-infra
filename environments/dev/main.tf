# Environment: Dev
module "network" {
  source = "../../modules/network"
  name   = "festival-dev"
}

module "backend" {
  source         = "../../modules/backend"
  network_id     = module.network.network_id
  container_name = "festival-backend"
  image          = var.backend_image
  port           = 3002

  env = [
    # Formato: postgresql://usuario:contraseña@host_contenedor:puerto/nombre_db
    "DATABASE_URL=postgresql://postgres:${var.db_password}@festival-db:5432/festival_match"
  ]
}

module "frontend" {
  source         = "../../modules/frontend"
  network_id     = module.network.network_id
  container_name = "festival-frontend"
  image          = var.frontend_image
  port           = 5173
}

resource "docker_container" "db" {
  name  = "festival-db"
  image = "postgres:14"
  networks_advanced {
    name = "festival-dev"
  }
  env = [
    "POSTGRES_DB=festival_match",
    "POSTGRES_USER=postgres",
    "POSTGRES_PASSWORD=${var.db_password}" 
  ]
  # No es estrictamente necesario mapear el puerto 5432 al host si solo 
  # el backend la usará, pero ayuda para verla desde TablePlus/DBeaver.
  ports {
    internal = 5432
    external = 5432
  }
}