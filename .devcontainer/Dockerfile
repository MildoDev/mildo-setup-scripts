FROM mcr.microsoft.com/devcontainers/base:noble
USER root
RUN apt update && \
    apt install -y pipx shellcheck
USER vscode
RUN pipx install pre-commit
