local Players = game:GetService("Players")
local player = Players.LocalPlayer

local discordInvite = "https://discord.gg/6y7TpYTBkW"

-- COPY CLIPBOARD (executor only)
if setclipboard then
	setclipboard(discordInvite)
elseif toclipboard then
	toclipboard(discordInvite)
end

task.wait(1)

player:Kick(
	"/INDO/ Link Discord đã được copy\n" ..
	"/AR/ تم نسخ رابط Discord\n" ..
	"/EN/ Discord link copied\n\n" ..
	discordInvite
)
