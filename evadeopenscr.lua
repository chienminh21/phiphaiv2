

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/refs/heads/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Lighting = game:GetService("Lighting")
local VirtualInputManager = game:GetService("VirtualInputManager")
local LocalPlayer = Players.LocalPlayer


getgenv().EvadeConfig = getgenv().EvadeConfig or {
    NextbotESP = false,
    TicketESP = false,
    AntiNextbot = false,
    AntiDistance = 28,
    FarmTickets = false,
    FarmMode = "TP",
    FarmDelay = 0.25,
    TweenSpeed = 90,
    UnderMapFarm = false,
    UnderMapY = -120,
    SkyFarm = false,
    SkyY = 280,
    AutoReviveOthers = false,
    AutoSelfRevive = false,
    ReviveHoldTime = 4.5,
    Noclip = false,
    ShowDistance = true,

    
    RemoveTextures = false,
    HidePlayers = false,
    HideEffects = false,
    LowGFX = false,
    NoShadows = false,
    Fullbright = false,
}

local Config = getgenv().EvadeConfig


local function findFolder(paths)
    for _, path in ipairs(paths) do
        local current = workspace
        local ok = true
        for _, name in ipairs(path) do
            current = current:FindFirstChild(name)
            if not current then
                ok = false
                break
            end
        end
        if ok then return current end
    end
    return nil
end

local BotFolder = findFolder({
    {"Players"},
    {"Game", "Players"},
    {"Game", "Bots"},
})

local TicketsFolder = findFolder({
    {"Effects", "Tickets"},
    {"Game", "Effects", "Tickets"},
    {"Game", "Tickets"},
})

local EffectsFolder = findFolder({
    {"Effects"},
    {"Game", "Effects"},
})


local function isRealPlayer(name)
    return Players:FindFirstChild(name) ~= nil
end

local function getHRP()
    local char = LocalPlayer.Character
    return char and char:FindFirstChild("HumanoidRootPart")
end

local function clearESP(obj)
    if not obj then return end
    for _, v in ipairs(obj:GetChildren()) do
        if v.Name:find("ESP_") or v.Name == "NextbotHighlight" or v.Name == "TicketHighlight" then
            pcall(function() v:Destroy() end)
        end
    end
end

local nextbotConns = {}

local function applyNextbotESP(model)
    if not model or not model:IsA("Model") then return end
    if isRealPlayer(model.Name) then return end

    clearESP(model)

    local root = model:FindFirstChild("HumanoidRootPart") or model:FindFirstChildWhichIsA("BasePart")
    if not root then return end

    local hl = Instance.new("Highlight")
    hl.Name = "NextbotHighlight"
    hl.Adornee = model
    hl.FillColor = Color3.fromRGB(255, 45, 45)
    hl.OutlineColor = Color3.fromRGB(255, 0, 0)
    hl.FillTransparency = 0.55
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = model

    local bill = Instance.new("BillboardGui")
    bill.Name = "ESP_Billboard"
    bill.Adornee = root
    bill.Size = UDim2.new(0, 130, 0, 40)
    bill.StudsOffset = Vector3.new(0, 3.2, 0)
    bill.AlwaysOnTop = true
    bill.Parent = model

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255, 70, 70)
    label.TextStrokeTransparency = 0.25
    label.Font = Enum.Font.GothamBold
    label.TextSize = 14
    label.Text = model.Name
    label.Parent = bill

    if Config.ShowDistance then
        local conn
        conn = RunService.RenderStepped:Connect(function()
            if not model.Parent or not root.Parent then
                if conn then conn:Disconnect() end
                return
            end
            local hrp = getHRP()
            if hrp then
                local dist = math.floor((hrp.Position - root.Position).Magnitude)
                label.Text = model.Name .. "\n[" .. dist .. "]"
            end
        end)
        nextbotConns[model] = conn
    end
end

local function setupNextbotESP()
    if not BotFolder then return end
    for _, child in ipairs(BotFolder:GetChildren()) do
        if child:IsA("Model") and not isRealPlayer(child.Name) then
            applyNextbotESP(child)
        end
    end
    BotFolder.ChildAdded:Connect(function(child)
        task.wait(0.12)
        if child:IsA("Model") and not isRealPlayer(child.Name) and Config.NextbotESP then
            applyNextbotESP(child)
        end
    end)
