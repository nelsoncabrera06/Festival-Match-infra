# Backend Module - Main
resource "docker_container" "this" {
  name    = var.container_name
  image   = var.image
  env     = var.env
  restart = "on-failure"

  networks_advanced {
    name = var.network_id
  }

  ports {
    internal = var.port
    external = var.port
  }
}
