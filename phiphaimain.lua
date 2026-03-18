local PlaceId = game.PlaceId

local Scripts = {
	[102212685525266] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/shotbrainrot.lua",
	[130594398886540] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/gardenhorizons",
	[137826330724902] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyScaryShawarmaKiosk.lua",
  [128001665358186] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ScaryShawarmaKiosk.lua",
  [116495829188952] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua",
  [70876832253163] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua",
	[108172906114565] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/sol%E2%80%99sRNGBoss2.lua",
	[103854444055060] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/SilentAssassins.lua",
	[15532962292] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/Sol%E2%80%99sRNGMain.lua",
	[108730407897379] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyAmberAlert.lua",
	[79943475071382] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/EasyModeAmberAlert.lua",
}

local url = Scripts[PlaceId]
if url then
	loadstring(game:HttpGet(url))()
else
	warn("Game No Support")
end
