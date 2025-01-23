#!/bin/bash

configure_dnf() {
    dnf config-manager setopt max_parallel_downloads=15
}

system_upgrade() {
    dnf -y upgrade
}

install_nvidia_drivers() {
    dnf -y install akmod-nvidia
}

install_development_libs() {
    dnf -y install bzip2-devel ncurses-devel libffi-devel readline-devel sqlite-devel tk-devel
}

install_docker() {
    dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
    dnf -y install containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-compose-plugin
    usermod -aG docker "${USERNAME}"
    systemctl enable --now docker
}

install_terminal_programs() {
    dnf -y install kitty zsh
    chsh -s "$(which zsh)" "${USERNAME}"
}

install_terminal_utilities() {
    dnf -y install bat eza fd-find procs ripgrep sd
    dnf -y install git-delta hyperfine nu tealdeer
}

install_vscode() {
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" >/etc/yum.repos.d/vscode.repo
    dnf -y install code
}

install_brave() {
    dnf config-manager addrepo --from-repofile https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    dnf -y install brave-browser
}

install_discord() {
    flatpak install -y flathub com.discordapp.Discord
}

install_openfortivpn() {
    dnf -y install openfortivpn
}

system_cleanup() {
    dnf -y autoremove
    dnf clean all
}

main() {
    configure_dnf
    system_upgrade
    install_nvidia_drivers
    install_development_libs
    install_docker
    install_terminal_programs
    install_terminal_utilities
    install_vscode
    install_brave
    install_discord
    install_openfortivpn
    system_cleanup
}

main
