local PlaceId = game.PlaceId

local Scripts = {
	[119524908037342] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyBaksoMalangAnomalies.lua",
	[77338972879392]  = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/BaksoMalangAnomalies.lua",
	[137826330724902] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyScaryShawarmaKiosk.lua",
    [128001665358186] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ScaryShawarmaKiosk.lua",
}

local url = Scripts[PlaceId]
if url then
	loadstring(game:HttpGet(url))()
else
	warn("Game No Support")
end
