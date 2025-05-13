FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
USER root
RUN apt update && \
    apt install -y pipx shellcheck
USER vscode
RUN pipx install pre-commit
