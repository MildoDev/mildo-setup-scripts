#!/bin/bash

configure_starship() {
    echo -e "eval \"\$(starship init zsh)\"\n" >> ~/.zshrc
}

install_zsh_plugins() {
    # shellcheck disable=SC1090
    source ~/.zshrc
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
    omz plugin enable mise zsh-autosuggestions zsh-syntax-highlighting
}

install_mise_languages() {
    mise use --global python java nodejs rust go pipx
    eval "$(mise activate zsh)"
}

install_eza() {
    cargo install --locked eza
}

install_dust() {
    cargo install du-dust
}

configure_ssh() {
    echo -n "(SSH and Git) Enter your email: " && read -r USER_EMAIL
    ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -C "${USER_EMAIL}"
    ssh-add ~/.ssh/id_ed25519
}

configure_gpg() {
    gpg --full-generate-key
}

configure_git() {
    echo -n "(Git) Enter your full name: " && read -r GIT_FULL_NAME
    git config --global user.name "${GIT_FULL_NAME}"
    git config --global user.email "${USER_EMAIL}"
    git config --global init.defaultBranch main
    git config --global commit.gpgsign true
    git config --global core.pager delta
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate true
    git config --global merge.conflictStyle zdiff3
}

main() {
    configure_starship
    install_zsh_plugins
    install_mise_languages
    install_eza
    install_dust
    configure_ssh
    configure_gpg
    configure_git
}

main
