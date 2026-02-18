local PlaceId = game.PlaceId

local Scripts = {
	[102212685525266] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/shotbrainrot.lua",
	[136764190843219]  = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/knockout.lua",
	[137826330724902] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyScaryShawarmaKiosk.lua",
  [128001665358186] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ScaryShawarmaKiosk.lua",
	[133862653684768] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/knockout.lua",
  [116495829188952] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua",
  [70876832253163] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua",
}

local url = Scripts[PlaceId]
if url then
	loadstring(game:HttpGet(url))()
else
	warn("Game No Support")
end
