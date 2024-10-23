--[[

Coding: utf-8
Copyright (C) 2024 github.com/donfushii

--]]

local ImperiumLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/donfushii/Roblox-Things/main/UILibrary/Imperium"))()

local Windows = ImperiumLib:Window("Imperium", Color3.fromRGB(245, 102, 154), Enum.KeyCode.V)
ImperiumLib:Notification("Notification", "Welcome to Imperium. Thanks for using my HUB, Soon we will bring more.", "Okay!")

-- [ TABS ] --

local MainTAB = Windows:Tab("Main")
local CombatTAB = Windows:Tab("Combat")
local CratesTAB = Windows:Tab("Crates")
local CreditsTAB = Windows:Tab("Credits")

-- [ VARIABLES ] --

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ImperiumBrick = Color3.fromRGB(245, 102, 154)
local ImperiumColor = BrickColor.new(ImperiumBrick)

-- [ SETTINGS ] --

_G.AutoFarm = false
_G.AutoEquip = false
_G.AutoGetPowerups = false
_G.GroundDistance = 0
_G.ZombieDist = 100000
_G.HeadSize = 3

-- [ FUNCTION'S ] --

local function SendNotify(title, message, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = message, Duration = duration})
end

local function Settings()
	_G.AutoFarm = false
	_G.AutoEquip = false
	_G.AutoGetPowerups = false
end

-- [ TAB #1 - MAIN ] --

MainTAB:Button("📍 ・ Anti AFK", function()
	Players.LocalPlayer.Idled:Connect(function()
		game:GetService("VirtualUser"):CaptureController()
		game:GetService("VirtualUser"):ClickButton2(Vector2.new())
	end)
	SendNotify("[Notification]", "Anti AFK Enabled!", 5)
end)

MainTAB:Toggle("📌 ・ Auto Farm", false, function(bool)
	_G.AutoFarm = bool
end)

MainTAB:Toggle("📌 ・ Auto Get Powerups", false, function(bool)	
	_G.AutoGetPowerups = bool
end)

MainTAB:Toggle("📌 ・ Auto Equip Guns", false, function(bool)	
	_G.AutoEquip = bool
end)

-- [ TAB #2 - COMBAT ] --

CombatTAB:Textbox("📌 ・ Ground Distance", true, function(value)
	_G.GroundDistance = tonumber(value) or 0
end)

CombatTAB:Textbox("📌 ・ Set Hitbox", true, function(value)
	_G.HeadSize = tonumber(value) or 3
end)

CombatTAB:Slider("📌 ・ Set WalkSpeed", 5, 500, 16, function(value)
	Player.Character.Humanoid.WalkSpeed = tonumber(value) or 16
end)

CombatTAB:Slider("📌 ・ Set JumpPower", 5, 500, 50, function(value)
	Player.Character.Humanoid.JumpPower = tonumber(value) or 50
end)



-- [ HITBOX CONFIG ] --

local function modifyHitbox()
	local targets = {workspace.enemies:GetChildren(), workspace.BossFolder:GetChildren()}
	for _, targetGroup in ipairs(targets) do
		for _, v in ipairs(targetGroup) do
			if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
				local humanoidRootPart = v.HumanoidRootPart
				humanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
				humanoidRootPart.Material = "Neon"
				humanoidRootPart.BrickColor = ImperiumColor
				humanoidRootPart.Transparency = 0.92
				humanoidRootPart.CanCollide = false
			end
		end
	end
end

spawn(function()
	while true do
		modifyHitbox()
		wait(0.1)
	end
end)

-- [ AUTOEQUIP CONFIG ] --

local function autoEquip()
	local backpack = Player.Backpack
	for _, item in pairs(backpack:GetChildren()) do
		if item:IsA("Tool") then
			item.Parent = Player.Character
		end
	end
end

spawn(function()
	while true do
		if _G.AutoEquip then
			autoEquip()
		end
		wait(0.1)
	end
end)

-- [ GET POWERUPS CONFIG ] --

local function autogetpowerupscript()
	local powerups = game.workspace.Powerups
	for _, v in pairs(powerups:GetChildren()) do 
		firetouchinterest(Player.Character.HumanoidRootPart, v.Part, 0)
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

-- [ ZOMBIE DETECTION ] --

local function getNearest()
	local nearest, dist = nil, _G.ZombieDist
	local allTargets = {workspace.BossFolder:GetChildren(), workspace.enemies:GetChildren()}
	for _, targetGroup in ipairs(allTargets) do
		for _, v in ipairs(targetGroup) do
			if v:FindFirstChild("Head") then
				local m = (Player.Character.Head.Position - v.Head.Position).magnitude
				if m < dist then
					dist = m
					nearest = v
				end
			end
		end
	end
	return nearest
end

-- [ AUTOFARM LOGIC ] --

_G.globalTarget = nil
game:GetService("RunService").RenderStepped:Connect(function()
	if _G.AutoFarm then
		local target = getNearest()
		if target and target:FindFirstChild("Head") then
			game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.p, target.Head.Position)
			Player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.GroundDistance, 9)
			_G.globalTarget = target
		end
	end
end)

spawn(function()
	while wait() do
		Player.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
		Player.Character.Torso.Velocity = Vector3.new(0, 0, 0)
	end
end)

spawn(function()
	while wait() do
		if _G.AutoFarm and _G.globalTarget and _G.globalTarget:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool") then
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
end)



-- [ TAB #3 - CRATES ] --

CratesTAB:Button("📍 ・ Open Crate #1 [1 KEY]", function()
	local args = {"unbox_box", "Basic #1"}
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #2 [1 KEY]", function()
	local args = {"unbox_box", "Basic #2"}
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #3 [1 KEY]", function()
	local args = {"unbox_box", "Basic #3"}
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #4 [3 KEY]", function()
	local args = {"unbox_box", "Uncommon"}
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #5 [10 KEY]", function()
	local args = {"unbox_box", "Rare"}
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

CratesTAB:Button("📍 ・ Open Crate #6 [30 KEY]", function()
	local args = {"unbox_box", "Legendary"}
	game:GetService("ReplicatedStorage").RemoteEventContainer.CommunicationF:InvokeServer(unpack(args))
end)

-- [ TAB #4 - CREDITS ] --

CreditsTAB:Label("・ Owner   :  @donfushii")
CreditsTAB:Label("・ Tester    :  @ImperiumClothes")

CreditsTAB:Button("📍 ・ Copy Discord", function()
	setclipboard("discord.gg/UBcYG3sA")
end)

CreditsTAB:Colorpicker("📍 ・ UI Color", Color3.fromRGB(245, 102, 154), function(t)
	ImperiumLib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
