# Festival Match Infra

Terraform infrastructure for the Festival Match project.

## Structure

- `environments/`: Environment-specific configurations (e.g., dev, prod).
- `modules/`: Reusable Terraform modules (network, backend, frontend).



# Festival Match – Infrastructure

This repository contains the infrastructure definition for the Festival Match
application using Terraform.

## Stack
- Terraform
- Docker provider
- Modular architecture
- Multi-service setup (frontend + backend)

## Architecture
- Frontend and backend run as Docker containers
- Containers are connected via a dedicated Docker network
- Infrastructure is fully managed by Terraform

## Environments
- dev: local development environment

## How to run
```bash
cd environments/dev
terraform init
terraform plan
terraform apply
