
------------------------------------------------
-- LOAD WINDUI
------------------------------------------------
local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/download/1.6.63/main.lua"
))()

------------------------------------------------
-- WINDOW
------------------------------------------------
local Window = WindUI:CreateWindow({
    Title = "PhiPhai v2",
    Icon = "eye-off",
    Author = "by aaaaaaaaaaa",

    KeySystem = {
        Note = "Example Key System. With platoboost.",
        API = {
            {
                Type = "platoboost",
                ServiceId = 19712,
                Secret = "cec45638-7dc0-4386-a2c5-8e5d5ce886d4",
            },
        },
    },
})

Window:Tag({
    Title = "Getkey Version",
    Color = Color3.fromHex("#30ff6a"),
    Radius = 5,
})

WindUI:SetTheme("Sky")

  Window:EditOpenButton({
    Title = "PPv2",
    Icon = "monitor",
    CornerRadius = UDim.new(0,16),
    StrokeThickness = 2,
    Color = ColorSequence.new( -- gradient
        Color3.fromHex("09cfe6"), 
        Color3.fromHex("#0a70ff")
    ),
    OnlyMobile = false,
    Enabled = true,
    Draggable = true,
})                  

------------------------------------------------
-- TAB
------------------------------------------------
local AutoTab = Window:Tab({
    Title = "Auto",
    Desc = "beta",
    Icon = "bird",
    IconColor = Color3.fromRGB(255, 100, 100),
    Border = false,
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


local AutoShawarmaSection = AutoTab:Section({ Title = "Auto Shawarma" })

local AutoShawarma = false

AutoShawarmaSection:Toggle({
    Title = "Auto Make Shawarma",
    Value = false,
    Callback = function(v)
        AutoShawarma = v
    end
})

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

        local kebab = workspace:FindFirstChild("Kebab")
        if kebab and kebab:FindFirstChild("kebabmyaso") then
            addPrompt(
                kebab.kebabmyaso:FindFirstChild("Kebab.040")
            )
        end

        local cans = workspace:FindFirstChild("Cans")
        if cans and cans:FindFirstChild("Prompts") then
            for i = 1, 99 do
                addPrompt(cans.Prompts:FindFirstChild("popcan" .. i))
            end
        end

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
    Title = "Kebab Delay (Seconds)",
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

        promptConn = ProximityPromptService.PromptShown:Connect(function(prompt)
            if AutoInteract then
                task.wait(0.05)
                firePrompt(prompt)
            end
        end)

        local function stop()
            AutoInteract = false
            if promptConn then
                promptConn:Disconnect()
                promptConn = nil
            end
        end

        local function tpAndPress(prompt)
            if not (prompt and prompt:IsA("ProximityPrompt")) then return end
            local part = prompt.Parent
            if not part:IsA("BasePart") then return end

            hrp.CFrame = part.CFrame * CFrame.new(0, 0, -3)
            task.wait(0.2)
            firePrompt(prompt)
        end

        local function walkTo(pos)
            hum:MoveTo(pos)
            hum.MoveToFinished:Wait()
        end

        local lightPrompt =
            workspace:FindFirstChild("Kebab")
            and workspace.Kebab:FindFirstChild("LightSwitch")
            and workspace.Kebab.LightSwitch:FindFirstChild("Base")
            and workspace.Kebab.LightSwitch.Base:FindFirstChildOfClass("ProximityPrompt")

        local doorPrompt =
            workspace:FindFirstChild("Door")
            and workspace.Door:FindFirstChild("Base")
            and workspace.Door.Base:FindFirstChildOfClass("ProximityPrompt")

        local WalkPoints = {
            Vector3.new(-38.77, 4.76, -562.52),
            Vector3.new(-38.74, 5.06, -555.16),
            Vector3.new(-38.61, 4.76, -566.14),
            Vector3.new(-39.29, 5.06, -549.62),
        }

        tpAndPress(lightPrompt)
        task.wait(0.3)
        tpAndPress(doorPrompt)
        task.wait(0.3)

        for i, pos in ipairs(WalkPoints) do
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
    Title = "Auto Event Police (Once)",
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
    Title = "Auto Event Police (Auto)",
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
local ESPTab = Window:Tab({ Title = "ESP", Icon = "eye" })
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

    -- hide all
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
        for i = 1, 99 do
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
    ------------------------------------------------
    -- INSPECTOR CAR
    ------------------------------------------------
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

    ------------------------------------------------
    -- AMON
    ------------------------------------------------
    ------------------------------------------------
-- ANOM SECRET (Clown)
------------------------------------------------
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
    ------------------------------------------------
    -- HUM (CHỈ HUMAN THẬT)
    ------------------------------------------------
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

    ------------------------------------------------
    -- SPECIAL
    ------------------------------------------------
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

    ------------------------------------------------
    -- SCREAM
    ------------------------------------------------
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

------------------------------------------------
-- CAT ESP (Hum.Cat + workspace.CatSit)
------------------------------------------------
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

    ------------------------------------------------
    -- TALL MAN
    ------------------------------------------------
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

    ------------------------------------------------
    -- DEER
    ------------------------------------------------
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

    ------------------------------------------------
    -- KIRA
    ------------------------------------------------
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

------------------------------------------------
-- TP TAB
------------------------------------------------
local Players = game:GetService("Players")

local TpTab = Window:Tab({
    Title = "Teleport",
    Icon = "bird",
    Locked = false,
})

local TpSection = TpTab:Section({
    Title = "Teleport"
})

-- hàm teleport chung (đỡ lặp code)
local function TeleportTo(pos)
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(pos)
end

------------------------------------------------
-- TP HOME
------------------------------------------------
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

------------------------------------------------
-- TP STOP BUS
------------------------------------------------
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


------------------------------------------------
-- ENDING TAB
------------------------------------------------
local Players = game:GetService("Players")

local EndingTab = Window:Tab({
    Title = "Ending",
    Icon = "bird",
    Locked = false,
})

local EndingSection = EndingTab:Section({
    Title = "Ending Teleport"
})

-- hàm TP chung
local function TeleportTo(pos)
    local player = Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")
    hrp.CFrame = CFrame.new(pos)
end

------------------------------------------------
-- END 4/5
------------------------------------------------
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

------------------------------------------------
-- END 3/5
------------------------------------------------
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


------------------------------------------------
-- AUTO END 5/5
------------------------------------------------
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

------------------------------------------------
-- CONFIG
------------------------------------------------
local STEP_DELAY = 0.01
local AUTO_RUNNING = false

local POS_A = Vector3.new(-43.76, 5.06, -548.06)
local POS_B = Vector3.new(-44.10, 5.06, -554.71)

------------------------------------------------
-- AUTO INTERACT
------------------------------------------------
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

------------------------------------------------
-- PROMPT UTILS
------------------------------------------------
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

    local kebab = workspace:FindFirstChild("Kebab")
    if kebab and kebab:FindFirstChild("kebabmyaso") then
        add(getPrompt(kebab.kebabmyaso:FindFirstChild("Kebab.040")))
    end

    local cans = workspace:FindFirstChild("Cans")
    if cans and cans:FindFirstChild("Prompts") then
        for i = 1, 99 do
            add(getPrompt(cans.Prompts:FindFirstChild("popcan" .. i)))
        end
    end

    return list
end

------------------------------------------------
-- AUTO FIRE LOOP
------------------------------------------------
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

------------------------------------------------
-- MOVE SYSTEM
------------------------------------------------
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

------------------------------------------------
-- UI BUTTON
------------------------------------------------
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

------------------------------------------------
-- SERVICES
------------------------------------------------
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

------------------------------------------------
-- TAB + SECTION
------------------------------------------------
local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "settings"
})

