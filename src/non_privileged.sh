#!/bin/bash

install_fonts() {
    mkdir -p ~/.local/share/fonts/
    curl -fsSL --output-dir ~/.local/share/fonts/ \
        -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf \
        -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf \
        -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf \
        -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf
}

install_powerlevel10k() {
    # shellcheck disable=SC1090
    source ~/.zshrc
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"
    omz theme set powerlevel10k/powerlevel10k
    # shellcheck disable=SC1090
    source ~/.zshrc
    p10k configure && echo -e "\nPOWERLEVEL9K_TERM_SHELL_INTEGRATION=true\n" >> ~/.p10k.zsh
}

install_zsh_plugins() {
    git clone --depth=1 https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
    git clone --depth=1 https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
    omz plugin enable mise zsh-autosuggestions zsh-syntax-highlighting
}

install_mise_languages() {
    mise use --global python java nodejs rust go pipx
    eval "$(mise activate zsh)"
}

install_eza() {
    cargo install eza
}

install_dust() {
    cargo install du-dust
}

add_zsh_aliases() {
    echo -e "\nalias cat=\"bat\"\nalias ls=\"eza --icons\"\n" >> ~/.zshrc
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

configure_tealdeer() {
    tldr --seed-config
    sed -i "s/auto_update = false/auto_update = true/" ~/.config/tealdeer/config.toml
}

main() {
    install_fonts
    install_powerlevel10k
    install_zsh_plugins
    install_mise_languages
    install_eza
    install_dust
    add_zsh_aliases
    configure_ssh
    configure_gpg
    configure_git
    configure_tealdeer
}

main
