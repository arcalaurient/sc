--[[
    ArcaHUB - Open Sea For Animals!
    Place ID: 88047783411976
    Game ID: 10765091041
    Created with ArcaHUB Modern Edition Design System
]]

-- Services
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TeleportService = game:GetService("TeleportService")
local VirtualUser = game:GetService("VirtualUser")
local HttpService = game:GetService("HttpService")
local Lighting = game:GetService("Lighting")

-- Cleanup Existing UI
if LocalPlayer.PlayerGui:FindFirstChild("ArcaHUB") then
    LocalPlayer.PlayerGui.ArcaHUB:Destroy()
end

-- ScreenGui Container
local screen = Instance.new("ScreenGui")
screen.Name = "ArcaHUB"
screen.ResetOnSpawn = false
screen.Parent = LocalPlayer.PlayerGui

-- ==========================================
-- DESIGN SYSTEM (THEME)
-- ==========================================
local theme = {
    Accent = Color3.fromRGB(255, 85, 0),       -- Vibrant Orange
    Background = Color3.fromRGB(12, 12, 12),   -- Deep Dark Base
    Sidebar = Color3.fromRGB(16, 16, 16),      -- Slightly lighter for depth
    Card = Color3.fromRGB(18, 18, 18),         -- Section background
    Element = Color3.fromRGB(24, 24, 24),      -- Input/Dropdown background
    Border = Color3.fromRGB(35, 35, 35),       -- Subtle dividers
    Text = Color3.fromRGB(245, 245, 245),      -- Primary Text
    TextDim = Color3.fromRGB(140, 140, 140),   -- Secondary Text / Inactive
    Hover = Color3.fromRGB(30, 30, 30),        -- Generic Hover State
    Radius = UDim.new(0, 6)                    -- Universal Corner Radius
}

-- Hover Helper
local function applyHover(btn, defaultCol, hoverCol)
    btn.MouseEnter:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = hoverCol}):Play()
    end)
    btn.MouseLeave:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = defaultCol}):Play()
    end)
end

-- Global State & Scale
local state = { UIScale = 1 }
local uiScaleObj = Instance.new("UIScale")
uiScaleObj.Scale = state.UIScale
uiScaleObj.Parent = screen

-- Main Container
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 750, 0, 520)
MainFrame.Position = UDim2.new(0.5, -375, 0.5, -260)
MainFrame.BackgroundColor3 = theme.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = screen
Instance.new("UICorner", MainFrame).CornerRadius = theme.Radius

local mainStroke = Instance.new("UIStroke")
mainStroke.Color = theme.Border
mainStroke.Parent = MainFrame

-- Background Image
local bgImages = {"", "rbxassetid://10709761813", "rbxassetid://7733917120", "rbxassetid://10723415766"}
local bgIdx = 1
local bgImageLabel = Instance.new("ImageLabel")
bgImageLabel.Size = UDim2.new(1, 0, 1, 0)
bgImageLabel.BackgroundTransparency = 1
bgImageLabel.ImageTransparency = 0.8
bgImageLabel.ZIndex = 0
bgImageLabel.Parent = MainFrame
Instance.new("UICorner", bgImageLabel).CornerRadius = theme.Radius

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 64, 1, 0)
Sidebar.BackgroundColor3 = theme.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame
Instance.new("UICorner", Sidebar).CornerRadius = theme.Radius

local Title = Instance.new("ImageLabel")
Title.Size = UDim2.new(0, 26, 0, 26)
Title.Position = UDim2.new(0.5, -13, 0, 15)
Title.BackgroundTransparency = 1
Title.Image = "rbxassetid://10709761813" -- Lucide Aperture
Title.ImageColor3 = theme.Accent
Title.Parent = Sidebar

local tabContainer = Instance.new("Frame")
tabContainer.Size = UDim2.new(1, 0, 1, -115)
tabContainer.Position = UDim2.new(0, 0, 0, 60)
tabContainer.BackgroundTransparency = 1
tabContainer.Parent = Sidebar
local tabLayout = Instance.new("UIListLayout")
tabLayout.Padding = UDim.new(0, 8)
tabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
tabLayout.Parent = tabContainer

-- Content Container
local tabs = {}
local currentTab = nil
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(1, -64, 1, 0)
Content.Position = UDim2.new(0, 64, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Size = UDim2.new(1, 0, 0, 60)
Header.Position = UDim2.new(0, 0, 0, 0)
Header.BackgroundTransparency = 1
Header.Parent = Content

local HeaderTitle = Instance.new("TextLabel")
HeaderTitle.Size = UDim2.new(0, 320, 1, 0)
HeaderTitle.Position = UDim2.new(0, 16, 0, 0)
HeaderTitle.BackgroundTransparency = 1
HeaderTitle.Text = "ArcaHUB"
HeaderTitle.TextColor3 = theme.Text
HeaderTitle.Font = Enum.Font.Gotham
HeaderTitle.TextSize = 20
HeaderTitle.TextXAlignment = Enum.TextXAlignment.Left
HeaderTitle.Parent = Header

local SearchBoxContainer = Instance.new("Frame")
SearchBoxContainer.Size = UDim2.new(0, 220, 0, 32)
SearchBoxContainer.Position = UDim2.new(1, -236, 0.5, -16)
SearchBoxContainer.BackgroundColor3 = theme.Element
SearchBoxContainer.Parent = Header
Instance.new("UICorner", SearchBoxContainer).CornerRadius = theme.Radius
Instance.new("UIStroke", SearchBoxContainer).Color = theme.Border

local SearchIcon = Instance.new("ImageLabel")
SearchIcon.Size = UDim2.new(0, 16, 0, 16)
SearchIcon.Position = UDim2.new(0, 10, 0.5, -8)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Image = "rbxassetid://10734943674"
SearchIcon.ImageColor3 = theme.TextDim
SearchIcon.Parent = SearchBoxContainer

local SearchInput = Instance.new("TextBox")
SearchInput.Size = UDim2.new(1, -34, 1, 0)
SearchInput.Position = UDim2.new(0, 34, 0, 0)
SearchInput.BackgroundTransparency = 1
SearchInput.Text = ""
SearchInput.PlaceholderText = "Search features..."
SearchInput.PlaceholderColor3 = theme.TextDim
SearchInput.TextColor3 = theme.Text
SearchInput.Font = Enum.Font.Gotham
SearchInput.TextSize = 13
SearchInput.TextXAlignment = Enum.TextXAlignment.Left
SearchInput.Parent = SearchBoxContainer

local registeredSearchItems = {}
SearchInput:GetPropertyChangedSignal("Text"):Connect(function()
    local q = string.lower(SearchInput.Text)
    for _, item in ipairs(registeredSearchItems) do
        if item.frame and item.name then
            if q == "" or string.find(string.lower(item.name), q) then
                item.frame.Visible = true
            else
                item.frame.Visible = false
            end
        end
    end
end)

-- Tabs logic
local function addTab(name, iconId)
    local isSettings = (name == "Settings")
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 42, 0, 42)
    btn.BackgroundColor3 = theme.Sidebar
    btn.BackgroundTransparency = 1
    btn.Text = ""
    btn.AutoButtonColor = false
    btn.Parent = isSettings and Sidebar or tabContainer
    if isSettings then btn.Position = UDim2.new(0, 11, 1, -55) end
    Instance.new("UICorner", btn).CornerRadius = theme.Radius

    local highlight = Instance.new("Frame")
    highlight.Size = UDim2.new(0, 3, 0, 0)
    highlight.Position = UDim2.new(0, -11, 0.5, 0)
    highlight.AnchorPoint = Vector2.new(0, 0.5)
    highlight.BackgroundColor3 = theme.Accent
    highlight.BorderSizePixel = 0
    highlight.Parent = btn
    Instance.new("UICorner", highlight).CornerRadius = UDim.new(0, 2)

    local icon = Instance.new("ImageLabel")
    icon.Size = UDim2.new(0, 20, 0, 20)
    icon.Position = UDim2.new(0.5, -10, 0.5, -10)
    icon.BackgroundTransparency = 1
    icon.Image = iconId or "rbxassetid://6026568210"
    icon.ImageColor3 = theme.TextDim
    icon.Parent = btn

    btn.MouseEnter:Connect(function()
        if currentTab ~= name then
            TweenService:Create(icon, TweenInfo.new(0.2), {ImageColor3 = theme.Text}):Play()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.6, BackgroundColor3 = theme.Hover}):Play()
        end
    end)
    btn.MouseLeave:Connect(function()
        if currentTab ~= name then
            TweenService:Create(icon, TweenInfo.new(0.2), {ImageColor3 = theme.TextDim}):Play()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
        end
    end)

    local contentFrame = Instance.new("Frame")
    contentFrame.Size = UDim2.new(1, 0, 1, -60)
    contentFrame.Position = UDim2.new(0, 0, 0, 60)
    contentFrame.BackgroundTransparency = 1
    contentFrame.Visible = false
    contentFrame.Parent = Content
    
    local leftPanel = Instance.new("ScrollingFrame")
    leftPanel.Size = UDim2.new(0.5, -24, 1, -40)
    leftPanel.Position = UDim2.new(0, 16, 0, 20)
    leftPanel.BackgroundTransparency = 1
    leftPanel.ScrollBarThickness = 2
    leftPanel.ScrollBarImageColor3 = theme.Border
    leftPanel.BorderSizePixel = 0
    leftPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    leftPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    leftPanel.Parent = contentFrame
    local lPad = Instance.new("UIPadding")
    lPad.PaddingBottom = UDim.new(0, 20)
    lPad.Parent = leftPanel
    local ll = Instance.new("UIListLayout")
    ll.Padding = UDim.new(0, 12)
    ll.Parent = leftPanel

    local rightPanel = Instance.new("ScrollingFrame")
    rightPanel.Size = UDim2.new(0.5, -24, 1, -40)
    rightPanel.Position = UDim2.new(0.5, 8, 0, 20)
    rightPanel.BackgroundTransparency = 1
    rightPanel.ScrollBarThickness = 2
    rightPanel.ScrollBarImageColor3 = theme.Border
    rightPanel.BorderSizePixel = 0
    rightPanel.AutomaticCanvasSize = Enum.AutomaticSize.Y
    rightPanel.CanvasSize = UDim2.new(0, 0, 0, 0)
    rightPanel.Parent = contentFrame
    local rPad = Instance.new("UIPadding")
    rPad.PaddingBottom = UDim.new(0, 20)
    rPad.Parent = rightPanel
    local rl = Instance.new("UIListLayout")
    rl.Padding = UDim.new(0, 12)
    rl.Parent = rightPanel

    btn.MouseButton1Click:Connect(function()
        if currentTab == name then return end
        
        if currentTab then
            local oldData = tabs[currentTab]
            local oldFrame = oldData.frame
            local oldTabName = currentTab
            
            TweenService:Create(oldData.btn, TweenInfo.new(0.2), {BackgroundTransparency = 1}):Play()
            TweenService:Create(oldData.icon, TweenInfo.new(0.2), {ImageColor3 = theme.TextDim}):Play()
            TweenService:Create(oldData.highlight, TweenInfo.new(0.2), {Size = UDim2.new(0, 3, 0, 0)}):Play()
            
            TweenService:Create(oldData.left, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0, -24, 0, 20)}):Play()
            TweenService:Create(oldData.right, TweenInfo.new(0.25, Enum.EasingStyle.Quint, Enum.EasingDirection.In), {Position = UDim2.new(0.5, 48, 0, 20)}):Play()
            
            task.delay(0.25, function()
                if currentTab ~= oldTabName then oldFrame.Visible = false end
            end)
        end
        
        local activeBgColor = Color3.new(theme.Accent.R * 0.2, theme.Accent.G * 0.2, theme.Accent.B * 0.2)
        TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundTransparency = 0, BackgroundColor3 = activeBgColor}):Play()
        TweenService:Create(icon, TweenInfo.new(0.2), {ImageColor3 = theme.Accent}):Play()
        TweenService:Create(highlight, TweenInfo.new(0.2, Enum.EasingStyle.Bounce), {Size = UDim2.new(0, 3, 0, 22)}):Play()
        contentFrame.Visible = true
        
        leftPanel.Position = UDim2.new(0, 56, 0, 20)
        rightPanel.Position = UDim2.new(0.5, -32, 0, 20)
        
        TweenService:Create(leftPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0, 16, 0, 20)}):Play()
        TweenService:Create(rightPanel, TweenInfo.new(0.4, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {Position = UDim2.new(0.5, 8, 0, 20)}):Play()
        
        HeaderTitle.Text = "ArcaHUB - " .. name
        currentTab = name
    end)

    tabs[name] = {left = leftPanel, right = rightPanel, btn = btn, icon = icon, frame = contentFrame, highlight = highlight}
    return tabs[name]
