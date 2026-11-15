<div align="center">

# 🌌 OrnOS (KDE Plasma Edition)

**Um sistema operacional imutável de alta performance para Jogos e Criação de Conteúdo.**  
*Construído sobre a solidez do Fedora Atomic, turbinado com todas as otimizações de baixa latência do Nobara e projetado nativamente para Wayland com KDE Plasma 6.*

---

[![Build OrnOS Image](https://github.com/ornellasdev/ornos/actions/workflows/build.yml/badge.svg)](https://github.com/ornellasdev/ornos/actions/workflows/build.yml)
[![Build OrnOS Bootable ISO](https://github.com/ornellasdev/ornos/actions/workflows/build-iso.yml/badge.svg)](https://github.com/ornellasdev/ornos/actions/workflows/build-iso.yml)
[![Fedora Base](https://img.shields.io/badge/Fedora%20Atomic-41-blue?logo=fedora)](https://fedoraproject.org/)
[![Desktop](https://img.shields.io/badge/Desktop-KDE%20Plasma%206-teal?logo=kde)](https://kde.org/plasma-desktop/)
[![Platform](https://img.shields.io/badge/Arch-x86__64-orange)](#)
[![GPU Ready](https://img.shields.io/badge/NVIDIA-Proprietary%20%2B%20CUDA-76B900?logo=nvidia)](#)

</div>

---

## ⚡ Sobre o Projeto

O **OrnOS** nasceu para resolver o maior dilema dos jogadores no Linux: a escolha entre distros mutáveis com pós-instalações instáveis ou distros imutáveis corporativas sem suporte a jogos de ponta.

Utilizando a tecnologia de containers e imagens imutáveis do ecossistema Universal Blue / Fedora Atomic (`bootc`), o OrnOS empacota o ecossistema completo de otimizações do Nobara (patches de kernel, agendadores de CPU de tempo real, suporte robusto a controles e stack multimídia completa) em uma imagem resiliente com **rollback instantâneo**. Se uma atualização quebrar, reverta para a versão anterior em 10 segundos no GRUB.

---

## 🚀 Principais Otimizações e Recursos

### 🎮 Gaming & Baixa Latência (Estilo Nobara)
* **Kernel & Kargs Otimizados:** Boot configurado de fábrica com `split_lock_detect=off` (elimina *stutters* em jogos DirectX 11/12 rodando via Proton), `nvidia-drm.modeset=1` e `nvidia-drm.fbdev=1`.
* **KDE Plasma 6 Wayland Otimizado:** Configuração nativa de KWin com suporte a **Variable Refresh Rate (VRR / G-Sync / FreeSync)** automático e **Tearing permitido em tela cheia**, garantindo o menor *input lag* possível.
* **Agendador de CPU de Tempo Real (`scx`):** Serviço `scx-scheds` integrado com o agendador **`scx_lavd`** (o mesmo padrão do SteamOS) para priorizar a renderização de jogos sobre tarefas secundárias em segundo plano.
* **Tuning de Memória & Rede:**
  * `vm.max_map_count = 2147483642` (evita falhas e fechamentos espontâneos em títulos como *Counter-Strike 2*, *Star Citizen*, *Hogwarts Legacy* e *The Finals*).
  * Algoritmo de controle de congestionamento de rede **BBR** ativo por padrão para reduzir *jitter* e *bufferbloat* em partidas competitivas.
  * `swappiness = 10` e cache preservado em memória RAM.

### 🎥 Stack para Criadores & Live Stream
* **OBS Studio Nativo com VkCapture:** Inclui `obs-vkcapture` (64-bit e 32-bit), permitindo captura direta de tela e jogos OpenGL/Vulkan sob Wayland sem overhead e sem tela preta.
* **Aceleração por Hardware (NVENC / VAAPI):** Codecs completos do RPM Fusion (FFmpeg, GStreamer e bibliotecas proprietárias) prontos para uso.
* **Virtual Camera & Dispositivos:** Módulo `v4l2loopback` pronto para transmissões no Discord, OBS e browsers.

### 🎮 Periféricos e Hardware
* **`game-devices-udev` & `steam-devices`:** Regras para mais de 80 modelos de controles (DualSense, Xbox Wireless, 8BitDo, GameSir, Nintendo Switch Pro e volantes Logitech/Thrustmaster via Oversteer) com permissões de acesso direto sem necessidade de privilégios de root.
* **RGB e Mouse:** Suporte a `openrgb` (com regras de permissão) e `libratbag-ratbagd` / `piper` para configuração de mouses gamer.

### 🔮 Identidade Visual Neon
* **Tema Plymouth Customizado:** Animação de inicialização com visual neon violeta e ciano, integrando logo translúcido e barra de pulso dinâmico renderizados em script nativo no initramfs.

---

## 📦 Estrutura do Repositório

```text
ornos/
├── .github/
│   └── workflows/
│       ├── build.yml             # Compila a imagem OCI e publica em ghcr.io
│       └── build-iso.yml         # Gera o arquivo instalador .iso e publica nas Releases
├── build_files/
│   ├── 01-repos-and-copr.sh      # Repositórios COPR (CachyOS addons, VkCapture, Oversteer)
│   ├── 02-packages.sh            # Stack gamer (64/32-bit), Steam, Lutris, Wine, MangoHud, OBS
│   ├── 03-kernel-override.sh     # Argumentos de boot kargs e inicialização
│   └── 04-cleanup.sh             # Otimização de camadas OCI, serviços e commit ostree
├── system_files/
│   ├── etc/
│   │   ├── dracut.conf.d/        # Módulo Plymouth forçado no initramfs
│   │   ├── security/limits.d/    # Limites de sistema para esync e tempo real
│   │   ├── sysctl.d/             # Otimizações de kernel para jogos
│   │   └── xdg/kwinrc            # Defaults de baixa latência e tearing do KDE Plasma
│   └── usr/
│       └── share/
│           ├── plymouth/themes/  # Tema OrnOS neon (script e imagens)
│           └── ublue-os/just/    # Atalhos ujust para configuração pós-instalação
└── Containerfile                 # Manifesto principal da imagem
```

---

## 💿 Como Instalar

### Opção 1: Baixar a ISO Pronta (Recomendado)

1. Acesse a aba de **[Releases](../../releases)** deste repositório.
2. Baixe o arquivo `OrnOS-KDE-NVIDIA-x86_64.iso` e seu respectivo `CHECKSUM`.
3. Grave a imagem em um pendrive utilizando o **[Ventoy](https://www.ventoy.net/)** (basta copiar o arquivo `.iso` para o pendrive) ou o **[BalenaEtcher](https://etcher.balena.io/)**.
4. Inicialize o computador pelo pendrive e siga os passos do instalador gráfico.

---

### Opção 2: Rebase a partir de um Fedora Atomic existente

Se você já utiliza **Fedora Silverblue** ou **Fedora Kinoite**, pode migrar para o OrnOS sem formatar:

```bash
# Rebase para a imagem do OrnOS
rpm-ostree rebase ostree-unverified-registry:ghcr.io/ornellasdev/ornos:latest

# Reinicie para entrar no OrnOS
systemctl reboot
```

Para reverter para o sistema anterior a qualquer momento:
```bash
rpm-ostree rollback
```

---

## 🛠️ Pós-Instalação e Atalhos Úteis

O OrnOS inclui utilitários de conveniência integrados ao comando `ujust`:

* **Instalar suíte de launchers e utilitários Flatpak:**
  ```bash
  ujust setup-gaming
  ```
  *(Instala ProtonPlus, Heroic Games Launcher, Vesktop Discord e ProtonUp-Qt).*

* **Monitorar uso de CPU, GPU NVIDIA e memória em tempo real:**
  ```bash
  nvtop      # Monitor visual da GPU NVIDIA (VRAM, Temperatura, Clock, Encoders)
  btop       # Monitor de recursos de CPU, processos e discos
  fastfetch  # Informações de sistema e hardware do OrnOS
  ```

---

## 🤝 Desenvolvimento e Compilação Local

Para testar ou compilar a imagem localmente utilizando `podman` ou `buildah`:

```bash
# Clone o repositório
git clone https://github.com/ornellasdev/ornos.git
cd ornos

# Compilar a imagem OCI
podman build -t ornos:local -f Containerfile .
```

---

## 📜 Licença

Distribuído sob os termos da licença [MIT](LICENSE) ou compatível com a base Fedora / Universal Blue. Patches e scripts de integração herdados dos projetos Nobara, CachyOS e Fedora Project respeitam suas respectivas licenças originais.