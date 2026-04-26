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
    Title = "PhiPhai v2 | TestUiWibu ",
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







local AutoTab = Window:Tab({
    Title = "Main",
    Icon = "rbxassetid://85279746515974", 
})


------------------------------------------------
-- UTILITY
------------------------------------------------
local function firePrompt(prompt)
    if prompt and prompt:IsA("ProximityPrompt") then
        prompt.HoldDuration = 0
        pcall(function()
            fireproximityprompt(prompt)
        end)
        task.wait(0.2)
    end
end

------------------------------------------------
-- UI
------------------------------------------------
local AutoShawarmaSection = AutoTab:Section({ Title = "Auto Shawarma" })

local AutoShawarma = false

AutoShawarmaSection:Toggle({
    Title = "Auto Make Shawarma",
    Value = false,
    Callback = function(v)
        AutoShawarma = v
    end
})

------------------------------------------------
-- LOOP
------------------------------------------------
task.spawn(function()
    while true do
        task.wait(0.5)
        if not AutoShawarma then continue end

        local prompts = {}

        local function addPrompt(obj)
            if obj then
                local p = obj:FindFirstChildOfClass("ProximityPrompt")
                if p then
                    table.insert(prompts, p)
                end
            end
        end

        ------------------------------------------------
        -- KIT
        ------------------------------------------------
        local kit = workspace:FindFirstChild("Kit")
        if kit then
            addPrompt(kit:FindFirstChild("Salad") and kit.Salad:FindFirstChild("Button"))
            addPrompt(kit:FindFirstChild("Lavash") and kit.Lavash:FindFirstChild("Button"))
            addPrompt(kit:FindFirstChild("Cheese") and kit.Cheese:FindFirstChild("Button"))
            addPrompt(kit:FindFirstChild("Fry") and kit.Fry:FindFirstChild("Button"))
            addPrompt(kit:FindFirstChild("Sauce") and kit.Sauce:FindFirstChild("Button"))
            addPrompt(kit:FindFirstChild("Board"))
            addPrompt(kit:FindFirstChild("popcan"))
            addPrompt(kit:FindFirstChild("Done") and kit.Done:FindFirstChild("Lavash"))
        end

        ------------------------------------------------
        -- KEBAB
        ------------------------------------------------
        local kebab = workspace:FindFirstChild("Kebab")
        if kebab and kebab:FindFirstChild("kebabmyaso") then
            addPrompt(
                kebab.kebabmyaso:FindFirstChild("Kebab.040")
            )
        end

        ------------------------------------------------
        -- CANS (POP)
        ------------------------------------------------
        local cans = workspace:FindFirstChild("Cans")
        if cans then

            -- 🔥 POP CAN
            if cans:FindFirstChild("Prompts") then
                for i = 1, 99 do
                    addPrompt(cans.Prompts:FindFirstChild("popcan" .. i))
                end
            end

            -- 🔥 COFFEE (THÊM Ở ĐÂY)
            if cans:FindFirstChild("Coffee") then
                local coffeePrompt = cans.Coffee:FindFirstChildOfClass("ProximityPrompt")
                if coffeePrompt then
                    table.insert(prompts, coffeePrompt)
                end
            end

        end

        ------------------------------------------------
        -- FIRE ALL
        ------------------------------------------------
        for _, p in ipairs(prompts) do
            if not AutoShawarma then break end
            firePrompt(p)
        end
    end
end)

------------------------------------------------
-- SECTION : AUTO SPAM
------------------------------------------------
local AutoSpamSection = AutoTab:Section({ Title = "Auto Spam" })

------------------------------------------------
-- AUTO PRESS GARGE
------------------------------------------------
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
    Value = {
        Default = 0.3,
        Min = 0.05,
        Max = 5,
        Rounding = 2
    },
    Callback = function(v)
        GargeDelay = v
    end
})

task.spawn(function()
    while true do
        task.wait(GargeDelay)
        if not AutoGarge then continue end

        local prompt =
            workspace:FindFirstChild("Kit")
            and workspace.Kit:FindFirstChild("Garge")
            and workspace.Kit.Garge:FindFirstChild("Button")
            and workspace.Kit.Garge.Button:FindFirstChildOfClass("ProximityPrompt")

        firePrompt(prompt)
    end
end)

------------------------------------------------
-- AUTO CLEAR
------------------------------------------------
local RunService = game:GetService("RunService")

local AutoClear = false
local ClearDelay = 0.05
local lastFire = 0
local connection
local CachedPrompt

local function getClearPrompt()
    local hum = workspace:FindFirstChild("Hum")
    local man32 = hum and hum:FindFirstChild("Man32")
    local shawerma = man32 and man32:FindFirstChild("shawerma")
    local d3 = shawerma and shawerma:FindFirstChild("D3")
    return d3 and d3:FindFirstChildOfClass("ProximityPrompt")
end

