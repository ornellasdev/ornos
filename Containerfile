ARG BASE_IMAGE=ghcr.io/ublue-os/kinoite-nvidia
ARG IMAGE_TAG=latest

FROM ${BASE_IMAGE}:${IMAGE_TAG}

LABEL org.opencontainers.image.title="OrnOS"
LABEL org.opencontainers.image.description="OrnOS: Fedora Atomic KDE Plasma com otimizações Nobara e suporte NVIDIA"

# 1. Injeta arquivos de tuning do sistema e atalhos ujust
COPY system_files/ /

# 2. Copia os scripts de automação para /tmp
COPY build_files/ /tmp/build_files/

# 3. Executa a instalação completa e limpeza em camada única
RUN chmod +x /tmp/build_files/*.sh && \
    /tmp/build_files/01-repos-and-copr.sh && \
    /tmp/build_files/02-packages.sh && \
    /tmp/build_files/03-kernel-override.sh && \
    /tmp/build_files/04-cleanup.sh