#!/usr/bin/env bash
#
# ✦ VibeTerm — Premium Powerlevel10k Ubuntu Terminal
# https://github.com/YOUR_USERNAME/vibeterm
#
# Installs and configures:
#   • Zsh + Oh My Zsh
#   • Powerlevel10k
#   • JetBrainsMono Nerd Font
#   • zsh-autosuggestions
#   • zsh-syntax-highlighting
#   • eza, bat, fzf, zoxide, btop, fastfetch
#   • Useful developer / Git / Docker aliases
#
# Safe-by-default:
#   • Backs up existing ~/.zshrc
#   • Does not delete existing Oh My Zsh installations
#   • Can be run more than once
#
# After installation, run:
#   p10k configure
#
# Requirements:
#   Ubuntu/Debian-based Linux
#

set -Eeuo pipefail

# -----------------------------
# Colors / UI
# -----------------------------

if [[ -t 1 ]]; then
    RESET='\033[0m'
    BOLD='\033[1m'
    CYAN='\033[38;5;81m'
    PURPLE='\033[38;5;141m'
    GREEN='\033[38;5;114m'
    YELLOW='\033[38;5;221m'
    RED='\033[38;5;204m'
    MUTED='\033[38;5;245m'
else
    RESET='' BOLD='' CYAN='' PURPLE='' GREEN='' YELLOW='' RED='' MUTED=''
fi

info()  { printf "${CYAN}  ›${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}  ✓${RESET} %s\n" "$*"; }
warn()  { printf "${YELLOW}  !${RESET} %s\n" "$*"; }
error() { printf "${RED}  ✗${RESET} %s\n" "$*" >&2; }
die()   { error "$*"; exit 1; }

trap 'error "Installation stopped at line $LINENO."' ERR

# -----------------------------
# Configuration
# -----------------------------

OH_MY_ZSH="${ZSH:-$HOME/.oh-my-zsh}"
ZSH_CUSTOM="${ZSH_CUSTOM:-$OH_MY_ZSH/custom}"

P10K_DIR="$ZSH_CUSTOM/themes/powerlevel10k"
AUTOSUGGESTIONS_DIR="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
SYNTAX_DIR="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMono"
FONT_ZIP="/tmp/JetBrainsMono.zip"
FONT_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip"

TIMESTAMP="$(date +%Y%m%d_%H%M%S)"
BACKUP_DIR="$HOME/.vibeterm-backup-$TIMESTAMP"

# -----------------------------
# Checks
# -----------------------------

command -v sudo >/dev/null 2>&1 || die "sudo is required."
command -v curl >/dev/null 2>&1 || die "curl is required. Install it with: sudo apt install curl"

if [[ ! -f /etc/os-release ]]; then
    die "Cannot determine Linux distribution."
fi

# shellcheck disable=SC1091
source /etc/os-release

if [[ "${ID:-}" != "ubuntu" && "${ID_LIKE:-}" != *debian* ]]; then
    warn "This script is designed for Ubuntu/Debian-based systems."
    read -r -p "Continue anyway? [y/N] " answer
    [[ "$answer" =~ ^[Yy]$ ]] || exit 0
fi

if [[ "${EUID}" -eq 0 ]]; then
    die "Do not run this script as root. Run it as your normal user."
fi

# -----------------------------
# Banner
# -----------------------------

clear
printf "\n"
printf "${PURPLE}${BOLD}"
printf "  ╭──────────────────────────────────────────────────────╮\n"
printf "  │                                                      │\n"
printf "  │        ✦  VIBETERM — CYBER DEVELOPER  ✦           │\n"
printf "  │                                                      │\n"
printf "  │     Zsh • Powerlevel10k • Nerd Font • CLI Tools    │\n"
printf "  │                                                      │\n"
printf "  ╰──────────────────────────────────────────────────────╯\n"
printf "${RESET}\n"

info "Ubuntu/Debian detected: ${PRETTY_NAME:-$ID}"
info "Backup location: $BACKUP_DIR"
printf "\n"

# -----------------------------
# Backup existing configuration
# -----------------------------

mkdir -p "$BACKUP_DIR"

if [[ -f "$HOME/.zshrc" ]]; then
    cp -a "$HOME/.zshrc" "$BACKUP_DIR/.zshrc"
    ok "Backed up existing .zshrc"
