# DBT Test Project


## How to run

1. Create a .env file to set environment variables
```bash
DB_PORT="5432"
POSTGRES_DB="testdb"
POSTGRES_USER="user"
POSTGRES_PASSWORD="password"
PGADMIN_DEFAULT_EMAIL=admin@admin.com
PGADMIN_DEFAULT_PASSWORD=admin
```

3. When running the first time, download the data. See /data/raw/download_from.md

2. Start the docker containers
```bash
docker-compose -f docker_compose.yaml up -d --build 
```

3. Access the shell inside the dbt docker container
```bash
docker exec -it dbt bash
```

4. When running the first time, initialize the database
```bash
# inside the dbt container
cd ../data
python init_db.py
cd ../dbttest
```

5. Check if dbt is configured correctly
```bash
# inside the dbt container
dbt debug
```

6. Start dbt
```bash
# inside the dbt container
dbt build
```

7. Access the database on localhost:8080/ via pgAdmin