# Lightweight base with VS Code optimizations
FROM mcr.microsoft.com/devcontainers/base:ubuntu-24.04


ARG DEBIAN_FRONTEND=noninteractive
ARG USERNAME=vscode


# Core tools + Neovim (via PPA) + kubectl (official apt repo)
RUN apt-get update && apt-get install -y --no-install-recommends \
ca-certificates curl git zsh tmux ripgrep fzf fd-find stow unzip \
build-essential software-properties-common gnupg lsb-release \
&& add-apt-repository -y ppa:neovim-ppa/unstable \
&& apt-get update && apt-get install -y --no-install-recommends neovim \
# kubectl (v1.30 stable line; adjust if you need another line)
&& curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.30/deb/Release.key \
| gpg --dearmor -o /usr/share/keyrings/kubernetes-apt-keyring.gpg \
&& echo "deb [signed-by=/usr/share/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.30/deb/ /" \
> /etc/apt/sources.list.d/kubernetes.list \
&& apt-get update && apt-get install -y --no-install-recommends kubectl \
&& chsh -s /usr/bin/zsh ${USERNAME} \
&& apt-get clean && rm -rf /var/lib/apt/lists/*


# Helpful dirs (owned by vscode)
USER ${USERNAME}
SHELL ["/usr/bin/zsh", "-lc"]
RUN mkdir -p ~/.config ~/.kube ~/.local/bin
WORKDIR /workspaces
