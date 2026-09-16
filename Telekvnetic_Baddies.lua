--// TELEKVNETIC BADDIES
--// LocalScript - StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

local PVP_PVE = PlayerGui:WaitForChild("PVP_PVE")
local ToggleFrame = PVP_PVE:WaitForChild("ToggleFrame")
local RemoteEvent = ToggleFrame:WaitForChild("RemoteEvent")
local GetFromItems = ToggleFrame:WaitForChild("GetFromItems")

local Presets = {
	{Name="Legit", Health="115", ID=115, Tools={"Fiji 1","Big Lex 21","YG Dior 1","Fiji 2","Big Lex 17","Get up"}},
	{Name="Semi Legit", Health="135", ID=135, Tools={"Fiji 1","Big Lex 21","YG Dior 1","Fiji 2","Big Lex 17","Get up"}},
	{Name="Heavy Hitter", Health="155", ID=155, Tools={"Fiji 1","Big Lex 21","YG Dior 1","Fiji 2","Big Lex 17","Stomping"}},
	{Name="Inf Health", Health="1999999", ID=1999999, Tools={}},
	{Name="Grabs", Health="136", ID=136, Tools={"LiddylLock","Lex vs Summer","Dolly vs Summer","Big Lex Rush","Dolly rush","Swing Around"}}
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "TelekvneticBaddies"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = PlayerGui

local Main = Instance.new("Frame")
Main.Size = UDim2.new(0,430,0,270)
Main.Position = UDim2.new(0.5,-215,0.5,-135)
Main.BackgroundColor3 = Color3.fromRGB(7,10,18)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0,16)
MainCorner.Parent = Main

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Parent = Main

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1,0,0,54)
TopBar.BackgroundTransparency = 1
TopBar.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,-120,0,30)
Title.Position = UDim2.new(0,17,0,7)
Title.BackgroundTransparency = 1
Title.Text = "Telekvnetic Baddies"
Title.TextSize = 20
Title.Font = Enum.Font.GothamBold
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = TopBar

local Subtitle = Instance.new("TextLabel")
Subtitle.Size = UDim2.new(1,-120,0,14)
Subtitle.Position = UDim2.new(0,18,0,35)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "Health Presets"
Subtitle.TextSize = 10
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextColor3 = Color3.fromRGB(150,155,170)
Subtitle.TextXAlignment = Enum.TextXAlignment.Left
Subtitle.Parent = TopBar

local Minimize = Instance.new("TextButton")
Minimize.Size = UDim2.new(0,30,0,30)
Minimize.Position = UDim2.new(1,-76,0,9)
Minimize.BackgroundColor3 = Color3.fromRGB(16,22,36)
Minimize.Text = "—"
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.TextSize = 17
Minimize.Font = Enum.Font.GothamBold
Minimize.AutoButtonColor = false
Minimize.Parent = TopBar

local MinCorner = Instance.new("UICorner")
MinCorner.CornerRadius = UDim.new(1,0)
MinCorner.Parent = Minimize

local MinStroke = Instance.new("UIStroke")
MinStroke.Thickness = 1.5
MinStroke.Parent = Minimize

local Close = Instance.new("TextButton")
Close.Size = UDim2.new(0,30,0,30)
Close.Position = UDim2.new(1,-39,0,9)
Close.BackgroundColor3 = Color3.fromRGB(16,22,36)
Close.Text = "×"
Close.TextColor3 = Color3.new(1,1,1)
Close.TextSize = 21
Close.Font = Enum.Font.GothamBold
Close.AutoButtonColor = false
Close.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1,0)
CloseCorner.Parent = Close

local CloseStroke = Instance.new("UIStroke")
CloseStroke.Thickness = 1.5
CloseStroke.Parent = Close

local Container = Instance.new("Frame")
Container.Size = UDim2.new(1,-28,1,-67)
Container.Position = UDim2.new(0,14,0,60)
Container.BackgroundTransparency = 1
Container.Parent = Main

