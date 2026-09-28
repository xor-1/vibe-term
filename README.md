# ✦ VibeTerm

### A premium, colorful, cyber-inspired terminal setup for Ubuntu.

VibeTerm transforms a fresh Ubuntu terminal into a modern developer workspace with **Zsh, Powerlevel10k, Nerd Fonts, Git integration, modern CLI tools, useful aliases, and a highly customizable Powerline aesthetic.**

> Built for developers, cybersecurity enthusiasts, sysadmins, and anyone who thinks the default terminal deserves more vibes. ✦

---

## ✨ Preview

<p align="center">
  <img src="https://github.com/xor-1/vibe-term/blob/main/Vibe-Term-Preview.png" alt="VibeTerm Preview" width="900">
</p>

---

## ⚡ Features

| Feature | Description |
|---|---|
| 🐚 **Zsh** | Powerful shell with a better interactive experience |
| ⚡ **Powerlevel10k** | Highly customizable Powerline prompt |
| 🎨 **Rainbow UI** | Colorful segmented terminal prompt |
| 🔤 **JetBrainsMono Nerd Font** | Beautiful developer font with icons |
| 🌿 **Git Integration** | Branch, changes, ahead/behind status |
| 🧠 **Autosuggestions** | Intelligent command suggestions |
| 🎨 **Syntax Highlighting** | Visual command validation while typing |
| 📁 **eza** | Modern replacement for `ls` |
| 📖 **bat** | Better `cat` with syntax highlighting |
| 🔎 **fzf** | Fast fuzzy finder |
| 🚀 **zoxide** | Smarter directory navigation |
| 📊 **btop** | Beautiful system monitor |
| 🖥️ **Fastfetch** | System information on terminal startup |
| 🐍 **Python support** | Virtual environment awareness |
| 🐳 **Docker support** | Docker context integration |
| 🛡️ **Safe installation** | Existing shell configuration is backed up |

---

# 🚀 Installation

## Requirements

VibeTerm is designed primarily for:

- Ubuntu
- Debian-based distributions
- x86_64 / amd64 systems
- Internet connection

> Other Linux distributions may work, but Ubuntu/Debian are the primary targets.

---

## 1. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/VibeTerm.git
cd VibeTerm
```

Replace `YOUR_USERNAME` with the GitHub account hosting the repository.

---

## 2. Make the installer executable

```bash
chmod +x install.sh
```

---

## 3. Run the installer

```bash
./install.sh
```

The installer will automatically install and configure the required tools.

---

## 4. Restart Zsh

After installation:

```bash
exec zsh
```

---

## 5. Configure Powerlevel10k

Run:

```bash
p10k configure
```

For the full VibeTerm experience, recommended choices are:

```text
Powerline        → Yes
Rainbow          → Yes
Icons            → Many
Prompt            → Two lines
Prompt spacing    → Compact
Time              → 24-hour
Transient prompt  → Yes
```

The exact wizard options may vary depending on your Powerlevel10k version.

---

# 🎨 Recommended Terminal Settings

VibeTerm uses **JetBrainsMono Nerd Font**.

Open your terminal application's profile settings and configure:

### Font

```text
JetBrainsMono Nerd Font
```

Recommended size:

```text
12pt
```

### Background

```text
#11111B
```

### Foreground

```text
#CDD6F4
```

### Cursor

```text
#F5C2E7
```

A small amount of transparency can also be used if supported by your terminal emulator.

Recommended:

```text
8–12%
```

---

# 🧰 Included CLI Tools

## eza

Modern replacement for `ls`.

```bash
ls
```

Detailed listing:

```bash
ll
```

Tree view:

```bash
lt
```

---

## bat

Modern replacement for `cat`.

```bash
cat filename.py
```

Syntax highlighting is automatically provided when supported.

---

## fzf

Fuzzy finder for quickly searching files, commands, history, and more.

```bash
fzf
```

---

## zoxide

Smarter directory navigation.

Instead of:

```bash
cd ~/Documents/Projects/AirXorium/AirXRange
```

you can use:

```bash
z AirXRange
```

after visiting the directory.

---

## btop

Beautiful system monitoring.

```bash
btop
```

---

## fastfetch

Display system information when opening a terminal.

```bash
fastfetch
```

---

# ⌨️ Useful Aliases

VibeTerm includes several convenient aliases.

### Navigation

```bash
..
...
....
```

Examples:

```bash
..
cd ..
```

```bash
...
cd ../..
```

---

### Git

```bash
gs
ga
gc
gp
gl
```

Equivalent to:

```bash
git status
git add
git commit
git push
git log --oneline --graph --decorate --all
```

---

### Docker

```bash
dc
```

Equivalent to:

```bash
docker compose
```

And:

```bash
dps
```

for:

```bash
docker ps
```

---

### Python

```bash
py
```

runs:

```bash
python3
```

And:

```bash
pip
```

uses:

```bash
python3 -m pip
```

---

### Networking

```bash
ports
```

Displays listening ports:

```bash
sudo ss -tulpn
```

Check your public IP:

```bash
myip
```

---

### System update

```bash
update
```

Runs:

```bash
sudo apt update && sudo apt upgrade
```

---

# 🛡️ Safety

VibeTerm is designed to be safe to run on an existing installation.

Before modifying your shell configuration, the installer creates a timestamped backup directory:

```text
~/.vibeterm-backup-YYYYMMDD_HHMMSS/
```

Existing files such as:

```text
~/.zshrc
~/.p10k.zsh
```

are backed up when present.

The installer **does not require root execution**.

You should run:

```bash
./install.sh
```

as your normal user.

The script uses `sudo` only when elevated permissions are required for package installation or changing the default shell.

---

# 🔄 Re-running the Installer

The installer is designed to be reasonably safe to run again.

```bash
./install.sh
```

Already-installed components are detected where possible.

Your previous configuration is backed up before VibeTerm writes a new `.zshrc`.

---

# 🔙 Restore Your Previous Configuration

If you want to revert the VibeTerm configuration, find your backup:

```bash
ls -la ~ | grep vibeterm-backup
```

Then restore your previous `.zshrc`.

For example:

```bash
cp ~/.vibeterm-backup-YYYYMMDD_HHMMSS/.zshrc ~/.zshrc
```

Restart Zsh:

```bash
exec zsh
```

---

# 🎯 Philosophy

VibeTerm is built around a simple idea:

> **Your terminal is where you spend a huge part of your development life. It should feel good to use.**

The goal isn't to fill the terminal with every possible system statistic.

Instead, VibeTerm focuses on:

```text
Beautiful
    +
