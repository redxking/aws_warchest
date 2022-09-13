# FROM Arguments
ARG VARIANT="ubuntu-22.04"

# [Choice] Ubuntu version: bionic, focal
FROM mcr.microsoft.com/vscode/devcontainers/base:0-${VARIANT}

# Build Arguments
ARG TF_VERSION="1.2.5"
ARG TF_DOCS_VERSION="v0.16.0"
ARG IAMLIVE_VERSION="v0.48.0"
ARG NVM_VERSION="v0.39.1"

# ROOT user commands
# [Optional] Uncomment this section to install additional OS packages.
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    bash-completion \
    curl \
    gcc \
    git \
    golang \
    libc-dev \
    make \
    pkg-config \
    python3-pip \
    python3-venv \
    software-properties-common \
    && rm -rf /var/lib/apt/lists/*

# Set up Terraform
RUN curl -sSLo ./terraform.zip https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_$(dpkg --print-architecture).zip \
    && unzip terraform.zip \
    && rm terraform.zip \
    && mv terraform /usr/local/bin/

# Set up Terraform-docs
RUN curl -sSLo ./terraform-docs.tar.gz https://terraform-docs.io/dl/${TF_DOCS_VERSION}/terraform-docs-${TF_DOCS_VERSION}-$(uname)-$(dpkg --print-architecture).tar.gz \
    && tar -xzf terraform-docs.tar.gz \
    && chmod +x terraform-docs \
    && mv terraform-docs /usr/local/bin/ \
    && rm -rf terraform-docs.tar.gz

RUN curl -sSLo ./iamlive.tar.gz https://github.com/iann0036/iamlive/releases/download/${IAMLIVE_VERSION}/iamlive-${IAMLIVE_VERSION}-linux-$(dpkg --print-architecture).tar.gz \
    && tar -xzf iamlive.tar.gz \
    && mv iamlive /usr/local/bin/ \
    && rm -fr iamlive.tar.gz

# Set up tflint
RUN curl -s https://raw.githubusercontent.com/terraform-linters/tflint/master/install_linux.sh | bash

# Set up nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/${NVM_VERSION}/install.sh | bash \
    && export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")" \
    && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
    && nvm install 16

# Symlink /usr/bin/python to /usr/bin/python3
RUN sudo ln -s /usr/bin/python3 /usr/bin/python

# VSCODE user commands
USER vscode

# Setup Bash Completion
ADD --chown=vscode:vscode files/.bash_completion /home/vscode/.bash_completion
RUN mkdir /home/vscode/.bash_completion.d/

# Setup AWS CLI
RUN pip3 install --user \
    awscli \
    terraform-local \
    && echo "complete -C '/home/vscode/.local/bin/aws_completer' aws" >> ~/.bashrc

# Setup Poetry
RUN bash -c "curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python - \
    && echo 'export PATH=$HOME/.local/bin:\$PATH' >> ~/.bashrc" \
    && bash -c "export PATH=$HOME/.local/bin:\$PATH \
    && poetry completions bash > ~/.bash_completion.d/poetry.bash-completion"

# Install some Go packages to support the
# vscode Go extension...
RUN go install -v github.com/ramya-rao-a/go-outline@latest \
    && go install -v golang.org/x/tools/gopls@latest
