--[[

Coding: utf-8
Copyright (C) 2024 github.com/donfushii

--]]

local ImperiumLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/donfushii/Roblox-Things/main/UILibrary/Imperium"))()

local Windows = ImperiumLib:Window("Imperium", Color3.fromRGB(255, 102, 178), Enum.KeyCode.V)
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
_G.GroundDistance = 0
_G.ZombieDist = 100000
_G.HeadSize = 3

-- [ FUNCTIONS ] --

local function SendNotify(title, message, duration)
    game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = message, Duration = duration;})
end

local function Settings()
    _G.AutoFarm = false
    _G.AutoEquip = false
    _G.AutoGetPowerups = false
end

-- [ TAB #1 - Main ] --

MainTAB:Button("📍 ・ Anti AFK", function()
    game:GetService("Players").LocalPlayer.Idled:Connect(function()
        game:GetService("VirtualUser"):CaptureController()
        game:GetService("VirtualUser"):ClickButton2(Vector2.new())
    end)
    SendNotify("[Notification]", "Anti AFK Enabled!", 5)
end)

MainTAB:Toggle("📌 ・ Auto Farm", false, function(bool)
    _G.AutoFarm = bool
end)

MainTAB:Toggle("📌 ・ Auto GetPowersups", false, function(bool)
    _G.AutoGetPowerups = bool
end)

MainTAB:Toggle("📌 ・ Auto Equip Guns", false, function(bool)
    _G.AutoEquip = bool
end)

-- [ TAB #2 - Combat ] --

CombatTAB:Textbox("📌 ・ Hitbox [3]", true, function(value)
    _G.HeadSize = tonumber(value)
end)

CombatTAB:Textbox("📌 ・ Search Zombie Dist [100000]", true, function(value)
    _G.ZombieDist = tonumber(value)
end)

CombatTAB:Label("     ^  Not recommended to change  ^")

-- [ FUNCTIONS DE UTILIDAD ] --

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

local function autoEquip()
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack

    for _, item in pairs(backpack:GetChildren()) do
        if item:IsA("Tool") then
            item.Parent = player.Character
        end
    end
end

local function autoGetPowerups()
    for _, v in pairs(workspace.Powerups:GetChildren()) do
        firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Part, 0)
    end
end

-- [ Nearest Zombie Detection ] --

local function getNearest()
    local nearest, dist = nil, _G.ZombieDist

    if not Player.Character or not Player.Character:FindFirstChild("Head") then
        return nil
    end

    for _, v in pairs(game.Workspace.BossFolder:GetChildren()) do
        if v:FindFirstChild("Head") then
            local m = (Player.Character.Head.Position - v.Head.Position).magnitude
            if m < dist then
                dist = m
                nearest = v
            end
        end
    end

    for _, v in pairs(game.Workspace.enemies:GetChildren()) do
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

-- [ AutoFarm Logic ] --

spawn(function()
    while true do
        if _G.AutoFarm then
            local target = getNearest()
            if target and target:FindFirstChild("Head") then
                game.Workspace.CurrentCamera.CFrame = CFrame.new(
                    game.Workspace.CurrentCamera.CFrame.Position, 
                    target.Head.Position
                )
                Player.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame * CFrame.new(0, _G.GroundDistance, 9)
            end
        end
        wait(0.1)
    end
end)

-- [ Auto Equip Loop ] --

spawn(function()
    while true do
        if _G.AutoEquip then
            autoEquip()
        end
        wait(0.1)
    end
end)

-- [ Auto Get Powerups Loop ] --

spawn(function()
    while true do
        if _G.AutoGetPowerups then
            autoGetPowerups()
        end
        wait(0.1)
    end
end)

-- [ Crates Tab ] --

CratesTAB:Button("📍 ・ Open Crate #1 [1 KEY]", function()
    game.ReplicatedStorage.RemoteEventContainer.CommunicationF:InvokeServer("unbox_box", "Basic #1")
end)

-- [ Credits Tab ] --

CreditsTAB:Label("・ Owner: @donfushii")
CreditsTAB:Label("・ Tester: @ImperiumClothes")

CreditsTAB:Button("📍 ・ Copy Discord", function()
    setclipboard("discord.gg/UBcYG3sA")
end)

CreditsTAB:Colorpicker("📍 ・ UI Color", Color3.fromRGB(44, 120, 224), function(t)
    ImperiumLib:ChangePresetColor(Color3.fromRGB(t.R * 255, t.G * 255, t.B * 255))
end)