Useful
    +
Fast
    +
Customizable
```

The Powerlevel10k prompt can be customized extensively depending on your workflow.

---

# 🧑‍💻 Recommended For

VibeTerm is especially useful for:

- 👨‍💻 Software developers
- 🛡️ Cybersecurity professionals
- 🔐 Penetration testers
- 🐧 Linux users
- ☁️ DevOps engineers
- 🐳 Docker users
- 🐍 Python developers
- 🌐 Web developers
- 🎓 Students
- 🧪 Researchers

---

# 🛠️ Customization

VibeTerm doesn't lock you into a specific appearance.

Powerlevel10k configuration is stored in:

```bash
~/.p10k.zsh
```

Run the configuration wizard at any time:

```bash
p10k configure
```

You can also manually customize the configuration:

```bash
nano ~/.p10k.zsh
```

---

# 📂 Project Structure

```text
VibeTerm/
│
├── install.sh
├── README.md
├── LICENSE
│
└── screenshots/
    └── terminal.png
```

---

# 🤝 Contributing

Contributions are welcome!

If you have an improvement, bug fix, theme, alias collection, or better installation method:

### 1. Fork the repository

```text
Fork → Clone → Modify → Commit → Pull Request
```

### 2. Create a branch

```bash
git checkout -b feature/my-improvement
```

### 3. Commit your changes

```bash
git add .
git commit -m "feat: improve terminal experience"
```

### 4. Push

```bash
git push origin feature/my-improvement
```

### 5. Open a Pull Request

Please keep contributions:

- Cross-user compatible
- Safe
- Reversible where possible
- Free from hard-coded usernames/paths
- Well documented

---

# 🐛 Issues

Found a problem?

Please open an issue and include:

```text
Ubuntu version:
Architecture:
Terminal emulator:
Zsh version:
Powerlevel10k version:
Error/output:
Steps to reproduce:
```

You can get useful information with:

```bash
cat /etc/os-release
zsh --version
p10k --version
echo $TERM
```

---

# ⭐ Support the Project

If VibeTerm made your terminal better:

⭐ **Star the repository**

🐛 **Report issues**

💡 **Suggest improvements**

🔀 **Submit pull requests**

📢 **Share it with other Linux developers**

---

# 📜 License

This project is licensed under the MIT License.

See [`LICENSE`](LICENSE) for details.

---

# 🙏 Credits

VibeTerm is built on top of excellent open-source projects:

- [Oh My Zsh](https://ohmyz.sh/)
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k)
- [Nerd Fonts](https://www.nerdfonts.com/)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [eza](https://github.com/eza-community/eza)
- [bat](https://github.com/sharkdp/bat)
- [fzf](https://github.com/junegunn/fzf)
- [zoxide](https://github.com/ajeetdsouza/zoxide)
- [btop](https://github.com/aristocratos/btop)
- [Fastfetch](https://github.com/fastfetch-cli/fastfetch)

VibeTerm would not exist without these projects and their maintainers.

---

<div align="center">

### ✦ Make your terminal a place you actually want to work in.

**VibeTerm**

`Linux • Zsh • Powerlevel10k • Developer Experience`

⭐ Star the repo if you like the vibes.

</div>
