FROM ubuntu:20.04 AS base

# Disable interaction while installing or upgrading the system via apt
ARG DEBIAN_FRONTEND=noninteractive

# Install curl and docker.io using apt-get
RUN apt-get -yqq update && apt-get -yqq upgrade &&  apt-get -yqq install \
  software-properties-common \
  python3-pip \
  gnupg \
  unzip \
  wget \
  curl \
  docker.io
  
# Install npm and nodejs
# Install from nodesource using apt-get
# https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-an-ubuntu-14-04-server
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - && apt-get install -y nodejs
RUN npm install -g npm

# Download Terraform
RUN wget -O- https://apt.releases.hashicorp.com/gpg | \
    gpg --dearmor | \
    tee /usr/share/keyrings/hashicorp-archive-keyring.gpg

RUN gpg --no-default-keyring \
    --keyring /usr/share/keyrings/hashicorp-archive-keyring.gpg \
    --fingerprint

RUN echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] \
    https://apt.releases.hashicorp.com $(lsb_release -cs) main" | \
    tee /etc/apt/sources.list.d/hashicorp.list

RUN apt-get update && apt-get install terraform=1.2.5

# Setup env
ENV LANG C.UTF-8
ENV LC_ALL C.UTF-8
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONFAULTHANDLER 1

FROM base AS python-deps

# Install poetry
RUN pip install poetry==1.1.11

# Install python dependencies in /.venv
COPY pyproject.toml .
COPY poetry.lock .
RUN POETRY_VIRTUALENVS_IN_PROJECT=true poetry install --no-dev

FROM base AS runtime

# Copy virtual env from python-deps stage
COPY --from=python-deps /.venv /.venv
ENV PATH="/.venv/bin:$PATH"

# Create and switch to a new user
RUN useradd --create-home runway
WORKDIR /home/runway
