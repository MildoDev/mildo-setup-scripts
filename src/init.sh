#!/bin/bash

start_privileged_script() {
    sudo ./privileged.sh
}

install_oh_my_zsh() {
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
}

start_non_privileged_script() {
    zsh non_privileged.sh
}

main() {
    start_privileged_script
    install_oh_my_zsh
    start_non_privileged_script
}

main