end

local function removeAllNextbotESP()
    if not BotFolder then return end
    for _, child in ipairs(BotFolder:GetChildren()) do
        clearESP(child)
    end
    for _, conn in pairs(nextbotConns) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(nextbotConns)
end


local function applyTicketESP(obj)
    if not obj then return end
    clearESP(obj)

    local part = obj:IsA("BasePart") and obj or obj:FindFirstChildWhichIsA("BasePart")
    if not part then return end

    local hl = Instance.new("Highlight")
    hl.Name = "TicketHighlight"
    hl.Adornee = obj
    hl.FillColor = Color3.fromRGB(255, 215, 0)
    hl.OutlineColor = Color3.fromRGB(255, 255, 120)
    hl.FillTransparency = 0.4
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Parent = obj

    local bill = Instance.new("BillboardGui")
    bill.Name = "ESP_Billboard"
    bill.Adornee = part
    bill.Size = UDim2.new(0, 90, 0, 26)
    bill.StudsOffset = Vector3.new(0, 2.3, 0)
    bill.AlwaysOnTop = true
    bill.Parent = obj

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.Text = "TICKET"
    label.TextColor3 = Color3.fromRGB(255, 230, 60)
    label.TextStrokeTransparency = 0.35
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.Parent = bill
end

local function setupTicketESP()
    if not TicketsFolder then return end
    for _, child in ipairs(TicketsFolder:GetChildren()) do
        applyTicketESP(child)
    end
    TicketsFolder.ChildAdded:Connect(function(child)
        task.wait(0.08)
        if Config.TicketESP then
            applyTicketESP(child)
        end
    end)
end

local function removeAllTicketESP()
    if not TicketsFolder then return end
    for _, child in ipairs(TicketsFolder:GetChildren()) do
        clearESP(child)
    end
end


local function antiNextbotLoop()
    while true do
        task.wait(0.1)
        if not Config.AntiNextbot or not BotFolder then continue end
        local hrp = getHRP()
        if not hrp then continue end

        for _, bot in ipairs(BotFolder:GetChildren()) do
            if bot:IsA("Model") and not isRealPlayer(bot.Name) then
                local root = bot:FindFirstChild("HumanoidRootPart") or bot:FindFirstChildWhichIsA("BasePart")
                if root then
                    local dist = (hrp.Position - root.Position).Magnitude
                    if dist < Config.AntiDistance then
                        local dir = (hrp.Position - root.Position).Unit
                        hrp.CFrame = hrp.CFrame + dir * 20
                    end
                end
            end
        end
    end
end


local safePlatform = nil
local currentSafeMode = nil

local function createSafePlatform(mode)
    if safePlatform and safePlatform.Parent then
        safePlatform:Destroy()
    end

    local y = mode == "sky" and Config.SkyY or Config.UnderMapY
    currentSafeMode = mode

    safePlatform = Instance.new("Part")
    safePlatform.Name = "EvadeSafePlatform"
    safePlatform.Size = Vector3.new(50, 1, 50)
    safePlatform.Anchored = true
    safePlatform.CanCollide = true
    safePlatform.Transparency = 0.5
    safePlatform.Color = mode == "sky" and Color3.fromRGB(80, 160, 255) or Color3.fromRGB(40, 40, 50)
    safePlatform.Material = Enum.Material.SmoothPlastic
    safePlatform.Parent = workspace

    local hrp = getHRP()
    if hrp then
        safePlatform.CFrame = CFrame.new(hrp.Position.X, y, hrp.Position.Z)
        hrp.CFrame = safePlatform.CFrame + Vector3.new(0, 3.5, 0)
    end
end

local function destroySafePlatform()
    if safePlatform then
        safePlatform:Destroy()
        safePlatform = nil
        currentSafeMode = nil
    end
end

local function returnToSafe()
    local hrp = getHRP()
    if not hrp or not safePlatform or not safePlatform.Parent then return end
    hrp.CFrame = safePlatform.CFrame + Vector3.new(0, 3.5, 0)
end


local farming = false
local isGoingToTicket = false