fi

if [[ -f "$HOME/.p10k.zsh" ]]; then
    cp -a "$HOME/.p10k.zsh" "$BACKUP_DIR/.p10k.zsh"
    ok "Backed up existing .p10k.zsh"
fi

# -----------------------------
# Packages
# -----------------------------

info "Updating package index..."
sudo apt-get update

PACKAGES=(
    zsh
    git
    curl
    wget
    unzip
    fontconfig
    fzf
    btop
    zoxide
    eza
    bat
    python3
    python3-venv
)

# Fastfetch is available in current Ubuntu releases. If unavailable,
# the script continues and simply skips it.
if apt-cache show fastfetch >/dev/null 2>&1; then
    PACKAGES+=(fastfetch)
fi

info "Installing terminal packages..."
sudo apt-get install -y "${PACKAGES[@]}"
ok "Core packages installed"

# -----------------------------
# Starship is no longer needed
# -----------------------------
# We intentionally do not uninstall Starship. It can remain installed
# harmlessly, but Powerlevel10k will own the prompt.

# -----------------------------
# Oh My Zsh
# -----------------------------

if [[ -f "$OH_MY_ZSH/oh-my-zsh.sh" ]]; then
    ok "Oh My Zsh already installed"
else
    info "Installing Oh My Zsh..."

    if [[ -d "$OH_MY_ZSH" ]]; then
        warn "Found an incomplete Oh My Zsh directory at $OH_MY_ZSH"
        warn "It will be backed up before reinstalling."

        mv "$OH_MY_ZSH" "$BACKUP_DIR/oh-my-zsh-incomplete"

        RUNZSH=no CHSH=no ZSH="$OH_MY_ZSH" \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    else
        RUNZSH=no CHSH=no ZSH="$OH_MY_ZSH" \
            sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    fi

    [[ -f "$OH_MY_ZSH/oh-my-zsh.sh" ]] || die "Oh My Zsh installation failed."
    ok "Oh My Zsh installed"
fi

# -----------------------------
# Powerlevel10k
# -----------------------------

if [[ -f "$P10K_DIR/powerlevel10k.zsh-theme" ]]; then
    ok "Powerlevel10k already installed"
else
    info "Installing Powerlevel10k..."

    mkdir -p "$(dirname "$P10K_DIR")"

    git clone --depth=1 \
        https://github.com/romkatv/powerlevel10k.git \
        "$P10K_DIR"

    ok "Powerlevel10k installed"
fi

# -----------------------------
# Zsh plugins
# -----------------------------

info "Installing Zsh plugins..."
mkdir -p "$ZSH_CUSTOM/plugins"

if [[ -d "$AUTOSUGGESTIONS_DIR/.git" ]]; then
    ok "zsh-autosuggestions already installed"
else
    rm -rf "$AUTOSUGGESTIONS_DIR"
    git clone --depth=1 \
        https://github.com/zsh-users/zsh-autosuggestions.git \
        "$AUTOSUGGESTIONS_DIR"
    ok "zsh-autosuggestions installed"
fi

if [[ -d "$SYNTAX_DIR/.git" ]]; then
    ok "zsh-syntax-highlighting already installed"
else
    rm -rf "$SYNTAX_DIR"
    git clone --depth=1 \
        https://github.com/zsh-users/zsh-syntax-highlighting.git \
        "$SYNTAX_DIR"
    ok "zsh-syntax-highlighting installed"
fi

# -----------------------------
# JetBrainsMono Nerd Font
# -----------------------------

if fc-list 2>/dev/null | grep -qi "JetBrainsMono Nerd Font"; then
    ok "JetBrainsMono Nerd Font already installed"
else
    info "Installing JetBrainsMono Nerd Font..."
    mkdir -p "$FONT_DIR"

    rm -f "$FONT_ZIP"

    curl -fL --retry 5 --retry-delay 3 --connect-timeout 15 \
        "$FONT_URL" \
        -o "$FONT_ZIP"

    [[ -s "$FONT_ZIP" ]] || die "Font download failed."

    unzip -q -o "$FONT_ZIP" -d "$FONT_DIR"
    fc-cache -f "$FONT_DIR"

    rm -f "$FONT_ZIP"

    ok "JetBrainsMono Nerd Font installed"
