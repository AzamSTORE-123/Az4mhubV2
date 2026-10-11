--[[
    ╔══════════════════════════════════════════╗
    ║          AZAM HUB v2.0 — ADVANCED        ║
    ║  Auto Steal + Mode Steal + Auto Return    ║
    ║          Created by Azam                  ║
    ╚══════════════════════════════════════════╝
--]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer

--=================== CONFIG ===================--
local CONFIG = {
    STEAL_SPEED = 250,
    STEAL_MODE = "ZIGZAG", -- ZIGZAG, STRAIGHT, FLY, FLASH
    AUTO_STEAL = false,
    AUTO_RETURN = true,
    RARITY_PRIORITY = {"Secret", "Divine", "Eternal", "Cosmic", "Mythic", "Legendary", "Epic", "Rare", "Uncommon", "Common"},
    IMAGE_URL = "https://i.ibb.co.com/gbqCPy9M/IMG-20261009-WA0598.jpg",
    HUB_NAME = "AzamHub",
}

--=================== GUI SETUP ===================--
if CoreGui:FindFirstChild(CONFIG.HUB_NAME) then
    CoreGui[CONFIG.HUB_NAME]:Destroy()
end
pcall(function()
    if LocalPlayer:FindFirstChild("PlayerGui") and LocalPlayer.PlayerGui:FindFirstChild(CONFIG.HUB_NAME) then
        LocalPlayer.PlayerGui[CONFIG.HUB_NAME]:Destroy()
    end
end)

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = CONFIG.HUB_NAME
ScreenGui.ResetOnSpawn = false
pcall(function() ScreenGui.Parent = CoreGui end)
if not ScreenGui.Parent then ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui") end

-- Toggle Button
local ToggleBtn = Instance.new("TextButton")
ToggleBtn.Size = UDim2.new(0, 60, 0, 60)
ToggleBtn.Position = UDim2.new(0, 20, 0.5, -30)
ToggleBtn.BackgroundColor3 = Color3.fromRGB(229, 35, 50)
ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleBtn.Text = "AZ"
ToggleBtn.TextSize = 24
ToggleBtn.Font = Enum.Font.GothamBlack
ToggleBtn.BorderSizePixel = 0
ToggleBtn.Parent = ScreenGui
Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 15)

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.new(0, 360, 0, 520)
Main.Position = UDim2.new(0.5, -180, 0.5, -260)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(229, 35, 50)
stroke.Thickness = 2
stroke.Parent = Main

-- Banner
local BannerFrame = Instance.new("Frame")
BannerFrame.Size = UDim2.new(1, 0, 0, 140)
BannerFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
BannerFrame.BorderSizePixel = 0
BannerFrame.Parent = Main
Instance.new("UICorner", BannerFrame).CornerRadius = UDim.new(0, 18)

local fix = Instance.new("Frame")
fix.Size = UDim2.new(1, 0, 0, 20)
fix.Position = UDim2.new(0, 0, 1, -20)
fix.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
fix.BorderSizePixel = 0
fix.Parent = BannerFrame

local BannerImage = Instance.new("ImageLabel")
BannerImage.Size = UDim2.new(1, 0, 1, 0)
BannerImage.BackgroundTransparency = 1
BannerImage.Image = CONFIG.IMAGE_URL
BannerImage.ScaleType = Enum.ScaleType.Crop
BannerImage.Parent = BannerFrame

local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0)
overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
overlay.BackgroundTransparency = 0.4
overlay.BorderSizePixel = 0
overlay.Parent = BannerFrame

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Position = UDim2.new(0, 0, 1, -60)
Title.BackgroundTransparency = 1
Title.Text = "AZAM HUB v2"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 30
Title.Font = Enum.Font.GothamBlack
Title.TextStrokeTransparency = 0
Title.Parent = BannerFrame

local Sub = Instance.new("TextLabel")
Sub.Size = UDim2.new(1, 0, 0, 20)
Sub.Position = UDim2.new(0, 0, 1, -25)
Sub.BackgroundTransparency = 1
Sub.Text = "Advanced Auto Steal System"
Sub.TextColor3 = Color3.fromRGB(229, 35, 50)
Sub.TextSize = 11
Sub.Font = Enum.Font.GothamBold
Sub.Parent = BannerFrame

-- Content
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -20, 1, -160)
Content.Position = UDim2.new(0, 10, 0, 150)
Content.BackgroundTransparency = 1
Content.Parent = Main

