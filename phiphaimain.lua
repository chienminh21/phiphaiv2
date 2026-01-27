local Players = game:GetService("Players")
local player = Players.LocalPlayer

local discordInvite = "https://discord.gg/6y7TpYTBkW"

if setclipboard then
	setclipboard(discordInvite)
elseif toclipboard then
	toclipboard(discordInvite)
end

local locale = player.LocaleId or "en-us"
locale = string.lower(locale)

local messages = {
	["vi"] = "Vui lòng vào Discord để lấy script mới.\nLink đã được copy:",
	["en"] = "Please join Discord to get the new script.\nLink copied:",
	["id"] = "Silakan masuk Discord untuk script terbaru.\nLink telah disalin:",
	["ar"] = "يرجى الانضمام إلى Discord للحصول على السكربت الجديد.\nتم نسخ الرابط:",
	["th"] = "กรุณาเข้า Discord เพื่อรับสคริปต์ใหม่\nคัดลอกลิงก์แล้ว:",
}

local msg = messages["en"] 

for lang, text in pairs(messages) do
	if string.find(locale, lang) then
		msg = text
		break
	end
end

task.wait(1)

player:Kick(msg .. "\n\n" .. discordInvite)
