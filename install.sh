#!/bin/bash
# === Arch Minimal -> Hyprland + JaKooLit + SDDM (Catppuccin theme) ===

# Función para instalar paquetes oficiales si no están instalados
install_pacman_pkg() {
    for pkg in "$@"; do
        if ! pacman -Qi $pkg &>/dev/null; then
            echo "Instalando paquete oficial: $pkg"
            sudo pacman -S --noconfirm $pkg
        else
            echo "Ya está instalado: $pkg"
        fi
    done
}

# Función para instalar paquetes AUR con yay si no están instalados
install_aur_pkg() {
    for pkg in "$@"; do
        if ! pacman -Qi $pkg &>/dev/null; then
            echo "Instalando paquete AUR: $pkg"
            yay -S --noconfirm $pkg
        else
            echo "Ya está instalado: $pkg"
        fi
    done
}

# 1️⃣ Actualizar sistema
sudo pacman -Syu --noconfirm

# 2️⃣ Instalar paquetes oficiales
install_pacman_pkg \
    git base-devel wget curl nano vim unzip \
    networkmanager bluez bluez-utils \
    pipewire pipewire-alsa pipewire-pulse pipewire-jack \
    pavucontrol brightnessctl playerctl \
    wl-clipboard grim slurp swappy \
    kitty thunar dunst rofi waybar \
    ttf-jetbrains-mono-nerd ttf-font-awesome noto-fonts \
    sddm qt5-graphicaleffects qt5-quickcontrols2

# 3️⃣ Instalar yay si no existe
if ! command -v yay &>/dev/null; then
    echo "Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

# 4️⃣ Instalar paquetes de AUR
install_aur_pkg hyprland xdg-desktop-portal-hyprland

# 5️⃣ Habilitar servicios
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth
sudo systemctl enable sddm

# 6️⃣ Clonar y ejecutar JaKooLit dotfiles
cd ~
if [ ! -d "Hyprland-Dots" ]; then
    git clone https://github.com/JaKooLit/Hyprland-Dots.git
fi
cd Hyprland-Dots
chmod +x copy.sh
./copy.sh

# 7️⃣ Instalar tema Catppuccin para SDDM
cd ~
if [ ! -d "catppuccin-sddm" ]; then
    git clone https://github.com/catppuccin/sddm.git catppuccin-sddm
fi
sudo mkdir -p /usr/share/sddm/themes/catppuccin
sudo cp -r catppuccin-sddm/src/* /usr/share/sddm/themes/catppuccin

# 8️⃣ Configurar SDDM para usar el tema
sudo bash -c 'cat > /etc/sddm.conf <<EOF
[Theme]
Current=catppuccin
EOF'

echo "✅ Instalación completa."
echo "Reinicia tu sistema y verás SDDM con tema Catppuccin."
echo "En el login selecciona Hyprland y disfruta 🚀"