local function getClosestTicket(hrp)
    if not TicketsFolder then return nil end
    local closest, closestDist = nil, math.huge
    for _, ticket in ipairs(TicketsFolder:GetChildren()) do
        local part = ticket:IsA("BasePart") and ticket or ticket:FindFirstChildWhichIsA("BasePart")
        if part and part.Parent then
            local dist = (hrp.Position - part.Position).Magnitude
            if dist < closestDist then
                closestDist = dist
                closest = part
            end
        end
    end
    return closest
end

local function farmTicketsLoop()
    if farming then return end
    farming = true

    task.spawn(function()
        while Config.FarmTickets or Config.UnderMapFarm or Config.SkyFarm do
            local hrp = getHRP()
            if not hrp then
                task.wait(0.4)
                continue
            end

          
            if (Config.UnderMapFarm or Config.SkyFarm) and not isGoingToTicket then
                if safePlatform and safePlatform.Parent then
                    local targetY = currentSafeMode == "sky" and Config.SkyY or Config.UnderMapY
                    if math.abs(hrp.Position.Y - (targetY + 3.5)) > 15 then
                        hrp.CFrame = CFrame.new(hrp.Position.X, targetY + 3.5, hrp.Position.Z)
                    end
                end
            end

            local target = getClosestTicket(hrp)
            if target and target.Parent then
                isGoingToTicket = true

                if Config.FarmMode == "TP" then
                    hrp.CFrame = target.CFrame + Vector3.new(0, 2.8, 0)
                else
                    local dist = (hrp.Position - target.Position).Magnitude
                    local tween = TweenService:Create(hrp, TweenInfo.new(
                        math.clamp(dist / Config.TweenSpeed, 0.06, 1.0),
                        Enum.EasingStyle.Linear
                    ), {CFrame = target.CFrame + Vector3.new(0, 2.8, 0)})
                    tween:Play()
                    tween.Completed:Wait()
                end

               
                task.wait(Config.FarmDelay)

               
                if (Config.UnderMapFarm or Config.SkyFarm) and safePlatform and safePlatform.Parent then
                    returnToSafe()
                end

                isGoingToTicket = false
                task.wait(0.08)
            else
                isGoingToTicket = false
                task.wait(0.3)
            end
        end
        farming = false
        isGoingToTicket = false
    end)
end


local reviving = false

local function isDowned(character)
    if not character then return false end
    local hum = character:FindFirstChildOfClass("Humanoid")
    if not hum then return false end

    if hum.Health <= 0 then return true end
    if character:GetAttribute("Downed") == true then return true end
    if character:FindFirstChild("Downed") then return true end

    for _, v in ipairs(character:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local name = v.Name:lower()
            local action = (v.ActionText or ""):lower()
            if name:find("revive") or action:find("revive") or action:find("help") then
                return true, v
            end
        end
    end
    return false
end

local function findRevivePrompt(character)
    if not character then return nil end
    for _, v in ipairs(character:GetDescendants()) do
        if v:IsA("ProximityPrompt") then
            local name = v.Name:lower()
            local action = (v.ActionText or ""):lower()
            if name:find("revive") or action:find("revive") or action:find("help") or action:find("carry") then
                return v
            end
        end
    end
    return nil
end

local function holdKey(key, duration)
    VirtualInputManager:SendKeyEvent(true, key, false, game)
    task.wait(duration)
    VirtualInputManager:SendKeyEvent(false, key, false, game)
end

local function autoReviveOthersLoop()
    task.spawn(function()
        while true do
            task.wait(0.4)
            if not Config.AutoReviveOthers or reviving or isGoingToTicket then continue end

            local hrp = getHRP()
            if not hrp then continue end

            for _, plr in ipairs(Players:GetPlayers()) do
                if plr == LocalPlayer then continue end
                local char = plr.Character
                if not char then continue end

                local downed, prompt = isDowned(char)
                if downed then
                    local targetRoot = char:FindFirstChild("HumanoidRootPart")
                    if not targetRoot then continue end

                    reviving = true

                    hrp.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3.5)
                    task.wait(0.12)

                    local revivePrompt = prompt or findRevivePrompt(char)
                    if revivePrompt then
                        pcall(function() revivePrompt:InputHoldBegin() end)
                        task.wait(Config.ReviveHoldTime)
                        pcall(function() revivePrompt:InputHoldEnd() end)
                    else
                        holdKey(Enum.KeyCode.E, Config.ReviveHoldTime)
                    end

                    if (Config.UnderMapFarm or Config.SkyFarm) and safePlatform then
                        returnToSafe()
                    end

                    reviving = false
                    task.wait(0.7)
                    break
                end
            end
        end
    end)