local Layout = Instance.new("UIGridLayout")
Layout.CellSize = UDim2.new(0.5,-5,0,55)
Layout.CellPadding = UDim2.new(0,8,0,8)
Layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
Layout.VerticalAlignment = Enum.VerticalAlignment.Top
Layout.SortOrder = Enum.SortOrder.LayoutOrder
Layout.Parent = Container

local function FindTool(ToolName)
	local Character = Player.Character
	local Backpack = Player:FindFirstChildOfClass("Backpack")
	if Character then
		local Tool = Character:FindFirstChild(ToolName)
		if Tool and Tool:IsA("Tool") then return Tool end
	end
	if Backpack then
		local Tool = Backpack:FindFirstChild(ToolName)
		if Tool and Tool:IsA("Tool") then return Tool end
	end
	return nil
end

local function EquipTool(ToolName)
	local Character = Player.Character
	if not Character then return false end
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	if not Humanoid then return false end
	local Tool = FindTool(ToolName)
	if Tool then
		Humanoid:EquipTool(Tool)
		return true
	end
	return false
end

local function RunPreset(Preset)
	RemoteEvent:FireServer(Preset.ID)
	task.wait(0.08)
	GetFromItems:FireServer()
	task.wait(0.15)
	for _, ToolName in ipairs(Preset.Tools) do
		EquipTool(ToolName)
		task.wait(0.04)
	end
end

local HealthButtons = {}

for Index, Preset in ipairs(Presets) do
	local Button = Instance.new("TextButton")
	Button.Size = UDim2.new(0,200,0,55)
	Button.BackgroundColor3 = Color3.fromRGB(14,17,27)
	Button.BorderSizePixel = 0
	Button.Text = ""
	Button.AutoButtonColor = false
	Button.LayoutOrder = Index
	Button.Parent = Container

	local Corner = Instance.new("UICorner")
	Corner.CornerRadius = UDim.new(0,11)
	Corner.Parent = Button

	local Stroke = Instance.new("UIStroke")
	Stroke.Thickness = 1.5
	Stroke.Parent = Button

	local NameLabel = Instance.new("TextLabel")
	NameLabel.Size = UDim2.new(0.68,0,0,27)
	NameLabel.Position = UDim2.new(0,13,0,4)
	NameLabel.BackgroundTransparency = 1
	NameLabel.Text = Preset.Name
	NameLabel.TextColor3 = Color3.fromRGB(235,238,247)
	NameLabel.TextSize = 14
	NameLabel.Font = Enum.Font.GothamSemibold
	NameLabel.TextXAlignment = Enum.TextXAlignment.Left
	NameLabel.Parent = Button

	local HealthLabel = Instance.new("TextLabel")
	HealthLabel.Size = UDim2.new(0.27,0,0,27)
	HealthLabel.Position = UDim2.new(0.69,0,0,4)
	HealthLabel.BackgroundTransparency = 1
	HealthLabel.Text = Preset.Health
	HealthLabel.TextSize = 14
	HealthLabel.Font = Enum.Font.GothamBold
	HealthLabel.TextXAlignment = Enum.TextXAlignment.Right
	HealthLabel.Parent = Button

	local Desc = Instance.new("TextLabel")
	Desc.Size = UDim2.new(1,-26,0,15)
	Desc.Position = UDim2.new(0,13,0,32)
	Desc.BackgroundTransparency = 1
	Desc.Text = Preset.Name == "Inf Health" and "Infinite" or (Preset.Name == "Grabs" and "Grab tools" or "Health preset")
	Desc.TextColor3 = Color3.fromRGB(120,128,145)
	Desc.TextSize = 9
	Desc.Font = Enum.Font.Gotham
	Desc.TextXAlignment = Enum.TextXAlignment.Left
	Desc.Parent = Button

	table.insert(HealthButtons,{Stroke=Stroke,Health=HealthLabel})

	Button.Activated:Connect(function()
		RunPreset(Preset)
		TweenService:Create(Button,TweenInfo.new(0.08),{BackgroundTransparency=0.25}):Play()
		task.delay(0.08,function()
			if Button.Parent then
				TweenService:Create(Button,TweenInfo.new(0.12),{BackgroundTransparency=0}):Play()
			end
		end)
	end)
end

