#!/usr/bin/env bash
set -ouex pipefail

echo ":: [OrnOS] Instalando pacotes Gamer, Multimídia e Low-Latency ::"

pkg_install() {
    if command -v dnf5 &> /dev/null; then
        dnf5 -y install "$@"
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
    openrgb-udev-rules \
    libratbag-ratbagd \
    piper \
    oversteer \
    scx-scheds \
    irqbalance \
    obs-studio \
    obs-vkcapture \
    obs-vkcapture.i686 \
    v4l2loopback \
    distrobox \
    nvtop \
    btop \
    fastfetch \
    jq \
    just \
    kdialog \
    os-prober \
    util-linux \
    ntfs-3g \
    gparted 
  