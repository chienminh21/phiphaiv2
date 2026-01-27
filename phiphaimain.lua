local Players = game:GetService("Players")
local player = Players.LocalPlayer

local discordInvite = "https://discord.gg/6y7TpYTBkW"

if setclipboard then
	setclipboard(discordInvite)
elseif toclipboard then
	toclipboard(discordInvite)
end

local locale = string.lower(player.LocaleId or "en-us")

local messages = {
	["vi"] = "Vui lòng vào Discord để lấy script mới.\nLink đã được copy",
	["en"] = "Please join Discord to get the new script.\nLink copied",
	["id"] = "Silakan masuk Discord untuk mendapatkan script terbaru.\nLink telah disalin",
	["th"] = "กรุณาเข้า Discord เพื่อรับสคริปต์ใหม่\nลิงก์ถูกคัดลอกแล้ว",
	["ru"] = "Зайдите в Discord, чтобы получить новый скрипт.\nСсылка скопирована",
	["fr"] = "Veuillez rejoindre le Discord pour obtenir le nouveau script.\nLien copié",
	["de"] = "Bitte trete dem Discord bei, um das neue Skript zu erhalten.\nLink kopiert",
	["es"] = "Únete a Discord para obtener el nuevo script.\nEnlace copiado",
	["pt"] = "Entre no Discord para obter o novo script.\nLink copiado",
	["ja"] = "新しいスクリプトを入手するにはDiscordに参加してください。\nリンクがコピーされました",
	["ko"] = "새 스크립트를 받으려면 Discord에 참여하세요.\n링크가 복사되었습니다",
	["zh-cn"] = "请加入 Discord 以获取最新脚本。\n链接已复制",
	["zh-tw"] = "請加入 Discord 以獲取最新腳本。\n連結已複製",
	["ar"] = "يرجى الانضمام إلى Discord للحصول على السكربت الجديد.\nتم نسخ الرابط",
	["tr"] = "Yeni scripti almak için Discord'a katılın.\nBağlantı kopyalandı",
	["it"] = "Unisciti a Discord per ottenere il nuovo script.\nLink copiato",
	["pl"] = "Dołącz do Discorda, aby otrzymać nowy skrypt.\nLink skopiowany",
	["nl"] = "Ga naar Discord om het nieuwe script te krijgen.\nLink gekopieerd",
}

local text = messages["en"]
for k,v in pairs(messages) do
	if string.find(locale, k) then
		text = v
		break
	end
end

task.wait(1)
player:Kick(text .. "\n\n" .. discordInvite)
