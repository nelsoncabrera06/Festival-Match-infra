# Festival Match Infra

Terraform infrastructure for the Festival Match project:
https://github.com/nelsoncabrera06/Festival-Match

## Stack
- Terraform
- Docker provider
- Modular architecture
- Multi-service setup (frontend + backend)

## Architecture

- Docker containers managed via Terraform
- Isolated networks per environment
- Modular design (network / app)

## Environments
- dev: lightweight containers
- prod: scalable setup (simulated)

## Commands
```
terraform init
terraform plan
terraform apply
terraform destroy
```

## Architecture of this proyect:
```
FestivalMatch-infra/
├── docs
│   └── README-DETAILED.md --> you are here :) 
├── environments
│   └── dev
│       ├── main.tf
│       ├── providers.tf
│       ├── terraform.tfstate -- ignored in repository
│       ├── terraform.tfstate.backup -- ignored in repository
│       ├── terraform.tfvars -- local variables (ignored in repository)
│       └── variables.tf
├── modules
│   ├── backend
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   ├── frontend
│   │   ├── main.tf
│   │   ├── outputs.tf
│   │   ├── variables.tf
│   │   └── versions.tf
│   └── network
│       ├── main.tf
│       ├── outputs.tf
│       ├── variables.tf
│       └── versions.tf
└── README.md
```

------------------------------------------------------------------------

## Architecture of the application FestivalMatch (the app I use to test this infrastructure)

```
FestivalMatch/
├── festival_match_backup.sql --> db backup, this is important 
├── package-lock.json
├── package.json
├── .env 
├── public
│   ├── app.js
│   ├── Dockerfile   ---> this is important
│   ├── i18n
│   │   ├── en.json
│   │   ├── es.json
│   │   └── fi.json
│   ├── i18n.js
│   ├── images
│   │   ├── madcoolfestival.jpg
│   │   ├── primavera sound 2026.webp
│   │   └── szigetfestival.png
│   ├── index.html
│   └── styles.css
└── server
    ├── auth.js
    ├── db.js
    ├── Dockerfile   ---> this is important
    ├── festivals.json
    └── server.js
```

This is how it should look like:
```
festival-backend   (app)
festival-frontend  (app)
postgres:14        (db)
festival-infra     (Terraform)
```

Once you created the Dockerfiles, you have to build the image:

I ran this, inside the project FestivalMatch/ 
```
FestivalMatch %
docker build -t festival-backend ./server
docker build -t festival-frontend ./public
```
With this I just created the docker images, you can check that with
```
FestivalMatch-infra % docker images
IMAGE                            ID             DISK USAGE   CONTENT SIZE   EXTRA        
festival-backend:latest          cdf20eb8c76e        148MB             0B        
festival-frontend:latest         4d4d6c53b444        148MB             0B        
```

Now we have the images ready

First check, no containers are running yet:
```
% docker ps
CONTAINER ID   IMAGE     COMMAND   CREATED   STATUS    PORTS     NAMES
```
Terraform will create the containers (for backend, frontend and db) and the network in main.tf

/FestivalMatch-infra/environments/dev/main.tf

```
module "network" { ... name   = "festival-dev" }

module "backend" {
...
  container_name = "festival-backend"
...
  env = [
    # Formato: postgresql://usuario:contraseña@host_contenedor:puerto/nombre_db
    "DATABASE_URL=postgresql://postgres:${var.db_password}@festival-db:5432/festival_match"
  ]
}

module "frontend" { ... container_name = "festival-frontend" ....}

resource "docker_container" "db" { name  = "festival-db" ... }
```

from this project FestivalMatch-infra in environments/dev run
```
FestivalMatch-infra/environments/dev%
# initialize terraform 
terraform init
# plan and apply the changes
terraform plan
terraform apply
```

After this our Infrastructure is alive, and we will see first our db image created "postgres:14"
```
% docker images
IMAGE                            ID             DISK USAGE   CONTENT SIZE   EXTRA
festival-backend:latest          cdf20eb8c76e        148MB             0B        
festival-frontend:latest         4d4d6c53b444        148MB             0B        
postgres:14                      8eaca06e6f5a        464MB             0B 
```

Now our containers are running:
```
dev % docker ps
CONTAINER ID   IMAGE                      COMMAND                  CREATED          STATUS          PORTS                    NAMES
4c381197b453   festival-backend:latest    "docker-entrypoint.s…"   9 seconds ago    Up 9 seconds    0.0.0.0:3002->3002/tcp   festival-backend
bdccf5bf7a10   festival-frontend:latest   "docker-entrypoint.s…"   9 seconds ago    Up 9 seconds    0.0.0.0:5173->5173/tcp   festival-frontend
620aeff3de44   postgres:14                "docker-entrypoint.s…"   10 seconds ago   Up 10 seconds   0.0.0.0:5432->5432/tcp   festival-db
```

I check the logs of my backend container:
```
dev % docker logs festival-backend
...
   - Local:   http://localhost:3002
   - Red:     http://172.19.0.4:3002
```