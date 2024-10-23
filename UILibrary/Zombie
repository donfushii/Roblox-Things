--[[

Coding: utf-8
Copyright (C) 2024 github.com/donfushii

--]]


local ImperiumLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/donfushii/Roblox-Things/main/UILibrary/Imperium"))()

local Windows = ImperiumLib:Window("Imperium", Color3.fromRGB(255, 102, 178), Enum.KeyCode.V) -- 44, 120, 224 -- Default Colour --
ImperiumLib:Notification("Notification", "Welcome to Imperium. Thanks for using my HUB, Soon we will bring more.", "Okay!")

-- [ TABS ] --

local MainTAB = Windows:Tab("Main")
local CombatTAB = Windows:Tab("Combat")
local CratesTAB = Windows:Tab("Crates")
local CreditsTAB = Windows:Tab("Credits")



-- [ VARIABLE'S ] --

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local player = Players.LocalPlayer
local humanoid = plr.Character.Humanoid




-- [ TOGGLE'S ] --

if _G.Settings == true then
	_G.AutoFarm = false
	_G.AutoEquip = false
	_G.AutoGetPowerups = false

	_G.GroundDistance = 0 -- [ AutoFarm Up / Down ] --
	_G.ZombieDist = 100000 -- [ Search Zombie Distance ] --
	_G.HeadSize = 3 -- [ HITBOX ] --
	
	elseif _G.Settings == false then
	  Settings()
	end
	
	local function Settings()
	_G.AutoFarm = false
	_G.AutoEquip = false
	_G.AutoGetPowerups = false

	_G.GroundDistance = 0 -- [ AutoFarm Up / Down ] --
	_G.ZombieDist = 100000 -- [ Search Zombie Distance ] --
	_G.HeadSize = 3 -- [ HITBOX ] --
end




-- [ FUNCTION'S ] --

local function SendNotify(title, message, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = message, Duration = duration;})
end




-- [ TAB #1 ] --

MainTAB:Button("📍 ・ Anti AFK", function()
	wait(0.5)
		local ba=Instance.new("ScreenGui")
		local ca=Instance.new("TextLabel")local da=Instance.new("Frame")
		local _b=Instance.new("TextLabel")local ab=Instance.new("TextLabel")ba.Parent=game.CoreGui

			ba.ZIndexBehavior=Enum.ZIndexBehavior.Sibling;ca.Parent=ba;ca.Active=true
			ca.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ca.Draggable=true
			ca.Position=UDim2.new(0.698610067,0,0.098096624,0)ca.Size=UDim2.new(0,0,0,0)
			ca.Font=Enum.Font.SourceSansSemibold;ca.Text=""ca.TextColor3=Color3.new(0,1,1)
			ca.TextSize=22;da.Parent=ca
			da.BackgroundColor3=Color3.new(0.196078,0.196078,0.196078)da.Position=UDim2.new(0,0,1.0192306,0)
			da.Size=UDim2.new(0,0,0,0)_b.Parent=da
			_b.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)_b.Position=UDim2.new(0,0,0.800455689,0)
			_b.Size=UDim2.new(0,0,0,0)_b.Font=Enum.Font.Arial;_b.Text=""
			_b.TextColor3=Color3.new(0,1,1)_b.TextSize=20;ab.Parent=da
			ab.BackgroundColor3=Color3.new(0.176471,0.176471,0.176471)ab.Position=UDim2.new(0,0,0.158377,0)
			ab.Size=UDim2.new(0,0,0,0)ab.Font=Enum.Font.ArialBold;ab.Text=""

		ab.TextColor3=Color3.new(0,1,1)ab.TextSize=20;local bb=game:service'VirtualUser'
		game:service'Players'.LocalPlayer.Idled:connect(function()
		bb:CaptureController()bb:ClickButton2(Vector2.new())
	ab.Text=""wait(2)ab.Text=""end)

	wait(0.1)

	game.StarterGui:SetCore("SendNotification", {Title = "[Notification]", Text = "Anti AFK Enabled!", Duration = 5, })
end)


---- [ ] ----


MainTAB:Toggle("📌 ・ Auto Farm", false, function(bool)
	_G.AutoFarm = bool
end)

MainTAB:Toggle("📌 ・ Auto GetPowersups", false, function(bool)	
	_G.AutoGetPowerups = bool
end)

MainTAB:Toggle("📌 ・ Auto Equip Guns", false, function(bool)	
	_G.AutoEquip = bool
end)




-- [ TAB #2 ] --

CombatTAB:Textbox("📌 ・ Hitbox", true, function(value)
	_G.HeadSize = value
end)

CombatTAB:Textbox("📌 ・ Ground Distance [Y]", true, function(value)
	_G.GroundDistance = value
end)

CombatTAB:Textbox("📌 ・ Ground Distance [X]", true, function(value)
	_G.GroundDistance = value
end)

CombatTAB:Textbox("📌 ・ Search Zombie Dist", true, function(value)
	_G.ZombieDist = value
end)

--[[CombatTAB:Slider("📌 ・ Hitbox", 3, 50, 3, function(value)
	_G.HeadSize = value
end)

CombatTAB:Slider("📌 ・ Ground Distance [Y]", 0, 150, 0, function(value)
	_G.GroundDistance = value
end)

CombatTAB:Slider("📌 ・ Ground Distance [X]", 0, -150, 0, function(value)
	_G.GroundDistance = value
end)

CombatTAB:Slider("📌 ・ Search Zombie Dist", 0, 250000, 100000, function(value)
	_G.ZombieDist = value
end)
]]

CombatTAB:Label("     ^  Not recomend to change  ^")




-- [ TAB #1 ] --

CratesTAB:Button("📍 ・ Open Crate #1 [1 KEY]", function()
	local args = {
		[1] = "unbox_box",
		[2] = "Basic #1"
	}
	
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #2 [1 KEY]", function()
	local args = {
		[1] = "unbox_box",
		[2] = "Basic #2"
	}
	
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #3 [1 KEY]", function()
	local args = {
		[1] = "unbox_box",
		[2] = "Basic #3"
	}
	
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #4 [3 KEY]", function()
	local args = {
		[1] = "unbox_box",
		[2] = "Uncommon"
	}
	
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #5 [10 KEY]", function()
	local args = {
		[1] = "unbox_box",
		[2] = "Rare"
	}
	
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #6 [30 KEY]", function()
	local args = {
		[1] = "unbox_box",
		[2] = "Legendary"
	}
	
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)




-- [ TAB #3 ] --

CreditsTAB:Label("・ Owner   :  @donfushii")
CreditsTAB:Label("・ Tester    :  @ImperiumClothes")

CreditsTAB:Button("📍 ・ Copy Discord", function()
	setclipboard("discord.gg/UBcYG3sA")
end)

CreditsTAB:Colorpicker("📍 ・ UI Color",Color3.fromRGB(44, 120, 224), function(t)
    ImperiumLib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)



-- [ CONFIGURATION ] --

while wait() do
	local bosses = game.Workspace.BossFolder:GetChildren()
 for _, v in ipairs(bosses) do
	 if game.Workspace.enemies:FindFirstChild("Zombie") then
		 for i,v in pairs(game.Workspace.enemies:GetChildren()) do
			 wait()
			 if v:FindFirstChild("Head") then
				 v.Head.CanCollide = false
				 v.Head.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
				 v.Head.CFrame = v.Torso.CFrame * CFrame.new(0,_G.HeadSize/2,0)
			 end
		 end
	 end
 end

local function modifyHitbox()
 local enemies = workspace.enemies:GetChildren()
 for _, v in ipairs(enemies) do
	 if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
		 v.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
		 v.HumanoidRootPart.Material = "Neon"
		 v.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
		 v.HumanoidRootPart.Transparency = 0.92
		 v.HumanoidRootPart.CanCollide = false
	 end
 end
 
 local bosses = game.Workspace.BossFolder:GetChildren()
 for _, v in ipairs(bosses) do
	 if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
		 v.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
		 v.HumanoidRootPart.Material = "Neon"
		 v.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
		 v.HumanoidRootPart.Transparency = 0.92
		 v.HumanoidRootPart.CanCollide = false
	 end
 end
end

spawn(function()
 while true do
	 modifyHitbox()
	 wait(0.1)
 end
end)

local function autoequip()
 local player = game.Players.LocalPlayer
 local backpack = player.Backpack

 for _,item in pairs(backpack:GetChildren()) do
	 if item:IsA("Tool") then
		 item.Parent = player.Character
	 end
 end
end

local function autogetpowerupscript()
 powerups = game.workspace.Powerups
 print(powerups)
   for i,v in pairs(powerups:GetChildren()) do 
        print(v.Part.TouchInterest)
   firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,v.Part,0)
   end
end

spawn(function()
 while true do
	 if _G.AutoGetPowerups then
		 autogetpowerupscript()
	 end
	 wait(0.1)
 end
end)

spawn(function()
 while true do
	 if _G.AutoEquip then
		 autoequip()
	 end
	 wait(0.1)
 end
end)

local Player = game:GetService("Players").LocalPlayer

local function getNearest()
 local nearest, dist = nil, _G.ZombieDist
 for _,v in pairs(game.Workspace.BossFolder:GetChildren()) do
	 if v:FindFirstChild("Head") then
		 local m = (Player.Character.Head.Position - v.Head.Position).magnitude
		 if m < dist then
			 dist = m
			 nearest = v
		 end
	 end
 end
 for _,v in pairs(game.Workspace.enemies:GetChildren()) do
	 if v:FindFirstChild("Head") then
		 local m = (Player.Character.Head.Position - v.Head.Position).magnitude
		 if m < dist then
			 dist = m
			 nearest = v
		 end
	 end
 end
 return nearest
end





_G.globalTarget = nil
game:GetService("RunService").RenderStepped:Connect(function()
 if _G.AutoFarm == true then
	 local target = getNearest()
	 if target and target:FindFirstChild("Head") then
		 game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
		 Player.Character.HumanoidRootPart.CFrame =
		 (target.HumanoidRootPart.CFrame * CFrame.new(0, _G.GroundDistance, 9))
		 _G.globalTarget = target
	 end
 end
end)

spawn(function()
 while wait() do
	 game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
	 game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0,0)
 end
end)

while wait() do 
 if _G.AutoFarm == true and _G.globalTarget ~= nil and _G.globalTarget:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool") then -- Script
	 local target = _G.globalTarget
	 game.ReplicatedStorage.Gun:FireServer({
		 ["Normal"] = Vector3.new(0, 0, 0),
		 ["Direction"] = target.Head.Position,
		 ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name,
		 ["Hit"] = target.Head,
		 ["Origin"] = target.Head.Position,
		 ["Pos"] = target.Head.Position,
	 })
	 wait()
end
end
end
