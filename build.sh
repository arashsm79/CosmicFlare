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
    gnome-keyring
    
# Set up display manager
rm -f /etc/systemd/system/display-manager.service
ln -s /usr/lib/systemd/system/cosmic-greeter.service /etc/systemd/system/display-manager.service

# Example for enabling a System Unit File
systemctl enable podman.socket
systemctl enable docker.socket
systemctl enable mullvad-daemon
systemctl enable cosmic-greeter.service
