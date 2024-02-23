# DBT Test Project


## How to run

1. Create a .env file to set environment variables

2. Start the docker containers
```bash
docker-compose -f docker_compose.yaml up -d --build 
```

3. Use poetry to create a virtual environment
```bash
# creates venv under the hood and activates it
poetry shell
```

4. Inside the poetry shell, initialize the database
```bash
python init_db.py
```
A view on the database is available on localhost:8080/ via pgAdmin

5. Use dbt inside the poetry shell
```bash
dbt run
```
