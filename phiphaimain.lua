local Discord = "https://discord.gg/6y7TpYTBkW"
local luoivl = game.PlaceId

local saiduocallgameluon =
    "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/universal.lua"

local env = getgenv and getgenv() or _G

if env.PP_Loaded then
    warn("running.")
    return
end

env.PP_Loaded = true
local function ShowDiscordNotification()
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "PP_DiscordNotify"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.Parent =
        game:GetService("CoreGui")
        or game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(0, 320, 0, 140)
    Frame.Position = UDim2.new(0.5, -160, 0, 20)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    Frame.BorderSizePixel = 0
    Frame.Parent = ScreenGui

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Frame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 10, 0, 8)
    Title.BackgroundTransparency = 1
    Title.Text = "PP Loader"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = Frame

    local Content = Instance.new("TextLabel")
    Content.Size = UDim2.new(1, -20, 0, 40)
    Content.Position = UDim2.new(0, 10, 0, 40)
    Content.BackgroundTransparency = 1
    Content.Text =
        "Join Discord plzz<3. can u join server to get free key access in ticket\n"
        .. Discord
    Content.TextColor3 = Color3.fromRGB(200, 200, 210)
    Content.Font = Enum.Font.Gotham
    Content.TextSize = 13
    Content.TextWrapped = true
    Content.TextXAlignment = Enum.TextXAlignment.Left
    Content.Parent = Frame

    local CopyBtn = Instance.new("TextButton")
    CopyBtn.Size = UDim2.new(0, 140, 0, 32)
    CopyBtn.Position = UDim2.new(0, 10, 1, -42)
    CopyBtn.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
    CopyBtn.Text = "Copy Discord"
    CopyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    CopyBtn.Font = Enum.Font.GothamBold
    CopyBtn.TextSize = 14
    CopyBtn.Parent = Frame

    local CopyCorner = Instance.new("UICorner")
    CopyCorner.CornerRadius = UDim.new(0, 6)
    CopyCorner.Parent = CopyBtn

    local SkipBtn = Instance.new("TextButton")
    SkipBtn.Size = UDim2.new(0, 140, 0, 32)
    SkipBtn.Position = UDim2.new(1, -150, 1, -42)
    SkipBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
    SkipBtn.Text = "Skip"
    SkipBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    SkipBtn.Font = Enum.Font.GothamBold
    SkipBtn.TextSize = 14
    SkipBtn.Parent = Frame

    local SkipCorner = Instance.new("UICorner")
    SkipCorner.CornerRadius = UDim.new(0, 6)
    SkipCorner.Parent = SkipBtn

    CopyBtn.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard(Discord)

            CopyBtn.Text = "Copied!"

            task.wait(1.2)

            if CopyBtn and CopyBtn.Parent then
                CopyBtn.Text = "Copy Discord"
            end
        else
            CopyBtn.Text = "No clipboard"
        end
    end)

    SkipBtn.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)

    task.delay(5, function()
        if ScreenGui and ScreenGui.Parent then
            ScreenGui:Destroy()
        end
    end)
end

task.delay(0.8, function()
    ShowDiscordNotification()
end)


local function N(t)
    pcall(function()
        game.StarterGui:SetCore(
            "SendNotification",
            {
                Title = "PP Loader",
                Text = t,
                Duration = 5
            }
        )
    end)
end

task.delay(1, function()
    N("wait script loader | don't executor again.")
end)


local function loadScript(url)
    local ok, res = pcall(function()
        return game:HttpGet(url)
    end)

    if not ok then
        warn("HttpGet loi:", url)
        return
    end

    local func, err = loadstring(res)

    if not func then
        warn("Loader loi:", err)
        return
    end

    local success, runtimeErr = pcall(func)

    if not success then
        warn("Runtime loi:", runtimeErr)
    end
end


if luoivl == 102212685525266 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/shotbrainrot.lua"
    )

elseif luoivl == 134225461562780 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/survivehomelander.lua"
    )

elseif luoivl == 137826330724902 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyScaryShawarmaKiosk.lua"
    )

elseif luoivl == 128001665358186 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ScaryShawarmaKiosk.lua"
    )

elseif luoivl == 116495829188952
    or luoivl == 70876832253163 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/DeadRails.lua"
    )

elseif luoivl == 108172906114565 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/sol%E2%80%99sRNGBoss2.lua"
    )

elseif luoivl == 139955980906311 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/sol%E2%80%99sRNGboss1.lua"
    )

elseif luoivl == 103854444055060 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/SilentAssassins.lua"
    )

elseif luoivl == 15532962292 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/Sol%E2%80%99sRNGMain.lua"
    )

elseif luoivl == 108730407897379 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/LobbyAmberAlert.lua"
    )

elseif luoivl == 79943475071382 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/EasyModeAmberAlert.lua"
    )

elseif luoivl == 85633367989270 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/MediumModeAmberAlert.lua"
    )

elseif luoivl == 82671281194242 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/HardModeAmberAlert.lua"
    )

elseif luoivl == 92671411590360 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/NightmareModeAmberAlert.lua"
    )

elseif luoivl == 82511549210927 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/ExpertModeAmberAlert.lua"
    )

elseif luoivl == 87778445949069 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/GrandparentsModeAmberAlert.lua"
    )

elseif luoivl == 142823291
    or luoivl == 100325591601715
    or luoivl == 80469437126309 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/MM2Z.lua"
    )

elseif luoivl == 80356011995441 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/minecraftfake.lua"
    )

elseif luoivl == 94309190278698
    or luoivl == 77419850589072 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/safetynotrequired.lua"
    )

elseif luoivl == 111894976456494 then

    loadScript(
        "https://raw.githubusercontent.com/chienminh21/phiphaiv2/refs/heads/main.lua/amlf.lua"
    )

else

    loadScript(saiduocallgameluon)

end

task.spawn(function()

    local ok, err = pcall(function()

        loadstring(
            game:HttpGet(
                "https://raw.githubusercontent.com/chienminh21/aaaaaaaa/refs/heads/main/picklol.lua"
            )
        )()

    end)

    if not ok then
        warn("loader end loi:", err)
    end
end)


task.delay(1, function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/chienminh21/aaaaaaaa/refs/heads/main/helpdevhuhu.lua"))()
end)
