--[[
  PhiPhai v2 | Anime Life
  Note Im open scr can u relase that =))
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Lighting = game:GetService("Lighting")
local UIS = game:GetService("UserInputService")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local repo = "https://raw.githubusercontent.com/deividcomsono/Obsidian/main/"
local Library = loadstring(game:HttpGet(repo .. "Library.lua"))()
local ThemeManager = loadstring(game:HttpGet(repo .. "addons/ThemeManager.lua"))()
local SaveManager = loadstring(game:HttpGet(repo .. "addons/SaveManager.lua"))()

local Options = Library.Options
local Toggles = Library.Toggles

Library.ShowToggleFrameInKeybinds = true

ThemeManager:SetLibrary(Library)
ThemeManager:SetDefaultTheme({
	FontColor = "ffffff",
	MainColor = "1a0a0a",
	AccentColor = "850c0c",
	BackgroundColor = "0d0505",
	OutlineColor = "3a1515",
})

local Window = Library:CreateWindow({
	Title = "PhiPhai v2 | Anime Life",
	Footer = "discord.gg/6y7TpYTBkW",
	Center = true,
	AutoShow = true,
	Resizable = true,
	NotifySide = "Right",
	ShowCustomCursor = true,
})

local function Notify(title, text, time)
	pcall(function()
		Library:Notify({
			Title = tostring(title or "PhiPhai"),
			Description = tostring(text or ""),
			Time = time or 3,
		})
	end)
end

local Tabs = {
	Main = Window:AddTab("Main", "cup-soda"),
	Auto = Window:AddTab("Automatic", "bot"),
	Misc = Window:AddTab("Misc", "wrench"),
	TP = Window:AddTab("TP", "map-pin"),
	Shop = Window:AddTab("Shop", "shopping-bag"),
	Server = Window:AddTab("Server", "server"),
	Discord = Window:AddTab("Discord", "message-circle"),
	Settings = Window:AddTab("Settings", "settings"),
}

local MainBox = Tabs.Main:AddLeftGroupbox("Drinks")

local AutoBuy = false
local AutoDrink = false
local BuyAmount = 5
local MinEnergy = 25
local SelectedDrink = "ColdBrewBottle"

local DrinkList = {
	"ColdBrewBottle",
	"SodaCan",
	"GreenTeaBottle",
	"MilkTeaCan",
	"StrawberryMilkTeaBottle",
}

MainBox:AddDropdown("AL_Drink", {
	Text = "Drink",
	Values = DrinkList,
	Default = "ColdBrewBottle",
	Callback = function(v)
		SelectedDrink = v
	end,
})

MainBox:AddToggle("AL_AutoDrink", {
	Text = "Auto Drink",
	Default = false,
	Callback = function(v)
		AutoDrink = v
	end,
})

MainBox:AddToggle("AL_AutoBuy", {
	Text = "Auto Buy",
	Default = false,
	Callback = function(v)
		AutoBuy = v
	end,
})

MainBox:AddSlider("AL_BuyAmount", {
	Text = "Buy Amount",
	Default = 5,
	Min = 1,
	Max = 20,
	Rounding = 0,
	Callback = function(v)
		BuyAmount = v
	end,
})

MainBox:AddSlider("AL_MinEnergy", {
	Text = "Min Energy",
	Default = 25,
	Min = 0,
	Max = 100,
	Rounding = 0,
	Callback = function(v)
		MinEnergy = v
	end,
})

task.spawn(function()
	local ProfileModule, InventoryModule
	pcall(function()
		ProfileModule = require(ReplicatedStorage.Systems.Profile)
		InventoryModule = require(ReplicatedStorage.Systems.Inventory)
	end)

	local BuyItem = ReplicatedStorage:FindFirstChild("Systems")
		and ReplicatedStorage.Systems:FindFirstChild("Shop")
		and ReplicatedStorage.Systems.Shop:FindFirstChild("BuyItem")

	local ConsumeFood = ReplicatedStorage:FindFirstChild("Systems")
		and ReplicatedStorage.Systems:FindFirstChild("Food")
		and ReplicatedStorage.Systems.Food:FindFirstChild("ConsumeFood")

	while task.wait(4) do
		pcall(function()
			if not ProfileModule or not InventoryModule then
				return
			end

			local Profile = ProfileModule:GetProfile(LocalPlayer)
			if not Profile then
				return
			end

			local Item = InventoryModule:GetOwnedItem(LocalPlayer, SelectedDrink)
			local Count = 0
			if Item then
				Count = Item:GetAttribute("Count") or 1
			end

			if AutoBuy and BuyItem then
				while Count < BuyAmount do
					BuyItem:InvokeServer(SelectedDrink)
					Count += 1
					task.wait(0.15)
				end
			end

			if AutoDrink and Count > 0 and ConsumeFood then
				local Energy = Profile.Needs.Energy:GetAttribute("Value")
				if Energy and Energy <= MinEnergy then
					ConsumeFood:FireServer(SelectedDrink)
				end
			end
		end)
	end
end)