end

local function autoSelfReviveLoop()
    task.spawn(function()
        while true do
            task.wait(0.5)
            if not Config.AutoSelfRevive then continue end

            local char = LocalPlayer.Character
            if not char then continue end

            local downed = isDowned(char)
            if downed then
                pcall(function()
                    local Event = game:GetService("ReplicatedStorage").Events.SetPlayerMode
                    Event:FireServer(true)
                end)
                task.wait(2.5)
            end
        end
    end)
end


local noclipConn

local function setNoclip(state)
    if noclipConn then
        noclipConn:Disconnect()
        noclipConn = nil
    end
    if state then
        noclipConn = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in ipairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end)
    end
end


local originalSettings = {}
local hiddenPlayers = {}

local function setRemoveTextures(state)
    if state then
        for _, v in ipairs(workspace:GetDescendants()) do
            if v:IsA("Texture") or v:IsA("Decal") then
                pcall(function() v.Transparency = 1 end)
            end
            if v:IsA("MeshPart") then
                pcall(function() v.TextureID = "" end)
            end
        end
        if not getgenv().TextureHook then
            getgenv().TextureHook = workspace.DescendantAdded:Connect(function(v)
                if not Config.RemoveTextures then return end
                if v:IsA("Texture") or v:IsA("Decal") then
                    pcall(function() v.Transparency = 1 end)
                end
            end)
        end
    end
end

local function setHidePlayers(state)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr == LocalPlayer then continue end
        local char = plr.Character
        if char then
            for _, part in ipairs(char:GetDescendants()) do
                if part:IsA("BasePart") or part:IsA("Decal") or part:IsA("Texture") then
                    if state then
                        if not hiddenPlayers[part] then
                            hiddenPlayers[part] = part.LocalTransparencyModifier
                        end
                        part.LocalTransparencyModifier = 1
                    else
                        if hiddenPlayers[part] then
                            part.LocalTransparencyModifier = hiddenPlayers[part]
                        end
                    end
                end
            end
        end
    end
    if not state then
        table.clear(hiddenPlayers)
    end
end

local function setHideEffects(state)
    for _, v in ipairs(workspace:GetDescendants()) do
        if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") or v:IsA("Fire") or v:IsA("Smoke") or v:IsA("Sparkles") then
            v.Enabled = not state
        end
    end
end

local function setLowGFX(state)
    if state then
        originalSettings.QualityLevel = settings().Rendering.QualityLevel
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        pcall(function()
            settings().Rendering.MeshPartDetailLevel = Enum.MeshPartDetailLevel.Level01
        end)
    else
        if originalSettings.QualityLevel then
            settings().Rendering.QualityLevel = originalSettings.QualityLevel
        end
    end
end

local function setNoShadows(state)
    Lighting.GlobalShadows = not state
end

local function setFullbright(state)
    if state then
        originalSettings.Brightness = Lighting.Brightness
        originalSettings.ClockTime = Lighting.ClockTime
        originalSettings.FogEnd = Lighting.FogEnd
        originalSettings.GlobalShadows = Lighting.GlobalShadows
        originalSettings.OutdoorAmbient = Lighting.OutdoorAmbient

        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 100000
        Lighting.GlobalShadows = false
        Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
    else
        if originalSettings.Brightness then
            Lighting.Brightness = originalSettings.Brightness
            Lighting.ClockTime = originalSettings.ClockTime
            Lighting.FogEnd = originalSettings.FogEnd
            Lighting.GlobalShadows = originalSettings.GlobalShadows
            Lighting.OutdoorAmbient = originalSettings.OutdoorAmbient
        end
    end
end


local Window = Library:CreateWindow({
    Title = "PhiPhai v2 (openscr)",
    Footer = "https://discord.gg/6y7TpYTBkW",
    ToggleKeybind = Enum.KeyCode.RightControl,
    Center = true,
    AutoShow = true,
    NotifySide = "Right",
})

local Tabs = {
    Main = Window:AddTab("Main", "home"),
    Farm = Window:AddTab("Farm", "coins"),
    Revive = Window:AddTab("Revive", "heart"),
    FPS = Window:AddTab("FPS", "gauge"),
    Visual = Window:AddTab("Visual", "eye"),
    Misc = Window:AddTab("Misc", "settings"),
}