AutoSpamSection:Toggle({
    Title = "Auto Clear",
    Value = false,
    Callback = function(v)
        AutoClear = v
        lastFire = 0

        if not v then
            if connection then
                connection:Disconnect()
                connection = nil
            end
            CachedPrompt = nil
            return
        end

        connection = RunService.Heartbeat:Connect(function()
            if not AutoClear then return end

            if not CachedPrompt or not CachedPrompt.Parent then
                CachedPrompt = getClearPrompt()
            end

            if CachedPrompt and tick() - lastFire >= ClearDelay then
                firePrompt(CachedPrompt)
                lastFire = tick()
            end
        end)
    end
})

AutoSpamSection:Slider({
    Title = "Auto Clear Speed",
    Value = {
        Default = 0.05,
        Min = 0.01,
        Max = 5,
        Rounding = 2
    },
    Callback = function(v)
        ClearDelay = v
    end
})

------------------------------------------------
-- AUTO GET MEAT
------------------------------------------------
local AutoKebab = false
local KebabDelay = 5

AutoSpamSection:Toggle({
    Title = "Auto Get Meat",
    Desc = "Automatically get kebab meat",
    Icon = "drumstick",
    Value = false,
    Callback = function(v)
        AutoKebab = v
    end
})

AutoSpamSection:Slider({
    Title = "Kebab Delay (S)",
    Value = {
        Default = 5,
        Min = 1,
        Max = 999,
        Rounding = 0
    },
    Callback = function(v)
        KebabDelay = v
    end
})

task.spawn(function()
    while true do
        task.wait(KebabDelay)
        if not AutoKebab then continue end

        local kebab = workspace:FindFirstChild("Kebab")
        local myaso = kebab and kebab:FindFirstChild("kebabmyaso")
        local meat = myaso and myaso:FindFirstChild("Kebab.040")
        local prompt = meat and meat:FindFirstChildOfClass("ProximityPrompt")

        firePrompt(prompt)
    end
end)


------------------------------------------------
-- SECTION : EVENT
------------------------------------------------
local EventSection = AutoTab:Section({ Title = "Event" })

------------------------------------------------
-- AUTO FIX TALL MAN EVENT
------------------------------------------------
EventSection:Button({
    Title = "Auto Fix Tall Man Event",
    Icon = "zap",
    Callback = function()
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        local function tpAndPress(prompt)
            if not (prompt and prompt:IsA("ProximityPrompt")) then return end
            local part = prompt.Parent
            if not part:IsA("BasePart") then return end

            hrp.CFrame = part.CFrame * CFrame.new(0, 0, -3)
            task.wait(0.15)
            firePrompt(prompt)
        end

        tpAndPress(
            workspace:FindFirstChild("Damaged_Trash")
            and workspace.Damaged_Trash:FindFirstChild("can")
            and workspace.Damaged_Trash.can:FindFirstChildOfClass("ProximityPrompt")
        )

        task.wait(0.3)

        tpAndPress(
            workspace:FindFirstChild("PowerBox")
            and workspace.PowerBox:FindFirstChild("Handle")
            and workspace.PowerBox.Handle:FindFirstChildOfClass("ProximityPrompt")
        )
    end
})

------------------------------------------------
-- AUTO EVENT MEAT ANOMALY
------------------------------------------------
EventSection:Button({
    Title = "Auto Event Meat Anomaly",
    Desc = "Do not click twice",
    Icon = "zap",
    Callback = function()

        local Players = game:GetService("Players")
        local ProximityPromptService = game:GetService("ProximityPromptService")

        local player = Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local hum = char:WaitForChild("Humanoid")

        local AutoInteract = true
        local promptConn

        ------------------------------------------------
        -- AUTO PROMPT
        ------------------------------------------------

        promptConn = ProximityPromptService.PromptShown:Connect(function(prompt)
            if AutoInteract then
                task.wait(0.05)
                pcall(function()
                    fireproximityprompt(prompt)
                end)
            end
        end)

        ------------------------------------------------
        -- STOP FUNCTION
        ------------------------------------------------

        local function stop()
            AutoInteract = false

            if promptConn then
                promptConn:Disconnect()
                promptConn = nil
            end
        end

        ------------------------------------------------
        -- TELEPORT + PRESS
        ------------------------------------------------

        local function tpAndPress(prompt)

            if not (prompt and prompt:IsA("ProximityPrompt")) then return end
            local part = prompt.Parent

            if not part:IsA("BasePart") then return end

            hrp.CFrame = part.CFrame * CFrame.new(0,0,-3)

            task.wait(0.2)

            pcall(function()
                fireproximityprompt(prompt)
            end)

        end

        ------------------------------------------------
        -- WALK FUNCTION
        ------------------------------------------------

        local function walkTo(pos)

            hum:MoveTo(pos)

            local finished = hum.MoveToFinished:Wait(3)

            if not finished then
                hrp.CFrame = CFrame.new(pos)
            end

        end

        ------------------------------------------------
        -- PROMPTS
        ------------------------------------------------

        local lightPrompt =
            workspace:FindFirstChild("Kebab")
            and workspace.Kebab:FindFirstChild("LightSwitch")
            and workspace.Kebab.LightSwitch:FindFirstChild("Base")
            and workspace.Kebab.LightSwitch.Base:FindFirstChildOfClass("ProximityPrompt")

        local doorPrompt =
            workspace:FindFirstChild("Door")
            and workspace.Door:FindFirstChild("Base")
            and workspace.Door.Base:FindFirstChildOfClass("ProximityPrompt")

        ------------------------------------------------
        -- WALK PATH
        ------------------------------------------------

        local WalkPoints = {

            Vector3.new(-38.77, 4.76, -562.52),
            Vector3.new(-38.74, 5.06, -555.16),
            Vector3.new(-38.61, 4.76, -566.14),
            Vector3.new(-39.29, 5.06, -549.62),

        }

        ------------------------------------------------
        -- EXECUTE
        ------------------------------------------------

        tpAndPress(lightPrompt)
        task.wait(0.3)

        tpAndPress(doorPrompt)
        task.wait(0.3)

        for _,pos in ipairs(WalkPoints) do
            walkTo(pos)
            task.wait(0.1)
        end

        stop()

    end
})