local ViewSection = MiscTab:Section({
    Title = "View"
})

------------------------------------------------
-- FOV
------------------------------------------------
ViewSection:Slider({
    Title = "Field Of View",
    Value = {
        Default = Camera.FieldOfView,
        Min = 30,
        Max = 120,
        Rounding = 0
    },
    Callback = function(v)
        Camera.FieldOfView = v
    end
})

------------------------------------------------
-- DEFAULT VALUES
------------------------------------------------
local DEFAULT_WALKSPEED = 16
local DEFAULT_JUMPPOWER = 50
local DEFAULT_GRAVITY = Workspace.Gravity

------------------------------------------------
-- STATE
------------------------------------------------
local WS_ENABLED = false
local JP_ENABLED = false
local GRAV_ENABLED = false

local WalkSpeedValue = DEFAULT_WALKSPEED
local JumpPowerValue = DEFAULT_JUMPPOWER
local GravityValue = DEFAULT_GRAVITY

------------------------------------------------
-- APPLY STATS
------------------------------------------------
local function applyStats()
    local char = player.Character
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    if not hum then return end

    -- WalkSpeed
    hum.WalkSpeed = WS_ENABLED and WalkSpeedValue or DEFAULT_WALKSPEED

    -- JumpPower
    hum.UseJumpPower = true
    hum.JumpPower = JP_ENABLED and JumpPowerValue or DEFAULT_JUMPPOWER

    -- Gravity
    Workspace.Gravity = GRAV_ENABLED and GravityValue or DEFAULT_GRAVITY
