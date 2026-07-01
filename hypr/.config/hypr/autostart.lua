hl.on("hyprland.start", function ()
	local startup = {
		"waybar & hyprpaper &", --start waybar and wallpaper
		"hypridle", --start idle and lock-screen
		"wl-paste -t text --watch clipman store --no-persist", --start clipboard manager
	}
	for i = 1, #startup do
		hl.exec_cmd(startup[i])
	end
end)
