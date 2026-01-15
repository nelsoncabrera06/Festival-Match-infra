# Festival Match Infra

Terraform infrastructure for the Festival Match project.

## Structure

- `environments/`: Environment-specific configurations (e.g., dev, prod).
- `modules/`: Reusable Terraform modules (network, backend, frontend).

## Stack
- Terraform
- Docker provider
- Modular architecture
- Multi-service setup (frontend + backend)

## Architecture
- Frontend and backend run as **Docker containers**
- Containers are connected via a dedicated Docker network
- Infrastructure is fully managed by **Terraform**

## Environments
- dev: local development environment

## How to run
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
```

## How to destroy
```bash
terraform destroy
```

## Documentation
- [README-DETAILED.md](docs/README-DETAILED.md) - Step-by-step guide
- [Learning-roadmap.md](docs/Learning-roadmap.md) - Terraform learning path
