#!/bin/bash

configure_dnf() {
    dnf config-manager setopt max_parallel_downloads=15
}

enable_rpm_fusion_free() {
    dnf -y install "https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
}

system_upgrade() {
    dnf -y upgrade
}

install_nvidia_drivers() {
    echo "%_with_kmod_nvidia_open 1" > /etc/rpm/macros.nvidia-kmod
    dnf -y install akmod-nvidia
}

install_mise() {
    dnf config-manager addrepo --from-repofile https://mise.jdx.dev/rpm/mise.repo
    dnf -y install mise
}

install_docker() {
    dnf config-manager addrepo --from-repofile https://download.docker.com/linux/fedora/docker-ce.repo
    dnf -y install containerd.io docker-buildx-plugin docker-ce docker-ce-cli docker-compose-plugin
    usermod -aG docker "${USERNAME}"
    systemctl enable --now docker
}

install_terminal_programs() {
    dnf -y install kitty zsh
    chsh -s /bin/zsh "${USERNAME}"
}

install_terminal_utilities() {
    dnf -y install bat fd-find procs ripgrep
    dnf -y install git-delta hyperfine nu tealdeer
}

install_appindicator() {
    dnf -y install gnome-shell-extension-appindicator
}

install_dropbox() {
    echo -e "[Dropbox]\nname=Dropbox Repository\nbaseurl=http://linux.dropbox.com/fedora/\$releasever/\nenabled=1\ngpgcheck=1\ngpgkey=https://linux.dropbox.com/fedora/rpm-public-key.asc" > /etc/yum.repos.d/dropbox.repo
    dnf -y install nautilus-dropbox
}

install_vscode() {
    echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo
    dnf -y install code
}

install_librewolf() {
    dnf config-manager addrepo --from-repofile https://repo.librewolf.net/librewolf.repo
    dnf -y install librewolf
}

install_brave() {
    dnf config-manager addrepo --from-repofile https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
    dnf -y install brave-browser
}

install_virtualbox() {
    dnf -y install virtualbox
}

install_discord() {
    flatpak install -y flathub com.discordapp.Discord
}

install_scrcpy() {
    dnf -y copr enable zeno/scrcpy
    dnf -y install scrcpy
}

install_v4l2loopback() {
    dnf -y install v4l2loopback
}

install_antimicrox() {
    dnf -y install antimicrox
}

install_openfortivpn() {
    dnf -y install openfortivpn
}

install_steam() {
    flatpak install -y flathub com.valvesoftware.Steam
}

system_cleanup() {
    dnf -y autoremove
    dnf clean all
}

main() {
    configure_dnf
    enable_rpm_fusion_free
    system_upgrade
    install_nvidia_drivers
    install_mise
    install_docker
    install_terminal_programs
    install_terminal_utilities
    install_appindicator
    install_dropbox
    install_vscode
    install_librewolf
    install_brave
    install_virtualbox
    install_discord
    install_scrcpy
    install_v4l2loopback
    install_antimicrox
    install_openfortivpn
    install_steam
    system_cleanup
}

main
