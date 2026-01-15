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
festival-backend   (app)
festival-frontend  (app)
postgres:14        (db)
festival-infra     (Terraform)


Once you created the Dockerfiles, you have to build the image:
```
docker build -t festivalmatch-frontend .
docker build -t festivalmatch-backend .
```

Run the containers:
```
docker run -d --name festivalmatch-frontend -p 3000:3000 festivalmatch-frontend
docker run -d --name festivalmatch-backend -p 3001:3001 festivalmatch-backend
```

Check the images:
```
nelson.cabrera@Nelsons-MacBook-Pro FestivalMatch-infra % docker images
IMAGE                            ID             DISK USAGE   CONTENT SIZE   EXTRA        
festival-backend:latest          cdf20eb8c76e        148MB             0B        
festival-frontend:latest         4d4d6c53b444        148MB             0B        
postgres:14                      8eaca06e6f5a        464MB             0B    
```