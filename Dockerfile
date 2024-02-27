FROM python:3.10-slim


ENV PYTHONFAULTHANDLER=1 \
  # Poetry's configuration:
  POETRY_NO_INTERACTION=1 \
  POETRY_VIRTUALENVS_CREATE=false \
  POETRY_CACHE_DIR='/var/cache/pypoetry' \
  POETRY_HOME='/usr/local'


# Install curl
RUN apt-get update && apt-get install -y curl

# Install Poetry
RUN curl -sSL https://install.python-poetry.org | POETRY_HOME=/app/poetry python3 -
ENV PATH="$PATH:/app/poetry/bin"

# Copy only the files necessary for installing dependencies to cache the layers better
COPY pyproject.toml poetry.lock ./
RUN poetry install --no-dev --no-root

# Copy the rest of your app code
COPY data ./data/

# Add the Poetry environment's bin directory to the PATH to access the poetry command
ENV PATH="$PATH:/app/.venv/bin"

WORKDIR /dbttest

ENTRYPOINT [ "bash" ]