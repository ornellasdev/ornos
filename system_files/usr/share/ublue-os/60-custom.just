# Reabre o Assistente de Configuração Inicial do OrnOS
ornos-setup:
    rm -f "$HOME/.config/ornos-first-setup.done"
    /usr/bin/ornos-first-setup

# Configura o suporte da GPU NVIDIA para contêineres e IA Local (Podman/Docker CDI)
ornos-nvidia-containers:
    sudo nvidia-ctk cdi generate --output=/etc/cdi/nvidia.yaml
    echo "Suporte NVIDIA CDI ativado com sucesso!"

# Limpa versões antigas do sistema, caches órfãos e pacotes Flatpak sem uso
ornos-clean:
    flatpak uninstall --unused -y
    sudo rpm-ostree cleanup -bm
    echo "Limpeza do OrnOS concluída!"

# Instala launchers e utilitários Flatpak pós-instalação
setup-gaming:
    #!/usr/bin/env bash
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
    flatpak install -y flathub \
        com.vysp3r.ProtonPlus \
        com.heroicgameslauncher.hgl \
        dev.vencord.Vesktop \
        net.davidotek.pupgui2

# Painel de Diagnóstico Rápido do OrnOS (Verifica se todos os modos Pro estão ativos)
ornos-status:
    #!/usr/bin/env bash
    echo "=== DIAGNÓSTICO DE PERFORMANCE ORNOS ==="
    echo "• Escalonador CPU (scx): $(systemctl is-active scx.service)"
    echo "• Algoritmo TCP: $(sysctl -n net.ipv4.tcp_congestion_control)"
    echo "• Limite Memória SteamOS (max_map_count): $(sysctl -n vm.max_map_count)"
    echo "• ZRAM Ativa: $(swapon --show=NAME,SIZE,USED --noheadings)"
    echo "• Driver NVIDIA Wayland fbdev: $(cat /sys/module/nvidia_drm/parameters/fbdev 2>/dev/null || echo 'N/A')"