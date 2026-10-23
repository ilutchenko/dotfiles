#!/usr/bin/env bash
#
# Install the packages this dotfiles repo needs, using whichever package
# manager the current distribution provides (apt, dnf/yum, pacman, zypper, apk).

set -e

packages=(vim tmux zsh)

SUDO=""
if [ "$(id -u)" -ne 0 ]; then
    SUDO="sudo"
fi

if command -v apt-get >/dev/null 2>&1; then
    $SUDO apt-get update
    $SUDO apt-get install -y "${packages[@]}"
elif command -v dnf >/dev/null 2>&1; then
    $SUDO dnf install -y "${packages[@]}"
elif command -v yum >/dev/null 2>&1; then
    $SUDO yum install -y "${packages[@]}"
elif command -v pacman >/dev/null 2>&1; then
    $SUDO pacman -Sy --noconfirm "${packages[@]}"
elif command -v zypper >/dev/null 2>&1; then
    $SUDO zypper install -y "${packages[@]}"
elif command -v apk >/dev/null 2>&1; then
    $SUDO apk add "${packages[@]}"
else
    echo "No supported package manager found (apt-get/dnf/yum/pacman/zypper/apk)." >&2
    echo "Install these manually: ${packages[*]}" >&2
    exit 1
fi
