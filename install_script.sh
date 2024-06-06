#!/bin/bash

check_yay_installed() {
    if command -v yay &> /dev/null; then
        echo "yay is already installed."
        return 0
    else
        return 1
    fi
}

install_yay() {
    echo "Installing yay..."
    sudo pacman -Syu --noconfirm
    sudo pacman -S --needed --noconfirm base-devel git
    cd /opt
    sudo git clone https://aur.archlinux.org/yay.git
    sudo chown -R $(whoami):$(whoami) yay
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
}


apps=(
    # Terminal utilities
    tmux
    htop
    wget
    curl
    git
    nvim
    fzf
    
    # System monitoring
    fastfetch

    # Audio and video
    vlc
    spotify

    # Web browsers
    firefox

    # Compression tools
    unzip
    unrar

    # Others
    gparted
    ntfs-3g
    solaar
    konsave
    alacritty
    i3
    i3status
    dmenu
    discord-screenaudio
)

# Install the applications using yay
for app in "${apps[@]}"; do
    yay -S --noconfirm $app
done

# Clean up
yay -Yc --noconfirm
sudo pacman -Sc --noconfirm

echo "Done."