local MainLeft = Tabs.Main:AddLeftGroupbox("Nextbot")
local MainRight = Tabs.Main:AddRightGroupbox("Movement")

MainLeft:AddToggle("NextbotESP", {
    Text = "Nextbot ESP",
    Default = Config.NextbotESP,
    Callback = function(v)
        Config.NextbotESP = v
        if v then setupNextbotESP() else removeAllNextbotESP() end
    end
})

MainLeft:AddToggle("AntiNextbot", {
    Text = "Anti Nextbot",
    Default = Config.AntiNextbot,
    Callback = function(v) Config.AntiNextbot = v end
})

MainLeft:AddSlider("AntiDistance", {
    Text = "Anti Distance",
    Default = Config.AntiDistance,
    Min = 10, Max = 60, Rounding = 0,
    Callback = function(v) Config.AntiDistance = v end
})

MainRight:AddToggle("Noclip", {
    Text = "Noclip",
    Default = Config.Noclip,
    Callback = function(v)
        Config.Noclip = v
        setNoclip(v)
    end
})


local FarmLeft = Tabs.Farm:AddLeftGroupbox("Ticket Farm")
local FarmRight = Tabs.Farm:AddRightGroupbox("Safe Farm")

FarmLeft:AddToggle("FarmTickets", {
    Text = "Auto Farm Tickets",
    Default = Config.FarmTickets,
    Callback = function(v)
        Config.FarmTickets = v
        if v then farmTicketsLoop() end
    end
})

FarmLeft:AddDropdown("FarmMode", {
    Text = "Farm Mode",
    Values = {"TP", "Tween"},
    Default = Config.FarmMode,
    Callback = function(v) Config.FarmMode = v end
})

FarmLeft:AddSlider("FarmDelay", {
    Text = "Farm Delay",
    Default = Config.FarmDelay,
    Min = 1, Max = 10, Rounding = 2,
    Callback = function(v) Config.FarmDelay = v end
})

FarmLeft:AddSlider("TweenSpeed", {
    Text = "Tween Speed",
    Default = Config.TweenSpeed,
    Min = 5, Max = 30, Rounding = 0,
    Callback = function(v) Config.TweenSpeed = v end
})

FarmRight:AddToggle("UnderMapFarm", {
    Text = "Under Map Farm",
    Default = Config.UnderMapFarm,
    Callback = function(v)
        Config.UnderMapFarm = v
        if v then
            Config.SkyFarm = false
            createSafePlatform("under")
            Config.FarmTickets = true
            farmTicketsLoop()
            
        else
            if not Config.SkyFarm then destroySafePlatform() end
        end
    end
})

FarmRight:AddSlider("UnderMapY", {
    Text = "Under Map Y",
    Default = Config.UnderMapY,
    Min = -300, Max = -40, Rounding = 0,
    Callback = function(v)
        Config.UnderMapY = v
        if currentSafeMode == "under" and safePlatform then
            safePlatform.CFrame = CFrame.new(safePlatform.Position.X, v, safePlatform.Position.Z)
        end
    end
})

FarmRight:AddToggle("SkyFarm", {
    Text = "Sky Farm ",
    Default = Config.SkyFarm,
    Callback = function(v)
        Config.SkyFarm = v
        if v then
            Config.UnderMapFarm = false
            createSafePlatform("sky")
            Config.FarmTickets = true
            farmTicketsLoop()
            
        else
            if not Config.UnderMapFarm then destroySafePlatform() end
        end
    end
})

FarmRight:AddSlider("SkyY", {
    Text = "Sky Height",
    Default = Config.SkyY,
    Min = 150, Max = 600, Rounding = 0,
    Callback = function(v)
        Config.SkyY = v
        if currentSafeMode == "sky" and safePlatform then
            safePlatform.CFrame = CFrame.new(safePlatform.Position.X, v, safePlatform.Position.Z)
        end
    end
})

FarmRight:AddButton({
    Text = "button create Platform",
    Func = function()
        createSafePlatform(Config.SkyFarm and "sky" or "under")
        
    end
})

FarmRight:AddButton({
    Text = "del Platform",
    Func = function()
        destroySafePlatform()
        
    end
})


