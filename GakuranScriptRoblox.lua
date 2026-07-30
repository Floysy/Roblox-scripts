--// Gakuran Style Hub
--// UI Template

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")


-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GakuranHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui


local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,420,0,300)
Main.Position = UDim2.new(0.5,-210,0.5,-150)
Main.BackgroundColor3 = Color3.fromRGB(20,20,25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui


local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0,12)
Corner.Parent = Main


-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "🔥 Gakuran Ultimate Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Parent = Main


-- Tabs
local Tabs = {
    "Home",
    "Settings",
    "Info"
}


local function CreateButton(name, position)

    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(0,120,0,35)
    Button.Position = position
    Button.Text = name
    Button.TextSize = 16
    Button.Font = Enum.Font.Gotham
    Button.BackgroundColor3 = Color3.fromRGB(45,45,55)
    Button.TextColor3 = Color3.new(1,1,1)
    Button.Parent = Main

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0,8)
    c.Parent = Button


    Button.MouseEnter:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(.2),
            {BackgroundColor3 = Color3.fromRGB(80,80,100)}
        ):Play()
    end)


    Button.MouseLeave:Connect(function()
        TweenService:Create(
            Button,
            TweenInfo.new(.2),
            {BackgroundColor3 = Color3.fromRGB(45,45,55)}
        ):Play()
    end)


    return Button
end



local Home = CreateButton(
    "🏠 Home",
    UDim2.new(0.08,0,0.25,0)
)


local Settings = CreateButton(
    "⚙ Settings",
    UDim2.new(0.38,0,0.25,0)
)


local Info = CreateButton(
    "⭐ Info",
    UDim2.new(0.68,0,0.25,0)
)



-- Content
local Text = Instance.new("TextLabel")
Text.Size = UDim2.new(.85,0,.35,0)
Text.Position = UDim2.new(.075,0,.5,0)
Text.BackgroundTransparency = 1
Text.TextWrapped = true
Text.TextColor3 = Color3.new(1,1,1)
Text.TextSize = 18
Text.Font = Enum.Font.Gotham
Text.Text = "Welcome to Gakuran Hub\n\nSelect a category"
Text.Parent = Main



Home.MouseButton1Click:Connect(function()
    Text.Text = "🏠 Home\n\nMain dashboard loaded"
end)


Settings.MouseButton1Click:Connect(function()
    Text.Text = "⚙ Settings\n\nUI Settings\nTheme: Dark"
end)


Info.MouseButton1Click:Connect(function()
    Text.Text = "⭐ Gakuran Ultimate Hub\nVersion 1.0"
end)


-- Drag system
local dragging = false
local dragStart
local startPos

Main.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
    end

end)


Main.InputChanged:Connect(function(input)

    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then

        local delta = input.Position - dragStart

        Main.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )

    end

end)


game:GetService("UserInputService").InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end

end)