local function makeBtn(text, y, callback)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(1, 0, 0, 40)
    Btn.Position = UDim2.new(0, 0, 0, y)
    Btn.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Text = text
    Btn.TextSize = 13
    Btn.Font = Enum.Font.GothamBold
    Btn.BorderSizePixel = 0
    Btn.Parent = Content
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 10)
    local s = Instance.new("UIStroke")
    s.Color = Color3.fromRGB(60, 60, 75)
    s.Parent = Btn
    Btn.MouseButton1Click:Connect(function() callback(Btn) end)
    return Btn
end

-- AUTO STEAL TOGGLE
local autoStealEnabled = false
makeBtn("🥚 Auto Steal: OFF", 0, function(btn)
    autoStealEnabled = not autoStealEnabled
    btn.Text = autoStealEnabled and "🥚 Auto Steal: ON" or "🥚 Auto Steal: OFF"
    btn.BackgroundColor3 = autoStealEnabled and Color3.fromRGB(229, 35, 50) or Color3.fromRGB(35, 35, 45)
end)

-- STEAL MODE
local modes = {"ZIGZAG", "STRAIGHT", "FLY", "FLASH"}
local modeIdx = 1
local modeBtn = makeBtn("🎯 Mode: ZIGZAG", 48, function(btn)
    modeIdx = (modeIdx % #modes) + 1
    CONFIG.STEAL_MODE = modes[modeIdx]
    btn.Text = "🎯 Mode: " .. CONFIG.STEAL_MODE
end)

-- RARITY PRIORITY
local rarities = {"Secret", "Divine", "Eternal", "Cosmic", "Mythic", "Legendary", "Epic", "Rare", "Uncommon", "Common"}
local rarityIdx = 1
local rarityBtn = makeBtn("💎 Priority: Secret", 96, function(btn)
    rarityIdx = (rarityIdx % #rarities) + 1
    btn.Text = "💎 Priority: " .. rarities[rarityIdx]
    CONFIG.RARITY_PRIORITY = {rarities[rarityIdx]}
end)

-- AUTO RETURN
local autoReturnEnabled = true
makeBtn("🏠 Auto Return: ON", 144, function(btn)
    autoReturnEnabled = not autoReturnEnabled
    btn.Text = autoReturnEnabled and "🏠 Auto Return: ON" or "🏠 Auto Return: OFF"
    btn.BackgroundColor3 = autoReturnEnabled and Color3.fromRGB(229, 35, 50) or Color3.fromRGB(35, 35, 45)
end)

-- STATUS
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Size = UDim2.new(1, 0, 0, 60)
StatusLabel.Position = UDim2.new(0, 0, 0, 192)
StatusLabel.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
StatusLabel.TextColor3 = Color3.fromRGB(150, 255, 150)
StatusLabel.Text = "Status: Idle\nEggs: 0"
StatusLabel.TextSize = 12
StatusLabel.Font = Enum.Font.GothamBold
StatusLabel.BorderSizePixel = 0
StatusLabel.Parent = Content
Instance.new("UICorner", StatusLabel).CornerRadius = UDim.new(0, 8)

--=================== CORE FUNCTIONS ===================--

local eggsStolen = 0
local basePosition = nil
local isStealing = false

-- Simpan posisi base
local function saveBase()
    local char = LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        basePosition = char.HumanoidRootPart.CFrame
        StatusLabel.Text = "Status: Base tersimpan\nEggs: " .. eggsStolen
    end
end

-- Teleport dengan mode berbeda
local function teleportTo(targetPart, mode)
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local targetPos = targetPart.Position + Vector3.new(0, 3, 0)
    local startPos = hrp.Position

    if mode == "STRAIGHT" then
        -- Lurus langsung
        hrp.CFrame = CFrame.new(targetPos)

    elseif mode == "ZIGZAG" then
        -- Zigzag: tween dengan offset
        for i = 1, 3 do
            local offset = Vector3.new(math.random(-20, 20), math.random(5, 15), math.random(-20, 20))
            local midPos = startPos:Lerp(targetPos, i/4) + offset
            local tw = TweenService:Create(hrp, TweenInfo.new(0.15, Enum.EasingStyle.Linear), {CFrame = CFrame.new(midPos)})
            tw:Play()
            tw.Completed:Wait()
        end
        hrp.CFrame = CFrame.new(targetPos)

    elseif mode == "FLY" then
        -- Terbang tinggi dulu
        local flyPos = startPos + Vector3.new(0, 100, 0)
        local tw1 = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = CFrame.new(flyPos)})
        tw1:Play()
        tw1.Completed:Wait()
        local tw2 = TweenService:Create(hrp, TweenInfo.new(0.3, Enum.EasingStyle.Linear), {CFrame = CFrame.new(targetPos)})
        tw2:Play()
        tw2.Completed:Wait()

    elseif mode == "FLASH" then
        -- Flash: kecepatan tinggi langsung
        hrp.CFrame = CFrame.new(targetPos)
    end

    return true
