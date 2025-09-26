#!/bin/bash
set -e

echo "==> Actualizando sistema..."
sudo pacman -Syu --noconfirm

echo "==> Instalando yay (AUR helper)..."
sudo pacman -S --noconfirm --needed base-devel git
if ! command -v yay &> /dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

echo "==> Instalando aplicaciones..."
# Visual Studio Code
yay -S --noconfirm visual-studio-code-bin

# Spotify
yay -S --noconfirm spotify

# LibreOffice (alternativa libre a MS Office)
sudo pacman -S --noconfirm libreoffice-fresh

# Microsoft Teams (opcional)
yay -S --noconfirm teams

# Discord (por si lo usas)
yay -S --noconfirm discord

# Google Chrome
yay -S --noconfirm google-chrome

echo "==> Instalación terminada 🎉"