------------------------------------------------
-- AUTO EVENT POLICE (BUTTON)
------------------------------------------------
EventSection:Button({
    Title = "Auto Event Police ",
    Desc = "Do not click twice",
    Icon = "route",
    Callback = function()
        local Players = game:GetService("Players")
        local TweenService = game:GetService("TweenService")
        local RunService = game:GetService("RunService")
        local ProximityPromptService = game:GetService("ProximityPromptService")

        local player = Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")
        local camera = workspace.CurrentCamera

        local camBind = "AUTO_LOCK_CAMERA_EVENT"
        local AutoInteract = true
        local promptConn

        promptConn = ProximityPromptService.PromptShown:Connect(function(prompt)
            if AutoInteract then
                task.wait(0.05)
                firePrompt(prompt)
            end
        end)

        local LOCK_POS = Vector3.new(-34.30, 5.03, -579.84)

        RunService:BindToRenderStep(
            camBind,
            Enum.RenderPriority.Camera.Value + 10,
            function()
                local camPos = camera.CFrame.Position
                camera.CFrame = CFrame.lookAt(camPos, LOCK_POS)
            end
        )

        local function tweenTo(pos, speed)
            speed = speed or 14
            local time = (hrp.Position - pos).Magnitude / speed
            TweenService:Create(
                hrp,
                TweenInfo.new(time, Enum.EasingStyle.Linear),
                { CFrame = CFrame.new(pos) }
            ):Play()
            task.wait(time)
        end

        task.spawn(function()
            hrp.CFrame = CFrame.new(-41.94, 5.06, -550.06)
            task.wait(0.5)

            tweenTo(Vector3.new(-38.88, 5.06, -558.00))
            tweenTo(Vector3.new(-34.48, 4.98, -577.99))
            tweenTo(Vector3.new(-35.52, 4.96, -578.68))

            AutoInteract = false
            if promptConn then promptConn:Disconnect() end
            RunService:UnbindFromRenderStep(camBind)
        end)
    end
})


------------------------------------------------
-- AUTO EVENT POLICE (TOGGLE)
------------------------------------------------
local AutoPoliceEvent = false
local PolicePromptConn = nil
local PoliceCamBind = "AUTO_LOCK_CAMERA_POLICE"

