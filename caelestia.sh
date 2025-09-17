#!/bin/bash
# Instalador completo de Caelestia Dots en Arch Linux Minimal
# Alfonso - 2025

set -e

echo "=== 2. Instalando base gráfica y utilidades ==="
sudo pacman -S --needed --noconfirm \
  base-devel git wget curl unzip zip \
  networkmanager bluez bluez-utils \
  xdg-user-dirs xdg-desktop-portal xdg-desktop-portal-hyprland \
  wl-clipboard grim slurp swaybg swaylock swayidle \
  pipewire pipewire-alsa pipewire-pulse wireplumber \
  mesa vulkan-intel vulkan-radeon vulkan-nouveau \
  fish neovim tmux htop btop \
  kitty thunar pavucontrol firefox \
  ttf-font-awesome ttf-jetbrains-mono-nerd \
  gvfs gvfs-mtp

echo "=== 3. Habilitando servicios esenciales ==="
sudo systemctl enable NetworkManager.service
sudo systemctl enable bluetooth.service

echo "=== 4. Instalando helper de AUR (yay) ==="
if ! command -v yay >/dev/null 2>&1; then
  git clone https://aur.archlinux.org/yay-bin.git /tmp/yay-bin
  cd /tmp/yay-bin
  makepkg -si --noconfirm
  cd ~
fi

echo "=== 5. Instalando Hyprland y Caelestia desde AUR ==="
yay -S --needed --noconfirm hyprland caelestia-meta

echo "=== 6. Clonando dotfiles de Caelestia ==="
mkdir -p ~/.local/share
if [ ! -d ~/.local/share/caelestia ]; then
  git clone https://github.com/caelestia-dots/caelestia.git ~/.local/share/caelestia
fi

echo "=== 7. Ejecutando instalador de Caelestia ==="
cd ~/.local/share/caelestia
fish ./install.fish -y

echo "=== 8. Instalando software adicional desde AUR ==="
yay -S --needed --noconfirm \
  vscodium-bin spotify discord

echo "=== ✅ Instalación completada ==="
echo "👉 Reinicia y entra en sesión con Hyprland para ver Caelestia funcionando."