fi

# -----------------------------
# .zshrc
# -----------------------------

info "Writing Zsh configuration..."

cat > "$HOME/.zshrc" <<'EOF'
# =========================================================
# ✦ VibeTerm — Premium Cyber Developer Terminal
# =========================================================

export ZSH="${ZSH:-$HOME/.oh-my-zsh}"

ZSH_THEME="powerlevel10k/powerlevel10k"

# Keep syntax highlighting LAST in the plugin list.
plugins=(
    git
    sudo
    zsh-autosuggestions
    zsh-syntax-highlighting
)

source "$ZSH/oh-my-zsh.sh"

# Powerlevel10k user configuration
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# ---------------------------------------------------------
# Modern navigation
# ---------------------------------------------------------

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# ---------------------------------------------------------
# FZF
# ---------------------------------------------------------

if command -v fzf >/dev/null 2>&1; then
    source <(fzf --zsh)
fi

# ---------------------------------------------------------
# Modern CLI aliases
# ---------------------------------------------------------

if command -v eza >/dev/null 2>&1; then
    alias ls='eza --icons --group-directories-first --color=always'
    alias ll='eza -lah --icons --group-directories-first --color=always'
    alias la='eza -a --icons --group-directories-first --color=always'
    alias lt='eza --tree --level=2 --icons --color=always'
fi

if command -v batcat >/dev/null 2>&1; then
    alias cat='batcat --paging=never'
elif command -v bat >/dev/null 2>&1; then
    alias cat='bat --paging=never'
fi

# ---------------------------------------------------------
# Navigation
# ---------------------------------------------------------

alias c='clear'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# ---------------------------------------------------------
# Git
# ---------------------------------------------------------

alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
alias gl='git log --oneline --graph --decorate --all'

# ---------------------------------------------------------
# Python
# ---------------------------------------------------------

alias py='python3'
alias pip='python3 -m pip'

# ---------------------------------------------------------
# Docker
# ---------------------------------------------------------

alias dc='docker compose'
alias dps='docker ps'

# ---------------------------------------------------------
# Networking
# ---------------------------------------------------------

alias ports='sudo ss -tulpn'
alias myip='curl -s https://ifconfig.me && echo'

# ---------------------------------------------------------
# System
# ---------------------------------------------------------

alias update='sudo apt update && sudo apt upgrade'

# ---------------------------------------------------------
# Fastfetch
# ---------------------------------------------------------

if command -v fastfetch >/dev/null 2>&1; then
    fastfetch --logo small
fi
EOF

ok "Zsh configuration written"

# -----------------------------
# Default shell
# -----------------------------

ZSH_BIN="$(command -v zsh)"

if [[ "${SHELL:-}" != "$ZSH_BIN" ]]; then
    info "Setting Zsh as your default shell..."

    if chsh -s "$ZSH_BIN" "$USER"; then
        ok "Zsh is now the default shell"
    else
        warn "Could not change the default shell automatically."
        warn "Run manually: chsh -s $ZSH_BIN"
    fi
else
    ok "Zsh is already your default shell"
fi

# -----------------------------
# Finish
# -----------------------------

printf "\n"
printf "${GREEN}${BOLD}"
printf "  ╭──────────────────────────────────────────────────────╮\n"
printf "  │                 ✓ INSTALLATION DONE                 │\n"
printf "  ╰──────────────────────────────────────────────────────╯\n"
printf "${RESET}\n"

printf "${BOLD}  Next step:${RESET}\n\n"
printf "    ${CYAN}exec zsh${RESET}\n\n"
printf "  Then launch the visual Powerlevel10k wizard:\n\n"
printf "    ${PURPLE}p10k configure${RESET}\n\n"

printf "${MUTED}"
printf "  Recommended wizard choices for the VibeTerm look:\n"
printf "    • Powerline / Rainbow\n"
printf "    • Nerd Font / Many icons\n"
printf "    • Two-line prompt\n"
printf "    • Compact spacing\n"
printf "    • 24-hour clock\n"
printf "    • Transient prompt: Yes\n"
printf "${RESET}\n"

printf "  Your previous configuration is backed up at:\n"
printf "    ${MUTED}%s${RESET}\n\n" "$BACKUP_DIR"