EventSection:Toggle({
    Title = "Auto Event Police",
    Desc = "Auto when Inspector Car spawn",
    Icon = "route",
    Value = false,
    Callback = function(state)
        AutoPoliceEvent = state

        -- TURN OFF
        if not state then
            pcall(function()
                if PolicePromptConn then
                    PolicePromptConn:Disconnect()
                    PolicePromptConn = nil
                end
                game:GetService("RunService"):UnbindFromRenderStep(PoliceCamBind)
            end)
            return
        end

        -- TURN ON
        task.spawn(function()
            local Players = game:GetService("Players")
            local TweenService = game:GetService("TweenService")
            local RunService = game:GetService("RunService")
            local ProximityPromptService = game:GetService("ProximityPromptService")

            local player = Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")
            local camera = workspace.CurrentCamera

            local function getInspectorCar()
                local hum = workspace:FindFirstChild("Hum")
                local inspector = hum and hum:FindFirstChild("Inspector")
                local carCheck = inspector and inspector:FindFirstChild("CarCheck")
                return carCheck and carCheck:FindFirstChild("Car")
            end

            -- WAIT FOR CAR
            while AutoPoliceEvent and not getInspectorCar() do
                task.wait(0.5)
            end
            if not AutoPoliceEvent then return end

            -- AUTO INTERACT
            PolicePromptConn = ProximityPromptService.PromptShown:Connect(function(prompt)
                if AutoPoliceEvent then
                    task.wait(0.05)
                    firePrompt(prompt)
                end
            end)

            -- CAMERA LOCK
            local LOCK_POS = Vector3.new(-34.30, 5.03, -579.84)

            RunService:BindToRenderStep(
                PoliceCamBind,
                Enum.RenderPriority.Camera.Value + 10,
                function()
                    if not AutoPoliceEvent then return end
                    local camPos = camera.CFrame.Position
                    camera.CFrame = CFrame.lookAt(camPos, LOCK_POS)
                end
            )

            local function tweenTo(pos, speed)
                if not AutoPoliceEvent then return end
                speed = speed or 14
                local time = (hrp.Position - pos).Magnitude / speed

                TweenService:Create(
                    hrp,
                    TweenInfo.new(time, Enum.EasingStyle.Linear),
                    { CFrame = CFrame.new(pos) }
                ):Play()

                task.wait(time)
            end

            -- MOVE SEQUENCE
            hrp.CFrame = CFrame.new(-41.94, 5.06, -550.06)
            task.wait(0.5)

            tweenTo(Vector3.new(-38.88, 5.06, -558.00))
            tweenTo(Vector3.new(-34.48, 4.98, -577.99))
            tweenTo(Vector3.new(-35.52, 4.96, -578.68))

            -- CLEANUP
            AutoPoliceEvent = false
            if PolicePromptConn then
                PolicePromptConn:Disconnect()
                PolicePromptConn = nil
            end
            RunService:UnbindFromRenderStep(PoliceCamBind)
        end)
    end
})




------------------------------------------------
-- ESP SYSTEM (FULL FIXED)
------------------------------------------------
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

------------------------------------------------
-- ESP UPDATE CONTROL
------------------------------------------------
local ESP_UPDATE_RATE = 0 -- 0 = realtime
local lastESPUpdate = 0

------------------------------------------------
-- UTILS
------------------------------------------------
local function getHRP()
    local c = LocalPlayer.Character
    return c and c:FindFirstChild("HumanoidRootPart")
end

local function NewText(text, color)
    local t = Drawing.new("Text")
    t.Center = true
    t.Outline = true
    t.Size = 16
    t.Text = text
    t.Color = color
    t.Visible = false
    return t
end

local function Clear(tbl)
    for _, v in pairs(tbl) do
        pcall(function() v:Remove() end)
    end
    table.clear(tbl)
end

------------------------------------------------
-- ESP CONFIG
------------------------------------------------
local ESP = {
    Amon = {ON=false,COLOR=Color3.fromRGB(255,0,0),DIST=1500,TEXTS={}},
    Hum = {ON=false,COLOR=Color3.fromRGB(0,255,0),DIST=1500,TEXTS={}},
    Special = {ON=false,COLOR=Color3.fromRGB(0,170,255),DIST=1500,TEXTS={}},
    Scream = {ON=false,COLOR=Color3.fromRGB(139,69,19),DIST=1500,TEXTS={}},
    Cat = {ON=false,COLOR=Color3.fromRGB(0,255,0),DIST=1500,TEXTS={}},
    TallMan = {ON=false,COLOR=Color3.fromRGB(255,0,0),DIST=1500,TEXTS={}},
    Deer = {ON=false,COLOR=Color3.fromRGB(255,0,0),DIST=1500,TEXTS={}},
    Kira = {ON=false,COLOR=Color3.fromRGB(0,255,0),DIST=1500,TEXTS={}},
    InspectorCar = {ON=false,COLOR=Color3.fromRGB(255,0,0),DIST=2000,TEXTS={}},
    
    -- 🔥 THÊM 3 CÁI NÀY
    Clown = {ON=false,COLOR=Color3.fromRGB(255,0,0),DIST=1500,TEXTS={}},
    Cupid = {ON=false,COLOR=Color3.fromRGB(255,255,255),DIST=1500,TEXTS={}},
    Heart = {ON=false,COLOR=Color3.fromRGB(255,255,255),DIST=1500,TEXTS={}},
}

------------------------------------------------
-- ESP UI
------------------------------------------------
local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "rbxassetid://88340703117751",
})
local ESPSection = ESPTab:Section({ Title = "ESP Settings" })

ESPSection:Slider({
    Title = "ESP Lag Control",
    Desc = "0 = realtime | Higher value reduces lag",
    Value = {Default = 0, Min = 0, Max = 30, Rounding = 0},
    Callback = function(v)
        ESP_UPDATE_RATE = v == 0 and 0 or v * 0.01
    end
})

