#!/bin/bash

# Este script instala programas comunes para desarrollo, diseño, y ofimática en Arch Linux.
# Se asume una instalación mínima de Arch.

# Asegúrate de estar conectado a internet.
# Sincronizar la base de datos de los paquetes
sudo pacman -Syu --noconfirm

# --- Programación ---
## IDEs y editores de texto
sudo pacman -S --noconfirm neovim vim visual-studio-code-bin # VS Code desde el AUR

## Lenguajes y herramientas
sudo pacman -S --noconfirm git python go nodejs npm dbeaver

# --- Diseño de circuitos y 3D ---
## Diseño de circuitos
sudo pacman -S --noconfirm kicad

## Diseño 3D
sudo pacman -S --noconfirm blender freecad openscad

# --- Ofimática y utilidades básicas ---
## Suite de oficina
sudo pacman -S --noconfirm libreoffice-fresh

## Navegadores web
sudo pacman -S --noconfirm firefox chromium

## Utilidades
sudo pacman -S --noconfirm file-roller zip unzip p7zip curl wget htop neofetch

# --- Configuración de Caelestia Dots ---
## Requisitos
sudo pacman -S --noconfirm sway waybar rofi wofi alacritty pipewire pipewire-pulse

## Clonar el repositorio
git clone https://github.com/caelestiaproject/dots.git ~/.config/caelestia-dots

## Mover las configuraciones
mv ~/.config/caelestia-dots/* ~/.config/
rm -rf ~/.config/caelestia-dots

echo "Instalación completada. Reinicia tu sistema o ejecuta 'startx' o 'sway' para iniciar el entorno."
