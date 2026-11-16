# 🎮 OrnOS — Gaming & Pro Workstation Edition (v1.0.0)

**OrnOS** é uma distribuição Linux imutável de última geração baseada no **Fedora Atomic (`kinoite-nvidia` / Universal Blue)**, projetada para entregar **máxima performance em jogos**, **baixa latência de hardware** e uma experiência **100% amigável (*noob-friendly*)** pronta para uso logo após a instalação.

---

## ✨ Principais Diferenciais

* 🛡️ **Arquitetura Imutável à Prova de Falhas (`bootc` / `ostree`):** O sistema base é montado em modo somente-leitura com atualizações atômicas em segundo plano (`stage`). Se uma atualização falhar, basta reiniciar na imagem anterior pelo menu de boot.
* 🚀 **Otimização Extrema para NVIDIA & Wayland:**
  * Drivers proprietários NVIDIA pré-instalados na imagem base (`nvidia-drm.modeset=1` e `fbdev=1`).
  * Cache de Shaders desbloqueado para **10 GB** (elimina *stuttering* em jogos DirectX 12 e Unreal Engine 5).
  * Preservação de VRAM na suspensão (`NVreg_PreserveVideoMemoryAllocations=1`) e otimização de memória PAT.
* ⚡ **Kernel & Escalonamento de Nível Competitivo:**
  * Escalonador de CPU **sched_ext (`scx_lavd`)** ativo por padrão (prioriza threads de jogos e áudio em tempo real).
  * Pilha de rede com **TCP BBR**, fila **Fair Queue (`fq`)**, buffers UDP expandidos para partidas online e **DNS-over-TLS** (Cloudflare/Quad9) de ultra-baixa latência.
  * Limites de memória no padrão **SteamOS** (`vm.max_map_count = 2147483642`) e **ZRAM (`zstd`)** até 16 GB.
  * Regras `udev` automáticas de I/O: escalonador `none` para NVMe, `kyber` para SSD SATA e `bfq` para HDDs.
* 🖥️ **KDE Plasma 6 Customizado & Modo Console:**
  * Tema **Breeze Dark** com acentos em Ciano/Roxo Néon, VRR (*Adaptive Sync / G-Sync*) e *AllowTearing* pré-configurados no KWin.
  * **OrnOS Console Mode:** Sessão dedicada estilo Steam Deck (*Steam GamepadUI*) acelerada via `gamescope` e `gamemode`.
* 🧙‍♂️ **Assistente de Primeiro Boot (`ornos-first-setup`):**
  * Detecção automática de hardware.
  * Criação automática da árvore de bibliotecas de jogos (`~/Games`).
  * Montagem visual em 1 clique de discos secundários (`ext4`, `btrfs`, `ntfs`) sem precisar usar o terminal.
  * Central de Aplicações Flatpak integrada e suporte nativo a **Dual Boot com Windows** via `os-prober`.

---

## 🛠️ Comandos Rápidos (`ujust`)

O OrnOS inclui atalhos inteligentes no terminal através do comando `ujust`:

| Comando | Descrição |
| :--- | :--- |
| `ujust ornos-setup` | Reabre o Assistente de Configuração Inicial e montagem de discos do OrnOS. |
| `ujust setup-gaming` | Instala o pacote essencial Flatpak (ProtonPlus, Heroic Launcher, Vesktop, ProtonUp-Qt). |
| `ujust ornos-nvidia-containers` | Configura o suporte da GPU NVIDIA (CDI) para contêineres Podman/Docker e IA Local. |
| `ujust ornos-status` | Exibe o painel de diagnóstico rápido confirmando os modos Pro ativos no sistema. |
| `ujust ornos-clean` | Remove pacotes Flatpak órfãos e limpa versões antigas do `rpm-ostree`. |

---

## 💿 Instalação (ISO Bootável)

1. Baixe a imagem `.iso` mais recente na seção **[Releases](../../releases)** deste repositório.
2. Grave a ISO em um pendrive de 8 GB+ utilizando o **Fedora Media Writer**, **Ventoy** ou **BalenaEtcher**.
3. Inicie o computador pelo pendrive (certifique-se de que o **Secure Boot** esteja desativado na BIOS para carregamento dos módulos NVIDIA/Kernel customizados).
4. No instalador **Anaconda**, selecione o idioma, escolha o disco de destino (podendo formatar uma partição específica mantendo o Windows para Dual Boot) e conclua a instalação.

---

## 🔄 Mudar para o OrnOS a partir de um Fedora Atomic existente

Se você já utiliza o Fedora Kinoite ou outra imagem Universal Blue, pode migrar para o OrnOS com um único comando no terminal:

```bash
sudo bootc switch ghcr.io/ornellasdev/ornos:latest