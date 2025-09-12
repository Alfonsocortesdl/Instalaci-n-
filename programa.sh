#!/bin/bash
# === Instalación de programas básicos en Arch Linux ===

# 1️⃣ Actualizar sistema
sudo pacman -Syu --noconfirm

# 2️⃣ Instalar yay si no está (para AUR)
if ! command -v yay &>/dev/null; then
    echo "Instalando yay..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

# 3️⃣ Función para instalar paquetes oficiales
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

# 4️⃣ Función para instalar paquetes de AUR
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

# 5️⃣ Paquetes oficiales de Arch
install_pacman_pkg \
    libreoffice-fresh   \
    kicad               \
    firefox             \
    vlc                 \
    gimp                \
    inkscape            \
    obs-studio          \
    steam               \
    thunderbird         \
    code                \
    htop                \
    neofetch            \
    git                 \
    wget curl nano vim unzip \
    networkmanager bluez bluez-utils \
    pipewire pipewire-alsa pipewire-pulse pipewire-jack \
    pavucontrol

# 6️⃣ Paquetes de AUR
install_aur_pkg \
    spotify             \
    visual-studio-code-bin \
    zoom               \
    discord            \
    slack-desktop

# 7️⃣ Habilitar servicios esenciales
sudo systemctl enable --now NetworkManager
sudo systemctl enable --now bluetooth

echo "✅ Todos los programas han sido instalados correctamente."