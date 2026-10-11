# Regular user custom PS1 (blue-colored)
# ---------------------------
# Colors for regular user
COLOR_BLACK="\[\e[38;5;252m\]"  # #cdd6f4
COLOR_BLUE="\[\e[38;5;75m\]"    # Blue for regular user
COLOR_GREEN="\[\e[38;5;75m\]"   # #89b4fa
COLOR_YELLOW="\[\e[38;5;75m\]"  # #89b4fa
COLOR_MAGENTA="\[\e[38;5;75m\]" # #89b4fa
COLOR_CYAN="\[\e[38;5;75m\]"    # #89b4fa
COLOR_WHITE="\[\e[38;5;75m\]"   # #89b4fa
COLOR_RESET="\[\e[0m\]"         # Reset color

# Git info function to display current branch
parse_git_branch() {
  git branch 2>/dev/null | sed -n '/\*/s/\* \(.*\)/ (\1)/p'
}

# ---------- Aliases ----------
alias ll='ls -l --color=auto'
alias ls='ls -l --color=auto'
alias grep='grep --color=auto'
alias vi='nvim'
alias hx='helix'

# ---------- Regular User Prompt ----------
# Regular user prompt with full directory path, time, user, host, Git branch in blue
PS1="${COLOR_BLUE}\t ${COLOR_WHITE}\u@\h ${COLOR_YELLOW}\w$(parse_git_branch)\n${COLOR_BLUE}\[\e[1m\]>\[\e[0m\] "

# ---------- Optional: LS Colors ----------
export LS_COLORS="di=38;5;75:ln=38;5;75:so=38;5;75:pi=38;5;75:ex=38;5;75:bd=38;5;75:cd=38;5;75:su=38;5;75:sg=38;5;75:tw=38;5;75:ow=38;5;75:"

# ---------- Autostart ----------
#fastfetch

eval "$(ssh-agent -s)" >/dev/null
ssh-add ~/.ssh/id_ed25519 2>/dev/null

# ---------- PATH and tools ----------
# .NET
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"

# npm global packages
export PATH="$HOME/.npm-global/bin:$PATH"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# ~/.local/bin (uv env script + Hermes Agent)
[ -f "$HOME/.local/bin/env" ] && . "$HOME/.local/bin/env"
export PATH="$HOME/.local/bin:$PATH"

# ---------- Lua ----------
export LUA_PATH='/usr/share/lua/5.5/?.lua;/usr/local/share/lua/5.5/?.lua;/usr/local/share/lua/5.5/?/init.lua;/usr/share/lua/5.5/?/init.lua;/usr/local/lib/lua/5.5/?.lua;/usr/local/lib/lua/5.5/?/init.lua;/usr/lib/lua/5.5/?.lua;/usr/lib/lua/5.5/?/init.lua;./?.lua;./?/init.lua;/home/roan/.luarocks/share/lua/5.5/?.lua;/home/roan/.luarocks/share/lua/5.5/?/init.lua'
export LUA_CPATH='/usr/local/lib/lua/5.5/?.so;/usr/lib/lua/5.5/?.so;/usr/local/lib/lua/5.5/loadall.so;/usr/lib/lua/5.5/loadall.so;./?.so;/home/roan/.luarocks/lib/lua/5.5/?.so'
export CLAUDE_CODE_OAUTH_TOKEN="WDCxzUL4XuMB8jKQygaPPFskYfy4wn239h4qqLK2C7n5vZxf#SS8qYNCqIdkMwaXSE3_k6VlvDkuIoo-Xb3zikmipaqU"
# End of regular user profile config