end

-- ==========================================
-- COMPONENT BUILDERS
-- ==========================================
local function createSection(parent, title, iconId)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 40)
    frame.BackgroundColor3 = theme.Card
    frame.Parent = parent
    Instance.new("UICorner", frame).CornerRadius = theme.Radius
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.Border
    stroke.Parent = frame

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, -24, 0, 35)
    header.Position = UDim2.new(0, 12, 0, 0)
    
    if iconId then
        header.Position = UDim2.new(0, 36, 0, 0)
        local icon = Instance.new("ImageLabel")
        icon.Size = UDim2.new(0, 16, 0, 16)
        icon.Position = UDim2.new(0, 12, 0, 9)
        icon.BackgroundTransparency = 1
        icon.Image = iconId
        icon.ImageColor3 = theme.TextDim
        icon.Parent = frame
    end
    
    header.BackgroundTransparency = 1
    header.Text = string.upper(title)
    header.TextColor3 = theme.TextDim
    header.Font = Enum.Font.Gotham
    header.TextSize = 11
    header.TextXAlignment = Enum.TextXAlignment.Left
    header.Parent = frame

    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, -16, 1, -35)
    container.Position = UDim2.new(0, 8, 0, 35)
    container.BackgroundTransparency = 1
    container.Parent = frame
    
    local cl = Instance.new("UIListLayout")
    cl.Padding = UDim.new(0, 6)
    cl.HorizontalAlignment = Enum.HorizontalAlignment.Center
    cl.Parent = container

    local function updateSize()
        frame.Size = UDim2.new(1, 0, 0, 35 + cl.AbsoluteContentSize.Y + 12)
    end
    cl:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)
    task.delay(0.1, updateSize)
    return container
end

local function createToggle(parent, text, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = theme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local toggleBtn = Instance.new("TextButton")
    toggleBtn.Size = UDim2.new(0, 38, 0, 20)
    toggleBtn.Position = UDim2.new(1, -46, 0.5, -10)
    toggleBtn.BackgroundColor3 = default and theme.Accent or theme.Element
    toggleBtn.Text = ""
    toggleBtn.AutoButtonColor = false
    toggleBtn.Parent = frame
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.Border
    stroke.Parent = toggleBtn

    local circle = Instance.new("Frame")
    circle.Size = UDim2.new(0, 14, 0, 14)
    circle.Position = default and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)
    circle.BackgroundColor3 = theme.Text
    circle.Parent = toggleBtn
    Instance.new("UICorner", circle).CornerRadius = UDim.new(1, 0)

    local currentState = default
    local function updateState(newState)
        currentState = newState
        local goalColor = currentState and theme.Accent or theme.Element
        local goalPos = currentState and UDim2.new(1, -17, 0.5, -7) or UDim2.new(0, 3, 0.5, -7)

        TweenService:Create(toggleBtn, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {BackgroundColor3 = goalColor}):Play()
        TweenService:Create(circle, TweenInfo.new(0.25, Enum.EasingStyle.Quint), {Position = goalPos}):Play()
        if stroke then TweenService:Create(stroke, TweenInfo.new(0.2), {Transparency = currentState and 1 or 0}):Play() end
        callback(currentState)
    end

    toggleBtn.MouseButton1Click:Connect(function()
        updateState(not currentState)
    end)

    table.insert(registeredSearchItems, {name = text, frame = frame})
    return {
        Set = updateState,
        Get = function() return currentState end
    }
end

local function createSlider(parent, text, min, max, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 38)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.4, 0, 0, 16)
    label.Position = UDim2.new(0, 8, 0, 2)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = theme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local sliderBg = Instance.new("TextButton")
    sliderBg.Size = UDim2.new(1, -16, 0, 6)
    sliderBg.Position = UDim2.new(0, 8, 0, 24)
    sliderBg.BackgroundColor3 = theme.Element
    sliderBg.Text = ""
    sliderBg.AutoButtonColor = false
    sliderBg.Parent = frame
    Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.Border
    stroke.Parent = sliderBg

    local sliderFill = Instance.new("Frame")
    sliderFill.Size = UDim2.new((default-min)/(max-min), 0, 1, 0)
    sliderFill.BackgroundColor3 = theme.Accent
    sliderFill.Parent = sliderBg
    Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

    local valInput = Instance.new("TextBox")
    valInput.Size = UDim2.new(0, 40, 0, 18)
    valInput.Position = UDim2.new(1, -48, 0, 2)
    valInput.BackgroundColor3 = theme.Element
    valInput.Text = tostring(default)
    valInput.TextColor3 = theme.TextDim
    valInput.Font = Enum.Font.Gotham
    valInput.TextSize = 11
    valInput.Parent = frame
    Instance.new("UICorner", valInput).CornerRadius = theme.Radius
    Instance.new("UIStroke", valInput).Color = theme.Border

    local currentVal = default
    local dragging = false
    
    valInput.FocusLost:Connect(function()
        local num = tonumber(valInput.Text)
        if num then
            num = math.clamp(num, min, max)
            currentVal = num
            valInput.Text = tostring(num)
            local pct = (num - min) / (max - min)
            TweenService:Create(sliderFill, TweenInfo.new(0.05), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
            callback(num)
        else
            valInput.Text = tostring(currentVal)
        end
    end)

    sliderBg.MouseButton1Down:Connect(function() dragging = true end)
    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local mousePos = UIS:GetMouseLocation().X
            local relPos = mousePos - sliderBg.AbsolutePosition.X
            local pct = math.clamp(relPos / sliderBg.AbsoluteSize.X, 0, 1)
            local val = min + (max - min) * pct
            val = math.floor(val * 10) / 10
            currentVal = val
            TweenService:Create(sliderFill, TweenInfo.new(0.05), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
            valInput.Text = tostring(val)
            callback(val)
        end
    end)

    table.insert(registeredSearchItems, {name = text, frame = frame})
end

local function createButton(parent, text, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -16, 0, 32)
    btn.Position = UDim2.new(0, 8, 0, 2)
    btn.BackgroundColor3 = theme.Element
    btn.Text = text
    btn.TextColor3 = theme.Text
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 13
    btn.AutoButtonColor = false
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = theme.Radius
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = theme.Border
    stroke.Parent = btn

    btn.MouseButton1Click:Connect(function()
        TweenService:Create(btn, TweenInfo.new(0.1), {BackgroundColor3 = theme.Accent}):Play()
        task.delay(0.12, function()
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = theme.Element}):Play()
        end)
        callback()
    end)

    applyHover(btn, theme.Element, theme.Hover)
    table.insert(registeredSearchItems, {name = text, frame = frame})
    return btn
end