local PizzaBox = Tabs.Auto:AddLeftGroupbox("Auto Pizza Delivery")

local AutoPizza = false
local PizzaThread
local FlyHeight = 250
local FarmDelay = 4
local BodyVelocity, BodyGyro

local function StartVFly()
	local char = LocalPlayer.Character
	if not char then
		return
	end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		return
	end

	BodyVelocity = Instance.new("BodyVelocity")
	BodyVelocity.MaxForce = Vector3.new(1e5, 1e5, 1e5)
	BodyVelocity.Velocity = Vector3.zero
	BodyVelocity.Parent = hrp

	BodyGyro = Instance.new("BodyGyro")
	BodyGyro.MaxTorque = Vector3.new(1e5, 1e5, 1e5)
	BodyGyro.P = 12500
	BodyGyro.Parent = hrp
end

local function StopVFly()
	if BodyVelocity then
		BodyVelocity:Destroy()
		BodyVelocity = nil
	end
	if BodyGyro then
		BodyGyro:Destroy()
		BodyGyro = nil
	end
end

local function SetFreeze(state)
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart")
	if hrp then
		hrp.Anchored = state
	end
end

PizzaBox:AddToggle("AL_AutoPizza", {
	Text = "Auto Pizza Delivery",
	Default = false,
	Callback = function(state)
		AutoPizza = state

		if not state then
			StopVFly()
			SetFreeze(false)
			if PizzaThread then
				task.cancel(PizzaThread)
				PizzaThread = nil
			end
			return
		end

		StartVFly()
		SetFreeze(true)

		PizzaThread = task.spawn(function()
			while AutoPizza do
				pcall(function()
					local startJob = ReplicatedStorage:FindFirstChild("Systems")
						and ReplicatedStorage.Systems:FindFirstChild("Jobs")
						and ReplicatedStorage.Systems.Jobs:FindFirstChild("StartJob")

					if startJob then
						startJob:FireServer("PizzaDelivery")
					end
					task.wait(2)

					while AutoPizza do
						local zone = workspace:FindFirstChild("CompletionRegion", true)
						local driveZone = zone and zone:FindFirstChild("DriveZone")
						local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")

						if driveZone and hrp then
							local target = driveZone.Position + Vector3.new(0, 5, 0)
							hrp.CFrame = CFrame.new(hrp.Position.X, FlyHeight, hrp.Position.Z)
							task.wait(0.8)
							hrp.CFrame = CFrame.new(target.X, FlyHeight, target.Z)
							task.wait(1.2)
							hrp.CFrame = CFrame.new(target)
							task.wait(1.5)
							task.wait(FarmDelay)
						else
							SetFreeze(false)
							task.wait(0.5)
							if startJob then
								startJob:FireServer("PizzaDelivery")
							end
							task.wait(2)
							SetFreeze(true)
							task.wait(1)
						end
						task.wait(0.5)
					end
				end)
				task.wait(1)
			end
		end)
	end,
})

PizzaBox:AddSlider("AL_FlyHeight", {
	Text = "Height",
	Default = 250,
	Min = 10,
	Max = 400,
	Rounding = 0,
	Callback = function(v)
		FlyHeight = v
	end,
})

PizzaBox:AddSlider("AL_FarmDelay", {
	Text = "Farm Delay",
	Default = 4,
	Min = 4,
	Max = 15,
	Rounding = 0,
	Callback = function(v)
		FarmDelay = v
	end,
})

local MiscBox = Tabs.Misc:AddLeftGroupbox("Visual")
local PlayerBox = Tabs.Misc:AddRightGroupbox("Player")

local fullbright = false
local oldLighting = {
	Brightness = Lighting.Brightness,
	ClockTime = Lighting.ClockTime,
	FogEnd = Lighting.FogEnd,
	GlobalShadows = Lighting.GlobalShadows,
}

