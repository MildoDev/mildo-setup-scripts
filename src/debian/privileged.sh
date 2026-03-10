#!/bin/bash

enable_contrib_and_non_free_sources() {
    sed -i "s/main non-free-firmware/main contrib non-free non-free-firmware/g" /etc/apt/sources.list
    apt update
}

system_upgrade() {
    apt -y upgrade
}

install_nvidia_drivers() {
    apt -y install "linux-headers-$(uname -r)" nvidia-driver
}

install_flatpak() {
    apt -y install flatpak gnome-software-plugin-flatpak
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
}

install_mise() {
    curl -fsSL https://mise.jdx.dev/gpg-key.pub -o /etc/apt/keyrings/mise-archive-keyring.asc
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.asc] https://mise.jdx.dev/deb stable main" > /etc/apt/sources.list.d/mise.list
    apt update
    apt install -y mise
}

install_docker() {
    curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    echo "deb [signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
    apt update
    apt -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
    usermod -aG docker "${SUDO_USER}"
}

install_terminal_programs() {
    apt -y install kitty zsh
    chsh -s /bin/zsh "${SUDO_USER}"
}

install_terminal_utilities() {
    apt -y install bat fd-find procs ripgrep
    apt -y install git-delta aria2 hyperfine
}

install_appindicator() {
    apt -y install gnome-shell-extension-appindicator
}

install_dropbox() {
    curl -fsSL https://linux.dropbox.com/fedora/rpm-public-key.asc -o /etc/apt/keyrings/dropbox.asc
    echo "deb [signed-by=/etc/apt/keyrings/dropbox.asc] https://linux.dropbox.com/debian/ $(lsb_release -cs) main" > /etc/apt/sources.list.d/dropbox.list
    apt update
    apt install -y dropbox
}

install_vscode() {
    curl -fsSL https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > /usr/share/keyrings/microsoft.gpg
    echo -e "Types: deb\nURIs: https://packages.microsoft.com/repos/code\nSuites: stable\nComponents: main\nArchitectures: $(dpkg --print-architecture)\nSigned-By: /usr/share/keyrings/microsoft.gpg" > /etc/apt/sources.list.d/vscode.sources
    apt update
    apt install -y code
}

install_brave() {
    curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg -o /usr/share/keyrings/brave-browser-archive-keyring.gpg
    curl -fsSL https://brave-browser-apt-release.s3.brave.com/brave-browser.sources -o /etc/apt/sources.list.d/brave-browser-release.sources
    apt update
    apt install -y brave-browser
}

install_virt_manager() {
    apt install -y virt-manager
}

install_discord() {
    flatpak install -y flathub com.discordapp.Discord
}

install_openfortivpn() {
    apt -y install openfortivpn
}

install_steam() {
    flatpak install -y flathub com.valvesoftware.Steam
}

system_cleanup() {
    apt -y autoremove --purge
    apt clean
}

main() {
    enable_contrib_and_non_free_sources
    system_upgrade
    install_nvidia_drivers
    install_flatpak
    install_mise
    install_docker
    install_terminal_programs
    install_terminal_utilities
    install_appindicator
    install_dropbox
    install_vscode
    install_brave
    install_virt_manager
    install_discord
    install_openfortivpn
    install_steam
    system_cleanup
}

main