local function createDropdown(parent, text, options, default, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.ClipsDescendants = true
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -130, 0, 32)
    label.Position = UDim2.new(0, 8, 0, 2)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = theme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 115, 0, 24)
    btn.Position = UDim2.new(1, -123, 0, 6)
    btn.BackgroundColor3 = theme.Element
    btn.TextColor3 = theme.TextDim
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 11
    btn.AutoButtonColor = false
    btn.Text = default
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = theme.Radius
    Instance.new("UIStroke", btn).Color = theme.Border
    
    local dropContainer = Instance.new("ScrollingFrame")
    local dropHeight = math.min(#options * 24, 140)
    dropContainer.Size = UDim2.new(1, -16, 0, dropHeight)
    dropContainer.Position = UDim2.new(0, 8, 0, 36)
    dropContainer.BackgroundColor3 = theme.Element
    dropContainer.BorderSizePixel = 0
    dropContainer.ScrollBarThickness = 2
    dropContainer.ScrollBarImageColor3 = theme.Border
    dropContainer.AutomaticCanvasSize = Enum.AutomaticSize.Y
    dropContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
    dropContainer.Parent = frame
    Instance.new("UICorner", dropContainer).CornerRadius = theme.Radius
    Instance.new("UIStroke", dropContainer).Color = theme.Border
    
    local listLayout = Instance.new("UIListLayout")
    listLayout.Parent = dropContainer
    
    local expanded = false
    btn.MouseButton1Click:Connect(function()
        expanded = not expanded
        if expanded then
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 36 + dropHeight + 4)}):Play()
        else
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 36)}):Play()
        end
    end)
    
    for i, opt in ipairs(options) do
        local optBtn = Instance.new("TextButton")
        optBtn.Size = UDim2.new(1, 0, 0, 24)
        optBtn.BackgroundTransparency = 1
        optBtn.TextColor3 = theme.TextDim
        optBtn.Font = Enum.Font.Gotham
        optBtn.TextSize = 11
        optBtn.Text = opt
        optBtn.Parent = dropContainer
        
        optBtn.MouseButton1Click:Connect(function()
            btn.Text = opt
            expanded = false
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 36)}):Play()
            callback(opt, i)
        end)
    end

    table.insert(registeredSearchItems, {name = text, frame = frame})
    return {
        Set = function(val)
            btn.Text = val
        end
    }
end

local function createKeybind(parent, text, defaultKey, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 36)
    frame.BackgroundTransparency = 1
    frame.Parent = parent

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -120, 0, 36)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = theme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 100, 0, 24)
    btn.Position = UDim2.new(1, -108, 0, 6)
    btn.BackgroundColor3 = theme.Element
    btn.TextColor3 = theme.TextDim
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 12
    btn.AutoButtonColor = false
    btn.Text = defaultKey.Name
    btn.Parent = frame
    Instance.new("UICorner", btn).CornerRadius = theme.Radius
    Instance.new("UIStroke", btn).Color = theme.Border

    local isBinding = false
    btn.MouseButton1Click:Connect(function()
        if not isBinding then
            isBinding = true
            btn.Text = "..."
            TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = theme.Accent}):Play()
        end
    end)

    UIS.InputBegan:Connect(function(input, processed)
        if isBinding and input.UserInputType == Enum.UserInputType.Keyboard then
            isBinding = false
            local key = input.KeyCode
            btn.Text = key.Name
            TweenService:Create(btn, TweenInfo.new(0.2), {TextColor3 = theme.TextDim}):Play()
            callback(key)
        end
    end)

    table.insert(registeredSearchItems, {name = text, frame = frame})
end

local function createColorPicker(parent, text, defaultColor, callback)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 32)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    frame.ClipsDescendants = true

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -60, 0, 32)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.TextColor3 = theme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame

    local colorDisplayBtn = Instance.new("TextButton")
    colorDisplayBtn.Size = UDim2.new(0, 42, 0, 20)
    colorDisplayBtn.Position = UDim2.new(1, -50, 0, 6)
    colorDisplayBtn.BackgroundColor3 = defaultColor
    colorDisplayBtn.Text = ""
    colorDisplayBtn.AutoButtonColor = false
    colorDisplayBtn.Parent = frame
    Instance.new("UICorner", colorDisplayBtn).CornerRadius = UDim.new(0, 4)
    Instance.new("UIStroke", colorDisplayBtn).Color = theme.Border

    local expanded = false
    local currentColor = defaultColor

    local pickerContainer = Instance.new("Frame")
    pickerContainer.Size = UDim2.new(1, -16, 0, 95)
    pickerContainer.Position = UDim2.new(0, 8, 0, 36)
    pickerContainer.BackgroundColor3 = theme.Element
    pickerContainer.Parent = frame
    Instance.new("UICorner", pickerContainer).CornerRadius = theme.Radius
    Instance.new("UIStroke", pickerContainer).Color = theme.Border

    local function makeRgbSlider(yPos, colorName, initialVal, updateRgbCallback)
        local sFrame = Instance.new("Frame")
        sFrame.Size = UDim2.new(1, -20, 0, 20)
        sFrame.Position = UDim2.new(0, 10, 0, yPos)
        sFrame.BackgroundTransparency = 1
        sFrame.Parent = pickerContainer

        local cLabel = Instance.new("TextLabel")
        cLabel.Size = UDim2.new(0, 15, 1, 0)
        cLabel.BackgroundTransparency = 1
        cLabel.Text = colorName
        cLabel.TextColor3 = theme.TextDim
        cLabel.Font = Enum.Font.Gotham
        cLabel.TextSize = 11
        cLabel.Parent = sFrame

        local sliderBg = Instance.new("TextButton")
        sliderBg.Size = UDim2.new(1, -25, 0, 4)
        sliderBg.Position = UDim2.new(0, 25, 0.5, -2)
        sliderBg.BackgroundColor3 = theme.Card
        sliderBg.Text = ""
        sliderBg.AutoButtonColor = false
        sliderBg.Parent = sFrame
        Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new(initialVal/255, 0, 1, 0)
        sliderFill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        if colorName == "R" then sliderFill.BackgroundColor3 = Color3.fromRGB(255, 70, 70) end
        if colorName == "G" then sliderFill.BackgroundColor3 = Color3.fromRGB(70, 255, 70) end
        if colorName == "B" then sliderFill.BackgroundColor3 = Color3.fromRGB(70, 120, 255) end
        sliderFill.Parent = sliderBg
        Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

        local dragging = false
        sliderBg.MouseButton1Down:Connect(function() dragging = true end)
        UIS.InputEnded:Connect(function(input) 
            if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end 
        end)
        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local pct = math.clamp((UIS:GetMouseLocation().X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                TweenService:Create(sliderFill, TweenInfo.new(0.05), {Size = UDim2.new(pct, 0, 1, 0)}):Play()
                updateRgbCallback(math.floor(pct * 255))
            end
        end)
    end

    local r, g, b = math.floor(currentColor.R*255), math.floor(currentColor.G*255), math.floor(currentColor.B*255)
    
    local updateColor = function()
        currentColor = Color3.fromRGB(r, g, b)
        colorDisplayBtn.BackgroundColor3 = currentColor
        callback(currentColor)
    end

    makeRgbSlider(10, "R", r, function(val) r = val updateColor() end)
    makeRgbSlider(35, "G", g, function(val) g = val updateColor() end)
    makeRgbSlider(60, "B", b, function(val) b = val updateColor() end)

    colorDisplayBtn.MouseButton1Click:Connect(function()
        expanded = not expanded
        if expanded then
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 140)}):Play()
        else
            TweenService:Create(frame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(1, 0, 0, 32)}):Play()
        end
    end)
end

local function createLabel(parent, text, rightText)
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 0, 0, 24)
    frame.BackgroundTransparency = 1
    frame.Parent = parent
    
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(0.55, -8, 1, 0)
    label.Position = UDim2.new(0, 8, 0, 0)
    label.BackgroundTransparency = 1
    label.Text = text
    label.RichText = true
    label.TextColor3 = theme.Text
    label.Font = Enum.Font.Gotham
    label.TextSize = 13
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = frame
    
    local rightLabel = Instance.new("TextLabel")
    rightLabel.Size = UDim2.new(0.45, -8, 1, 0)
    rightLabel.Position = UDim2.new(0.55, 0, 0, 0)
    rightLabel.BackgroundTransparency = 1
    rightLabel.Text = rightText or ""
    rightLabel.RichText = true
    rightLabel.TextColor3 = theme.TextDim
    rightLabel.Font = Enum.Font.Gotham
    rightLabel.TextSize = 13
    rightLabel.TextXAlignment = Enum.TextXAlignment.Right
    rightLabel.Parent = frame
    
    local obj = {
        frame = frame,
        label = label,
        rightLabel = rightLabel,
        Set = function(self, newRight, newLeft)
            if newRight then rightLabel.Text = newRight end
            if newLeft then label.Text = newLeft end
        end
    }
    
    return setmetatable(obj, {
        __index = label,
        __newindex = function(t, k, v)
            if k == "Text" then
                if string.find(tostring(v), " %- ") then
                    local parts = string.split(tostring(v), " - ")
                    label.Text = parts[1]
                    rightLabel.Text = parts[2]
                else
                    label.Text = tostring(v)
                end
            else
                label[k] = v
            end
        end
    })
end

-- ==========================================
-- KNIT FRAMEWORK SERVICES & CONTROLLERS
-- ==========================================
local knitPkg = ReplicatedStorage:WaitForChild("Packages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit")
local knitServices = knitPkg:WaitForChild("Services")

local TrainingService = knitServices:WaitForChild("TrainingService")
local PlaytimeRewardService = knitServices:WaitForChild("PlaytimeRewardService")
local DailyRewardService = knitServices:WaitForChild("DailyRewardService")
local FreeShopService = knitServices:WaitForChild("FreeShopService")
local SpinWheelService = knitServices:WaitForChild("SpinWheelService")
local AnimalService = knitServices:WaitForChild("AnimalService")
local EggService = knitServices:WaitForChild("EggService")
local RebirthService = knitServices:WaitForChild("RebirthService")
local WaveService = knitServices:WaitForChild("WaveService")
local UpgradesService = knitServices:WaitForChild("UpgradesService")
local PlotService = knitServices:WaitForChild("PlotService")
local WarpService = knitServices:WaitForChild("WarpService")
local PickaxeService = knitServices:FindFirstChild("PickaxeService")

-- Client Controllers & Shared Utilities
local TrainingController = nil
local WaveController = nil
local EggController = nil
local ReplicaController = nil
local PickupController = nil
local PickupUtils = nil
local Modifiers = nil

pcall(function()
    local KnitClient = require(knitPkg)
    TrainingController = KnitClient.GetController("TrainingController")
    WaveController = KnitClient.GetController("WaveController")
    EggController = KnitClient.GetController("EggController")
    ReplicaController = KnitClient.GetController("ReplicaController")
    PickupController = KnitClient.GetController("PickupController")
end)

pcall(function()
    PickupUtils = require(ReplicatedStorage:WaitForChild("GameShared"):WaitForChild("PickupUtils"))
end)
pcall(function()
    Modifiers = require(ReplicatedStorage:WaitForChild("Modifiers"))
end)

