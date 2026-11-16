#!/usr/bin/env bash
set -ouex pipefail

FEDORA_VERSION="$(rpm -E %fedora)"
echo ":: [OrnOS] Habilitando repositórios COPR essenciais ::"

enable_copr() {
    local repo="$1"
    local repo_user="${repo%%/*}"
    local repo_name="${repo##*/}"
    if command -v dnf5 &> /dev/null; then
        dnf5 -y copr enable "${repo}"
    else
        curl -fsSL "https://copr.fedorainfracloud.org/coprs/${repo_user}/${repo_name}/repo/fedora-${FEDORA_VERSION}/${repo_user}-${repo_name}-fedora-${FEDORA_VERSION}.repo" \
            -o "/etc/yum.repos.d/_copr_${repo_user}-${repo_name}.repo"
    fi
}

enable_copr "bieszczaders/kernel-cachyos-addons"
enable_copr "kylegospo/obs-vkcapture"
enable_copr "kylegospo/oversteer"