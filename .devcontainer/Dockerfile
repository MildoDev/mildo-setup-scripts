FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04
USER root
RUN apt update && \
    apt install -y pipx shellcheck git-delta
USER vscode
RUN pipx install pre-commit
