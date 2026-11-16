#!/usr/bin/env bash
set -ouex pipefail

# Habilita atualização automática de imagem em segundo plano
systemctl enable bootc-update.timer || true
systemctl enable rpm-ostree-automatic.timer || true

echo ":: [OrnOS] Aplicando identidade oficial do sistema ::"

if [ -f /usr/lib/os-release ]; then
    sed -i 's/^NAME=.*/NAME="OrnOS"/' /usr/lib/os-release
    sed -i 's/^PRETTY_NAME=.*/PRETTY_NAME="OrnOS Gaming Edition (KDE NVIDIA)"/' /usr/lib/os-release
    sed -i 's/^DEFAULT_HOSTNAME=.*/DEFAULT_HOSTNAME="ornos-pc"/' /usr/lib/os-release
    sed -i 's|^HOME_URL=.*|HOME_URL="https://github.com/ornellasdev/ornos"|' /usr/lib/os-release
    sed -i 's|^DOCUMENTATION_URL=.*|DOCUMENTATION_URL="https://github.com/ornellasdev/ornos"|' /usr/lib/os-release
    sed -i 's|^SUPPORT_URL=.*|SUPPORT_URL="https://github.com/ornellasdev/ornos/issues"|' /usr/lib/os-release
    sed -i 's|^BUG_REPORT_URL=.*|BUG_REPORT_URL="https://github.com/ornellasdev/ornos/issues"|' /usr/lib/os-release
    sed -i 's/^ANSI_COLOR=.*/ANSI_COLOR="0;38;2;184;20;250"/' /usr/lib/os-release
fi

# Define o tema neon do OrnOS como padrão no Plymouth e reconstrói o initramfs
if command -v plymouth-set-default-theme &> /dev/null; then
    plymouth-set-default-theme ornOS || true
    KVER=$(ls /usr/lib/modules | head -n 1)
    if [ -n "$KVER" ]; then
        dracut --no-hostonly --reproducible --add ostree -f "/usr/lib/modules/${KVER}/initramfs.img" "$KVER" || true
        chmod 0600 "/usr/lib/modules/${KVER}/initramfs.img" || true
    fi
fi

echo ":: [OrnOS] Limpeza e ativação de serviços ::"

rm -f /etc/yum.repos.d/_copr_*.repo
if command -v dnf5 &> /dev/null; then
    dnf5 clean all
fi

if [[ -f /etc/default/scx ]]; then
    sed -i 's/^SCX_SCHEDULER=.*/SCX_SCHEDULER=scx_lavd/' /etc/default/scx
fi

systemctl enable scx.service || true
systemctl enable irqbalance.service || true
systemctl enable ratbagd.service || true
systemctl enable podman.socket || true

rm -rf /tmp/* /var/*
mkdir -p /tmp /var/tmp
chmod 1777 /tmp /var/tmp
chmod +x /usr/bin/ornos-first-setup
chmod +x /usr/bin/ornos-deck-session

ostree container commit