end

------------------------------------------------
-- REAPPLY ON RESPAWN
------------------------------------------------
player.CharacterAdded:Connect(function()
    task.wait(0.5)
    applyStats()
end)

------------------------------------------------
-- WALK SPEED
------------------------------------------------
MiscTab:Toggle({
    Title = "Walk Speed",
    Value = false,
    Callback = function(v)
        WS_ENABLED = v
        applyStats()
    end
})

MiscTab:Slider({
    Title = "Walk Speed Value",
    Value = {
        Default = DEFAULT_WALKSPEED,
        Min = 5,
        Max = 200,
        Rounding = 0
    },
    Callback = function(v)
        WalkSpeedValue = v
        if WS_ENABLED then
            applyStats()
        end
    end
})

------------------------------------------------
-- JUMP POWER
------------------------------------------------
MiscTab:Toggle({
    Title = "Jump Power",
    Value = false,
    Callback = function(v)
        JP_ENABLED = v
        applyStats()
    end
})

MiscTab:Slider({
    Title = "Jump Power Value",
    Value = {
        Default = DEFAULT_JUMPPOWER,
        Min = 10,
        Max = 300,
        Rounding = 0
    },
    Callback = function(v)
        JumpPowerValue = v
        if JP_ENABLED then
            applyStats()
        end
    end
})

------------------------------------------------
-- GRAVITY
------------------------------------------------
MiscTab:Toggle({
    Title = "Custom Gravity",
    Value = false,
    Callback = function(v)
        GRAV_ENABLED = v
        applyStats()
    end
})

MiscTab:Slider({
    Title = "Gravity Value",
    Value = {
        Default = DEFAULT_GRAVITY,
        Min = 20,
        Max = 196.2,
        Rounding = 1
    },
    Callback = function(v)
        GravityValue = v
        if GRAV_ENABLED then
            applyStats()
        end
    end
})


------------------------------------------------
-- SERVICES & PLAYER
------------------------------------------------
local Players = game:GetService("Players")
local Lighting = game:GetService("Lighting")
local ProximityPromptService = game:GetService("ProximityPromptService")

local player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

------------------------------------------------
-- THIRD PERSON VIEW
------------------------------------------------
local ThirdPersonEnabled = false
local oldCameraMode
local oldMinZoom
local oldMaxZoom

MiscTab:Toggle({
    Title = "Third Person View",
    Desc = "Dynamic zoom (scroll wheel)",
    Value = false,
    Callback = function(v)
        ThirdPersonEnabled = v

        if v then
            -- save old values
            oldCameraMode = player.CameraMode
            oldMinZoom = player.CameraMinZoomDistance
            oldMaxZoom = player.CameraMaxZoomDistance

            -- apply third person
            player.CameraMode = Enum.CameraMode.Classic
            player.CameraMinZoomDistance = 8
            player.CameraMaxZoomDistance = 15
        else
            -- restore
            player.CameraMode = oldCameraMode or Enum.CameraMode.Classic
            player.CameraMinZoomDistance = oldMinZoom or 0.5
            player.CameraMaxZoomDistance = oldMaxZoom or 12
        end
    end
})

