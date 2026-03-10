#!/bin/bash

start_privileged_script() {
    if [ -f /etc/fedora-release ]; then
        sudo ./fedora/privileged.sh
    elif [ -f /etc/debian_version ]; then
        sudo ./debian/privileged.sh
    fi
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

start_non_privileged_script() {
    zsh non_privileged.sh
}

add_zsh_aliases() {
    if [ -f /etc/fedora-release ]; then
        echo -e "\nalias cat=\"bat\"\nalias ls=\"eza --icons\"\n" >> ~/.zshrc
    elif [ -f /etc/debian_version ]; then
        echo -e "\nalias cat=\"batcat\"\nalias ls=\"eza --icons\"\n" >> ~/.zshrc
    fi
}

main() {
    start_privileged_script
    install_oh_my_zsh
    start_non_privileged_script
    add_zsh_aliases
}

main