local function AddESP(name, cfg)
    ESPSection:Toggle({
        Title = "ESP "..name,
        Value = false,
        Callback = function(v)
            cfg.ON = v
            if not v then Clear(cfg.TEXTS) end
        end
    })

	

    ESPSection:Colorpicker({
        Title = name.." Color",
        Default = cfg.COLOR,
        Callback = function(c)
            cfg.COLOR = c
            for _,t in pairs(cfg.TEXTS) do
                t.Color = c
            end
        end
    })

    ESPSection:Slider({
        Title = name.." Distance",
        Value = {Default = cfg.DIST, Min = 100, Max = 8000},
        Callback = function(v)
            cfg.DIST = v
        end
    })
end


AddESP("Amon",ESP.Amon)
AddESP("Hum",ESP.Hum)
AddESP("Special",ESP.Special)
AddESP("Scream",ESP.Scream)
AddESP("Cat",ESP.Cat)
AddESP("Tall Man",ESP.TallMan)
AddESP("Deer",ESP.Deer)
AddESP("Kira",ESP.Kira)
AddESP("Inspector Car",ESP.InspectorCar)
AddESP("Clown",ESP.Clown)
AddESP("Cupid",ESP.Cupid)
AddESP("Heart",ESP.Heart)

RunService.RenderStepped:Connect(function()
    if ESP_UPDATE_RATE > 0 then
        if tick() - lastESPUpdate < ESP_UPDATE_RATE then return end
        lastESPUpdate = tick()
    end

    local hrp = getHRP()
    if not hrp then return end

    local hum = workspace:FindFirstChild("Hum")
    if not hum then return end

    
    for _, cfg in pairs(ESP) do
        for _, t in pairs(cfg.TEXTS) do
            t.Visible = false
        end
    end
if ESP.Clown.ON then
    local clown = hum:FindFirstChild("Clown")
    local man = clown and clown:FindFirstChild("Man1")
    local part = man and man:FindFirstChildWhichIsA("BasePart", true)

    if part and (hrp.Position - part.Position).Magnitude <= ESP.Clown.DIST then
        ESP.Clown.TEXTS[clown] =
            ESP.Clown.TEXTS[clown] or NewText("Clown", ESP.Clown.COLOR)

        local p,on = Camera:WorldToViewportPoint(part.Position)
        if on then
            local t = ESP.Clown.TEXTS[clown]
            t.Position = Vector2.new(p.X, p.Y - 30)
            t.Color = ESP.Clown.COLOR
            t.Visible = true
        end
    end
end

if ESP.Heart.ON then
    local cupid = hum:FindFirstChild("Cupid")
    local folder = cupid and cupid:FindFirstChild("Heart")

    if folder then
        for i = 1, 4 do
            local heart = folder:FindFirstChild("Heart"..i)
            local part = heart and heart:FindFirstChildWhichIsA("BasePart", true)

            if part and (hrp.Position - part.Position).Magnitude <= ESP.Heart.DIST then
                ESP.Heart.TEXTS[heart] =
                    ESP.Heart.TEXTS[heart] or NewText("Heart"..i, ESP.Heart.COLOR)

                local p,on = Camera:WorldToViewportPoint(part.Position)
                if on then
                    local t = ESP.Heart.TEXTS[heart]
                    t.Position = Vector2.new(p.X, p.Y - 20)
                    t.Color = ESP.Heart.COLOR
                    t.Visible = true
                end
            end
        end
    end
end

if ESP.Clown.ON then
    local clown = hum:FindFirstChild("Clown")
    local man = clown and clown:FindFirstChild("Man1")
    local part = man and man:FindFirstChildWhichIsA("BasePart", true)

    if part and (hrp.Position - part.Position).Magnitude <= ESP.Clown.DIST then
        ESP.Clown.TEXTS[clown] =
            ESP.Clown.TEXTS[clown] or NewText("Clown", ESP.Clown.COLOR)

        local p,on = Camera:WorldToViewportPoint(part.Position)
        if on then
            local t = ESP.Clown.TEXTS[clown]
            t.Position = Vector2.new(p.X, p.Y - 30)
            t.Color = ESP.Clown.COLOR
            t.Visible = true
        end
    end
end
 
    if ESP.InspectorCar.ON then
        local inspector = hum:FindFirstChild("Inspector")
        local car = inspector
            and inspector:FindFirstChild("CarCheck")
            and inspector.CarCheck:FindFirstChild("Car")

        local part = car and car:FindFirstChildWhichIsA("BasePart", true)
        if part and (hrp.Position - part.Position).Magnitude <= ESP.InspectorCar.DIST then
            ESP.InspectorCar.TEXTS[car] =
                ESP.InspectorCar.TEXTS[car] or NewText("Inspector Car", ESP.InspectorCar.COLOR)

            local p,on = Camera:WorldToViewportPoint(part.Position)
            if on then
                local t = ESP.InspectorCar.TEXTS[car]
                t.Position = Vector2.new(p.X, p.Y - 30)
                t.Visible = true
            end
        end
    end


if ESP.Amon.ON and hum then
        for _,f in ipairs(hum:GetChildren()) do
            -- Anom thường
            if f.Name:match("^Anom") then
                local man = f:FindFirstChild("Man1")
                local part = man and man:FindFirstChildWhichIsA("BasePart")

                if part and (hrp.Position - part.Position).Magnitude <= ESP.Amon.DIST then
                    ESP.Amon.TEXTS[f] =
                        ESP.Amon.TEXTS[f] or NewText(f.Name, ESP.Amon.COLOR)

                    local p, ons = Camera:WorldToViewportPoint(part.Position)
                    if ons then
                        local t = ESP.Amon.TEXTS[f]
                        t.Position = Vector2.new(p.X, p.Y - 30)
                        t.Color = ESP.Amon.COLOR
                        t.Visible = true
                    end
                end
            end
        end

        -- 🔴 ANOMSECRET - CLOWN
        local clown = hum:FindFirstChild("Clown")
        local part = clown and clown:FindFirstChild("Man1")
        if part and (hrp.Position - part.Position).Magnitude <= ESP.Amon.DIST then
            ESP.Amon.TEXTS[clown] =
                ESP.Amon.TEXTS[clown] or NewText("anomsecret", ESP.Amon.COLOR)

            local p, ons = Camera:WorldToViewportPoint(part.Position)
            if ons then
                local t = ESP.Amon.TEXTS[clown]
                t.Position = Vector2.new(p.X, p.Y - 30)
                t.Color = ESP.Amon.COLOR
                t.Visible = true
            end
        end
    end

    if ESP.Hum.ON then
        for _, f in ipairs(hum:GetChildren()) do
            local skip =
                f.Name:match("^Anom")
                or table.find({"Mike","Internte","Narrator","ManAN1","ManAN2"}, f.Name)
                or f.Name == "Tall_Man"
                or f.Name == "Deer"
                or f.Name == "Lite_Yami"
                or f.Name == "Inspector"
                or not (f.Name:match("^Man%d+$") or f.Name == "Man")

            if not skip then
                local man = f:FindFirstChild("Man1")
                local part = man and man:FindFirstChildWhichIsA("BasePart")
                if part and (hrp.Position - part.Position).Magnitude <= ESP.Hum.DIST then
                    ESP.Hum.TEXTS[f] = ESP.Hum.TEXTS[f] or NewText(f.Name, ESP.Hum.COLOR)
                    local p,on = Camera:WorldToViewportPoint(part.Position)
                    if on then
                        local t = ESP.Hum.TEXTS[f]
                        t.Position = Vector2.new(p.X, p.Y - 30)
                        t.Visible = true
                    end
                end
            end
        end
    end


    if ESP.Special.ON then
        for _, name in ipairs({"Mike","Internte","Narrator","ManAN1","ManAN2"}) do
            local f = hum:FindFirstChild(name)
            local man = f and f:FindFirstChild("Man1")
            local part = man and man:FindFirstChildWhichIsA("BasePart")
            if part and (hrp.Position - part.Position).Magnitude <= ESP.Special.DIST then
                ESP.Special.TEXTS[f] = ESP.Special.TEXTS[f] or NewText(name, ESP.Special.COLOR)
                local p,on = Camera:WorldToViewportPoint(part.Position)
                if on then
                    local t = ESP.Special.TEXTS[f]
                    t.Position = Vector2.new(p.X, p.Y - 30)
                    t.Visible = true
                end
            end
        end
    end

    if ESP.Scream.ON then
        for i = 1, 99 do
            local s = hum:FindFirstChild("Scream"..i)
            local part = s and s:FindFirstChildWhichIsA("BasePart")
            if part and (hrp.Position - part.Position).Magnitude <= ESP.Scream.DIST then
                ESP.Scream.TEXTS[s] = ESP.Scream.TEXTS[s] or NewText(s.Name, ESP.Scream.COLOR)
                local p,on = Camera:WorldToViewportPoint(part.Position)
                if on then
                    local t = ESP.Scream.TEXTS[s]
                    t.Position = Vector2.new(p.X, p.Y - 30)
                    t.Visible = true
                end
            end
        end
    end

if ESP.Cat.ON then
    -- Cat trong Hum
    if hum then
        local cat = hum:FindFirstChild("Cat")
        if cat then
            local part = cat:FindFirstChild("Man1") 
                or cat:FindFirstChildWhichIsA("BasePart", true)

            if part and (hrp.Position - part.Position).Magnitude <= ESP.Cat.DIST then
                ESP.Cat.TEXTS[cat] =
                    ESP.Cat.TEXTS[cat] or NewText("Cat", ESP.Cat.COLOR)

                local pos, ons = Camera:WorldToViewportPoint(part.Position)
                if ons then
                    local t = ESP.Cat.TEXTS[cat]
                    t.Position = Vector2.new(pos.X, pos.Y - 30)
                    t.Color = ESP.Cat.COLOR
                    t.Visible = true
                end
            end
        end
    end

    -- CatSit ở workspace
    local catSit = workspace:FindFirstChild("CatSit")
    if catSit then
        local part = catSit:FindFirstChildWhichIsA("BasePart", true)
        if part and (hrp.Position - part.Position).Magnitude <= ESP.Cat.DIST then
            ESP.Cat.TEXTS[catSit] =
                ESP.Cat.TEXTS[catSit] or NewText("CatSit", ESP.Cat.COLOR)

            local pos, ons = Camera:WorldToViewportPoint(part.Position)
            if ons then
                local t = ESP.Cat.TEXTS[catSit]
                t.Position = Vector2.new(pos.X, pos.Y - 30)
                t.Color = ESP.Cat.COLOR
                t.Visible = true
            end
        end
    end
end


    if ESP.TallMan.ON then
        local f = hum:FindFirstChild("Tall_Man")
        local man = f and f:FindFirstChild("Man1")
        local part = man and man:FindFirstChildWhichIsA("BasePart")
        if part and (hrp.Position - part.Position).Magnitude <= ESP.TallMan.DIST then
            ESP.TallMan.TEXTS[f] = ESP.TallMan.TEXTS[f] or NewText("Tall Man", ESP.TallMan.COLOR)
            local p,on = Camera:WorldToViewportPoint(part.Position)
            if on then
                local t = ESP.TallMan.TEXTS[f]
                t.Position = Vector2.new(p.X, p.Y - 30)
                t.Visible = true
            end
        end
    end

    if ESP.Deer.ON then
        local f = hum:FindFirstChild("Deer")
        local man = f and f:FindFirstChild("Man1")
        local part = man and man:FindFirstChildWhichIsA("BasePart")
        if part and (hrp.Position - part.Position).Magnitude <= ESP.Deer.DIST then
            ESP.Deer.TEXTS[f] = ESP.Deer.TEXTS[f] or NewText("Deer", ESP.Deer.COLOR)
            local p,on = Camera:WorldToViewportPoint(part.Position)
            if on then
                local t = ESP.Deer.TEXTS[f]
                t.Position = Vector2.new(p.X, p.Y - 30)
                t.Visible = true
            end
        end
    end

 
    if ESP.Kira.ON then
        local f = hum:FindFirstChild("Lite_Yami")
        local man = f and f:FindFirstChild("Man1")
        local part = man and man:FindFirstChildWhichIsA("BasePart")
        if part and (hrp.Position - part.Position).Magnitude <= ESP.Kira.DIST then
            ESP.Kira.TEXTS[f] = ESP.Kira.TEXTS[f] or NewText("Kira", ESP.Kira.COLOR)
            local p,on = Camera:WorldToViewportPoint(part.Position)
            if on then
                local t = ESP.Kira.TEXTS[f]
                t.Position = Vector2.new(p.X, p.Y - 30)
                t.Visible = true
            end
        end
    end
end)


