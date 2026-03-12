-- KODE INI DITARUH DI GITHUB (URL RAW)
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local ScrollingFrame = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")
local TextLabel = Instance.new("TextLabel")

ScreenGui.Name = "MasterTeleportGUI"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

Frame.Size = UDim2.new(0, 200, 0, 300)
Frame.Position = UDim2.new(0.5, -100, 0.5, -150)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.BorderSizePixel = 2
Frame.Parent = ScreenGui
Frame.Active = true
Frame.Draggable = true -- Agar bisa digeser

TextLabel.Size = UDim2.new(1, 0, 0, 30)
TextLabel.Text = "TELEPORT MENU"
TextLabel.TextColor3 = Color3.new(1, 1, 1)
TextLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextLabel.Parent = Frame

ScrollingFrame.Size = UDim2.new(1, 0, 1, -30)
ScrollingFrame.Position = UDim2.new(0, 0, 0, 30)
ScrollingFrame.BackgroundTransparency = 1
ScrollingFrame.Parent = Frame

UIListLayout.Parent = ScrollingFrame
UIListLayout.Padding = UDim.new(0, 5)

-- Fungsi untuk update daftar pemain
local function refreshList()
    for _, child in pairs(ScrollingFrame:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end

    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= game.Players.LocalPlayer then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Text = p.Name
            btn.Parent = ScrollingFrame
            
            btn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame
                end
            end)
        end
    end
end

refreshList()
-- Tombol Close (Opsional) bisa Master tambahkan sendiri