local ReviveLeft = Tabs.Revive:AddLeftGroupbox("Auto Revive")
local ReviveRight = Tabs.Revive:AddRightGroupbox("Settings")



ReviveLeft:AddToggle("AutoSelfRevive", {
    Text = "Auto Self Revive",
    Default = Config.AutoSelfRevive,
    Callback = function(v)
        Config.AutoSelfRevive = v
        if v then  end
    end
})

ReviveRight:AddSlider("ReviveHoldTime", {
    Text = "Hold Time ",
    Default = Config.ReviveHoldTime,
    Min = 2, Max = 8, Rounding = 1,
    Callback = function(v) Config.ReviveHoldTime = v end
})



local FPSLeft = Tabs.FPS:AddLeftGroupbox("FPS Boost")
local FPSRight = Tabs.FPS:AddRightGroupbox("Graphics")

FPSLeft:AddToggle("RemoveTextures", {
    Text = "dis Texture / Decal",
    Default = Config.RemoveTextures,
    Callback = function(v)
        Config.RemoveTextures = v
        setRemoveTextures(v)
        
    end
})

FPSLeft:AddToggle("HidePlayers", {
    Text = "hide Player",
    Default = Config.HidePlayers,
    Callback = function(v)
        Config.HidePlayers = v
        setHidePlayers(v)
    end
})

FPSLeft:AddToggle("HideEffects", {
    Text = "dis Particle",
    Default = Config.HideEffects,
    Callback = function(v)
        Config.HideEffects = v
        setHideEffects(v)
    end
})

FPSRight:AddToggle("LowGFX", {
    Text = "Low GFX ",
    Default = Config.LowGFX,
    Callback = function(v)
        Config.LowGFX = v
        setLowGFX(v)
    end
})

FPSRight:AddToggle("NoShadows", {
    Text = "dis Shadow",
    Default = Config.NoShadows,
    Callback = function(v)
        Config.NoShadows = v
        setNoShadows(v)
    end
})

FPSRight:AddToggle("Fullbright", {
    Text = "Fullbright",
    Default = Config.Fullbright,
    Callback = function(v)
        Config.Fullbright = v
        setFullbright(v)
    end
})

FPSLeft:AddButton({
    Text = "On All Boost FPS ",
    Func = function()
        Config.RemoveTextures = true
        Config.HidePlayers = true
        Config.HideEffects = true
        Config.LowGFX = true
        Config.NoShadows = true
        setRemoveTextures(true)
        setHidePlayers(true)
        setHideEffects(true)
        setLowGFX(true)
        setNoShadows(true)
        
    end
})


local VisualLeft = Tabs.Visual:AddLeftGroupbox("ESP")

VisualLeft:AddToggle("TicketESP", {
    Text = "Ticket ESP",
    Default = Config.TicketESP,
    Callback = function(v)
        Config.TicketESP = v
        if v then setupTicketESP() else removeAllTicketESP() end
    end
})

VisualLeft:AddToggle("ShowDistance", {
    Text = "Show Distance",
    Default = Config.ShowDistance,
    Callback = function(v) Config.ShowDistance = v end
})


local MiscLeft = Tabs.Misc:AddLeftGroupbox("Utility")

MiscLeft:AddButton({
    Text = "Refresh Folders",
    Func = function()
        BotFolder = findFolder({{"Players"}, {"Game", "Players"}, {"Game", "Bots"}})
        TicketsFolder = findFolder({{"Effects", "Tickets"}, {"Game", "Effects", "Tickets"}, {"Game", "Tickets"}})
        EffectsFolder = findFolder({{"Effects"}, {"Game", "Effects"}})
        Library:Notify("Bot: " .. (BotFolder and "OK" or "FAIL") .. " | Ticket: " .. (TicketsFolder and "OK" or "FAIL"), 3)
    end
})

MiscLeft:AddLabel("RightControl = Toggle UI")

ThemeManager:SetLibrary(Library)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({"MenuKeybind"})
ThemeManager:SetFolder("EvadeHub")
SaveManager:SetFolder("EvadeHub")
SaveManager:BuildConfigSection(Tabs.Misc)
ThemeManager:ApplyToTab(Tabs.Misc)


task.spawn(antiNextbotLoop)
autoReviveOthersLoop()
autoSelfReviveLoop()
