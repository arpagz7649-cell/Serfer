--[[
    MASTER SYSTEM - TELEPORTATION MODULE v1.0
    Fitur: Teleport ke semua pemain, GUI Modern, Draggable
]]

local MasterSystem = {}

function MasterSystem.Init()
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local CoreGui = game:GetService("CoreGui") -- Menggunakan CoreGui agar tidak terhapus saat mati

    -- UI Utama
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MasterControl_GUI"
    ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 250, 0, 350)
    MainFrame.Position = UDim2.new(0.5, -125, 0.5, -175)
    MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    MainFrame.BorderSizePixel = 0
    MainFrame.Active = true
    MainFrame.Draggable = true
    MainFrame.Parent = ScreenGui

    -- Efek Sudut Melengkung
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame

    -- Judul
    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.Text = "MASTER TELEPORT"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.BackgroundTransparency = 1
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.Parent = MainFrame

    -- Daftar Pemain (Scrolling)
    local Scroll = Instance.new("ScrollingFrame")
    Scroll.Size = UDim2.new(1, -20, 1, -60)
    Scroll.Position = UDim2.new(0, 10, 0, 50)
    Scroll.BackgroundTransparency = 1
    Scroll.CanvasSize = UDim2.new(0, 0, 0, 0)
    Scroll.ScrollBarThickness = 2
    Scroll.Parent = MainFrame

    local ListLayout = Instance.new("UIListLayout")
    ListLayout.Padding = UDim.new(0, 5)
    ListLayout.Parent = Scroll

    -- Fungsi Teleportasi
    local function TeleportTo(targetPlayer)
        if targetPlayer and targetPlayer.Character then
            local root = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            if root and targetRoot then
                root.CFrame = targetRoot.CFrame * CFrame.new(0, 0, 3)
            end
        end
    end

    -- Update Daftar Pemain Secara Real-Time
    local function UpdateList()
        for _, child in pairs(Scroll:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end

        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local btn = Instance.new("TextButton")
                btn.Size = UDim2.new(1, 0, 0, 35)
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                btn.Text = "  " .. p.DisplayName .. " (@" .. p.Name .. ")"
                btn.TextColor3 = Color3.new(1, 1, 1)
                btn.Font = Enum.Font.Gotham
                btn.TextSize = 12
                btn.TextXAlignment = Enum.TextXAlignment.Left
                btn.Parent = Scroll

                local bCorner = Instance.new("UICorner")
                bCorner.CornerRadius = UDim.new(0, 6)
                bCorner.Parent = btn

                btn.MouseButton1Click:Connect(function()
                    TeleportTo(p)
                end)
            end
        end
        Scroll.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y)
    end

    Players.PlayerAdded:Connect(UpdateList)
    Players.PlayerRemoving:Connect(UpdateList)
    UpdateList()

    print("Master System Loaded Successfully.")
end

return MasterSystem.Init()