------------------------------------------------
-- UNLOCK MAX ZOOM
------------------------------------------------
local savedMaxZoom

MiscTab:Toggle({
    Title = "Unlock Max Zoom",
    Value = false,
    Callback = function(v)
        if v then
            savedMaxZoom = player.CameraMaxZoomDistance
            player.CameraMaxZoomDistance = 999999
        else
            player.CameraMaxZoomDistance = savedMaxZoom or 12
        end
    end
})

------------------------------------------------
-- FULL BRIGHT
------------------------------------------------
local Fullbright = false
local oldAmbient = Lighting.Ambient
local oldTop = Lighting.ColorShift_Top
local oldBottom = Lighting.ColorShift_Bottom
local fbConn

local function applyFullbright()
    Lighting.Ambient = Color3.new(1, 1, 1)
    Lighting.ColorShift_Top = Color3.new(1, 1, 1)
    Lighting.ColorShift_Bottom = Color3.new(1, 1, 1)
end

MiscTab:Toggle({
    Title = "Full Bright",
    Value = false,
    Callback = function(v)
        Fullbright = v

        if v then
            applyFullbright()

            fbConn = Lighting:GetPropertyChangedSignal("Ambient"):Connect(function()
                if Fullbright then
                    applyFullbright()
                end
            end)
        else
            if fbConn then
                fbConn:Disconnect()
                fbConn = nil
            end

            Lighting.Ambient = oldAmbient
            Lighting.ColorShift_Top = oldTop
            Lighting.ColorShift_Bottom = oldBottom
        end
    end
})

------------------------------------------------
-- FAST INTERACT (HOLD = 0)
------------------------------------------------
local FastInteract = false

MiscTab:Toggle({
    Title = "Fast Interact",
    Value = false,
    Callback = function(v)
        FastInteract = v
    end
})

ProximityPromptService.PromptButtonHoldBegan:Connect(function(prompt)
    if not FastInteract then return end

    prompt.HoldDuration = 0
    pcall(function()
        fireproximityprompt(prompt)
    end)
end)

------------------------------------------------
-- AUTO INTERACT (AUTO PRESS)
------------------------------------------------
local AutoInteract = false

MiscTab:Toggle({
    Title = "Auto Interact",
    Value = false,
    Callback = function(v)
        AutoInteract = v
    end
})

ProximityPromptService.PromptShown:Connect(function(prompt)
    if not AutoInteract then return end

    task.wait(0.05)
    prompt.HoldDuration = 0
    pcall(function()
        fireproximityprompt(prompt)
    end)
end)



local ESPPTab = Window:Tab({
    Title = "Esp Player",
    Icon = "settings"
})

local BoxColor = Color3.fromRGB(0,162,255)
local TracerColor = Color3.fromRGB(0,162,255)

local ESPEnabled = false
local BoxEnabled = false
local Tracers = false
local Team_Check = false
local Autothickness = false

ESPPTab:Toggle({
    Title = "Enable ESP",
    Value = false,
    Callback = function(state)
        ESPEnabled = state
    end
})

ESPPTab:Toggle({
    Title = "Box ESP",
    Value = false,
    Callback = function(state)
        BoxEnabled = state
    end
})

ESPPTab:Toggle({
    Title = "Tracer",
    Value = false,
    Callback = function(state)
        Tracers = state
    end
})

ESPPTab:Toggle({
    Title = "Team Check",
    Value = false,
    Callback = function(state)
        Team_Check = state
    end
})

ESPPTab:Toggle({
    Title = "Auto Thickness",
    Value = false,
    Callback = function(state)
        Autothickness = state
    end
})

ESPPTab:Colorpicker({
    Title = "Box Color",
    Default = BoxColor,
    Callback = function(color)
        BoxColor = color
    end
})

