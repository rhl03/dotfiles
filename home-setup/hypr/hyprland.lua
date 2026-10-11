------------------------------------------------------------------------------------------
--                               ENVIRONMENT & SYSTEM
------------------------------------------------------------------------------------------

-- Cursor & theme environment variables (old `env = ...`)
hl.env("XCURSOR_THEME", "crosshair")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Old `exec = ...` (runs on every config load/reload, not just once)
hl.exec_cmd('gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"')
hl.exec_cmd('gsettings set org.gnome.desktop.interface gtk-theme "Tokyonight-Dark"')

-- Old `exec-once = ...` (only runs once, at Hyprland startup)
hl.on("hyprland.start", function()
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

	hl.exec_cmd("hyprctl setcursor crosshair 24")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface cursor-theme 'crosshair' &> /dev/null")
	hl.exec_cmd("gsettings set org.gnome.desktop.interface font-name 'Maple Mono NF 11'")

	-- Startup services
	hl.exec_cmd("quickshell")
	hl.exec_cmd("wpaperd")
	hl.exec_cmd("mako")
	hl.exec_cmd("gsr-ui")
end)

------------------------------------------------------------------------------------------
--                                    MONITORS
------------------------------------------------------------------------------------------

hl.monitor({ output = "DP-1", mode = "1920x1080@360", position = "0x0", scale = 1 })
hl.monitor({ output = "DP-3", mode = "1920x1080@60", position = "-1080x-680", scale = 1, transform = 1 })

-- Workspace -> monitor assignment
for i = 1, 9 do
	hl.workspace_rule({ workspace = tostring(i), monitor = "DP-1" })
end
hl.workspace_rule({ workspace = "10", monitor = "DP-3" })

------------------------------------------------------------------------------------------
--                                   MY PROGRAMS
------------------------------------------------------------------------------------------

local terminal = "alacritty"
local fileManager = "nemo"
local menu = "rofi -show drun -theme ~/.config/rofi/tokyo-night.rasi 2>&1"
local powermenu = "zsh ~/.config/rofi/powermenu.sh"
local screenshot = "hyprshot -m region -m active --clipboard-only"

------------------------------------------------------------------------------------------
--                                   KEYBINDINGS
------------------------------------------------------------------------------------------

local mainMod = "SUPER"

-- Applications & essentials
hl.bind("ALT + Return", hl.dsp.exec_cmd(terminal))
hl.bind("ALT + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exit())
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen()) -- verify: may need an { action = ... } arg
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind("ALT + F", hl.dsp.window.float({ action = "toggle" }))
hl.bind("ALT + D", hl.dsp.exec_cmd(menu))
hl.bind("ALT + Backspace", hl.dsp.exec_cmd(powermenu))
hl.bind(mainMod .. " + A", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + D", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + W", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + S", hl.dsp.focus({ direction = "down" }))
hl.bind("ALT + F1", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))

-- Workspace navigation (ALT + 1..9)
for i = 1, 9 do
	hl.bind("ALT + " .. i, hl.dsp.focus({ workspace = i }))
end

-- Move window to workspace
for i = 1, 5 do
	hl.bind(mainMod .. " + " .. i, hl.dsp.window.move({ workspace = i }))
end
for i = 1, 5 do
	hl.bind("CTRL + SHIFT + " .. i, hl.dsp.window.move({ workspace = i + 5 }))
end

-- Mouse bindings
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true }) -- move
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true }) -- resize
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

------------------------------------------------------------------------------------------
--                                  LOOK AND FEEL
------------------------------------------------------------------------------------------

-- Tokyo Night palette
-- Background: #1a1b26  Foreground: #c0caf5
-- Blue:       #7aa2f7  Purple:     #bb9af7
-- Cyan:       #7dcfff  Green:      #9ece6a
-- Red:        #f7768e  Gold:       #e0af68

hl.config({
	general = {
		gaps_in = 0.5,
		gaps_out = 0.5,
		border_size = 1,
		col = {
			active_border = { colors = { "rgba(7aa2f7ff)", "rgba(bb9af7ff)" }, angle = 45 },
			inactive_border = "rgba(1a1b2600)",
		},
		resize_on_border = false,
		allow_tearing = false,
		layout = "dwindle",
	},

	decoration = {
		rounding = 5,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 8,
			render_power = 1000,
			color = "rgba(7aa2f755)",
			color_inactive = "rgba(1a1b2600)",
		},
		blur = {
			enabled = false,
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

	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = false,
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
		kb_variant = "",
		kb_model = "",
		kb_options = "grp:ctrl_space_toggle",
		kb_rules = "",
		accel_profile = "flat",
		follow_mouse = 1,
		sensitivity = 0.3,
		repeat_rate = 50,
		repeat_delay = 200,
		touchpad = {
			natural_scroll = false,
		},
	},

	cursor = {
		no_hardware_cursors = true,
		hotspot_padding = 2,
		no_warps = true,
	},

	debug = {
		damage_tracking = 1,
	},
})
