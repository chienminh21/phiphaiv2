local a,b,c=loadstring,game.HttpGet,game
local d=a(b(c,"https://sirius.menu/rayfield"))()
local e=c:GetService("Players")
local f=c:GetService("RunService")
local g=c:GetService("Lighting")
local h=c:GetService("ProximityPromptService")
local i=c:GetService("UserInputService")
local j=e.LocalPlayer
local k=workspace.CurrentCamera

local l=d:CreateWindow({
 Name="PhiPhai V2",
 LoadingTitle="join my server to get update",
 LoadingSubtitle="by obi",
 Theme="Default",
 ToggleUIKeybind="K",
 ConfigurationSaving={Enabled=true,FileName="phi phai v2"},
 Discord={Enabled=true,Invite="SYX99GChEE",RememberJoins=true}
})

local m=l:CreateTab("Universal",4483362458)
local n=70
m:CreateSlider({
 Name="FOV",Range={70,120},CurrentValue=70,
 Callback=function(o)n=o;k.FieldOfView=o end
})
f.RenderStepped:Connect(function()
 if k.FieldOfView~=n then k.FieldOfView=n end
end)

local p=false
local q
m:CreateToggle({
 Name="Anti AFK",
 Callback=function(r)
  p=r
  if r then
   q=j.Idled:Connect(function()
    local v=c:GetService("VirtualUser")
    v:Button2Down(Vector2.new(),k.CFrame)
    task.wait(1)
    v:Button2Up(Vector2.new(),k.CFrame)
   end)
  elseif q then q:Disconnect() end
 end
})

local s,t,u
m:CreateToggle({
 Name="Third Person View",
 Callback=function(r)
  if r then
   s=j.CameraMode
   t=j.CameraMinZoomDistance
   u=j.CameraMaxZoomDistance
   j.CameraMode=Enum.CameraMode.Classic
   j.CameraMinZoomDistance=8
   j.CameraMaxZoomDistance=20
  else
   j.CameraMode=s or Enum.CameraMode.LockFirstPerson
   j.CameraMinZoomDistance=t or 0
   j.CameraMaxZoomDistance=u or 0
  end
 end
})

local w=j.CameraMaxZoomDistance
m:CreateToggle({
 Name="Unlock Max Zoom",
 Callback=function(r)
  if r then
   w=j.CameraMaxZoomDistance
   j.CameraMaxZoomDistance=9e9
  else
   j.CameraMaxZoomDistance=w
  end
 end
})

local x=false
local y,z,A=g.Ambient,g.ColorShift_Top,g.ColorShift_Bottom
local B
local function C()
 g.Ambient=Color3.new(1,1,1)
 g.ColorShift_Top=Color3.new(1,1,1)
 g.ColorShift_Bottom=Color3.new(1,1,1)
end

m:CreateToggle({
 Name="Fullbright",
 Callback=function(r)
  x=r
  if r then
   C()
   B=g.LightingChanged:Connect(function()
    if x then C() end
   end)
  else
   if B then B:Disconnect() end
   g.Ambient=y;g.ColorShift_Top=z;g.ColorShift_Bottom=A
  end
 end
})

local D
local function E(F)
 for _,G in ipairs(F:GetDescendants()) do
  if G:IsA("BasePart") then G.CanCollide=false end
 end
end

m:CreateToggle({
 Name="Noclip",
 Callback=function(r)
  if r then
   D=f.Stepped:Connect(function()
    local H=j.Character
    if H then E(H) end
   end)
  elseif D then D:Disconnect() end
 end
})

local I=false
m:CreateToggle({Name="Infinite Jump",Callback=function(r)I=r end})
i.JumpRequest:Connect(function()
 if I then
  local J=j.Character and j.Character:FindFirstChildOfClass("Humanoid")
  if J then J:ChangeState(Enum.HumanoidStateType.Jumping) end
 end
end)

local K=false
h.PromptButtonHoldBegan:Connect(function(L)
 if K then fireproximityprompt(L) end
end)
m:CreateToggle({Name="Fast Interact",Callback=function(r)K=r end})

local M=false
m:CreateToggle({Name="Auto Interact",Callback=function(r)M=r end})
h.PromptShown:Connect(function(L)
 if M then task.wait(.05) pcall(function()fireproximityprompt(L)end) end
end)

d:Notify({
 Title="discord.gg/SYX99GChEE",
 Content="Very cool gui",
 Duration=5
})