-- ==========================================
-- GAME DATA DEFINITIONS
-- ==========================================
local DumbbellsList = {}
pcall(function()
    local TrainConfig = require(ReplicatedStorage.Configs.TrainToolConfig)
    local raw = TrainConfig.TRAIN_TOOLS or TrainConfig
    for id, info in pairs(raw) do
        table.insert(DumbbellsList, {
            id = id,
            name = info.name or info.displayName or id,
            gain = info.gainPerTrain or info.power or 0,
            order = info.layoutOrder or info.order or 0,
            price = info.defaultPrice or info.price or 0
        })
    end
    table.sort(DumbbellsList, function(a, b)
        if a.order ~= b.order then return a.order < b.order end
        return a.gain < b.gain
    end)
end)

-- Reliable fallback if config require fails
if #DumbbellsList == 0 then
    DumbbellsList = {
        { id = "dumbell", name = "Dumbbell", gain = 1, order = 2, price = 10 },
        { id = "dumbbellcircle", name = "Circle Dumbbell", gain = 2, order = 3, price = 15 },
        { id = "strawberry dumbbell", name = "Strawberry Dumbbell", gain = 5, order = 4, price = 19 },
        { id = "wooddumbbell", name = "Wood Dumbbell", gain = 20, order = 5, price = 39 },
        { id = "geardumbbell", name = "Gear Dumbbell", gain = 100, order = 6, price = 69 },
        { id = "nucleardumbbell", name = "Nuclear Dumbbell", gain = 500, order = 7, price = 99 },
        { id = "Present dumbbell", name = "Present Dumbbell", gain = 2500, order = 8, price = 139 },
        { id = "donutdumbbell", name = "Donut Dumbbell", gain = 12500, order = 9, price = 199 },
        { id = "pancakedumbbell", name = "Pancake Dumbbell", gain = 60000, order = 10, price = 249 },
        { id = "cubedumbbell", name = "Frozen Dumbbell", gain = 300000, order = 11, price = 299 },
        { id = "rocketdumbbell", name = "Rocket Dumbbell", gain = 1500000, order = 12, price = 399 },
        { id = "anvildumbbell", name = "Anvil Dumbbell", gain = 7500000, order = 13, price = 549 },
        { id = "burger dumbbell", name = "Burger Dumbbell", gain = 37500000, order = 14, price = 799 },
        { id = "skulldumbbell", name = "Skull Dumbbell", gain = 180750000, order = 15, price = 999 },
        { id = "rubikdumbbell", name = "Rubik Dumbbell", gain = 937500000, order = 16, price = 1199 },
        { id = "spikedumbbell", name = "Spike Dumbbell", gain = 5000000000, order = 17, price = 1499 },
        { id = "golddumbbell", name = "Gold Dumbbell", gain = 25000000000, order = 18, price = 1749 },
        { id = "diamonddumbbell", name = "Diamond Dumbbell", gain = 125000000000, order = 19, price = 1999 },
        { id = "bunnydumbbell", name = "Bunny Dumbbell", gain = 625000000000, order = 20, price = 2249 },
        { id = "birthdaydumbbell", name = "Birthday Dumbbell", gain = 3125000000000, order = 21, price = 2499 },
        { id = "1970car", name = "1970 Car", gain = 15625000000000, order = 22, price = 2749 },
        { id = "passenger_plane", name = "Plane Dumbbell", gain = 78125000000000, order = 23, price = 3499 },
        { id = "summerdumbbell", name = "Summer Dumbbell", gain = 1000000000, order = 24, price = 0 }
    }
end

-- ==========================================
-- HELPER FUNCTIONS FOR DUMBBELLS & WAVES
-- ==========================================

-- Helper: Get the best dumbbell owned by the player (Anti-Spam capable)
local function getBestOwnedDumbbell()
    local pData = nil
    if ReplicaController then
        pcall(function() pData = ReplicaController:GetPlayerData() end)
    end
    if not pData or not pData.OwnedTrainTools then
        return nil, nil
    end

    -- DumbbellsList is sorted from lowest to highest tier
    for i = #DumbbellsList, 1, -1 do
        local tool = DumbbellsList[i]
        if pData.OwnedTrainTools[tool.id] == true then
            return tool, pData.EquippedTrainTool
        end
    end
    return nil, pData.EquippedTrainTool
end

