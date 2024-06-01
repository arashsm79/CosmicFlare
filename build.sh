#!/bin/bash

set -ouex pipefail

RELEASE="$(rpm -E %fedora)"


### Install packages
# Setup repos
## Cosmic Desktop
wget https://copr.fedorainfracloud.org/coprs/ryanabx/cosmic-epoch/repo/fedora-40/ryanabx-cosmic-epoch-fedora-$(rpm -E %fedora).repo -O /etc/yum.repos.d/_copr_ryanabx-cosmic.repo
## VSCodium
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg" | tee -a /etc/yum.repos.d/vscodium.repo
## Docker
wget https://download.docker.com/linux/fedora/docker-ce.repo -O /etc/yum.repos.d/docker-ce.repo
## Mullvad
wget https://repository.mullvad.net/rpm/stable/mullvad.repo -O /etc/yum.repos.d/mullvad.repo

# Install cosmic desktop environment
rpm-ostree install cosmic-desktop

# Install extras
rpm-ostree install tuned \
    gnome-keyring \
    adobe-source-code-pro-fonts \
    alacritty \
    android-tools \
    autossh \
    bash-color-prompt \
    bat \
    bcache-tools \
    btrfs-progs \
    cascadia-code-fonts \
    cifs-utils \
    cmatrix \
    codium \
    containerd.io \
    cryptsetup \
    dbus-x11 \
    desktop-file-utils \
    dmidecode \
    docker-buildx-plugin \
    docker-ce \
    docker-ce-cli \
    docker-compose-plugin \
    dua-cli \
    edk2-ovmf \
    evtest \
    evtest \
    eza \
    fastfetch \
    fd-find \
    firewall-config \
    fish \
    fish \
    flatpak \
    fuse-sshfs \
    gcc \
    genisoimage \
    git \
    glx-utils \
    google-droid-sans-mono-fonts \
    google-go-mono-fonts \
    gwe \
    hplip \
    ibm-plex-mono-fonts \
    ifuse \
    input-remapper \
    iotop \
    jetbrains-mono-fonts-all \
    libappindicator \
    libimobiledevice \
    libnotify \
    libvirt \
    libxcrypt-compat \
    lm_sensors \
    lsof \
    make \
    mesa-libGLU \
    mozilla-fira-mono-fonts \
    mullvad-vpn \
    nethogs \
    p7zip \
    p7zip-plugins \
    pciutils \
    playerctl \
    podman-compose \
    podman-tui \
    podmansh \
    powerline-fonts \
    powertop \
    printer-driver-brlaser \
    procs \
    psmisc \
    pulseaudio-utils \
    rclone \
    restic \
    ripgrep \
    rocm-hip \
    rocm-opencl \
    samba \
    samba-dcerpc \
    samba-ldb-ldap-modules \
    samba-winbind-clients \
    samba-winbind-modules \
    sd \
    solaar \
    stress-ng \
    tmux \
    traceroute \
    tree \
    udica \
    unrar \
    unzip \
    usbmuxd \
    v4l-utils \
    vazirmatn-fonts \
    vulkan-tools \
    wireguard-tools \
    wl-clipboard \
    xprop
    
# Set up display manager
rm -f /etc/systemd/system/display-manager.service
ln -s /usr/lib/systemd/system/cosmic-greeter.service /etc/systemd/system/display-manager.service

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl enable docker.socket
systemctl enable mullvad-daemon
systemctl enable cosmic-greeter.service
