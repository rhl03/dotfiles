# dotfiles

My Arch Linux + Hyprland dotfiles, managed with GNU Stow.

## Stack

Hyprland, Quickshell, Alacritty, Neovim, Bash, Hyprlock, awww (wallpaper).

## Layout

```
work-setup/
├── alacritty/     -> ~/.config/alacritty/
├── bash/          -> ~/
├── hypr/          -> ~/.config/hypr/
├── nvim/          -> ~/.config/nvim/
├── quickshell/    -> ~/.config/quickshell/
├── pkglist.txt    (official repo packages, not stowed)
├── aurlist.txt    (AUR packages, not stowed)
└── install.sh
```

`home-setup/` is coming later.

## Install

### 1. Clone the repo

```bash
sudo pacman -S --needed git base-devel
git clone https://github.com/hro1025/dotfiles.git ~/.dotfiles
cd ~/.dotfiles/work-setup
```

### 2. Install packages

Official repo packages:

```bash
sudo pacman -S --needed - < pkglist.txt
```

AUR packages need an AUR helper. If paru isn't installed yet:

```bash
git clone https://aur.archlinux.org/paru.git /tmp/paru
cd /tmp/paru && makepkg -si
cd ~/.dotfiles/work-setup
```

Then:

```bash
paru -S --needed - < aurlist.txt
```

### 3. Link the configs

```bash
./install.sh
```

## Updating the package lists

Export explicitly installed packages, split into official repo (native) and AUR (foreign):

```bash
pacman -Qqen > ~/.dotfiles/work-setup/pkglist.txt
pacman -Qqem > ~/.dotfiles/work-setup/aurlist.txt
```

Review both files before committing and remove anything not needed on the new machine.
