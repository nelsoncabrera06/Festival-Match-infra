# Network Module - Main
resource "docker_network" "this" {
  name = var.name
}