ESPPTab:Colorpicker({
    Title = "Tracer Color",
    Default = TracerColor,
    Callback = function(color)
        TracerColor = color
    end
})

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local linesTable = {}

local function CreateESP(plr)

    local lines = {}

    -- 12 box lines
    for i = 1, 12 do
        local l = Drawing.new("Line")
        l.Visible = false
        l.Thickness = 1.5
        l.Color = Color3.fromRGB(0,162,255)
        table.insert(lines, l)
    end

    -- tracer
    local tracer = Drawing.new("Line")
    tracer.Visible = false
    tracer.Thickness = 1.5
    tracer.Color = Color3.fromRGB(0,162,255)
    table.insert(lines, tracer)

    linesTable[plr] = lines
end

-- tạo ESP cho player đang có sẵn
for _,plr in pairs(Players:GetPlayers()) do
    if plr ~= player then
        CreateESP(plr)
    end
end

-- player mới vào
Players.PlayerAdded:Connect(function(plr)
    if plr ~= player then
        CreateESP(plr)
    end
end)

RunService.RenderStepped:Connect(function()

    for plr, lines in pairs(linesTable) do

        -- Nếu tắt ESP Master → ẩn hết
        if not ESPEnabled then
            for _,l in pairs(lines) do
                l.Visible = false
            end
            continue
        end

        -- Kiểm tra nhân vật hợp lệ
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

                -- 🔥 BOX ESP
                if BoxEnabled then
                    for i,edge in pairs(edges) do
                        lines[i].From = screenCorners[edge[1]]
                        lines[i].To   = screenCorners[edge[2]]
                        lines[i].Color = BoxColor
                        lines[i].Visible = true
                    end
                else
                    for i = 1,12 do
                        lines[i].Visible = false
                    end
                end

                -- 🔥 TRACER
                local tracer = lines[13]

                if Tracers then
                    tracer.From = Vector2.new(
                        camera.ViewportSize.X/2,
                        camera.ViewportSize.Y
                    )
                    tracer.To = Vector2.new(
                        rootPos.X,
                        rootPos.Y
                    )
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
    Icon = "sticky-note"
})

-- KIRA NOTE
local KiraSection = NoteTab:Section({
    Title = "Kira Note"
})

KiraSection:Paragraph({
    Title = "⚠ KIRA NOTEBOOK",
    Desc = "Sell shawarma to Kira.\nIf he gives the notebook,\nCLOSE THE DOOR IMMEDIATELY.",
    Visible = true
})

-- ESP AMON / HUM NOTE
local EspNoteSection = NoteTab:Section({
    Title = "ESP Amon / Hum"
})

EspNoteSection:Paragraph({
    Title = "ESP Note",
    Desc = "Anom = Anomaly\nHum = Human"
})

-- BLUE ESP NOTE
local BlueNoteSection = NoteTab:Section({
    Title = "Blue ESP Note"
})

BlueNoteSection:Paragraph({
    Title = "BLUE ESP NOTICE",
    Desc = "Blue ESP is optional.\nYou may sell or not sell — the decision is entirely yours."
})

local DiscordTab = Window:Tab({
    Title = "Discord",
    Desc = "Join our community",
    Icon = "discord",
    IconColor = Color3.fromRGB(114, 137, 218),
    IconThemed = false,
})

local DiscordSection = DiscordTab:Section({
    Title = "Community"
})

DiscordSection:Button({
    Title = "Copy Discord Invite",
    Desc = "GA key in Discord",
    Icon = "message-circle-more",
    IconAlign = "Left",
    Color = Color3.fromRGB(114, 137, 218),
    Justify = "Between",

    Callback = function()
        local link = "https://discord.gg/6y7TpYTBkW"

        if setclipboard then
            setclipboard(link)
        elseif toclipboard then
            toclipboard(link)
        end

        -- notify
        Window:Notify({
            Title = "Discord",
            Content = "Invite link copied to clipboard!",
            Duration = 3
        })
    end
})