local Players = game:GetService("Players")

local TpTab = Window:Tab({
    Title = "Teleport",
    Icon = "rbxassetid://131043568838758",
    Locked = false,
})

local TpSection = TpTab:Section({
    Title = "Teleport"
})


local function TeleportTo(pos)
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(pos)
end


TpTab:Button({
    Title = "TP Home",
    Desc = "Teleport to home",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Color = Color3.fromRGB(100, 100, 255),
    Justify = "Between",
    Callback = function()
        TeleportTo(Vector3.new(-42.75, 4.95, -550.66))
    end
})


TpTab:Button({
    Title = "TP Stop Bus",
    Desc = "Teleport to bus stop",
    Icon = "mouse-pointer-click",
    IconAlign = "Right",
    Color = Color3.fromRGB(0, 0, 255),
    Justify = "Between",
    Callback = function()
        TeleportTo(Vector3.new(-40.44, 4.61, -480.90))
    end
})



local Players = game:GetService("Players")

local EndingTab = Window:Tab({
    Title = "Ending",
    Icon = "bird",
    Locked = false,
})

local EndingSection = EndingTab:Section({
    Title = "Ending Teleport"
})


local function TeleportTo(pos)
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(pos)
end

EndingTab:Button({
    Title = "TP Ending 4/5",
    Desc = "Teleport to Ending 4/5",
    Icon = "flag",
    IconAlign = "Right",
    Justify = "Between",
    Callback = function()
        TeleportTo(Vector3.new(1991.26, 316.65, -1312.99))
    end
})


