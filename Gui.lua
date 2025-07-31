-- Final MM2 GUI Script by JAXIN 💀
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")

-- Clean previous GUI
pcall(function() CoreGui:FindFirstChild("MM2_GUI_FINAL"):Destroy() end)

-- MAIN GUI SETUP
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "MM2_GUI_FINAL"
ScreenGui.ResetOnSpawn = false

-- MAIN FRAME
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 450, 0, 350)
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Visible = true
MainFrame.Active = true
MainFrame.Draggable = true

-- TOP BAR
local TopBar = Instance.new("TextLabel", MainFrame)
TopBar.Size = UDim2.new(1, 0, 0, 30)
TopBar.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TopBar.Text = "MM2 GUI FINAL v1.0"
TopBar.TextColor3 = Color3.fromRGB(255, 255, 255)
TopBar.TextSize = 14

-- CLOSE BUTTON
local CloseButton = Instance.new("TextButton", MainFrame)
CloseButton.Size = UDim2.new(0, 30, 0, 30)
CloseButton.Position = UDim2.new(1, -30, 0, 0)
CloseButton.Text = "X"
CloseButton.BackgroundColor3 = Color3.fromRGB(100, 0, 0)
CloseButton.TextColor3 = Color3.new(1,1,1)

-- FLOATING RETURN BUTTON
local ReturnButton = Instance.new("TextButton", ScreenGui)
ReturnButton.Size = UDim2.new(0, 100, 0, 40)
ReturnButton.Position = UDim2.new(1, -120, 1, -60)
ReturnButton.Text = "Open MM2 GUI"
ReturnButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ReturnButton.TextColor3 = Color3.new(1,1,1)
ReturnButton.Visible = false

CloseButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	ReturnButton.Visible = true
end)

ReturnButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = true
	ReturnButton.Visible = false
end)

-- SIDE TABS
local Tabs = {"Main", "Murder", "Sheriff", "Player"}
local Buttons = {}
local ContentFrames = {}

local TabList = Instance.new("Frame", MainFrame)
TabList.Size = UDim2.new(0, 100, 1, -30)
TabList.Position = UDim2.new(0, 0, 0, 30)
TabList.BackgroundColor3 = Color3.fromRGB(20, 20, 20)

local ContentArea = Instance.new("Frame", MainFrame)
ContentArea.Size = UDim2.new(1, -100, 1, -30)
ContentArea.Position = UDim2.new(0, 100, 0, 30)
ContentArea.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

for i, name in ipairs(Tabs) do
	local btn = Instance.new("TextButton", TabList)
	btn.Size = UDim2.new(1, 0, 0, 40)
	btn.Position = UDim2.new(0, 0, 0, (i-1)*40)
	btn.Text = name
	btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	btn.TextColor3 = Color3.new(1,1,1)

	local frame = Instance.new("Frame", ContentArea)
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.Visible = i == 1
	frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

	Buttons[name] = btn
	ContentFrames[name] = frame

	btn.MouseButton1Click:Connect(function()
		for _, f in pairs(ContentFrames) do f.Visible = false end
		for _, b in pairs(Buttons) do b.BackgroundColor3 = Color3.fromRGB(50, 50, 50) end
		frame.Visible = true
		btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	end)
end

--- === FEATURES ===
-- MAIN TAB FEATURES
local main = ContentFrames["Main"]

function makeButton(text, pos, callback)
	local b = Instance.new("TextButton", main)
	b.Size = UDim2.new(0, 200, 0, 30)
	b.Position = UDim2.new(0, 20, 0, pos)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
	b.TextColor3 = Color3.new(1,1,1)
	b.MouseButton1Click:Connect(callback)
	return b
end

-- ESP
makeButton("ESP Box (Client Only)", 10, function()
	for _, plr in pairs(Players:GetPlayers()) do
		if plr ~= LocalPlayer and plr.Character then
			local box = Instance.new("BoxHandleAdornment", plr.Character:FindFirstChild("HumanoidRootPart") or plr.Character:FindFirstChild("Torso") or plr.Character)
			box.Adornee = plr.Character
			box.AlwaysOnTop = true
			box.ZIndex = 5
			box.Size = Vector3.new(4,6,1)
			box.Color3 = Color3.fromRGB(255, 0, 0)
			box.Transparency = 0.6
		end
	end
end)

-- NoClip Toggle
local noClipActive = false
makeButton("Toggle NoClip", 50, function()
	noClipActive = not noClipActive
end)

RunService.Stepped:Connect(function()
	if noClipActive and LocalPlayer.Character then
		for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
			if part:IsA("BasePart") and part.CanCollide then
				part.CanCollide = false
			end
		end
	end
end)

-- Speed Boost 3x
makeButton("Speed Boost x3", 90, function()
	local h = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("Humanoid")
	if h then h.WalkSpeed = 48 end
end)

-- Invisible
makeButton("Become Invisible", 130, function()
	local chr = LocalPlayer.Character
	if chr then
		for _, part in pairs(chr:GetDescendants()) do
			if part:IsA("BasePart") then
				part.Transparency = 1
			end
		end
	end
end)

-- Add more features to other tabs here if needed.

print("[MM2 GUI] Loaded successfully.")
