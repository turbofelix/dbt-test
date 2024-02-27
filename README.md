# DBT Test Project


## How to run

1. Create a .env file to set environment variables

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
# this will throw missing git error, which can be ignored
```

6. Start dbt
```bash
# inside the dbt container
dbt run
```

7. Access the database on localhost:8080/ via pgAdmin