EndingTab:Button({
    Title = "TP Ending 3/5",
    Desc = "Teleport to Ending 3/5",
    Icon = "flag",
    IconAlign = "Right",
    Justify = "Between",
    Callback = function()
        TeleportTo(Vector3.new(2052.21, 100.75, -340.78))
    end
})


local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")


local STEP_DELAY = 0.01
local AUTO_RUNNING = false

local POS_A = Vector3.new(-43.76, 5.06, -548.06)
local POS_B = Vector3.new(-44.10, 5.06, -554.71)

local AutoInteract = false
local AutoInteractConn

local function enableAutoInteract()
    if AutoInteractConn then return end
    AutoInteract = true

    AutoInteractConn = ProximityPromptService.PromptShown:Connect(function(prompt)
        if not AutoInteract then return end
        task.wait(0.05)
        pcall(function()
            prompt.HoldDuration = 0
            fireproximityprompt(prompt)
        end)
    end)
end

local function disableAutoInteract()
    AutoInteract = false
    if AutoInteractConn then
        AutoInteractConn:Disconnect()
        AutoInteractConn = nil
    end
end


local function getPrompt(obj)
    return obj and obj:FindFirstChildOfClass("ProximityPrompt")
end

local function setupPrompt(p)
    if p and p:IsA("ProximityPrompt") then
        p.HoldDuration = 0
        p.RequiresLineOfSight = false
        p.MaxActivationDistance = 8
    end
