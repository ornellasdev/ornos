# 1. Imagem Base (Universal Blue Kinoite com drivers NVIDIA integrados)
FROM ghcr.io/ublue-os/kinoite-nvidia:latest

# 2. Metadados OCI e identificação de sistema bootc/ostree
LABEL org.opencontainers.image.title="OrnOS" \
      org.opencontainers.image.description="OrnOS Gaming Edition - Distro Linux imutável focada em baixa latência, jogos e suporte NVIDIA" \
      org.opencontainers.image.source="https://github.com/ornellasdev/ornos" \
      org.opencontainers.image.vendor="OrnOS Project" \
      containers.bootc="1"

# 3. Copia os ficheiros estáticos do sistema (etc/ e usr/) para a raiz da imagem
COPY system_files/ /

# 4. Copia os scripts de compilação para o diretório temporário
COPY build_files/ /tmp/build_files/

# 5. Camada Única de Compilação, Configuração, Initramfs, Limpeza e Commit OSTree
RUN chmod +x /tmp/build_files/*.sh && \
    /tmp/build_files/01-repos-and-copr.sh && \
    /tmp/build_files/02-packages.sh && \
    /tmp/build_files/03-kernel-override.sh && \
    /tmp/build_files/04-cleanup.sh