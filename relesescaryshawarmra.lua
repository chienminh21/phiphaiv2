
local cloneref = (cloneref or clonereference or function(instance)
	return instance
end)
local ReplicatedStorage = cloneref(game:GetService("ReplicatedStorage"))
local HttpService = cloneref(game:GetService("HttpService"))

local WindUI

do
	local ok, result = pcall(function()
		return require("./src/Init")
	end)

	if ok then
		WindUI = result
	else
		if cloneref(game:GetService("RunService")):IsStudio() then
			WindUI = require(cloneref(ReplicatedStorage:WaitForChild("WindUI"):WaitForChild("Init")))
		else
			WindUI =
				loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
		end
	end
end



local cloneref = cloneref or function(v) return v end

local Players = cloneref(game:GetService("Players"))
local RunService = cloneref(game:GetService("RunService"))
local TweenService = cloneref(game:GetService("TweenService"))
local UserInputService = cloneref(game:GetService("UserInputService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local HttpService = cloneref(game:GetService("HttpService"))

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local PlaceID = game.PlaceId









local Window = WindUI:CreateWindow({
    Title = "PhiPhai v2 | SSK ",
    Icon = "rbxassetid://133256696556004",
    Author = "by aaaaaaaa",
    Folder = "PPv2Save",
    Size = UDim2.fromOffset(540, 400),
    Transparent = true,
	--Background = "rbxassetid://1234",

    HideSearchBar = false,

    OpenButton = {
        Title = "PPV2",
        CornerRadius = UDim.new(0,16),
        StrokeThickness = 2,
        Enabled = true,
        Draggable = true,
        OnlyMobile = false,
        

        Color = ColorSequence.new(
            Color3.fromHex("#850c0c"),
            Color3.fromHex("#400101")
        ),
    },

    Topbar = {
        Height = 44,
        ButtonsType = "Mac",
    },
})

WindUI:SetTheme("Crimson")
if Window then
    Window:Tag({
        Title = "Main Version",
        Color = Color3.fromHex("#400101"),
        Radius = 5,
    })
else
    warn("WindUI failed to load")
end







local MainTab = Window:Tab({
    Title = "Main",
    Icon = "rbxassetid://85279746515974", 
})



local ShawarmaCFG = {}

ShawarmaCFG.Enabled = false
ShawarmaCFG.PromptList = {}


local function Shawarma_FirePrompt(pr)
    if pr and pr:IsA("ProximityPrompt") then
        pr.HoldDuration = 0
        pcall(function()
            fireproximityprompt(pr)
        end)
        task.wait(0.2)
    end
end


local function Shawarma_AddPrompt(tbl, obj)
    if obj then
        local pr = obj:FindFirstChildOfClass("ProximityPrompt")
        if pr then
            table.insert(tbl, pr)
        end
    end
end

local ShawarmaSection = MainTab:Section({
    Title = "Shawarma"
})

ShawarmaSection:Toggle({
    Title = "Auto Make Shawarma",
    Value = false,
    Callback = function(v)
        ShawarmaCFG.Enabled = v
    end
})


task.spawn(function()
    while true do
        task.wait(0.5)

        if not ShawarmaCFG.Enabled then continue end

        local list = {}

      local kit = workspace:FindFirstChild("Kit")
        if kit then
            Shawarma_AddPrompt(list, kit:FindFirstChild("Salad") and kit.Salad:FindFirstChild("Button"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("Lavash") and kit.Lavash:FindFirstChild("Button"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("Cheese") and kit.Cheese:FindFirstChild("Button"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("Fry") and kit.Fry:FindFirstChild("Button"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("Sauce") and kit.Sauce:FindFirstChild("Button"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("Board"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("popcan"))
            Shawarma_AddPrompt(list, kit:FindFirstChild("Done") and kit.Done:FindFirstChild("Lavash"))
        end

        local kebab = workspace:FindFirstChild("Kebab")
        if kebab and kebab:FindFirstChild("kebabmyaso") then
            Shawarma_AddPrompt(list, kebab.kebabmyaso:FindFirstChild("Kebab.040"))
        end

      
        local cans = workspace:FindFirstChild("Cans")
        if cans then

            
            local promptsFolder = cans:FindFirstChild("Prompts")
            if promptsFolder then
                for i = 1, 99 do
                    Shawarma_AddPrompt(list, promptsFolder:FindFirstChild("popcan"..i))
                end
            end

            
            local coffee = cans:FindFirstChild("Coffee")
            if coffee then
                local pr = coffee:FindFirstChildOfClass("ProximityPrompt")
                if pr then
                    table.insert(list, pr)
                end
            end
        end

        
        for _,pr in ipairs(list) do
            if not ShawarmaCFG.Enabled then break end
            Shawarma_FirePrompt(pr)
        end
    end
end)




local AutoSpamSection = MainTab:Section({
    Title = "Auto Spam"
})
local function getPrompt(path)

    local obj = workspace

    for _,v in ipairs(path) do

        obj = obj and obj:FindFirstChild(v)

    end

    return obj and obj:FindFirstChildOfClass("ProximityPrompt")

end


local AutoGarge = false

local GargeDelay = 0.3

AutoSpamSection:Toggle({

    Title = "Auto Press Garge",

    Value = false,

    Callback = function(v)

        AutoGarge = v

    end

})

AutoSpamSection:Slider({

    Title = "Garge Delay",

    Value = {Default = 0.3, Min = 0.05, Max = 5, Rounding = 2},

    Callback = function(v)

        GargeDelay = v

    end

})

task.spawn(function()

    while true do

        if AutoGarge then

            local prompt = getPrompt({"Kit","Garge","Button"})

            firePrompt(prompt)

        end

        task.wait(GargeDelay)

    end

end)



local AutoClear = false

local ClearDelay = 0.05

local lastFire = 0

local clearConn

local cachedClear

AutoSpamSection:Toggle({

    Title = "Auto Clear",

    Value = false,

    Callback = function(v)

        AutoClear = v

        lastFire = 0

        if clearConn then

            clearConn:Disconnect()

            clearConn = nil

        end

        if not v then

            cachedClear = nil

            return

        end

        clearConn = RunService.Heartbeat:Connect(function()

            if not AutoClear then return end

            if not cachedClear or not cachedClear.Parent then

                cachedClear = getPrompt({"Hum","Man32","shawerma","D3"})

            end

            if cachedClear and tick() - lastFire >= ClearDelay then

                firePrompt(cachedClear)

                lastFire = tick()

            end

        end)

    end

})

AutoSpamSection:Slider({

    Title = "Auto Clear Speed",

    Value = {Default = 0.05, Min = 0.01, Max = 5, Rounding = 2},

    Callback = function(v)

        ClearDelay = v

    end

})


local AutoKebab = false

local KebabDelay = 5

AutoSpamSection:Toggle({

    Title = "Auto Get Meat",

    Value = false,

    Callback = function(v)

        AutoKebab = v

    end

})

AutoSpamSection:Slider({

    Title = "Kebab Delay (S)",

    Value = {Default = 5, Min = 1, Max = 999, Rounding = 0},

    Callback = function(v)

        KebabDelay = v

    end

})

task.spawn(function()

    while true do

        if AutoKebab then

            local prompt = getPrompt({"Kebab","kebabmyaso","Kebab.040"})

            firePrompt(prompt)

        end

        task.wait(KebabDelay)

    end

end)



local AutomaticTab = Window:Tab({
    Title = "Automatic",
    Icon = "rbxassetid://88340703117751", 
})

local MiscTab = Window:Tab({
    Title = "MiscTab",
    Icon = "rbxassetid://131043568838758", 
})


local SectionMisc = MiscTab:Section({
    Title = "Misc",
    Opened = false
})


local AntiVoid = false
local VoidPart

local function createVoid()
    if VoidPart then return end

    VoidPart = Instance.new("Part")
    VoidPart.Name = "AntiVoid"
    VoidPart.Anchored = true
    VoidPart.CanCollide = true
    VoidPart.Size = Vector3.new(5000, 10, 5000)
    VoidPart.Position = Vector3.new(0, -60, 0)
    VoidPart.Transparency = 0.7
    VoidPart.Parent = workspace
end


local function removeVoid()
    if VoidPart then
        VoidPart:Destroy()
        VoidPart = nil
    end
end

RunService.Heartbeat:Connect(function()
    if not AntiVoid then return end

    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if hrp and hrp.Position.Y < -80 then
        hrp.CFrame = CFrame.new(hrp.Position.X, 30, hrp.Position.Z)
    end
end)

SectionMisc:Toggle({
    Title = "Anti Void",
    Value = false,
    Callback = function(v)
        AntiVoid = v

        if v then
            createVoid()
        else
            removeVoid()
        end
    end
})


local AntiFall = false
local Tweening = false

local function smoothTP(hrp, targetPos)
    if Tweening then return end
    Tweening = true

    local dist = (hrp.Position - targetPos).Magnitude
    local time = math.clamp(dist / 50, 0.1, 0.5)

    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(time, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
        { CFrame = CFrame.new(targetPos) }
    )

    tween:Play()
    tween.Completed:Wait()

    Tweening = false
end


RunService.Heartbeat:Connect(function()
    if not AntiFall then return end

    local char = player.Character
    local hrp = char and char:FindFirstChild("HumanoidRootPart")

    if hrp and hrp.Position.Y < -80 then
        smoothTP(hrp, Vector3.new(hrp.Position.X, 30, hrp.Position.Z))
    end
end)

local function setupChar(char)
    local hum = char:WaitForChild("Humanoid")
    local hrp = char:WaitForChild("HumanoidRootPart")

    hum.Died:Connect(function()
        if not AntiFall then return end
        task.wait(0.1)

        
        if hrp then
            hrp.CFrame = CFrame.new(0, 50, 0)
        end
    end)
end


player.CharacterAdded:Connect(setupChar)

if player.Character then
    setupChar(player.Character)
end

SectionMisc:Toggle({
    Title = "Anti Fall",
    Value = false,
    Callback = function(v)
        AntiFall = v
    end
})

local Lighting = game:GetService("Lighting")


local fullbright = false

local oldLighting = {
    Brightness = Lighting.Brightness,
    ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd,
    GlobalShadows = Lighting.GlobalShadows
}


local function applyFullBright()

    Lighting.Brightness = 5
    Lighting.ClockTime = 12
    Lighting.FogEnd = 10
    Lighting.GlobalShadows = false

end


task.spawn(function()

    while true do

        if fullbright then
            applyFullBright()
        end

        task.wait(1)

    end

end)


SectionMisc:Toggle({
    Title = "FullBright",
    Value = false,
	Desc = "",

    Callback = function(v)

        fullbright = v

        if v then

            applyFullBright()

        else

            Lighting.Brightness = oldLighting.Brightness
            Lighting.ClockTime = oldLighting.ClockTime
            Lighting.FogEnd = oldLighting.FogEnd
            Lighting.GlobalShadows = oldLighting.GlobalShadows

        end

    end
})


_G.WindShiftlock = false



local connection

local function setShiftlock(state)
	_G.WindShiftlock = state
	
	if connection then
		connection:Disconnect()
		connection = nil
	end
	
	if state then
		UserInputService.MouseBehavior = Enum.MouseBehavior.LockCenter
		
		connection = RunService.RenderStepped:Connect(function()
			local char = player.Character
			local root = char and char:FindFirstChild("HumanoidRootPart")
			if root then
				local camCF = camera.CFrame
				root.CFrame = CFrame.new(root.Position, Vector3.new(
					camCF.LookVector.X + root.Position.X,
					root.Position.Y,
					camCF.LookVector.Z + root.Position.Z
				))
			end
		end)
	else
		UserInputService.MouseBehavior = Enum.MouseBehavior.Default
	end
end

SectionMisc:Toggle({
	Title = "Shiftlock",
	Default = false,
	Callback = function(state)
		setShiftlock(state)
	end
})



local enabled = false

local function setCameraClip(state)
    enabled = state

    if state then
        
        player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
        
        
        camera.CameraType = Enum.CameraType.Custom
    else
        
        player.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
    end
end



_G.CameraClip = setCameraClip
SectionMisc:Toggle({
    Title = "Camera Noclip",
    Callback = function(v)
        _G.CameraClip(v)
    end
})







local SavedWS = 16
local SavedJP = 50
local SavedFOV = camera.FieldOfView
local SavedGravity = workspace.Gravity
local SavedZoom = player.CameraMaxZoomDistance

local DefaultWS = 16
local DefaultJP = 50
local DefaultFOV = camera.FieldOfView
local DefaultGravity = workspace.Gravity
local DefaultZoom = player.CameraMaxZoomDistance

local SelectedReset = {}
local InfJump = false

local function getDefaultStats()
    local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        DefaultWS = hum.WalkSpeed
        DefaultJP = hum.JumpPower
    end
end

local function applyStats(char)
    local hum = char:WaitForChild("Humanoid")
    hum.WalkSpeed = SavedWS
    hum.JumpPower = SavedJP
end

local function applyFOV()
    camera.FieldOfView = SavedFOV
end

local function applyGravity()
    workspace.Gravity = SavedGravity
end

local function applyZoom()
    player.CameraMaxZoomDistance = SavedZoom
end

local PlayerSection = MiscTab:Section({
    Title = "Player",
    Opened = false
})

PlayerSection:Slider({
    Title = "WalkSpeed",
    Value = {Default = SavedWS, Min = 1, Max = 350},
    Callback = function(v)
        SavedWS = v
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.WalkSpeed = v end
    end
})

PlayerSection:Slider({
    Title = "JumpPower",
    Value = {Default = SavedJP, Min = 1, Max = 350},
    Callback = function(v)
        SavedJP = v
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
        if hum then hum.JumpPower = v end
    end
})

PlayerSection:Slider({
    Title = "FOV",
    Value = {Default = SavedFOV, Min = 70, Max = 120},
    Callback = function(v)
        SavedFOV = v
        applyFOV()
    end
})

PlayerSection:Slider({
    Title = "Gravity",
    Value = {Default = SavedGravity, Min = 0, Max = 300},
    Callback = function(v)
        SavedGravity = v
        applyGravity()
    end
})

PlayerSection:Slider({
    Title = "Max Zoom",
    Value = {Default = SavedZoom, Min = 0, Max = 1000},
    Callback = function(v)
        SavedZoom = v
        applyZoom()
    end
})

PlayerSection:Toggle({
    Title = "Infinite Jump",
    Default = false,
    Callback = function(v)
        InfJump = v
    end
})

UserInputService.JumpRequest:Connect(function()

    if not InfJump then return end

    local char = player.Character

    if not char then return end

    local hum = char:FindFirstChildOfClass("Humanoid")

    if not hum then return end

    hum:ChangeState(Enum.HumanoidStateType.Jumping)

end)

PlayerSection:Dropdown({
    Title = "Select Reset",
    Values = {"WalkSpeed","JumpPower","FOV","Gravity","Zoom"},
    Value = {},
    Multi = true,
    Callback = function(selected)
        SelectedReset = selected
    end
})

PlayerSection:Button({
    Title = "Reset Value",
    Callback = function()
        local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")

        for _,v in pairs(SelectedReset) do
            if v == "WalkSpeed" then
                SavedWS = DefaultWS
                if hum then hum.WalkSpeed = DefaultWS end
            end

            if v == "JumpPower" then
                SavedJP = DefaultJP
                if hum then hum.JumpPower = DefaultJP end
            end

            if v == "FOV" then
                SavedFOV = DefaultFOV
                applyFOV()
            end

            if v == "Gravity" then
                SavedGravity = DefaultGravity
                applyGravity()
            end

            if v == "Zoom" then
                SavedZoom = DefaultZoom
                applyZoom()
            end

            if v == "InfJump" then
                InfJump = false
            end
        end
    end
})



player.CharacterAdded:Connect(function(char)
    task.wait(0.3)
    getDefaultStats()
    applyStats(char)
end)

getDefaultStats()
applyFOV()
applyGravity()
applyZoom()


local NoCollide = false
local connection

local function applyNoCollide()
    if connection then connection:Disconnect() end

    connection = RunService.Heartbeat:Connect(function()
        if not NoCollide then return end

        local myChar = player.Character
        if not myChar then return end

        for _,plr in pairs(Players:GetPlayers()) do
            if plr ~= player and plr.Character then
                for _,part in pairs(plr.Character:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
                end
            end
        end
    end)
end

local function resetCollide()
    for _,plr in pairs(Players:GetPlayers()) do
        if plr.Character then
            for _,part in pairs(plr.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end

PlayerSection:Toggle({
    Title = "AntiFling",
    Default = false,
    Callback = function(v)
        NoCollide = v

        if v then
            applyNoCollide()
        else
            if connection then
                connection:Disconnect()
                connection = nil
            end
            resetCollide()
        end
    end
})

player.CharacterAdded:Connect(function()
    task.wait(0.5)
    if NoCollide then
        applyNoCollide()
    end
end)
local InvisSection = MiscTab:Section({
    Title = "Invisible",
})


local Character, Humanoid, HRP
local IsInvisible = false
local VisibleParts = {}


local function SetupCharacter()
    Character = player.Character or player.CharacterAdded:Wait()
    Humanoid = Character:WaitForChild("Humanoid")
    HRP = Character:WaitForChild("HumanoidRootPart")

    VisibleParts = {}

    for _,v in pairs(Character:GetDescendants()) do
        if v:IsA("BasePart") and v.Transparency == 0 then
            table.insert(VisibleParts, v)
        end
    end
end

SetupCharacter()


local InvisToggle
local CurrentKey = Enum.KeyCode.Z

local function SetInvisible(state)
    IsInvisible = state
    local t = IsInvisible and 0.5 or 0
    for _,part in pairs(VisibleParts) do
        part.Transparency = t
    end
end

InvisToggle = InvisSection:Toggle({
    Title = "Invisible",
    Default = false,
    Callback = function(v)
        SetInvisible(v)
    end
})

InvisSection:Keybind({
    Title = "Keybind",
    Value = "Z",
    Callback = function(key)
        CurrentKey = Enum.KeyCode[key]
    end
})

game:GetService("UserInputService").InputBegan:Connect(function(input, gpe)
    if gpe then return end

    if input.KeyCode == CurrentKey then
        local newState = not IsInvisible
        SetInvisible(newState)
        InvisToggle:Set(newState)
    end
end)


RunService.Heartbeat:Connect(function()
    if IsInvisible and HRP then
        local oldCF = HRP.CFrame
        local oldOffset = Humanoid.CameraOffset

        local down = oldCF * CFrame.new(0,-200000,0)

        HRP.CFrame = down
        Humanoid.CameraOffset = down:ToObjectSpace(CFrame.new(oldCF.Position)).Position

        RunService.RenderStepped:Wait()

        HRP.CFrame = oldCF
        Humanoid.CameraOffset = oldOffset
    end
end)


player.CharacterAdded:Connect(function()
    IsInvisible = false
    SetupCharacter()
end)





local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "rbxassetid://136634387104334", 
})

local ESPPSection = ESPTab:Section({
    Title = "ESP Player",
    Opened = false
})



local BoxColor = Color3.fromRGB(0,0,0)
local TracerColor = Color3.fromRGB(0,0,0)
local HighlightColor = Color3.fromRGB(0, 0, 0)


local ESPEnabled = true
local BoxEnabled = false
local Tracers = false
local Team_Check = false
local HighlightEnabled = false
local HighlightPower = 1


ESPPSection:Toggle({
    Title = "Enable ESP",
    Default = true,
	Locked = true,
    Callback = function(v)
        ESPEnabled = v
    end
})

ESPPSection:Toggle({
    Title = "Box ESP",
    Default = false,
    Callback = function(v)
        BoxEnabled = v
    end
})

ESPPSection:Toggle({
    Title = "Tracer",
    Default = false,
    Callback = function(v)
        Tracers = v
    end
})

ESPPSection:Toggle({
    Title = "Highlight",
    Default = false,
    Callback = function(v)
        HighlightEnabled = v
    end
})

ESPPSection:Slider({
    Title = "Highlight Value",
	Desc = "1 = outline 10 = highlight", 
    Value = {Min = 1, Max = 10, Default = 1},
    Callback = function(v)
        HighlightPower = v
    end
})

ESPPSection:Toggle({
    Title = "Team Check",
    Default = false,
	Locked = true,
    Callback = function(v)
        Team_Check = v
    end
})

ESPPSection:Colorpicker({
    Title = "Box Color",
    Default = BoxColor,
    Callback = function(color)
        BoxColor = color
    end
})

ESPPSection:Colorpicker({
    Title = "Tracer Color",
    Default = TracerColor,
    Callback = function(color)
        TracerColor = color
    end
})

ESPPSection:Colorpicker({
    Title = "Highlight Color",
    Default = HighlightColor,
    Callback = function(color)
        HighlightColor = color
    end
})



local linesTable = {}

local function isEnemy(plr)
    if not Team_Check then return true end
    if not player.Team or not plr.Team then return true end
    return plr.Team ~= player.Team
end


local function applyHighlight(plr)
    local char = plr.Character
    if not char then return end

    local hl = char:FindFirstChild("HL")

    if not hl then
        hl = Instance.new("Highlight")
        hl.Name = "HL"
        hl.Parent = char
    end

   
    hl.FillColor = HighlightColor
    hl.OutlineColor = HighlightColor

    
    local alpha = HighlightPower / 10

    hl.FillTransparency = 1 - alpha   
    hl.OutlineTransparency = 0        

    
    if HighlightPower <= 1 then
        hl.FillTransparency = 1
    end
end

local function removeHighlight(plr)
    local char = plr.Character
    if char and char:FindFirstChild("HL") then
        char.HL:Destroy()
    end
end

local function CreateESP(plr)
    local lines = {}

    for i = 1, 12 do
        local l = Drawing.new("Line")
        l.Visible = false
        l.Thickness = 1.5
        table.insert(lines, l)
    end

    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = 1.5
    table.insert(lines, tracer)

    linesTable[plr] = lines
end


for _,plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        CreateESP(plr)
    end
end

Players.PlayerAdded:Connect(function(plr)
    if plr ~= player then
        CreateESP(plr)
    end
end)

Players.PlayerRemoving:Connect(function(plr)
    removeHighlight(plr)
end)

RunService.RenderStepped:Connect(function()

    for plr, lines in pairs(linesTable) do

        
        if not ESPEnabled then
            for _,l in pairs(lines) do
                l.Visible = false
            end
            removeHighlight(plr)
            continue
        end

       
        if Team_Check and not isEnemy(plr) then
            for _,l in pairs(lines) do
                l.Visible = false
            end
            removeHighlight(plr)
            continue
        end

        
        if HighlightEnabled then
            applyHighlight(plr)
        else
            removeHighlight(plr)
        end

        
        if plr.Character
        and plr.Character:FindFirstChild("HumanoidRootPart")
        and plr.Character:FindFirstChild("Head")
        and plr.Character:FindFirstChild("Humanoid")
        and plr.Character.Humanoid.Health > 0 then

            local hrp = plr.Character.HumanoidRootPart
            local head = plr.Character.Head

            local rootPos, vis = camera:WorldToViewportPoint(hrp.Position)

            if vis then

                local scale = head.Size.Y/2
                local size = Vector3.new(2,3,1.5) * (scale*2)

                local corners = {
                    hrp.CFrame * CFrame.new(-size.X, size.Y, -size.Z),
                    hrp.CFrame * CFrame.new(-size.X, size.Y, size.Z),
                    hrp.CFrame * CFrame.new(size.X, size.Y, size.Z),
                    hrp.CFrame * CFrame.new(size.X, size.Y, -size.Z),
                    hrp.CFrame * CFrame.new(-size.X,-size.Y,-size.Z),
                    hrp.CFrame * CFrame.new(-size.X,-size.Y,size.Z),
                    hrp.CFrame * CFrame.new(size.X,-size.Y,size.Z),
                    hrp.CFrame * CFrame.new(size.X,-size.Y,-size.Z)
                }

                local screenCorners = {}

                for _,v in pairs(corners) do
                    local p = camera:WorldToViewportPoint(v.Position)
                    table.insert(screenCorners, Vector2.new(p.X,p.Y))
                end

                local edges = {
                    {1,2},{2,3},{3,4},{4,1},
                    {5,6},{6,7},{7,8},{8,5},
                    {1,5},{2,6},{3,7},{4,8}
                }

                
                if BoxEnabled then
                    for i,edge in pairs(edges) do
                        lines[i].From = screenCorners[edge[1]]
                        lines[i].To   = screenCorners[edge[2]]
                        lines[i].Color = BoxColor
                        lines[i].Visible = true
                    end
                else
                    for i=1,12 do
                        lines[i].Visible = false
                    end
                end

                
                local tracer = lines[13]

                if Tracers then
                    tracer.From = Vector2.new(
                        camera.ViewportSize.X/2,
                        camera.ViewportSize.Y
                    )
                    tracer.To = Vector2.new(rootPos.X, rootPos.Y)
                    tracer.Color = TracerColor
                    tracer.Visible = true
                else
                    tracer.Visible = false
                end

            else
                for _,l in pairs(lines) do
                    l.Visible = false
                end
            end

        else
            for _,l in pairs(lines) do
                l.Visible = false
            end
        end
    end
end)

local NoteTab = Window:Tab({
    Title = "Note",
    Icon = "rbxassetid://93088734606782", 
})

local ServerTab = Window:Tab({
    Title = "Server",
    Icon = "rbxassetid://73788556017609", 
})

local SectionJoin = ServerTab:Section({
    Title = "Jobid",
    Opened = false
})

local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local JobId = game.JobId
local PlaceId = game.PlaceId

local InputJobId = ""


SectionJoin:Input({
    Title = "Enter JobId",
    Placeholder = "Paste JobId here...",
    Callback = function(text)
        InputJobId = text
    end
})


SectionJoin:Button({
    Title = "Copy JobId",
    Callback = function()
        if setclipboard then
            setclipboard(JobId)
            print("Copied JobId:", JobId)
        else
            warn("Executor does not support setclipboard")
        end
    end
})


SectionJoin:Button({
    Title = "Join JobId",
    Callback = function()
        if InputJobId ~= "" then
            TeleportService:TeleportToPlaceInstance(PlaceId, InputJobId, player)
        else
            warn("Haven't entered JobId")
        end
    end
})


local visitedServers = {}
local hopping = false

local function notify(msg)
    if Window and Window.Notify then
        Window:Notify({
            Title = "Server",
            Content = msg,
            Duration = 3
        })
    else
        print(msg)
    end
end

local function getServers()
    local servers = {}

    local success, result = pcall(function()
        return game:HttpGet(
            "https://games.roblox.com/v1/games/"..PlaceID.."/servers/Public?sortOrder=Asc&limit=100"
        )
    end)

    if success then
        local data = HttpService:JSONDecode(result)

        for _,v in pairs(data.data) do
            if v.playing < v.maxPlayers and not visitedServers[v.id] then
                table.insert(servers, v)
            end
        end
    end

    return servers
end

local function HopLow()
    if hopping then return end
    hopping = true

    notify("Finding low server...")

    local servers = getServers()

    if #servers > 0 then
        table.sort(servers, function(a,b)
            return a.playing < b.playing
        end)

        local target = servers[1]
        visitedServers[target.id] = true

        task.wait(1)
        TeleportService:TeleportToPlaceInstance(PlaceID, target.id, LP)
    else
        notify("No server found")
        hopping = false
    end
end

local function HopRandom()
    if hopping then return end
    hopping = true

    notify("Finding random server...")

    local servers = getServers()

    if #servers > 0 then
        local target = servers[math.random(1,#servers)]
        visitedServers[target.id] = true

        task.wait(1)
        TeleportService:TeleportToPlaceInstance(PlaceID, target.id, LP)
    else
        notify("No server found")
        hopping = false
    end
end

local function Rejoin()
    if hopping then return end
    hopping = true

    notify("Rejoining...")

    task.wait(1)
    TeleportService:Teleport(PlaceID, LP)
end

local Left = ServerTab:Group({
    Title = "Server"
})

local Right = ServerTab:Group({
    Title = ""
})

Left:Button({
    Title = "Low Server",
    Callback = function()
        HopLow()
    end
})

Right:Button({
    Title = "Hop Server",
    Callback = function()
        HopRandom()
    end
})

Left:Button({
    Title = "Rejoin",
    Callback = function()
        Rejoin()
    end
})



local DiscordTab = Window:Tab({
    Title = "Discord",
    Icon = "rbxassetid://97506778710114", 
})

local DiscordSection = DiscordTab:Section({
    Title = "Community"
})

DiscordSection:Button({
    Title = "Copy Discord Invite",
    Desc = "GA key in Discord",
    Icon = "message-circle-more",
    IconAlign = "Left",
    Color = Color3.fromRGB(0, 0, 0),
    Justify = "Between",

    Callback = function()
        local link = "https://discord.gg/6y7TpYTBkW"

        if setclipboard then
            setclipboard(link)
        elseif toclipboard then
            toclipboard(link)
        end

        Window:Notify({
            Title = "Discord",
            Content = "Invite link copied to clipboard!",
            Duration = 3
        })
    end
})