local function applyFullBright()
	Lighting.Brightness = 5
	Lighting.ClockTime = 12
	Lighting.FogEnd = 1e6
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

MiscBox:AddToggle("AL_FullBright", {
	Text = "FullBright",
	Default = false,
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
	end,
})

MiscBox:AddToggle("AL_CamClip", {
	Text = "Camera Noclip",
	Default = false,
	Callback = function(v)
		if v then
			LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Invisicam
			Camera.CameraType = Enum.CameraType.Custom
		else
			LocalPlayer.DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
		end
	end,
})

local SavedWS = 16
local SavedJP = 50
local SavedFOV = Camera.FieldOfView
local SavedGravity = workspace.Gravity
local SavedZoom = LocalPlayer.CameraMaxZoomDistance
local DefaultWS, DefaultJP = 16, 50
local DefaultFOV = Camera.FieldOfView
local DefaultGravity = workspace.Gravity
local DefaultZoom = LocalPlayer.CameraMaxZoomDistance

local InfJump = false
local TPWalk = false
local TPWalkSpeed = 2
local SelectedReset = {}

local function getDefaultStats()
	local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	if hum then
		DefaultWS = hum.WalkSpeed
		DefaultJP = hum.JumpPower
	end
end

RunService.RenderStepped:Connect(function()
	if not TPWalk then
		return
	end
	local char = LocalPlayer.Character
	if not char then
		return
	end
	local hum = char:FindFirstChildOfClass("Humanoid")
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hum or not hrp then
		return
	end
	local move = hum.MoveDirection
	if move.Magnitude > 0 then
		hrp.CFrame = hrp.CFrame + move * TPWalkSpeed
	end
end)

PlayerBox:AddSlider("AL_WS", {
	Text = "WalkSpeed",
	Default = 16,
	Min = 1,
	Max = 350,
	Rounding = 0,
	Callback = function(v)
		SavedWS = v
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.WalkSpeed = v
		end
	end,
})

PlayerBox:AddSlider("AL_JP", {
	Text = "JumpPower",
	Default = 50,
	Min = 1,
	Max = 350,
	Rounding = 0,
	Callback = function(v)
		SavedJP = v
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		if hum then
			hum.JumpPower = v
		end
	end,
})

PlayerBox:AddSlider("AL_FOV", {
	Text = "FOV",
	Default = math.floor(SavedFOV),
	Min = 70,
	Max = 120,
	Rounding = 0,
	Callback = function(v)
		SavedFOV = v
		Camera.FieldOfView = v
	end,
})

PlayerBox:AddSlider("AL_Grav", {
	Text = "Gravity",
	Default = math.floor(SavedGravity),
	Min = 0,
	Max = 300,
	Rounding = 0,
	Callback = function(v)
		SavedGravity = v
		workspace.Gravity = v
	end,
})

PlayerBox:AddSlider("AL_Zoom", {
	Text = "Max Zoom",
	Default = math.floor(SavedZoom),
	Min = 0,
	Max = 1000,
	Rounding = 0,
	Callback = function(v)
		SavedZoom = v
		LocalPlayer.CameraMaxZoomDistance = v
	end,
})

PlayerBox:AddToggle("AL_InfJump", {
	Text = "Infinite Jump",
	Default = false,
	Callback = function(v)
		InfJump = v
	end,
})

PlayerBox:AddToggle("AL_TPWalk", {
	Text = "TP Walk",
	Default = false,
	Callback = function(v)
		TPWalk = v
	end,
})

PlayerBox:AddSlider("AL_TPWalkSpeed", {
	Text = "TP Walk Speed",
	Default = 2,
	Min = 1,
	Max = 30,
	Rounding = 0,
	Callback = function(v)
		TPWalkSpeed = v
	end,
})

