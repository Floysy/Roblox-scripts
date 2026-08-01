-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DiscordGui"
screenGui.ResetOnSpawn = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

-- Create Frame (the popup box)
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 200)
frame.Position = UDim2.new(0.5, -200, 0.5, -100) -- Centered
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 2
frame.BorderColor3 = Color3.fromRGB(255, 255, 255)
frame.Parent = screenGui

-- Add UICorner for rounded edges
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = frame

-- Create TextLabel for the message
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(1, -40, 0, 50)
textLabel.Position = UDim2.new(0, 20, 0, 20)
textLabel.BackgroundTransparency = 1
textLabel.Text = "Join discord.gg/percsploit for the script"
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
textLabel.TextSize = 20
textLabel.TextWrapped = true
textLabel.Font = Enum.Font.GothamBold
textLabel.Parent = frame

-- Create secondary TextLabel for instructions
local instructionLabel = Instance.new("TextLabel")
instructionLabel.Size = UDim2.new(1, -40, 0, 30)
instructionLabel.Position = UDim2.new(0, 20, 0, 75)
instructionLabel.BackgroundTransparency = 1
instructionLabel.Text = "Once you joined the script will be in the #free-script channel"
instructionLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
instructionLabel.TextSize = 14
instructionLabel.TextWrapped = true
instructionLabel.Font = Enum.Font.Gotham
instructionLabel.Parent = frame

-- Create Copy Button
local copyButton = Instance.new("TextButton")
copyButton.Size = UDim2.new(0, 200, 0, 40)
copyButton.Position = UDim2.new(0.5, -100, 0, 110)
copyButton.BackgroundColor3 = Color3.fromRGB(88, 101, 242)
copyButton.Text = "Copy Discord Link"
copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyButton.TextSize = 16
copyButton.Font = Enum.Font.GothamBold
copyButton.Parent = frame

-- Add corner to copy button
local copyCorner = Instance.new("UICorner")
copyCorner.CornerRadius = UDim.new(0, 8)
copyCorner.Parent = copyButton

-- Copy button functionality
copyButton.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/percsploit")
    copyButton.Text = "Copied!"
    wait(1.5)
    copyButton.Text = "Copy Discord Link"
end)

-- Optional: Add a close button
local closeButton = Instance.new("TextButton")
closeButton.Size = UDim2.new(0, 30, 0, 30)
closeButton.Position = UDim2.new(1, -35, 0, 5)
closeButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
closeButton.Text = "X"
closeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
closeButton.TextSize = 18
closeButton.Font = Enum.Font.GothamBold
closeButton.Parent = frame

-- Add corner to close button
local closeCorner = Instance.new("UICorner")
closeCorner.CornerRadius = UDim.new(0, 5)
closeCorner.Parent = closeButton

-- Close button functionality
closeButton.MouseButton1Click:Connect(function()
    screenGui:Destroy()
end)