local Mini = Instance.new("TextButton")
Mini.Size = UDim2.new(0,72,0,55)
Mini.Position = UDim2.new(0.5,-36,0.5,-27)
Mini.BackgroundColor3 = Color3.fromRGB(5,18,35)
Mini.Text = ""
Mini.AutoButtonColor = false
Mini.Visible = false
Mini.ClipsDescendants = true
Mini.Parent = ScreenGui

local MiniCorner = Instance.new("UICorner")
MiniCorner.CornerRadius = UDim.new(0,15)
MiniCorner.Parent = Mini

local MiniStroke = Instance.new("UIStroke")
MiniStroke.Thickness = 2
MiniStroke.Parent = Mini

local BackMountain = Instance.new("TextLabel")
BackMountain.Size = UDim2.new(1,20,0,45)
BackMountain.Position = UDim2.new(0,-10,0,13)
BackMountain.BackgroundTransparency = 1
BackMountain.Text = "⛰"
BackMountain.TextSize = 53
BackMountain.TextColor3 = Color3.fromRGB(20,70,105)
BackMountain.Font = Enum.Font.GothamBold
BackMountain.Parent = Mini

local SnowMountain = Instance.new("TextLabel")
SnowMountain.Size = UDim2.new(1,20,0,43)
SnowMountain.Position = UDim2.new(0,-10,0,9)
SnowMountain.BackgroundTransparency = 1
SnowMountain.Text = "▲"
SnowMountain.TextSize = 38
SnowMountain.TextColor3 = Color3.fromRGB(225,245,255)
SnowMountain.Font = Enum.Font.GothamBold
SnowMountain.Parent = Mini

local SnowText = Instance.new("TextLabel")
SnowText.Size = UDim2.new(1,0,0,14)
SnowText.Position = UDim2.new(0,0,0,4)
SnowText.BackgroundTransparency = 1
SnowText.Text = "❄"
SnowText.TextSize = 10
SnowText.TextColor3 = Color3.fromRGB(220,245,255)
SnowText.Font = Enum.Font.GothamBold
SnowText.Parent = Mini

Minimize.Activated:Connect(function()
	Main.Visible = false
	Mini.Visible = true
end)

Mini.Activated:Connect(function()
	Mini.Visible = false
	Main.Visible = true
end)

local function MakeDraggable(Object, DragObject)
	local Dragging = false
	local DragStart
	local StartPosition
	local DragInput

	DragObject.InputBegan:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseButton1 then
			Dragging = true
			DragStart = Input.Position
			StartPosition = Object.Position
			Input.Changed:Connect(function()
				if Input.UserInputState == Enum.UserInputState.End then
					Dragging = false
				end
			end)
		end
	end)

	DragObject.InputChanged:Connect(function(Input)
		if Input.UserInputType == Enum.UserInputType.Touch or Input.UserInputType == Enum.UserInputType.MouseMovement then
			DragInput = Input
		end
	end)

	UserInputService.InputChanged:Connect(function(Input)
		if Input == DragInput and Dragging then
			local Delta = Input.Position - DragStart
			Object.Position = UDim2.new(StartPosition.X.Scale,StartPosition.X.Offset + Delta.X,StartPosition.Y.Scale,StartPosition.Y.Offset + Delta.Y)
		end
	end)
end

MakeDraggable(Main,TopBar)
MakeDraggable(Mini,Mini)

local function GetColor(Time)
	return Color3.fromHSV(Time % 1,0.78,1)
end

RunService.RenderStepped:Connect(function()
	local Time = tick() * 0.10
	MainStroke.Color = GetColor(Time)
	MinStroke.Color = GetColor(Time + 0.12)
	CloseStroke.Color = GetColor(Time + 0.24)
	Title.TextColor3 = GetColor(Time + 0.36)
	MiniStroke.Color = GetColor(Time + 0.48)

	for Index, Data in ipairs(HealthButtons) do
		Data.Stroke.Color = GetColor(Time + (Index * 0.07))
		Data.Health.TextColor3 = GetColor(Time + (Index * 0.07) + 0.15)
	end
end)

Close.Activated:Connect(function()
	ScreenGui:Destroy()
end)
