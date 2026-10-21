------------------------------------------------------------------------------------------
--                               ENVIRONMENT & SYSTEM
------------------------------------------------------------------------------------------

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Runs on every config reload
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "adw-gtk3-dark"')

-- Runs once at startup
hl.on("hyprland.start", function()
  hl.exec_cmd("hyprlock")
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")

  hl.exec_cmd("hyprctl setcursor hypr-dots-blue 24")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'hypr-dots-blue'")
  hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'JetBrains Mono Nerd Font 11'")

  hl.exec_cmd("quickshell")
  hl.exec_cmd("awww-daemon")
  hl.exec_cmd("hyprpm reload")
  hl.exec_cmd("dunst")
  hl.exec_cmd("blueman-applet")
  hl.exec_cmd("awww img /home/roan/Pictures/wallpaper.jpg")
end)

------------------------------------------------------------------------------------
--                                   MONITORS
------------------------------------------------------------------------------------

hl.monitor({ output = "HDMI-A-1", mode = "5120x1440@60", position = "0x0", scale = 1.25 })

hl.workspace_rule({ workspace = "1", monitor = "HDMI-A-1" })

------------------------------------------------------------------------------------
--                                 LAPTOP SCREEN
------------------------------------------------------------------------------------

-- Laptop screen turns off automatically when an external monitor is connected
local function laptopOn()
  hl.monitor({ output = "eDP-1", mode = "1920x1080@60", position = "auto", scale = 1, disabled = false })
end

local function laptopOff()
  hl.monitor({ output = "eDP-1", disabled = true })
end

local function hasExternal()
  for _, m in ipairs(hl.get_monitors()) do
    if m.name ~= "eDP-1" and m.name ~= "FALLBACK" then
      return true
    end
  end
  return false
end

local function updateLaptop()
  if hasExternal() then laptopOff() else laptopOn() end
end

hl.on("hyprland.start", updateLaptop)
hl.on("monitor.added", updateLaptop)
hl.on("monitor.removed", updateLaptop)

-- Manual override in case something goes wrong
hl.bind("SUPER + SHIFT + M", laptopOn)

------------------------------------------------------------------------------------------
--                                   MY PROGRAMS
------------------------------------------------------------------------------------------

local terminal = "alacritty"
local fileManager = "alacritty -e yazi"
local menu = "rofi -show drun"
local powermenu = "bash ~/.config/rofi/powermenu.sh"
local screenshot = "hyprshot -m region -m active --clipboard-only"

------------------------------------------------------------------------------------------
--                                   KEYBINDINGS
------------------------------------------------------------------------------------------

local mainMod = "SUPER"

-- Applications & essentials
hl.bind("ALT + Return", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + D", hl.dsp.exec_cmd(menu))
hl.bind("ALT + Delete", hl.dsp.exec_cmd(powermenu))
hl.bind("ALT + F1", hl.dsp.exec_cmd(screenshot))
hl.bind("SUPER + Escape", hl.dsp.exec_cmd("hyprlock"))

-- Focus
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Swap window with its neighbour (left window <-> right window)
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + D", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.swap({ direction = "down" }))

-- Resize active window (hold to keep resizing)
hl.bind(mainMod .. " + CTRL + A", hl.dsp.window.resize({ x = -40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + D", hl.dsp.window.resize({ x = 40, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + W", hl.dsp.window.resize({ x = 0, y = -40, relative = true }), { repeating = true })
hl.bind(mainMod .. " + CTRL + S", hl.dsp.window.resize({ x = 0, y = 40, relative = true }), { repeating = true })

-- Workspaces (ALT + 1..9)
for i = 1, 9 do
  hl.bind("ALT + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move window to workspace 1-5 / 6-10
for i = 1, 5 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.window.move({ workspace = i }))
  hl.bind("CTRL + SHIFT + " .. i, hl.dsp.window.move({ workspace = i + 5 }))
end

-- Mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

------------------------------------------------------------------------------------------
--                                  LOOK AND FEEL
------------------------------------------------------------------------------------------

hl.config({
  general = {
    gaps_in = 0,
    gaps_out = 0,
    border_size = 2,
    col = {
      active_border = { colors = { "rgba(89b4faff)", "rgba(89b4faff)" }, angle = 45 },
      inactive_border = "rgba(00000000)",
    },
    layout = "dwindle",
  },

  decoration = {
    rounding = 2,
    shadow = {
      enabled = false,
    },
    blur = {
      enabled = true,
      size = 1,
      passes = 5,
      vibrancy = 0.1696,
      new_optimizations = true,
    },
  },

  dwindle = {
    force_split = 2,
    preserve_split = true,
  },

  opengl = {
    nvidia_anti_flicker = true,
  },
})

-- Bezier curves
hl.curve("winIn", { type = "bezier", points = { { 0.1, 1.0 }, { 0.1, 1.0 } } })
hl.curve("winOut", { type = "bezier", points = { { 0.1, 1.0 }, { 0.1, 1.0 } } })
hl.curve("smoothOut", { type = "bezier", points = { { 0.5, 0 }, { 0.99, 0.99 } } })
hl.curve("layerOut", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })

-- Animations
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "default" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 7, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 3, bezier = "smoothOut", style = "slide" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 7, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 8, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 8, bezier = "winOut", style = "slide" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 10, bezier = "winIn", style = "slide" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 3, bezier = "layerOut", style = "popin 50%" })

------------------------------------------------------------------------------------------
--                                      INPUT
------------------------------------------------------------------------------------------

hl.config({
  input = {
    kb_layout = "no",
    kb_options = "grp:ctrl_space_toggle",
    accel_profile = "flat",
    follow_mouse = 1,
    sensitivity = 0.3,
    repeat_rate = 50,
    repeat_delay = 200,
  },
})
