# Tmux Powerline Bar - Catppuccin Theme

Tmux Powerline Bar is a Tmux plugin that enhances the status bar visualization, providing a modern and customizable experience with Catppuccin as the default theme.

![Tmux Powerline Bar Preview](assets/screenshot.png)

## ✨ Features
- 🎨 **Catppuccin as the default color scheme (Mocha).**
- 🔤 **NerdFonts for better visual representation.**
- 📂 **Current working directory (cwd).**
- 🖥 **CPU and RAM indicators.**
- ⏰ **Optional date and time display.**
- ⚙️ **Configurable via `.tmux.conf`.**

## 📦 Installation
### 1️⃣ Requirements
- Tmux v3.0+
- NerdFonts installed

### 2️⃣ Install with TPM
If you use [Tmux Plugin Manager (TPM)](https://github.com/tmux-plugins/tpm), add this to your `.tmux.conf`:

```bash
set -g @plugin 'armando-rios/tmux'
```

Then reload tmux and run `prefix + I` to install it.

## ⚙️ Configuration
You can customize the plugin by adding options to your `.tmux.conf`:

```bash
set -g @tmux_transparent "on"         # Enable transparency
set -g @tmux_status_show_clock "on"   # Show clock
set -g @tmux_status_show_sysinfo "on" # Show CPU and RAM usage
set -g @tmux_status_show_cwd "on"     # Show current directory

# Customize element order and visibility
set -g @tmux_status_format "cwd|sysinfo|clock"  # Default order
set -g @tmux_status_format "clock|cwd"          # Only clock and directory
set -g @tmux_status_format "sysinfo|clock|cwd"  # Custom order
set -g @tmux_status_format "cwd"                # Only current directory

# Choose your favorite theme
set -g @tmux_theme "mocha"          # Catppuccin Mocha (default)
set -g @tmux_theme "latte"          # Catppuccin Latte (light)
set -g @tmux_theme "frappe"         # Catppuccin Frappé
set -g @tmux_theme "macchiato"      # Catppuccin Macchiato
set -g @tmux_theme "dracula"        # Dracula theme
set -g @tmux_theme "nord"           # Nord theme
set -g @tmux_theme "gruvbox"        # Gruvbox Dark
set -g @tmux_theme "tokyo-night"    # Tokyo Night
set -g @tmux_theme "one-dark"       # One Dark
```

### 📝 Available Elements
- `cwd` - Current working directory
- `sysinfo` - CPU and RAM usage 
- `clock` - Current time (HH:MM format)

Use `|` to separate elements in your desired order.

### 🎨 Available Themes

**Catppuccin Family:**
- `mocha` - Dark theme with warm colors (default, matches your lualine setup)
- `latte` - Light theme with vibrant colors
- `frappe` - Dark theme with cooler tones
- `macchiato` - Dark theme with balanced warmth

**Popular Themes:**
- `dracula` - Purple and pink vibrant colors
- `nord` - Cool blue minimalist palette
- `gruvbox` - Retro warm colors
- `tokyo-night` - Modern blue night theme
- `one-dark` - Classic VS Code theme

All themes are carefully crafted to provide excellent contrast and readability.

## 🚀 Usage
After installing and configuring, reload Tmux:

```bash
tmux source-file ~/.tmux.conf
```

## 📖 Documentation
A dedicated website with detailed documentation will be available soon.

## 📝 License
This project is licensed under the MIT License.

## 💡 Contributions
Contributions are welcome! Feel free to open a PR or issue on GitHub.

---

⭐ **If you like this plugin, don't forget to star it on GitHub!**

