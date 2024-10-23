--[[

Coding: utf-8
Copyright (C) 2024 github.com/donfushii

--]]


local ImperiumLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/donfushii/Roblox-Things/main/UILibrary/Imperium"))()

local Windows = ImperiumLib:Window("Imperium", Color3.fromRGB(245, 102, 154), Enum.KeyCode.V) -- 44, 120, 224 -- Default Colour --
ImperiumLib:Notification("Notification", "Welcome to Imperium. Thanks for using my HUB, Soon we will bring more.", "Okay!")

-- [ TABS ] --

local MainTAB = Windows:Tab("Main")
local CombatTAB = Windows:Tab("Combat")
local CratesTAB = Windows:Tab("Crates")
local CreditsTAB = Windows:Tab("Credits")



-- [ VARIABLE'S ] --

local Players = game:GetService("Players")
local plr = Players.LocalPlayer
local humanoid = plr.Character and plr.Character:FindFirstChild("Humanoid")




-- [ SETTING'S ] --

_G.AutoFarm = false
_G.AutoEquip = false
_G.AutoGetPowerups = false
_G.GroundDistance = 0 -- [ Ground Distance: UP / DOWN ] --
_G.ZombieDist = 100000 -- [ Search Zombie Distance ] --
_G.HeadSize = 3 -- [ HITBOX ] --



-- [ FUNCTION'S ] --

local function SendNotify(title, message, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = message, Duration = duration;})
end

local function Settings()
    _G.AutoFarm = false
    _G.AutoEquip = false
    _G.AutoGetPowerups = false
end




-- [ TAB #1  -  MAIN ] --

MainTAB:Button("📍 ・ Anti AFK", function()
	game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
    SendNotify("[Notification]", "Anti AFK Enabled!", 5)
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




-- [ TAB #2  -  COMBAT ] --

CombatTAB:Textbox("📌 ・ Ground Distance", true, function(value)
	_G.GroundDistance = tonumber(value)
end)

CombatTAB:Textbox("📌 ・ Set Hitbox", true, function(value)
	_G.HeadSize = tonumber(value)
end)

CombatTAB:Slider("📌 ・ Set WalkSpeed", 5, 500, 16, function(value)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = tonumber(value)
end)

CombatTAB:Slider("📌 ・ Set JumpPower", 5, 500, 50, function(value)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = tonumber(value)
end)

--[[
CombatTAB:Textbox("📌 ・ Search Zombie Dist [100000]", true, function(value)
	_G.ZombieDist = tonumber(value)
end)
]]



-- [ HITBOX CONFIG ] --

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

spawn(function()
    while true do
        if _G.AutoEquip then
            autoequip()
        end
        wait(0.1)
    end
end)

-- [ GETPOWERUPS CONFIG ] --

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

-- [ ZOMBIE DETECTION ] --

local Player = game:GetService("Players").LocalPlayer

local function getNearest()
    local nearest, dist = nil, _G.dist
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

-- [ AUTOFARM LOGIC ] --

_G.globalTarget = nil
game:GetService("RunService").RenderStepped:Connect(function()
    if _G.farm2 == true then
        local target = getNearest()
        if target and target:FindFirstChild("Head") then
            game:GetService("Workspace").CurrentCamera.CFrame = CFrame.new(game:GetService("Workspace").CurrentCamera.CFrame.p, target.Head.Position)
            Player.Character.HumanoidRootPart.CFrame =
            (target.HumanoidRootPart.CFrame * CFrame.new(0, _G.groundDistance, 9))
            _G.globalTarget = target
        end
    end
end)

spawn(function() -- Player Velocity
    while wait() do
        game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0,0,0)
        game.Players.LocalPlayer.Character.Torso.Velocity = Vector3.new(0,0,0)
    end
end)

while wait() do -- _G. == true and _G. ~= nil (zombie) FindFirstChild Head (Zombie)
    if _G.farm2 == true and _G.globalTarget ~= nil and _G.globalTarget:FindFirstChild("Head") and Player.Character:FindFirstChildOfClass("Tool") then -- Script
        local target = _G.globalTarget -- _G.
        game.ReplicatedStorage.Gun:FireServer({ -- Event
            ["Normal"] = Vector3.new(0, 0, 0), -- Vector3
            ["Direction"] = target.Head.Position, -- Position
            ["Name"] = Player.Character:FindFirstChildOfClass("Tool").Name, -- Tool Player
            ["Hit"] = target.Head, -- HeadShot
            ["Origin"] = target.Head.Position, -- Position Head
            ["Pos"] = target.Head.Position, -- Position Head
        }) -- close
        wait() -- wait
  end
 end
end



-- [ TAB #3  -  CRATES ] --

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




-- [ TAB #4  -  CREDITS ] --

CreditsTAB:Label("・ Owner   :  @donfushii")
CreditsTAB:Label("・ Tester    :  @ImperiumClothes")

CreditsTAB:Button("📍 ・ Copy Discord", function()
	setclipboard("discord.gg/UBcYG3sA")
end)

CreditsTAB:Colorpicker("📍 ・ UI Color", Color3.fromRGB(245, 102, 154), function(t)
    ImperiumLib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
