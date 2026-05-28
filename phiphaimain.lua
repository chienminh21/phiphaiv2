
local function N(t)
    pcall(function()
        game.StarterGui:SetCore("SendNotification",{Title="PP Loader",Text=t,Duration=5})
    end)
end

task.delay(1,function()
    N("wait script loader | don't executor again.")
end)

local luoivl = game.PlaceId
local saiduocallgameluon = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/universal.lua"

local Scripts = {
    [102212685525266] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/shotbrainrot.lua",
    [130594398886540] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/gardenhorizons",
    [137826330724902] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyScaryShawarmaKiosk.lua",
  [128001665358186] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ScaryShawarmaKiosk.lua",
  [116495829188952] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua",
  [70876832253163] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua",
    [108172906114565] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/sol%E2%80%99sRNGBoss2.lua",
    [139955980906311] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/sol%E2%80%99sRNGboss1.lua",
    [103854444055060] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/SilentAssassins.lua",
    [15532962292] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/Sol%E2%80%99sRNGMain.lua",
    [108730407897379] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyAmberAlert.lua",
    [79943475071382] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/EasyModeAmberAlert.lua",
    [85633367989270] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/MediumModeAmberAlert.lua",
    [82671281194242] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/HardModeAmberAlert.lua",
    [92671411590360] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/NightmareModeAmberAlert.lua",
    [82511549210927] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ExpertModeAmberAlert.lua",
    [87778445949069] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/GrandparentsModeAmberAlert.lua",
    [142823291] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/MM2Z.lua",
    [100325591601715] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/MM2Z.lua",
    [80469437126309] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/MM2Z.lua",
    [80356011995441] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/minecraftfake.lua",
	[94309190278698] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/safetynotrequired.lua",
	[77419850589072] = "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/safetynotrequired.lua",
}
local function loadScript(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)
    if not ok then
        warn("https:// loi:", url)
        return
    end
    local func, err = loadstring(res)
    if not func then
        warn("loader loi:", err)
        return
    end
    local success, runtimeErr = pcall(func)
    if not success then
        warn("runtime loi:", runtimeErr)
    end
end
local url = Scripts[luoivl]
if url then
    loadScript(url)
else
    loadScript(saiduocallgameluon)
end
task.spawn(function()
    local ok, err = pcall(function()
        loadstring(game:HttpGet(
            "https://raw.githubusercontent.com/chienminh21/aaaaaaaa/refs/heads/main/picklol.lua"
        ))()
    end)
    if not ok then
        warn("loader end loi:", err)
    end
end)
