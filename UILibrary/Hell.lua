--[[

Coding: utf-8
Copyright (C) 2024 github.com/donfushii

--]]


getsenv(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("LocalScript")).kick = function()
    return;
end


local ImperiumLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/donfushii/Roblox-Things/main/UILibrary/Imperium"))()

local Windows = ImperiumLib:Window("Imperium", Color3.fromRGB(255, 102, 178), Enum.KeyCode.V) -- 44, 120, 224 -- Default Colour --
ImperiumLib:Notification("Notification", "Welcome to Imperium. Thanks for using my HUB, Soon we will bring more.", "Okay!")

-- [ TABS ] --

local MainTAB = Windows:Tab("Main")
local MovementTAB = Windows:Tab("Movement")
local CreditsTAB = Windows:Tab("Credits")




-- [ TOGGLE'S ] --

getgenv().autofarm = false
getgenv().godmode = false
game.Players.LocalPlayer.CharacterAdded:Connect(function(char)
     game.Players.LocalPlayer:WaitForChild("KillScript").Disabled = getgenv().godmode
end)


-- [ ANTI AFK ] --

local a = game:GetService("VirtualUser")game:GetService'Players'.LocalPlayer.Idled:Connect(function()a:CaptureController()a:ClickButton2(Vector2.new())end)

game:GetService("Players").LocalPlayer.PlayerGui.timer.timeLeft.Changed:Connect(function(change)
    if change == "Text" and getgenv().autofarm == true then
        print(game:GetService("Players").LocalPlayer.PlayerGui.timer.timeLeft.Text)
        if game:GetService("Players").LocalPlayer.PlayerGui.timer.timeLeft.Text == "0:30" or game:GetService("Players").LocalPlayer.PlayerGui.timer.timeLeft.Text == "1:00" or game:GetService("Players").LocalPlayer.PlayerGui.timer.timeLeft.Text == "1:30" then
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace"):WaitForChild("tower").finishes:FindFirstChild("Finish").Position)
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
            wait(.5)
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
            wait(1)
            game.Players.LocalPlayer.Character.Humanoid.Jump = true
        end
    end
end)


-- [ FUNCTION'S ] --

local function SendNotify(title, message, duration)
	game:GetService("StarterGui"):SetCore("SendNotification", {Title = title, Text = message, Duration = duration;})
end




-- [ TAB #1 ] --

MainTAB:Button("📍 ・ Get tools [CS]", function()
	for i,v in pairs(game:GetService("ReplicatedStorage").Gear:GetChildren()) do
        v.Parent = game.Players.LocalPlayer.Backpack 
    end
end)

MainTAB:Button("📍 ・ Ban Appeal", function()
	if game:GetService("Players").LocalPlayer.PlayerGui.shop2.shop.tabs:FindFirstChild("appeal") then
        local appealscript = getsenv(game:GetService("Players").LocalPlayer.PlayerGui.shop2.shop.items.appeal.LocalScript)
        game:GetService("Players").LocalPlayer.PlayerGui.shop2.shop.items.appeal.agreementBox.Text = game:GetService("Players").LocalPlayer.PlayerGui.shop2.shop.items.appeal.justifiedAgreement.Text
        appealscript.appeal()
    end
end)


---- [ ] ----


MainTAB:Toggle("📌 ・ Auto Farm", false, function(toggle)
	getgenv().autofarm = toggle
end)

MainTAB:Toggle("📌 ・ God Mode", false, function(toggle)
	getgenv().godmode = toggle
    game.Players.LocalPlayer.Character.KillScript.Disabled = toggle
end)

MainTAB:Toggle("📌 ・ Bunny Hop", false, function(toggle)
	game:GetService("ReplicatedStorage").bunnyJumping.Value = toggle
end)




-- [ TAB #2 ] --

MovementTAB:Slider("📌 ・ Set WalkSpeed", 5, 200, 16, function(value)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = (value)
end)

MovementTAB:Slider("📌 ・ Set JumpPower", 5, 200, 50, function(value)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = (value)
end)

MovementTAB:Slider("📌 ・ Set Gravity", 5, 1000, 196, function(value)
	game.Players.LocalPlayer.Character.Humanoid.Gravity = (value)
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
