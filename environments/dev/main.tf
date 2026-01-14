# Environment: Dev
module "network" {
  source = "../../modules/network"
  name   = "festival-dev"
}

module "backend" {
  source      = "../../modules/backend"
  network_id  = module.network.network_id
  container_name = "festival-backend"
  image       = "festival-backend:latest"
  port        = 3002
}

module "frontend" {
  source      = "../../modules/frontend"
  network_id  = module.network.network_id
  container_name = "festival-frontend"
  image       = "festival-frontend:latest"
  port        = 5173
}
