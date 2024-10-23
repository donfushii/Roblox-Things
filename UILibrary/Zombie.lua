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
local plr = Players.LocalPlayer
local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")

-- [ SETTINGS ] --

_G.AutoFarm = false
_G.AutoEquip = false
_G.AutoGetPowerups = false
_G.GroundDistance = 0 -- [ Ground Distance: UP / DOWN ] --
_G.ZombieDist = 100000 -- [ Search Zombie Distance ] --
_G.HeadSize = 3 -- [ HITBOX ] --

-- [ FUNCTIONS ] --

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
	game.Players.LocalPlayer.Idled:Connect(function()
		game:GetService("VirtualUser"):CaptureController()
		game:GetService("VirtualUser"):ClickButton2(Vector2.new())
	end)
	SendNotify("[Notification]", "Anti AFK Enabled!", 5)
end)

MainTAB:Toggle("📌 ・ Auto Farm", false, function(bool)
	_G.AutoFarm = bool
end)

MainTAB:Toggle("📌 ・ Auto Get Powersups", false, function(bool)
	_G.AutoGetPowerups = bool
end)

MainTAB:Toggle("📌 ・ Auto Equip Guns", false, function(bool)
	_G.AutoEquip = bool
end)

-- [ TAB #2 - COMBAT ] --

CombatTAB:Textbox("📌 ・ Ground Distance", true, function(value)
	_G.GroundDistance = tonumber(value) or 0 -- Ensure it's a number or default to 0
end)

CombatTAB:Textbox("📌 ・ Set Hitbox", true, function(value)
	_G.HeadSize = tonumber(value) or 3 -- Ensure it's a number or default to 3
end)

CombatTAB:Slider("📌 ・ Set WalkSpeed", 5, 500, 16, function(value)
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		plr.Character.Humanoid.WalkSpeed = value
	end
end)

CombatTAB:Slider("📌 ・ Set JumpPower", 5, 500, 50, function(value)
	if plr.Character and plr.Character:FindFirstChild("Humanoid") then
		plr.Character.Humanoid.JumpPower = value
	end
end)

-- [ HITBOX CONFIG ] --

local function modifyHitbox()
	local enemies = workspace.enemies:GetChildren()
	for _, v in pairs(enemies) do
		if v:IsA("Model") and v:FindFirstChild("HumanoidRootPart") then
			v.HumanoidRootPart.Size = Vector3.new(_G.HeadSize, _G.HeadSize, _G.HeadSize)
			v.HumanoidRootPart.Material = "Neon"
			v.HumanoidRootPart.BrickColor = BrickColor.new("Really blue")
			v.HumanoidRootPart.Transparency = 0.92
			v.HumanoidRootPart.CanCollide = false
		end
	end
end

-- [ AUTOEQUIP CONFIG ] --

local function autoEquip()
	local player = game.Players.LocalPlayer
	local backpack = player.Backpack

	for _, item in pairs(backpack:GetChildren()) do
		if item:IsA("Tool") then
			item.Parent = player.Character
		end
	end
end

-- [ GETPOWERUPS CONFIG ] --

local function autoGetPowerups()
	for _, v in pairs(workspace.Powerups:GetChildren()) do
		if v:IsA("Part") then -- Check if the powerup has a Part
			firetouchinterest(Players.LocalPlayer.Character.HumanoidRootPart, v, 0)
		end
	end
end

-- [ ZOMBIE DETECTION ] --

local function getNearest()
	local nearest, dist = nil, _G.ZombieDist

	if not plr.Character or not plr.Character:FindFirstChild("Head") then
		return nil
	end

	for _, v in pairs(workspace.BossFolder:GetChildren()) do
		if v:FindFirstChild("Head") then
			local m = (plr.Character.Head.Position - v.Head.Position).Magnitude
			if m < dist then
				dist = m
				nearest = v
			end
		end
	end

	for _, v in pairs(workspace.enemies:GetChildren()) do
		if v:FindFirstChild("Head") then
			local m = (plr.Character.Head.Position - v.Head.Position).Magnitude
			if m < dist then
				dist = m
				nearest = v
			end
		end
	end
	return nearest
end

-- [ AUTOFARM LOGIC ] --

spawn(function()
	while true do
		if _G.AutoFarm then
			local target = getNearest()
			if target and target:FindFirstChild("Head") then
				local targetPosition = target.HumanoidRootPart.Position

				-- Mueve la cámara suavemente hacia el objetivo
				game.Workspace.CurrentCamera.CFrame = CFrame.new(game.Workspace.CurrentCamera.CFrame.Position, targetPosition)

				if plr.Character and plr.Character:FindFirstChild("Humanoid") and plr.Character:FindFirstChild("HumanoidRootPart") then
					-- Teletransporta al personaje al objetivo con un pequeño offset
					plr.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, _G.GroundDistance, 9))

					-- Agrega un pequeño tiempo de espera después de mover
					wait(0.1)
				end
			end
		end
		wait(0.1) -- Intervalo de espera para evitar sobrecargar el bucle
	end
end)

-- [ AUTOEQUIP LOOP ] --

spawn(function()
	while true do
		if _G.AutoEquip then
			autoEquip()
		end
		wait(0.1)
	end
end)

-- [ GET POWERUPS LOOP ] --

spawn(function()
	while true do
		if _G.AutoGetPowerups then
			autoGetPowerups()
		end
		wait(0.1)
	end
end)

-- [ TAB #3 - CRATES ] --

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

-- [ TAB #4 - CREDITS ] --

CreditsTAB:Label("・ Owner   :  @donfushii")
CreditsTAB:Label("・ Tester    :  @ImperiumClothes")

CreditsTAB:Button("📍 ・ Copy Discord", function()
	setclipboard("discord.gg/UBcYG3sA")
end)

CreditsTAB:Colorpicker("📍 ・ UI Color", Color3.fromRGB(245, 102, 154), function(t)
	ImperiumLib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
