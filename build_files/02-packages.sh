#!/usr/bin/env bash
set -ouex pipefail

echo ":: [OrnOS] Instalando pacotes Gamer, Multimídia e Low-Latency ::"

pkg_install() {
    if command -v dnf5 &> /dev/null; then
        dnf5 -y install --skip-unavailable "$@"
    else
        rpm-ostree install "$@"
    fi
}

pkg_install \
    steam \
    lutris \
    wine \
    winetricks \
    gamemode \
    gamemode.i686 \
    gamescope \
    mangohud \
    mangohud.i686 \
    vkBasalt \
    goverlay \
    steam-devices \
    piper \
    irqbalance \
    obs-studio \
    obs-vkcapture \
    btop \
    fastfetch \
    gparted