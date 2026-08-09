--// ForgeGUI - Sell Lemons
--// Safe Roblox Studio LocalScript
--// Designed for your own Sell Lemons-style game

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

--// Configuration
local CONFIG = {
	AutoCollect = false,
	AutoSell = false,
	AutoUpgrade = false,
	CollectDelay = 0.5,
	SellDelay = 1,
	UpgradeDelay = 2
}

--// Remove old GUI
local oldGui = playerGui:FindFirstChild("ForgeGUI")
if oldGui then
	oldGui:Destroy()
end

--// Main GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ForgeGUI"
gui.ResetOnSpawn = false
gui.Parent = playerGui

--// Main window
local main = Instance.new("Frame")
main.Name = "Main"
main.Size = UDim2.new(0, 430, 0, 330)
main.Position = UDim2.new(0.5, -215, 0.5, -165)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 14)
corner.Parent = main

--// Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 65)
header.BackgroundColor3 = Color3.fromRGB(25, 25, 34)
header.BorderSizePixel = 0
header.Parent = main

local headerCorner = Instance.new("UICorner")
headerCorner.CornerRadius = UDim.new(0, 14)
headerCorner.Parent = header

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 0, 30)
title.Position = UDim2.new(0, 15, 0, 8)
title.BackgroundTransparency = 1
title.Text = "🍋 FORGEGUI"
title.TextColor3 = Color3.fromRGB(255, 220, 80)
title.TextSize = 23
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -30, 0, 20)
subtitle.Position = UDim2.new(0, 15, 0, 37)
subtitle.BackgroundTransparency = 1
subtitle.Text = "Sell Lemons • Farming Panel"
subtitle.TextColor3 = Color3.fromRGB(160, 160, 170)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = header

--// Content
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -30, 1, -85)
content.Position = UDim2.new(0, 15, 0, 75)
content.BackgroundTransparency = 1
content.Parent = main

local layout = Instance.new("UIListLayout")
layout.Padding = UDim.new(0, 10)
layout.Parent = content

--// Status
local status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 25)
status.BackgroundTransparency = 1
status.Text = "● Ready"
status.TextColor3 = Color3.fromRGB(100, 220, 130)
status.TextSize = 13
status.Font = Enum.Font.GothamMedium
status.TextXAlignment = Enum.TextXAlignment.Left
status.Parent = content

--// Button creator
local function createToggle(text, key)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 48)
	button.BackgroundColor3 = Color3.fromRGB(31, 31, 42)
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Text = ""
	button.Parent = content

	local buttonCorner = Instance.new("UICorner")
	buttonCorner.CornerRadius = UDim.new(0, 10)
	buttonCorner.Parent = button

	local label = Instance.new("TextLabel")
	label.Size = UDim2.new(1, -80, 1, 0)
	label.Position = UDim2.new(0, 15, 0, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(235, 235, 240)
	label.TextSize = 14
	label.Font = Enum.Font.GothamMedium
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.Parent = button

	local toggle = Instance.new("TextLabel")
	toggle.Size = UDim2.new(0, 50, 0, 26)
	toggle.Position = UDim2.new(1, -65, 0.5, -13)
	toggle.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
	toggle.Text = "OFF"
	toggle.TextColor3 = Color3.fromRGB(190, 190, 195)
	toggle.TextSize = 10
	toggle.Font = Enum.Font.GothamBold
	toggle.Parent = button

	local toggleCorner = Instance.new("UICorner")
	toggleCorner.CornerRadius = UDim.new(1, 0)
	toggleCorner.Parent = toggle

	button.MouseButton1Click:Connect(function()
		CONFIG[key] = not CONFIG[key]

		if CONFIG[key] then
			toggle.Text = "ON"
			toggle.BackgroundColor3 = Color3.fromRGB(255, 205, 60)
			toggle.TextColor3 = Color3.fromRGB(30, 30, 30)

			status.Text = "● " .. text .. " enabled"
			status.TextColor3 = Color3.fromRGB(100, 220, 130)
		else
			toggle.Text = "OFF"
			toggle.BackgroundColor3 = Color3.fromRGB(65, 65, 75)
			toggle.TextColor3 = Color3.fromRGB(190, 190, 195)

			status.Text = "● " .. text .. " disabled"
			status.TextColor3 = Color3.fromRGB(230, 180, 80)
		end
	end)

	return button
end

createToggle("🍋 Auto Collect Lemons", "AutoCollect")
createToggle("💰 Auto Sell", "AutoSell")
createToggle("⬆ Auto Upgrade", "AutoUpgrade")

--// Example game integration
--// Create these RemoteEvents in ReplicatedStorage for your own game:
--// CollectLemon
--// SellLemons
--// BuyUpgrade

local function fireRemote(name)
	local remote = ReplicatedStorage:FindFirstChild(name)

	if remote and remote:IsA("RemoteEvent") then
		remote:FireServer()
	end
end

--// Auto Collect
task.spawn(function()
	while task.wait(CONFIG.CollectDelay) do
		if CONFIG.AutoCollect then
			fireRemote("CollectLemon")
		end
	end
end)

--// Auto Sell
task.spawn(function()
	while task.wait(CONFIG.SellDelay) do
		if CONFIG.AutoSell then
			fireRemote("SellLemons")
		end
	end
end)

--// Auto Upgrade
task.spawn(function()
	while task.wait(CONFIG.UpgradeDelay) do
		if CONFIG.AutoUpgrade then
			fireRemote("BuyUpgrade")
		end
	end
end)

--// Dragging
local UserInputService = game:GetService("UserInputService")

local dragging = false
local dragStart
local startPosition

header.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPosition = main.Position
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart

		main.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
