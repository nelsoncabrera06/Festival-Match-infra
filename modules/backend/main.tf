# Backend Module - Main
resource "docker_container" "this" {
  name  = var.container_name
  image = var.image

  networks_advanced {
    name = var.network_id
  }

  ports {
    internal = var.port
    external = var.port
  }
}
