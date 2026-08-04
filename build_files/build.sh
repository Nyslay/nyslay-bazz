#!/bin/bash

set -ouex pipefail

# Copy the contents of system_files/ of the git repo to /
cp -avf "/ctx/system_files"/. /

### Install packages

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/43/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up en
# eabled on the final image:
# dnf5 -y copr disable ublue-os/staging


# pre script (desktop)
# /opt is a symlink to /var/opt on atomic Fedora — helium-bin's RPM
if [ -L /opt ]; then
  rm -f /opt
fi


# Enable Terra
sed -i 's/enabled=0/enabled=1/' /etc/yum.repos.d/terra.repo

#dnf5 -y copr enable theblackdon/kineticwe
dnf5 -y copr enable lionheartp/Hyprland
dnf5 -y config-manager addrepo --from-repofile=https://repo.vivaldi.com/stable/vivaldi-fedora.repo

dnf install -y \
    firefox \
    qt5ct \
    qt6ct \
    nwg-look \
    adw-gtk3-theme \
    thunderbird \
    deja-dup \
    htop \
    helix

# COPR + External
dnf install -y \
    noctalia-git \
    zed \
    vivaldi-stable \
    yazi \
    
dnf install -y \
    fuzzel \
    waybar \
    alacritty \
    xdg-desktop-portal-gnome  \
    xdg-desktop-portal-gtk \
    niri



#### Example for enabling a System Unit File

systemctl enable podman.socket