UIS.JumpRequest:Connect(function()
	if not InfJump then
		return
	end
	local char = LocalPlayer.Character
	local hum = char and char:FindFirstChildOfClass("Humanoid")
	if hum then
		hum:ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

PlayerBox:AddDropdown("AL_ResetSelect", {
	Text = "Select Reset",
	Values = { "WalkSpeed", "JumpPower", "FOV", "Gravity", "Zoom", "InfJump", "TPWalk" },
	Default = {},
	Multi = true,
	Callback = function(selected)
		SelectedReset = selected
	end,
})

PlayerBox:AddButton({
	Text = "Reset Value",
	Func = function()
		local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		local list = SelectedReset

		-- multi set can u set muti in dropdown
		local function each(fn)
			if type(list) ~= "table" then
				return
			end
			for k, v in pairs(list) do
				if v == true and type(k) == "string" then
					fn(k)
				elseif type(v) == "string" then
					fn(v)
				end
			end
		end

		each(function(name)
			if name == "WalkSpeed" then
				SavedWS = DefaultWS
				if hum then
					hum.WalkSpeed = DefaultWS
				end
			elseif name == "JumpPower" then
				SavedJP = DefaultJP
				if hum then
					hum.JumpPower = DefaultJP
				end
			elseif name == "FOV" then
				SavedFOV = DefaultFOV
				Camera.FieldOfView = DefaultFOV
			elseif name == "Gravity" then
				SavedGravity = DefaultGravity
				workspace.Gravity = DefaultGravity
			elseif name == "Zoom" then
				SavedZoom = DefaultZoom
				LocalPlayer.CameraMaxZoomDistance = DefaultZoom
			elseif name == "InfJump" then
				InfJump = false
			elseif name == "TPWalk" then
				TPWalk = false
				TPWalkSpeed = 2
			end
		end)
		Notify("Player", "Reset applied", 2)
	end,
})

LocalPlayer.CharacterAdded:Connect(function(char)
	task.wait(0.3)
	getDefaultStats()
	local hum = char:FindFirstChildOfClass("Humanoid") or char:WaitForChild("Humanoid", 3)
	if hum then
		hum.WalkSpeed = SavedWS
		hum.JumpPower = SavedJP
	end
end)

getDefaultStats()

local NpcBox = Tabs.TP:AddLeftGroupbox("NPC")

local NPCFolder = workspace:FindFirstChild("ServerNPCs") or workspace:WaitForChild("ServerNPCs", 10)
local NPCList = {}
local SelectedNPC

local function refreshNPCList()
	table.clear(NPCList)
	if not NPCFolder then
		return
	end
	for _, v in ipairs(NPCFolder:GetChildren()) do
		table.insert(NPCList, v.Name)
	end
	table.sort(NPCList)
	pcall(function()
		if Options.AL_NPC and Options.AL_NPC.SetValues then
			Options.AL_NPC:SetValues(NPCList)
		end
	end)
end

NpcBox:AddDropdown("AL_NPC", {
	Text = "NPC",
	Values = { "(none)" },
	Default = 1,
	Searchable = true,
	Callback = function(v)
		SelectedNPC = v
	end,
})

task.defer(function()
	refreshNPCList()
	if NPCFolder then
		NPCFolder.ChildAdded:Connect(refreshNPCList)
		NPCFolder.ChildRemoved:Connect(refreshNPCList)
	end
end)

NpcBox:AddButton({
	Text = "Refresh NPC List",
	Func = function()
		refreshNPCList()
		Notify("TP", "NPC list refreshed", 2)
	end,
})

NpcBox:AddButton({
	Text = "Teleport",
	Func = function()
		if not SelectedNPC or SelectedNPC == "(none)" then
			return
		end
		if not NPCFolder then
			return
		end
		local npc = NPCFolder:FindFirstChild(SelectedNPC)
		if not npc then
			return
		end
		local root = npc:FindFirstChild("HumanoidRootPart")
			or npc.PrimaryPart
			or npc:FindFirstChildWhichIsA("BasePart", true)
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if root and hrp then
			hrp.CFrame = root.CFrame + Vector3.new(0, 5, 0)
		end
	end,
})

-- SHOP
local ShopBox = Tabs.Shop:AddLeftGroupbox("Shop")

local ShopDrink = "SodaCan"

ShopBox:AddDropdown("AL_ShopDrink", {
	Text = "Select Drink",
	Values = DrinkList,
	Default = "SodaCan",
	Callback = function(v)
		ShopDrink = v
	end,
})

ShopBox:AddButton({
	Text = "Buy Drink",
	Func = function()
		local BuyItem = ReplicatedStorage:FindFirstChild("Systems")
			and ReplicatedStorage.Systems:FindFirstChild("Shop")
			and ReplicatedStorage.Systems.Shop:FindFirstChild("BuyItem")
		if BuyItem then
			pcall(function()
				BuyItem:InvokeServer(ShopDrink, nil)
			end)
		end
	end,
})

ShopBox:AddButton({
	Text = "Buy All Drinks",
	Func = function()
		local BuyItem = ReplicatedStorage:FindFirstChild("Systems")
			and ReplicatedStorage.Systems:FindFirstChild("Shop")
			and ReplicatedStorage.Systems.Shop:FindFirstChild("BuyItem")
		if not BuyItem then
			return
		end
		for _, drink in ipairs(DrinkList) do
			pcall(function()
				BuyItem:InvokeServer(drink, nil)
			end)
			task.wait(0.1)
		end
	end,
})
local JobBox = Tabs.Server:AddLeftGroupbox("JobId")
local HopBox = Tabs.Server:AddRightGroupbox("Server")

local InputJobId = ""
local PlaceId = game.PlaceId
local JobId = game.JobId
local visitedServers = {}
local hopping = false

JobBox:AddInput("AL_JobId", {
	Text = "Enter JobId",
	Default = "",
	Placeholder = "Paste JobId...",
	Finished = true,
	Callback = function(text)
		InputJobId = tostring(text or "")
	end,
})

JobBox:AddButton({
	Text = "Copy JobId",
	Func = function()
		if setclipboard then
			setclipboard(JobId)
		elseif toclipboard then
			toclipboard(JobId)
		end
		Notify("Server", "JobId copied", 2)
	end,
})

JobBox:AddButton({
	Text = "Join JobId",
	Func = function()
		if InputJobId == "" then
			Notify("Server", "No JobId entered", 2)
			return
		end
		TeleportService:TeleportToPlaceInstance(PlaceId, InputJobId, LocalPlayer)
	end,
})

local function getServers()
	local servers = {}
	local ok, result = pcall(function()
		return game:HttpGet(
			"https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
		)
	end)
	if not ok then
		return servers
	end
	local data = HttpService:JSONDecode(result)
	for _, v in pairs(data.data or {}) do
		if v.playing < v.maxPlayers and not visitedServers[v.id] then
			table.insert(servers, v)
		end
	end
	return servers
end

HopBox:AddButton({
	Text = "Low Server",
	Func = function()
		if hopping then
			return
		end
		hopping = true
		Notify("Server", "Finding low server...", 2)
		local servers = getServers()
		if #servers > 0 then
			table.sort(servers, function(a, b)
				return a.playing < b.playing
			end)
			local target = servers[1]
			visitedServers[target.id] = true
			task.wait(1)
			TeleportService:TeleportToPlaceInstance(PlaceId, target.id, LocalPlayer)
		else
			Notify("Server", "No server found", 2)
			hopping = false
		end
	end,
})

HopBox:AddButton({
	Text = "Hop Server",
	Func = function()
		if hopping then
			return
		end
		hopping = true
		Notify("Server", "Finding random server...", 2)
		local servers = getServers()
		if #servers > 0 then
			local target = servers[math.random(1, #servers)]
			visitedServers[target.id] = true
			task.wait(1)
			TeleportService:TeleportToPlaceInstance(PlaceId, target.id, LocalPlayer)
		else
			Notify("Server", "No server found", 2)
			hopping = false
		end
	end,
})

HopBox:AddButton({
	Text = "Rejoin",
	Func = function()
		if hopping then
			return
		end
		hopping = true
		Notify("Server", "Rejoining...", 2)
		task.wait(1)
		TeleportService:Teleport(PlaceId, LocalPlayer)
	end,
})

local DiscBox = Tabs.Discord:AddLeftGroupbox("Community")

DiscBox:AddLabel("Hello, " .. LocalPlayer.DisplayName)
DiscBox:AddLabel("UserId: " .. tostring(LocalPlayer.UserId))
DiscBox:AddLabel("Account Age: " .. tostring(LocalPlayer.AccountAge) .. " days")

DiscBox:AddButton({
	Text = "Copy Discord Invite",
	Func = function()
		local link = "https://discord.gg/6y7TpYTBkW"
		if setclipboard then
			setclipboard(link)
		elseif toclipboard then
			toclipboard(link)
		end
		Notify("Discord", "Invite copied", 3)
	end,
})

ThemeManager:SetFolder("PhiPhaiAnimeLife")
ThemeManager:ApplyToTab(Tabs.Settings)
SaveManager:SetLibrary(Library)
SaveManager:IgnoreThemeSettings()
SaveManager:SetFolder("PhiPhaiAnimeLife")
SaveManager:BuildConfigSection(Tabs.Settings)
SaveManager:LoadAutoloadConfig()