-- Helper: Collect spawned items during a wave
local function collectWaveItems()
    local spawnedFolder = workspace:FindFirstChild("SpawnedItems")
    if not spawnedFolder then return 0 end

    local maxPickup = 1
    if Modifiers then
        pcall(function() maxPickup = Modifiers.Get(LocalPlayer, "MaxPickup") end)
    end

    local currentHeld = 0
    if PickupUtils then
        pcall(function() currentHeld = #PickupUtils.GetPickables(LocalPlayer) end)
    end

    local collected = 0
    for _, item in ipairs(spawnedFolder:GetChildren()) do
        if currentHeld >= maxPickup then break end
        if item:HasTag("Pickable") and not item:GetAttribute("OwnerId") then
            if PickupController then
                local s, r = pcall(function() return PickupController:Pickup(item) end)
                if s and r then
                    currentHeld = currentHeld + 1
                    collected = collected + 1
                end
            end
        end
    end
    return collected
end

-- Helper: Cleanly deliver collected wave items and finish wave
local function finishAndDeliverWave()
    local itemIds = {}
    if PickupController then
        pcall(function() itemIds = PickupController:GetItemIds() end)
    end
    if PickupUtils then
        pcall(function()
            for _, v in ipairs(PickupUtils.GetPickables(LocalPlayer)) do
                v:Destroy()
            end
        end)
    end
    pcall(function()
        WaveService.RF.Finished:InvokeServer(itemIds)
    end)
end

local EggsList = {
    { id = "basic_egg", name = "Basic Egg" },
    { id = "seal_egg", name = "Seal Egg" },
    { id = "tiger_egg", name = "Tiger Egg" },
    { id = "bats_egg", name = "Bat Egg" },
    { id = "ocean_egg", name = "Ocean Egg" },
    { id = "mamut_egg", name = "Mamut Egg" },
    { id = "gorilla_egg", name = "Gorilla Egg" },
    { id = "snake_egg", name = "Snake Egg" },
    { id = "la_everything_egg", name = "La Everything Egg" },
    { id = "snails_egg", name = "Snails Egg" },
    { id = "magician_egg", name = "Magician Egg" },
    { id = "osctrich_egg", name = "Osctrich Egg" },
    { id = "polarbear_egg", name = "Polarbear Egg" },
    { id = "deer_egg", name = "Corals Egg" },
    { id = "glacial_egg", name = "Glacial Egg" },
    { id = "trex_egg", name = "Trex Egg" },
    { id = "sleepy_egg", name = "Sleepy Egg" },
    { id = "volt_egg", name = "Volt Egg" },
    { id = "dragon_egg", name = "Dragon Egg" },
    { id = "capybara_egg", name = "Capybara Egg" },
    { id = "mouse_egg", name = "Mouse Egg" },
    { id = "frogs_egg", name = "Frog Egg" },
    { id = "sphinx_egg", name = "Sphinx Egg" }
}

-- Teleport Coordinate Constants
local Coords = {
    Areas = {
        Common = Vector3.new(531, 42, 306),
        Uncommon = Vector3.new(391, 42, 306),
        Rare = Vector3.new(251, 42, 306),
        Epic = Vector3.new(110, 42, 306),
        Floor1 = Vector3.new(-599, 42, 306)
    },
    Portals = {
        ["Boss 1"] = Vector3.new(412, 52, 320),
        ["Boss 2"] = Vector3.new(211, 52, 246),
        ["Boss 3"] = Vector3.new(-12, 51, 320),
        ["Boss 4"] = Vector3.new(-194, 50, 248),
        ["Boss 5"] = Vector3.new(-416, 51, 318),
        ["Zeus Portal"] = Vector3.new(412, 43, 283),
        ["Devil Portal"] = Vector3.new(412, 43, 283)
    },
    Plots = {
        ["Plot 1"] = Vector3.new(718, 66, 201),
        ["Plot 2"] = Vector3.new(772, 67, 254),
        ["Plot 3"] = Vector3.new(772, 67, 326),
        ["Plot 4"] = Vector3.new(772, 67, 398),
        ["Plot 5"] = Vector3.new(772, 67, 470)
    }
}

-- Helper to teleport player character
local function teleportPlayer(targetPos)
    pcall(function()
        local char = LocalPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if hrp then
            hrp.CFrame = CFrame.new(targetPos)
        end
    end)
end

-- ==========================================
-- CONFIGURATION & SCRIPT STATE
-- ==========================================
local config = {
    -- Auto Train
    AutoTrain = false,
    AutoEquipBestDumbbell = false,
    AutoBuyDumbbells = false,
    AutoClaimTrainBonus = false,
    SelectedDumbbell = "dumbell",
    
    -- Wave & Animals
    AutoWaveFarm = false,          -- Full automated wave loop (Open -> Loot -> Deliver)
    AutoStartWave = false,         -- Open sea only
    AutoCollectWaveItems = false,  -- Loot seabed items only
    AutoFinishWave = false,        -- Finish / deliver wave loot only
    AutoResetWave = false,         -- Extend wave timer to max
    AutoCollectOfflineCash = false,
    AutoEquipBestAnimals = false,
    AutoStealAnimals = false,
    
    -- Eggs
    AutoHatchEgg = false,
    FastHatch = true,
    SelectedEgg = "basic_egg",
    HatchAmount = 1,
    AutoHatchPlotEggs = false,
    
    -- Rewards & Upgrades
    AutoClaimGifts = false,
    AutoSpinWheel = false,
    AutoDailyReward = false,
    AutoVIPDailyReward = false,
    AutoFreeShop = false,
    AutoRebirth = false,
    SkipRebirthAnim = true,
    AutoSpeedUpgrade = false,
    AutoSlotUpgrade = false,
    
    -- Player
    WalkSpeed = 16,
    JumpPower = 50,
    InfiniteJump = false,
    Noclip = false,
    
    -- ESP
    PlayerESP = false,
    AnimalESP = false,
    EggESP = false,
    
    -- System
    AntiAFK = false
}

-- Format Numbers (1K, 1M, 1B, 1T)
local function formatNumber(n)
    n = tonumber(n) or 0
    if n >= 1e12 then return string.format("%.2fT", n / 1e12) end
    if n >= 1e9 then return string.format("%.2fB", n / 1e9) end
    if n >= 1e6 then return string.format("%.2fM", n / 1e6) end
    if n >= 1e3 then return string.format("%.2fK", n / 1e3) end
    return tostring(math.floor(n))
end

-- ==========================================
-- BACKGROUND LOOPS & WORKERS
-- ==========================================

-- 1. Auto Training Worker
task.spawn(function()
    while true do
        task.wait(0.5)
        if config.AutoTrain then
            pcall(function()
                if TrainingController then
                    if not TrainingController:IsTraining() then
                        TrainingController:StartTraining()
                    end
                else
                    TrainingService.RF.StartTraining:InvokeServer()
                end
            end)
        end
    end
end)

-- 2. Auto Equip Best & Buy Dumbbells Worker (Anti-Spam)
task.spawn(function()
    while true do
        task.wait(2.0)
        if config.AutoBuyDumbbells then
            pcall(function()
                for _, item in ipairs(DumbbellsList) do
                    pcall(function() TrainingService.RF.BuyTrainTool:InvokeServer(item.id) end)
                    task.wait(0.1)
                end
            end)
        end
        if config.AutoEquipBestDumbbell then
            pcall(function()
                local bestTool, equippedId = getBestOwnedDumbbell()
                -- ONLY equip if bestTool exists AND it's not already equipped! NO SPAM!
                if bestTool and equippedId ~= bestTool.id then
                    TrainingService.RF.EquipTrainTool:InvokeServer(bestTool.id)
                end
            end)
        end
        if config.AutoClaimTrainBonus then
            pcall(function()
                TrainingService.RF.ClaimBonus:InvokeServer()
            end)
        end
    end
end)

-- 3. Auto Wave Farm & Animals Worker
local waveFarmBusy = false
task.spawn(function()
    while true do
        task.wait(1.0)
        
        -- Full Automated Wave Farming Loop
        if config.AutoWaveFarm then
            if not waveFarmBusy then
                waveFarmBusy = true
                pcall(function()
                    local isWaveActive = LocalPlayer:GetAttribute("IsWaveActive") == true
                    if not isWaveActive then
                        -- Start wave with max extension (5)
                        if WaveController then
                            pcall(function() WaveController:Start(5) end)
                        else
                            pcall(function() WaveService.RF.Start:InvokeServer(5) end)
                        end
                        task.wait(1.6)
                    end
                    
                    if LocalPlayer:GetAttribute("IsWaveActive") == true then
                        -- Collect items
                        collectWaveItems()
                        
                        local currentHeld = 0
                        if PickupUtils then
                            pcall(function() currentHeld = #PickupUtils.GetPickables(LocalPlayer) end)
                        end
                        local maxPickup = 1
                        if Modifiers then
                            pcall(function() maxPickup = Modifiers.Get(LocalPlayer, "MaxPickup") end)
                        end
                        
                        local spawnedFolder = workspace:FindFirstChild("SpawnedItems")
                        local remaining = spawnedFolder and #spawnedFolder:GetChildren() or 0
                        
                        -- If bag is full or no more items on seabed, deliver loot!
                        if currentHeld >= maxPickup or remaining == 0 then
                            finishAndDeliverWave()
                            task.wait(1.0)
                        else
                            if config.AutoResetWave then
                                pcall(function() WaveService.RF.ResetWaveToMax:InvokeServer() end)
                            end
                        end
                    end
                end)
                waveFarmBusy = false
            end
        else
            -- Granular Manual Toggles
            if config.AutoStartWave and not LocalPlayer:GetAttribute("IsWaveActive") then
                pcall(function()
                    if WaveController then
                        WaveController:Start(5)
                    else
                        WaveService.RF.Start:InvokeServer(5)
                    end
                end)
            end
            if config.AutoCollectWaveItems and LocalPlayer:GetAttribute("IsWaveActive") then
                pcall(function() collectWaveItems() end)
            end
            if config.AutoFinishWave and LocalPlayer:GetAttribute("IsWaveActive") then
                pcall(function() finishAndDeliverWave() end)
            end
            if config.AutoResetWave and LocalPlayer:GetAttribute("IsWaveActive") then
                pcall(function() WaveService.RF.ResetWaveToMax:InvokeServer() end)
            end
        end

        -- Animals & Offline Income
        if config.AutoCollectOfflineCash then
            pcall(function() AnimalService.RF.CollectOfflineCash:InvokeServer() end)
        end
        if config.AutoEquipBestAnimals then
            pcall(function() AnimalService.RF.EquipBest:InvokeServer() end)
        end
        if config.AutoStealAnimals then
            pcall(function() AnimalService.RF.Steal:InvokeServer() end)
        end
    end
end)

-- 4. Auto Egg Hatching Worker
task.spawn(function()
    while true do
        task.wait(1.0)
        if config.AutoHatchEgg then
            pcall(function()
                if config.FastHatch then
                    pcall(function() EggService.RF.InitSkip:InvokeServer() end)
                end
                EggService.RF.HatchEgg:InvokeServer(config.SelectedEgg, config.HatchAmount, config.FastHatch)
            end)
        end
        if config.AutoHatchPlotEggs then
            pcall(function()
                local myPlotId = PlotService.RF.GetMyPlotId:InvokeServer()
                if myPlotId then
                    local plot = workspace.Plots:FindFirstChild(tostring(myPlotId))
                    local inner = plot and plot:FindFirstChild(tostring(myPlotId))
                    local eggsFolder = inner and inner:FindFirstChild("Eggs")
                    if eggsFolder then
                        for _, egg in ipairs(eggsFolder:GetChildren()) do
                            pcall(function()
                                if config.FastHatch then EggService.RF.InitSkip:InvokeServer() end
                                EggService.RF.HatchEgg:InvokeServer(egg.Name, 1, config.FastHatch)
                            end)
                            task.wait(0.2)
                        end
                    end
                end
            end)
        end
    end
end)

-- 5. Auto Rewards & Free Items Worker
task.spawn(function()
    while true do
        task.wait(3.0)
        if config.AutoClaimGifts then
            pcall(function()
                for i = 1, 12 do
                    pcall(function() PlaytimeRewardService.RF.ClaimGift:InvokeServer(i) end)
                    task.wait(0.1)
                end
            end)
        end
        if config.AutoSpinWheel then
            pcall(function() SpinWheelService.RF.SpinWheel:InvokeServer() end)
        end
        if config.AutoDailyReward then
            pcall(function() DailyRewardService.RF.ClaimReward:InvokeServer() end)
        end
        if config.AutoVIPDailyReward then
            pcall(function() DailyRewardService.RF.ClaimVIPReward:InvokeServer() end)
        end
        if config.AutoFreeShop then
            pcall(function() FreeShopService.RF.Claim:InvokeServer() end)
        end
        if config.AutoRebirth then
            pcall(function()
                if config.SkipRebirthAnim then
                    pcall(function() RebirthService.RF.InitSkip:InvokeServer() end)
                end
                RebirthService.RF.Rebirth:InvokeServer()
            end)
        end
        if config.AutoSpeedUpgrade then
            pcall(function() UpgradesService.RF.PromptSpeedTier:InvokeServer() end)
        end
        if config.AutoSlotUpgrade then
            pcall(function() UpgradesService.RF.PromptAnimalSlotTier:InvokeServer() end)
        end
    end
end)

-- 6. Movement, Speed & Noclip Listeners
RunService.Stepped:Connect(function()
    if config.Noclip and LocalPlayer.Character then
        for _, part in ipairs(LocalPlayer.Character:GetDescendants()) do
            if part:IsA("BasePart") and part.CanCollide then
                part.CanCollide = false
            end
        end
    end
    if LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            if hum.WalkSpeed ~= config.WalkSpeed and config.WalkSpeed ~= 16 then
                hum.WalkSpeed = config.WalkSpeed
            end
            if hum.JumpPower ~= config.JumpPower and config.JumpPower ~= 50 then
                hum.JumpPower = config.JumpPower
            end
        end
    end
end)

UIS.JumpRequest:Connect(function()
    if config.InfiniteJump and LocalPlayer.Character then
        local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

-- 7. ESP Storage & Manager
local espFolder = Instance.new("Folder")
espFolder.Name = "ArcaHUB_ESP"
espFolder.Parent = CoreGui

local function clearESP()
    for _, obj in ipairs(espFolder:GetChildren()) do
        obj:Destroy()
    end
end

task.spawn(function()
    while true do
        task.wait(2.0)
        if not (config.PlayerESP or config.AnimalESP or config.EggESP) then
            clearESP()
        else
            -- Player ESP
            if config.PlayerESP then
                for _, player in ipairs(Players:GetPlayers()) do
                    if player ~= LocalPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        local bb = espFolder:FindFirstChild("PESP_" .. player.Name)
                        if not bb then
                            bb = Instance.new("BillboardGui")
                            bb.Name = "PESP_" .. player.Name
                            bb.AlwaysOnTop = true
                            bb.Size = UDim2.new(0, 100, 0, 30)
                            bb.Adornee = hrp
                            bb.Parent = espFolder
                            local lbl = Instance.new("TextLabel", bb)
                            lbl.Size = UDim2.new(1, 0, 1, 0)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = Color3.fromRGB(255, 100, 100)
                            lbl.Text = player.DisplayName .. "\n[" .. math.floor((hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
                            lbl.Font = Enum.Font.GothamBold
                            lbl.TextSize = 11
                        else
                            local lbl = bb:FindFirstChildOfClass("TextLabel")
                            if lbl and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                                lbl.Text = player.DisplayName .. "\n[" .. math.floor((hrp.Position - LocalPlayer.Character.HumanoidRootPart.Position).Magnitude) .. "m]"
                            end
                        end
                    end
                end
            end
            
            -- Egg ESP
            if config.EggESP then
                for _, plot in ipairs(workspace.Plots:GetChildren()) do
                    local inner = plot:FindFirstChild(plot.Name)
                    local eggsFolder = inner and inner:FindFirstChild("Eggs")
                    if eggsFolder then
                        for _, egg in ipairs(eggsFolder:GetChildren()) do
                            local part = egg:IsA("BasePart") and egg or egg:FindFirstChildWhichIsA("BasePart", true)
                            if part then
                                local bb = espFolder:FindFirstChild("EESP_" .. egg:GetDebugId())
                                if not bb then
                                    bb = Instance.new("BillboardGui")
                                    bb.Name = "EESP_" .. egg:GetDebugId()
                                    bb.AlwaysOnTop = true
                                    bb.Size = UDim2.new(0, 100, 0, 24)
                                    bb.Adornee = part
                                    bb.Parent = espFolder
                                    local lbl = Instance.new("TextLabel", bb)
                                    lbl.Size = UDim2.new(1, 0, 1, 0)
                                    lbl.BackgroundTransparency = 1
                                    lbl.TextColor3 = Color3.fromRGB(255, 215, 0)
                                    lbl.Text = "🥚 " .. egg.Name
                                    lbl.Font = Enum.Font.GothamBold
                                    lbl.TextSize = 10
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end)

-- ==========================================
-- CREATE TABS
-- ==========================================
local tabMain = addTab("Main", "rbxassetid://10709761813")       -- Aperture Core
local tabEggs = addTab("Eggs", "rbxassetid://10747372992")       -- Box/Egg
local tabTeleport = addTab("Teleport", "rbxassetid://10723415903") -- Map/Globe
local tabRewards = addTab("Rewards", "rbxassetid://10709789810") -- Gift Box
local tabPlayer = addTab("Player", "rbxassetid://10747373176")   -- User
local tabProfile = addTab("Profile", "rbxassetid://10747373176") -- Identity Card
local tabCustom = addTab("Customization", "rbxassetid://10747376349") -- Palette
local tabSettings = addTab("Settings", "rbxassetid://10734950309") -- Cog

-- ==========================================
-- 1. MAIN TAB (Auto Train, Waves & Animals)
-- ==========================================

-- Left Column: Auto Training & Dumbbells
local trainSec = createSection(tabMain.left, "Auto Training & Dumbbell", "rbxassetid://10709761813")
createToggle(trainSec, "Auto Train (Power)", false, function(state)
    config.AutoTrain = state
    if not state and TrainingController then
        pcall(function() TrainingController:StopTraining() end)
    end
end)

createToggle(trainSec, "Auto Equip Best Dumbbell (Anti-Spam)", false, function(state)
    config.AutoEquipBestDumbbell = state
end)

createToggle(trainSec, "Auto Buy Dumbbells", false, function(state)
    config.AutoBuyDumbbells = state
end)

createToggle(trainSec, "Auto Claim Train Bonus", false, function(state)
    config.AutoClaimTrainBonus = state
end)

local currentDumbbellLabel = createLabel(trainSec, "<b>Equipped Dumbbell</b>", "<font color=\"#FFAA00\">Loading...</font>")
task.spawn(function()
    while true do
        task.wait(1.0)
        pcall(function()
            local pData = nil
            if ReplicaController then pData = ReplicaController:GetPlayerData() end
            local eq = pData and pData.EquippedTrainTool or "None"
            local toolName = eq
            for _, t in ipairs(DumbbellsList) do
                if t.id == eq then
                    toolName = t.name
                    break
                end
            end
            currentDumbbellLabel.Text = "<b>Equipped</b> - <font color=\"#FFAA00\">" .. toolName .. "</font>"
        end)
    end
end)

local dumbbellNames = {}
for _, item in ipairs(DumbbellsList) do
    table.insert(dumbbellNames, item.name)
end

createDropdown(trainSec, "Select Dumbbell", dumbbellNames, (DumbbellsList[1] and DumbbellsList[1].name or "Dumbbell"), function(selected, idx)
    if DumbbellsList[idx] then
        config.SelectedDumbbell = DumbbellsList[idx].id
    end
end)

createButton(trainSec, "Equip Selected Dumbbell", function()
    pcall(function()
        TrainingService.RF.EquipTrainTool:InvokeServer(config.SelectedDumbbell)
    end)
end)

createButton(trainSec, "Buy Selected Dumbbell", function()
    pcall(function()
        TrainingService.RF.BuyTrainTool:InvokeServer(config.SelectedDumbbell)
    end)
end)

createButton(trainSec, "Train Once Now", function()
    pcall(function()
        if TrainingController then
            TrainingController:StartTraining()
            task.delay(0.5, function()
                if not config.AutoTrain then TrainingController:StopTraining() end
            end)
        else
            TrainingService.RF.StartTraining:InvokeServer()
        end
    end)
end)

-- Left Column: Rebirth & Progression Stats
local rebirthSec = createSection(tabMain.left, "Rebirth & Progression", "rbxassetid://10747375132")
createToggle(rebirthSec, "Auto Rebirth", false, function(state) config.AutoRebirth = state end)
createToggle(rebirthSec, "Skip Rebirth Animation", true, function(state) config.SkipRebirthAnim = state end)

local powerStatLabel = createLabel(rebirthSec, "<b>Power</b>", "<font color=\"#55FF55\">0</font>")
local cashStatLabel = createLabel(rebirthSec, "<b>Cash</b>", "<font color=\"#FFAA00\">0</font>")
local speedStatLabel = createLabel(rebirthSec, "<b>Speed</b>", "<font color=\"#55AAFF\">0</font>")

task.spawn(function()
    while true do
        task.wait(1.0)
        pcall(function()
            local ls = LocalPlayer:FindFirstChild("leaderstats")
            if ls then
                if ls:FindFirstChild("Power") then
                    powerStatLabel.Text = "<b>Power</b> - <font color=\"#55FF55\">" .. formatNumber(ls.Power.Value) .. "</font>"
                end
                if ls:FindFirstChild("Cash") then
                    cashStatLabel.Text = "<b>Cash</b> - <font color=\"#FFAA00\">" .. formatNumber(ls.Cash.Value) .. "</font>"
                end
                if ls:FindFirstChild("Speed") then
                    speedStatLabel.Text = "<b>Speed</b> - <font color=\"#55AAFF\">" .. formatNumber(ls.Speed.Value) .. "</font>"
                end
            end
        end)
    end
end)

createButton(rebirthSec, "Rebirth Once Now", function()
    pcall(function()
        if config.SkipRebirthAnim then RebirthService.RF.InitSkip:InvokeServer() end
        RebirthService.RF.Rebirth:InvokeServer()
    end)
end)

-- Right Column: Sea Wave Farm & Defense
local waveSec = createSection(tabMain.right, "Sea Wave Farm & Looting", "rbxassetid://10734898592")
createToggle(waveSec, "Auto Wave Farm (Full Loop)", false, function(state)
    config.AutoWaveFarm = state
end)
createToggle(waveSec, "Auto Open Sea (Start Wave)", false, function(state)
    config.AutoStartWave = state
end)
createToggle(waveSec, "Auto Collect Wave Items", false, function(state)
    config.AutoCollectWaveItems = state
end)
createToggle(waveSec, "Auto Finish & Deliver Loot", false, function(state)
    config.AutoFinishWave = state
end)
createToggle(waveSec, "Auto Extend Wave Timer", false, function(state)
    config.AutoResetWave = state
end)

local waveStatusLabel = createLabel(waveSec, "<b>Wave Status</b>", "<font color=\"#AAAAAA\">Closed</font>")
local waveItemsLabel = createLabel(waveSec, "<b>Seabed Items</b>", "<font color=\"#55AAFF\">0 items</font>")

task.spawn(function()
    while true do
        task.wait(1.0)
        pcall(function()
            local isActive = LocalPlayer:GetAttribute("IsWaveActive") == true
            waveStatusLabel.Text = "<b>Wave Status</b> - " .. (isActive and "<font color=\"#55FF55\">Active (Open)</font>" or "<font color=\"#AAAAAA\">Closed</font>")
            local count = 0
            if workspace:FindFirstChild("SpawnedItems") then
                count = #workspace.SpawnedItems:GetChildren()
            end
            waveItemsLabel.Text = "<b>Seabed Items</b> - <font color=\"#55AAFF\">" .. count .. " items</font>"
        end)
    end
end)

createButton(waveSec, "Open Sea Now (Max 5s Time)", function()
    pcall(function()
        if WaveController then
            WaveController:Start(5)
        else
            WaveService.RF.Start:InvokeServer(5)
        end
    end)
end)

createButton(waveSec, "Collect All Wave Items Now", function()
    pcall(function()
        collectWaveItems()
    end)
end)

createButton(waveSec, "Finish & Deliver Loot Now", function()
    pcall(function()
        finishAndDeliverWave()
    end)
end)

createButton(waveSec, "Reset Wave Timer to Max", function()
    pcall(function()
        WaveService.RF.ResetWaveToMax:InvokeServer()
    end)
end)

-- Right Column: Animals & Offline Farm
local animalSec = createSection(tabMain.right, "Animals & Offline Income", "rbxassetid://10747372992")
createToggle(animalSec, "Auto Collect Offline Cash", false, function(state) config.AutoCollectOfflineCash = state end)
createToggle(animalSec, "Auto Equip Best Animals", false, function(state) config.AutoEquipBestAnimals = state end)
createToggle(animalSec, "Auto Steal Animals", false, function(state) config.AutoStealAnimals = state end)

createButton(animalSec, "Collect Offline Cash Now", function()
    pcall(function() AnimalService.RF.CollectOfflineCash:InvokeServer() end)
end)

createButton(animalSec, "Equip Best Animals Now", function()
    pcall(function() AnimalService.RF.EquipBest:InvokeServer() end)
end)

-- ==========================================
-- 2. EGGS TAB (Hatching & Plot Eggs)
-- ==========================================
local eggHatchSec = createSection(tabEggs.left, "Egg Hatching System", "rbxassetid://10747372992")
createToggle(eggHatchSec, "Auto Hatch Selected Egg", false, function(state) config.AutoHatchEgg = state end)
createToggle(eggHatchSec, "Fast Hatch (Skip Animation)", true, function(state) config.FastHatch = state end)

local eggNames = {}
for _, item in ipairs(EggsList) do
    table.insert(eggNames, item.name)
end

createDropdown(eggHatchSec, "Select Egg Type", eggNames, EggsList[1].name, function(selected, idx)
    config.SelectedEgg = EggsList[idx].id
end)

createDropdown(eggHatchSec, "Hatch Amount", {"1 Egg", "3 Eggs", "8 Eggs"}, "1 Egg", function(selected, idx)
    local amounts = {1, 3, 8}
    config.HatchAmount = amounts[idx] or 1
end)

createButton(eggHatchSec, "Hatch Once Now", function()
    pcall(function()
        if config.FastHatch then EggService.RF.InitSkip:InvokeServer() end
        EggService.RF.HatchEgg:InvokeServer(config.SelectedEgg, config.HatchAmount, config.FastHatch)
    end)
end)

local plotEggSec = createSection(tabEggs.right, "Plot Egg Automation", "rbxassetid://10709789810")
createToggle(plotEggSec, "Auto Hatch Plot Eggs", false, function(state) config.AutoHatchPlotEggs = state end)

local plotEggCountLabel = createLabel(plotEggSec, "<b>Plot Eggs Placed</b>", "<font color=\"#55FF55\">0</font>")
task.spawn(function()
    while true do
        task.wait(1.5)
        pcall(function()
            local myPlotId = PlotService.RF.GetMyPlotId:InvokeServer()
            if myPlotId then
                local plot = workspace.Plots:FindFirstChild(tostring(myPlotId))
                local inner = plot and plot:FindFirstChild(tostring(myPlotId))
                local eggsFolder = inner and inner:FindFirstChild("Eggs")
                local count = eggsFolder and #eggsFolder:GetChildren() or 0
                plotEggCountLabel.Text = "<b>Plot Eggs Placed</b> - <font color=\"#55FF55\">" .. tostring(count) .. "</font>"
            end
        end)
    end
end)

createButton(plotEggSec, "Teleport to My Eggs", function()
    pcall(function()
        local myPlotId = PlotService.RF.GetMyPlotId:InvokeServer()
        if myPlotId and Coords.Plots["Plot " .. myPlotId] then
            teleportPlayer(Coords.Plots["Plot " .. myPlotId])
        end
    end)
end)

-- ==========================================
-- 3. TELEPORT TAB (Plots, Sea Areas & Bosses)
-- ==========================================
local plotTpSec = createSection(tabTeleport.left, "Plot Teleportation", "rbxassetid://10723415903")
createButton(plotTpSec, "Teleport to My Plot (Instant)", function()
    pcall(function() PlotService.RF.TeleportToPlot:InvokeServer() end)
end)

for i = 1, 5 do
    local pName = "Plot " .. i
    createButton(plotTpSec, "Teleport to " .. pName, function()
        teleportPlayer(Coords.Plots[pName])
    end)
end

local seaAreaSec = createSection(tabTeleport.left, "Sea Exploration Areas", "rbxassetid://10734898592")
createButton(seaAreaSec, "Teleport to Common Sea", function() teleportPlayer(Coords.Areas.Common) end)
createButton(seaAreaSec, "Teleport to Uncommon Sea", function() teleportPlayer(Coords.Areas.Uncommon) end)
createButton(seaAreaSec, "Teleport to Rare Sea", function() teleportPlayer(Coords.Areas.Rare) end)
createButton(seaAreaSec, "Teleport to Epic Sea", function() teleportPlayer(Coords.Areas.Epic) end)
createButton(seaAreaSec, "Teleport to Floor 1 Sea", function() teleportPlayer(Coords.Areas.Floor1) end)

local bossPortalSec = createSection(tabTeleport.right, "Boss & Event Portals", "rbxassetid://10734896881")
createButton(bossPortalSec, "Teleport to Boss 1 Portal", function() teleportPlayer(Coords.Portals["Boss 1"]) end)
createButton(bossPortalSec, "Teleport to Boss 2 Portal", function() teleportPlayer(Coords.Portals["Boss 2"]) end)
createButton(bossPortalSec, "Teleport to Boss 3 Portal", function() teleportPlayer(Coords.Portals["Boss 3"]) end)
createButton(bossPortalSec, "Teleport to Boss 4 Portal", function() teleportPlayer(Coords.Portals["Boss 4"]) end)
createButton(bossPortalSec, "Teleport to Boss 5 Portal", function() teleportPlayer(Coords.Portals["Boss 5"]) end)
createButton(bossPortalSec, "Teleport to Zeus Portal", function() teleportPlayer(Coords.Portals["Zeus Portal"]) end)
createButton(bossPortalSec, "Teleport to Devil Portal", function() teleportPlayer(Coords.Portals["Devil Portal"]) end)

-- ==========================================
-- 4. REWARDS & UPGRADES TAB
-- ==========================================
local rewardSec = createSection(tabRewards.left, "Free Claimable Rewards", "rbxassetid://10709789810")
createToggle(rewardSec, "Auto Claim Playtime Gifts (1-12)", false, function(state) config.AutoClaimGifts = state end)
createToggle(rewardSec, "Auto Spin Lucky Wheel", false, function(state) config.AutoSpinWheel = state end)
createToggle(rewardSec, "Auto Claim Daily Reward", false, function(state) config.AutoDailyReward = state end)
createToggle(rewardSec, "Auto Claim VIP Daily Reward", false, function(state) config.AutoVIPDailyReward = state end)
createToggle(rewardSec, "Auto Claim Free Shop Item", false, function(state) config.AutoFreeShop = state end)

createButton(rewardSec, "Claim All 12 Playtime Gifts", function()
    pcall(function()
        for i = 1, 12 do
            PlaytimeRewardService.RF.ClaimGift:InvokeServer(i)
            task.wait(0.08)
        end
    end)
end)

createButton(rewardSec, "Spin Lucky Wheel Now", function()
    pcall(function() SpinWheelService.RF.SpinWheel:InvokeServer() end)
end)

createButton(rewardSec, "Claim Daily Reward Now", function()
    pcall(function() DailyRewardService.RF.ClaimReward:InvokeServer() end)
end)

local upgradeSec = createSection(tabRewards.right, "Stat & Slot Upgrades", "rbxassetid://10723425376")
createToggle(upgradeSec, "Auto Speed Tier Upgrade", false, function(state) config.AutoSpeedUpgrade = state end)
createToggle(upgradeSec, "Auto Animal Slot Upgrade", false, function(state) config.AutoSlotUpgrade = state end)

createButton(upgradeSec, "Upgrade Speed Tier Now", function()
    pcall(function() UpgradesService.RF.PromptSpeedTier:InvokeServer() end)
end)

createButton(upgradeSec, "Upgrade Animal Slot Now", function()
    pcall(function() UpgradesService.RF.PromptAnimalSlotTier:InvokeServer() end)
end)

-- ==========================================
-- 5. PLAYER TAB (Movement & Visuals)
-- ==========================================
local moveSec = createSection(tabPlayer.left, "Movement Enhancements", "rbxassetid://10747373176")
createSlider(moveSec, "WalkSpeed", 16, 250, 16, function(val)
    config.WalkSpeed = val
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.WalkSpeed = val
        end
    end)
end)

createSlider(moveSec, "JumpPower", 50, 300, 50, function(val)
    config.JumpPower = val
    pcall(function()
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            LocalPlayer.Character.Humanoid.JumpPower = val
        end
    end)
end)

createToggle(moveSec, "Infinite Jump", false, function(state) config.InfiniteJump = state end)
createToggle(moveSec, "Noclip (Walk Through Walls)", false, function(state) config.Noclip = state end)

local visualSec = createSection(tabPlayer.right, "Visuals & ESP", "rbxassetid://10723415903")
createToggle(visualSec, "Player ESP", false, function(state)
    config.PlayerESP = state
    if not state then clearESP() end
end)

createToggle(visualSec, "Egg ESP", false, function(state)
    config.EggESP = state
    if not state then clearESP() end
end)

createButton(visualSec, "Rejoin Same Server", function()
    TeleportService:TeleportToPlaceInstance(game.PlaceId, game.JobId, LocalPlayer)
end)

createButton(visualSec, "Server Hop (Different Server)", function()
    pcall(function()
        local serversApi = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local res = game:HttpGet(serversApi)
        local data = HttpService:JSONDecode(res)
        if data and data.data then
            for _, s in ipairs(data.data) do
                if s.playing and s.playing < s.maxPlayers and s.id ~= game.JobId then
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, s.id, LocalPlayer)
                    break
                end
            end
        end
    end)
end)

-- ==========================================
-- 6. PROFILE TAB
-- ==========================================
local discordSec = createSection(tabProfile.left, "Community", "rbxassetid://10734888228")
createButton(discordSec, "Join Discord (ArcaHUB)", function()
    setclipboard("https://discord.gg/ZEcqg4HVY5")
end)

local accountSec = createSection(tabProfile.left, "Account Status", "rbxassetid://10747373176")
createLabel(accountSec, "<b>User</b> - <font color=\"#55FF55\">" .. LocalPlayer.Name .. "</font>")
createLabel(accountSec, "<b>Status</b> - <font color=\"#55FF55\">ArcaHUB VIP</font>")
createLabel(accountSec, "<b>Executor</b> - <font color=\"#55FF55\">" .. (identifyexecutor and identifyexecutor() or "Unknown") .. "</font>")

local gameInfoSec = createSection(tabProfile.left, "Game Session", "rbxassetid://10723415903")
createLabel(gameInfoSec, "<b>Game</b> - <font color=\"#55AAFF\">Open Sea For Animals!</font>")
createLabel(gameInfoSec, "<b>Place ID</b> - <font color=\"#55AAFF\">" .. game.PlaceId .. "</font>")

local sessionStart = tick()
local sessionLabel = createLabel(gameInfoSec, "<b>Session time</b> - <font color=\"#FFAA00\">0m 0s</font>")
task.spawn(function()
    while true do
        task.wait(1)
        local diff = tick() - sessionStart
        local m = math.floor(diff / 60)
        local s = math.floor(diff % 60)
        sessionLabel.Text = "<b>Session time</b> - <font color=\"#FFAA00\">" .. m .. "m " .. s .. "s</font>"
    end
end)

local shortJobId = game.JobId ~= "" and (string.sub(game.JobId, 1, 15) .. "...") or "Local Server"
createLabel(gameInfoSec, "<b>Server</b> - <font color=\"#AAAAAA\">" .. shortJobId .. "</font>")
createButton(gameInfoSec, "Copy Job ID Teleport Script", function()
    if game.JobId ~= "" then
        setclipboard('game:GetService("TeleportService"):TeleportToPlaceInstance('..game.PlaceId..', "'..game.JobId..'", game.Players.LocalPlayer)')
    end
end)

local scriptSec = createSection(tabProfile.right, "Script Details", "rbxassetid://10734943448")
createLabel(scriptSec, "<b>Script Name</b> - <font color=\"#55AAFF\">ArcaHUB</font>")
createLabel(scriptSec, "<b>Version</b> - <font color=\"#55FF55\">1.0.0 Modern</font>")
createLabel(scriptSec, "<b>Framework</b> - <font color=\"#FFAA00\">Knit 1.7.0</font>")

local socialSec = createSection(tabProfile.right, "Creator Links", "rbxassetid://10723404337")
createButton(socialSec, "Discord", function() setclipboard("https://discord.gg/ZEcqg4HVY5") end)
createButton(socialSec, "Rscript", function() setclipboard("https://rscripts.net/@ArcaLaurient") end)
createButton(socialSec, "Scriptverse", function() setclipboard("https://scriptverse.net/u/arcalaurient") end)

-- ==========================================
-- 7. CUSTOMIZATION TAB
-- ==========================================
local function isColorClose(c1, c2)
    return math.abs(c1.R - c2.R) < 0.01 and math.abs(c1.G - c2.G) < 0.01 and math.abs(c1.B - c2.B) < 0.01
end

local function applyThemeUpdate(key, newColor)
    local oldColor = theme[key]
    theme[key] = newColor
    for _, obj in ipairs(screen:GetDescendants()) do
        if obj:IsA("TextLabel") or obj:IsA("TextBox") or obj:IsA("TextButton") then
            if isColorClose(obj.TextColor3, oldColor) then obj.TextColor3 = newColor end
        end
        if obj:IsA("Frame") or obj:IsA("ScrollingFrame") or obj:IsA("TextButton") or obj:IsA("ImageButton") then
            if isColorClose(obj.BackgroundColor3, oldColor) then obj.BackgroundColor3 = newColor end
        end
        if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
            if isColorClose(obj.ImageColor3, oldColor) then obj.ImageColor3 = newColor end
        end
        if obj:IsA("UIStroke") then
            if isColorClose(obj.Color, oldColor) then obj.Color = newColor end
        end
    end
end

local themesSec = createSection(tabCustom.left, "Color Customization", "rbxassetid://10734910430")
createColorPicker(themesSec, "Background Color", theme.Background, function(color) applyThemeUpdate("Background", color) end)
createColorPicker(themesSec, "Accent Color", theme.Accent, function(color) applyThemeUpdate("Accent", color) end)
createColorPicker(themesSec, "Outline Color", theme.Border, function(color) applyThemeUpdate("Border", color) end)
createColorPicker(themesSec, "Font Color", theme.Text, function(color) applyThemeUpdate("Text", color) end)

createButton(themesSec, "Cycle Background Image", function()
    bgIdx = (bgIdx % #bgImages) + 1
    bgImageLabel.Image = bgImages[bgIdx]
end)

local themeListSec = createSection(tabCustom.right, "Preset Themes", "rbxassetid://10723433811")
local presets = {
    ["Default"] = {Background = Color3.fromRGB(12, 12, 12), Accent = Color3.fromRGB(255, 85, 0), Border = Color3.fromRGB(35, 35, 35), Text = Color3.fromRGB(245, 245, 245), Element = Color3.fromRGB(24, 24, 24), Sidebar = Color3.fromRGB(16, 16, 16)},
    ["Ouroboros"] = {Background = Color3.fromRGB(5, 5, 5), Accent = Color3.fromRGB(255, 100, 0), Border = Color3.fromRGB(50, 20, 0), Text = Color3.fromRGB(255, 220, 200), Element = Color3.fromRGB(15, 15, 15), Sidebar = Color3.fromRGB(8, 8, 8)},
    ["Light"] = {Background = Color3.fromRGB(240, 240, 240), Accent = Color3.fromRGB(0, 120, 255), Border = Color3.fromRGB(200, 200, 200), Text = Color3.fromRGB(20, 20, 20), Element = Color3.fromRGB(220, 220, 220), Sidebar = Color3.fromRGB(230, 230, 230)},
    ["Matrix"] = {Background = Color3.fromRGB(0, 10, 0), Accent = Color3.fromRGB(0, 255, 0), Border = Color3.fromRGB(0, 50, 0), Text = Color3.fromRGB(0, 200, 0), Element = Color3.fromRGB(0, 20, 0), Sidebar = Color3.fromRGB(0, 15, 0)},
    ["Blood"] = {Background = Color3.fromRGB(15, 0, 0), Accent = Color3.fromRGB(255, 0, 0), Border = Color3.fromRGB(50, 0, 0), Text = Color3.fromRGB(255, 150, 150), Element = Color3.fromRGB(25, 0, 0), Sidebar = Color3.fromRGB(20, 0, 0)},
    ["Midnight"] = {Background = Color3.fromRGB(0, 0, 15), Accent = Color3.fromRGB(0, 100, 255), Border = Color3.fromRGB(0, 0, 50), Text = Color3.fromRGB(150, 150, 255), Element = Color3.fromRGB(0, 0, 25), Sidebar = Color3.fromRGB(0, 0, 20)}
}
createDropdown(themeListSec, "Select Preset Theme", {"Default", "Ouroboros", "Light", "Matrix", "Blood", "Midnight"}, "Default", function(val)
    local p = presets[val]
    if p then
        applyThemeUpdate("Background", p.Background)
        applyThemeUpdate("Sidebar", p.Sidebar)
        applyThemeUpdate("Element", p.Element)
        applyThemeUpdate("Border", p.Border)
        applyThemeUpdate("Accent", p.Accent)
        applyThemeUpdate("Text", p.Text)
    end
end)

local extraSec = createSection(tabCustom.right, "Display Scaling", "rbxassetid://10723425376")
createSlider(extraSec, "UI Scale (%)", 50, 150, 100, function(val)
    if uiScaleObj then uiScaleObj.Scale = val / 100 end
end)

local blurEffect = nil
createToggle(extraSec, "Background Blur", false, function(state)
    if state then
        if not blurEffect then
            blurEffect = Instance.new("BlurEffect")
            blurEffect.Size = 15
            blurEffect.Parent = Lighting
        end
        blurEffect.Enabled = true
    else
        if blurEffect then blurEffect.Enabled = false end
    end
end)

createSlider(extraSec, "Corner Radius", 0, 24, 6, function(val)
    theme.Radius = UDim.new(0, val)
    for _, obj in ipairs(screen:GetDescendants()) do
        if obj:IsA("UICorner") and obj.Parent ~= minimizeBtn then
            obj.CornerRadius = theme.Radius
        end
    end
end)

-- ==========================================
-- 8. SETTINGS TAB
-- ==========================================
local menuSec = createSection(tabSettings.left, "Menu Controls", "rbxassetid://10734950309")
local currentMinimizeBind = Enum.KeyCode.RightControl
local isMinimized = false

local minimizeBtn = Instance.new("ImageButton")
minimizeBtn.Size = UDim2.new(0, 40, 0, 40)
minimizeBtn.Position = UDim2.new(0.5, -20, 0, 20)
minimizeBtn.BackgroundColor3 = theme.Background
minimizeBtn.Image = "rbxassetid://10709761813"
minimizeBtn.ImageColor3 = theme.Accent
minimizeBtn.Visible = true
minimizeBtn.Active = true
minimizeBtn.Draggable = true
minimizeBtn.Parent = screen
Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(0, 8)
local minimizeStroke = Instance.new("UIStroke")
minimizeStroke.Color = theme.Border
minimizeStroke.Parent = minimizeBtn

minimizeBtn.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    MainFrame.Visible = not isMinimized
end)

UIS.InputBegan:Connect(function(input, processed)
    if not processed and input.KeyCode == currentMinimizeBind then
        isMinimized = not isMinimized
        MainFrame.Visible = not isMinimized
    end
end)

createKeybind(menuSec, "Minimize Keybind", Enum.KeyCode.RightControl, function(key)
    currentMinimizeBind = key
end)

local nextJump = 0
createToggle(menuSec, "Anti AFK", true, function(state)
    config.AntiAFK = state
    if state then nextJump = tick() + math.random(300, 600) end
end)

-- Anti AFK Handlers
LocalPlayer.Idled:Connect(function()
    if config.AntiAFK then
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end
end)

RunService.Heartbeat:Connect(function()
    if config.AntiAFK and tick() >= nextJump then
        nextJump = tick() + math.random(300, 600)
        pcall(function()
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
            if hum then hum.Jump = true end
        end)
    end
end)

local fpsSec = createSection(tabSettings.left, "Graphics & FPS Boost", "rbxassetid://10734896881")
createToggle(fpsSec, "Performance Mode", false, function(state)
    if state then
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 9e9
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Material = Enum.Material.SmoothPlastic
            end
        end
    else
        Lighting.GlobalShadows = true
    end
end)

createToggle(fpsSec, "Better FPS (Low Quality)", false, function(state)
    if state then
        for _, v in pairs(workspace:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CastShadow = false
                v.Material = Enum.Material.SmoothPlastic
            elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") or v:IsA("Trail") then
                pcall(function() v.Enabled = false end)
                pcall(function() v.Transparency = 1 end)
            end
        end
    end
end)

-- Select Default First Tab
local activeTab = tabMain
local activeBgColor = Color3.new(theme.Accent.R * 0.2, theme.Accent.G * 0.2, theme.Accent.B * 0.2)
activeTab.btn.BackgroundColor3 = activeBgColor
activeTab.btn.BackgroundTransparency = 0
activeTab.icon.ImageColor3 = theme.Accent
activeTab.highlight.Size = UDim2.new(0, 3, 0, 22)
activeTab.frame.Visible = true
HeaderTitle.Text = "ArcaHUB - Main"
currentTab = "Main"