end

-- Ambil semua egg di workspace
local function getAllEggs()
    local eggs = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = string.lower(obj.Name)
            if string.find(name, "egg") and not string.find(name, "hatch") then
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

-- Cek rarity
local function getRarity(obj)
    if obj:GetAttribute("Rarity") then return obj:GetAttribute("Rarity") end
    if obj:GetAttribute("rarity") then return obj:GetAttribute("rarity") end
    for _, tag in pairs(obj:GetTags()) do
        if string.find(string.lower(tag), "rarity") then return tag end
    end
    return "Unknown"
end

-- Cek apakah egg ini sudah ada yang bawa (hindari egg yang mau ditetas orang)
local function isEggFree(egg)
    -- Cek kalau ada Handle yang nempel ke player
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            for _, tool in pairs(player.Character:GetChildren()) do
                if tool:IsA("Tool") and tool.Name:lower():find("egg") then
                    return false
                end
            end
        end
    end
    return true
end

-- Ambil egg
local function stealEgg(egg)
    local char = LocalPlayer.Character
    if not char then return false end
    local hrp = char:FindFirstChild("HumanoidRootPart")
    if not hrp then return false end

    local targetPos
    if egg:IsA("BasePart") then
        targetPos = egg
    else
        targetPos = egg:FindFirstChildWhichIsA("BasePart", true)
    end
    if not targetPos then return false end

    -- Teleport ke egg dengan mode
    teleportTo(targetPos, CONFIG.STEAL_MODE)
    task.wait(0.1)

    -- Fire prompt / click
    for _, desc in pairs(egg:GetDescendants()) do
        if desc:IsA("ProximityPrompt") then
            pcall(function() fireproximityprompt(desc) end)
        elseif desc:IsA("ClickDetector") then
            pcall(function() fireclickdetector(desc) end)
        end
    end

    return true
end

-- Auto steal loop
task.spawn(function()
    while task.wait(0.2) do
        if autoStealEnabled then
            local eggs = getAllEggs()
            local priority = CONFIG.RARITY_PRIORITY[1] or "Secret"

            -- Urutkan egg: rarity priority dulu
            local priorityEggs = {}
            local otherEggs = {}
            for _, egg in ipairs(eggs) do
                local r = getRarity(egg)
                if r == priority then
                    table.insert(priorityEggs, egg)
                else
                    table.insert(otherEggs, egg)
                end
            end

            -- Ambil egg priority dulu
            for _, egg in ipairs(priorityEggs) do
                if isEggFree(egg) and stealEgg(egg) then
                    eggsStolen += 1
                    StatusLabel.Text = "Status: Mengambil " .. getRarity(egg) .. "\nEggs: " .. eggsStolen

                    -- Auto return ke base
                    if autoReturnEnabled and basePosition then
                        task.wait(0.3)
                        local char = LocalPlayer.Character
                        if char and char:FindFirstChild("HumanoidRootPart") then
                            char.HumanoidRootPart.CFrame = basePosition
                            StatusLabel.Text = "Status: Balik ke base\nEggs: " .. eggsStolen
                        end
                    end
                    task.wait(0.5)
                end
            end
        end
    end
end)

-- Toggle minimize
local isOpen = true
ToggleBtn.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    TweenService:Create(Main, TweenInfo.new(0.3), {Position = isOpen and UDim2.new(0.5, -180, 0.5, -260) or UDim2.new(0.5, -180, 1.5, -260)}):Play()
end)

-- Drag
local dragging, dragInput, dragStart, startPos
local function update(input)
    local delta = input.Position - dragStart
    Main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end
BannerFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = Main.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
BannerFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then update(input) end
end)

-- Simpan base saat load
saveBase()

pcall(function()
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "AzamHub v2",
        Text = "Script loaded! Klik tombol untuk mulai.",
        Duration = 5,
    })
end)

print("[AzamHub v2] Loaded!")