end

local function getAllPrompts()
    local list = {}
    local function add(p) if p then table.insert(list, p) end end

    ------------------------------------------------
    -- KIT
    ------------------------------------------------
    local kit = workspace:FindFirstChild("Kit")
    if kit then
        add(getPrompt(kit:FindFirstChild("Salad") and kit.Salad:FindFirstChild("Button")))
        add(getPrompt(kit:FindFirstChild("Lavash") and kit.Lavash:FindFirstChild("Button")))
        add(getPrompt(kit:FindFirstChild("Cheese") and kit.Cheese:FindFirstChild("Button")))
        add(getPrompt(kit:FindFirstChild("Fry") and kit.Fry:FindFirstChild("Button")))
        add(getPrompt(kit:FindFirstChild("Sauce") and kit.Sauce:FindFirstChild("Button")))
        add(getPrompt(kit:FindFirstChild("Board")))
        add(getPrompt(kit:FindFirstChild("popcan")))

        if kit:FindFirstChild("Done") and kit.Done:FindFirstChild("Lavash") then
            add(getPrompt(kit.Done.Lavash))
        end
    end

    ------------------------------------------------
    -- KEBAB
    ------------------------------------------------
    local kebab = workspace:FindFirstChild("Kebab")
    if kebab and kebab:FindFirstChild("kebabmyaso") then
        add(getPrompt(kebab.kebabmyaso:FindFirstChild("Kebab.040")))
    end

    ------------------------------------------------
    -- CANS
    ------------------------------------------------
    local cans = workspace:FindFirstChild("Cans")
    if cans then

        -- POP CAN
        if cans:FindFirstChild("Prompts") then
            for i = 1, 99 do
                add(getPrompt(cans.Prompts:FindFirstChild("popcan" .. i)))
            end
        end

        -- 🔥 COFFEE (THÊM Ở ĐÂY)
        if cans:FindFirstChild("Coffee") then
            add(getPrompt(cans.Coffee))
        end

    end

    return list
end


task.spawn(function()
    while true do
        task.wait()
        if AUTO_RUNNING then
            for _, prompt in ipairs(getAllPrompts()) do
                if not AUTO_RUNNING then break end
                setupPrompt(prompt)
                if prompt and prompt.Parent then
                    pcall(function()
                        fireproximityprompt(prompt)
                    end)
                    task.wait(STEP_DELAY)
                end
            end
        end
    end
end)


local function tweenTo(pos)
    local dist = (hrp.Position - pos).Magnitude
    local time = dist / 12
    local tween = TweenService:Create(
        hrp,
        TweenInfo.new(time, Enum.EasingStyle.Linear),
        { CFrame = CFrame.new(pos) }
    )
    tween:Play()
    tween.Completed:Wait()
end

local function startWalkLoop()
    task.spawn(function()
        while AUTO_RUNNING do
            tweenTo(POS_B)
            if not AUTO_RUNNING then break end
            tweenTo(POS_A)
        end
    end)
end


EndingTab:Button({
    Title = "Auto End 5/5",
    Icon = "alert-triangle",
    Justify = "Between",
    Callback = function()
        Window:Dialog({
            Title = "Confirm Ending",
            Content = "Are you sure you want to start Auto Ending 5/5?",
            Buttons = {
                {
                    Title = "Yes",
                    Callback = function()
                        if AUTO_RUNNING then
                            AUTO_RUNNING = false
                            disableAutoInteract()
                            return
                        end

                        AUTO_RUNNING = true
                        hrp.CFrame = CFrame.new(POS_A)
                        task.wait(0.3)

                        enableAutoInteract()
                        startWalkLoop()
                    end
                },
                {
                    Title = "No",
                    Callback = function() end
                }
            }
        })
    end
})


local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera



local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "settings"
})
local SectionMisc = MiscTab:Section({
    Title = "Misc Settings"
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

local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local LP = Players.LocalPlayer
local PlaceID = game.PlaceId

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
    Title = "Random Server",
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
