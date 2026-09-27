--[[
	G2R5x 脚本中心
	作者 Q: 2122119096   交流群: 1081093229
]]

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local HUB_NAME = "G2R5x"
local HUB_CN = "脚本中心"

--------------------------------------------------------------------------------
-- 开场动画
--------------------------------------------------------------------------------
local function PlayIntro()
	local pg = LP:WaitForChild("PlayerGui")
	local gui = Instance.new("ScreenGui")
	gui.Name = "G2R5xIntro"
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.DisplayOrder = 9999

	local bg = Instance.new("Frame", gui)
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
	bg.BackgroundTransparency = 0
	bg.BorderSizePixel = 0

	local holder = Instance.new("Frame", bg)
	holder.Size = UDim2.new(0, 560, 0, 140)
	holder.Position = UDim2.new(0.5, 0, 0.5, 0)
	holder.AnchorPoint = Vector2.new(0.5, 0.5)
	holder.BackgroundTransparency = 1

	local en = Instance.new("TextLabel", holder)
	en.Name = "EN"
	en.Size = UDim2.new(0, 260, 0, 110)
	en.Position = UDim2.new(0, 0, 0, 15)
	en.BackgroundTransparency = 1
	en.Text = HUB_NAME
	en.Font = Enum.Font.GothamBlack
	en.TextSize = 82
	en.TextColor3 = Color3.fromRGB(255, 255, 255)
	en.TextTransparency = 1
	en.TextXAlignment = Enum.TextXAlignment.Right

	local bar = Instance.new("Frame", holder)
	bar.Size = UDim2.new(0, 3, 0, 90)
	bar.Position = UDim2.new(0, 272, 0, 25)
	bar.BackgroundColor3 = Color3.fromRGB(255, 90, 90)
	bar.BackgroundTransparency = 1
	bar.BorderSizePixel = 0

	local cn = Instance.new("TextLabel", holder)
	cn.Name = "CN"
	cn.Size = UDim2.new(0, 280, 0, 110)
	cn.Position = UDim2.new(0, 288, 0, 15)
	cn.BackgroundTransparency = 1
	cn.Text = HUB_CN
	cn.Font = Enum.Font.GothamBold
	cn.TextSize = 62
	cn.TextColor3 = Color3.fromRGB(255, 130, 130)
	cn.TextTransparency = 1
	cn.TextXAlignment = Enum.TextXAlignment.Left

	local sub = Instance.new("TextLabel", bg)
	sub.Size = UDim2.new(0, 400, 0, 30)
	sub.Position = UDim2.new(0.5, 0, 0.62, 0)
	sub.AnchorPoint = Vector2.new(0.5, 0)
	sub.BackgroundTransparency = 1
	sub.Text = "正在加载..."
	sub.Font = Enum.Font.Gotham
	sub.TextSize = 17
	sub.TextColor3 = Color3.fromRGB(150, 150, 165)
	sub.TextTransparency = 1

	gui.Parent = pg

	local ti = TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	TS:Create(en, ti, { TextTransparency = 0 }):Play()
	task.wait(0.55)
	TS:Create(bar, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
	TS:Create(cn, ti, { TextTransparency = 0 }):Play()
	task.wait(0.75)
	TS:Create(sub, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()
	task.wait(1.05)
	TS:Create(bg, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()
	TS:Create(en, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
	TS:Create(cn, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
	TS:Create(bar, TweenInfo.new(0.45), { BackgroundTransparency = 1 }):Play()
	TS:Create(sub, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
	task.wait(0.6)
	pcall(function() gui:Destroy() end)
end

task.spawn(function()
	pcall(PlayIntro)
end)

--------------------------------------------------------------------------------
-- 通用工具
--------------------------------------------------------------------------------
local function CopyText(txt)
	local ok = false
	if typeof(setclipboard) == "function" then
		ok = pcall(setclipboard, txt) or ok
	end
	if (not ok) and typeof(toclipboard) == "function" then
		ok = pcall(toclipboard, txt) or ok
	end
	if (not ok) and type(Clipboard) == "table" and typeof(Clipboard.set) == "function" then
		ok = pcall(Clipboard.set, txt) or ok
	end
	if not ok then
		pcall(function()
			local pg = LP:FindFirstChild("PlayerGui")
			if not pg then return end
			local g = Instance.new("ScreenGui")
			g.ResetOnSpawn = false
			g.Parent = pg
			local b = Instance.new("TextBox", g)
			b.Size = UDim2.new(0, 10, 0, 10)
			b.Position = UDim2.new(0, -100, 0, -100)
			b.Text = txt
			b.ClearTextOnFocus = false
			b:CaptureFocus()
			task.wait(0.05)
			g:Destroy()
			ok = true
		end)
	end
	return ok
end

local function Notify(t1, t2, dur)
	pcall(function()
		game:GetService("StarterGui"):SetCore("SendNotification", {
			Title = t1 or "G2R5x",
			Text = t2 or "",
			Duration = dur or 4,
		})
	end)
end

--------------------------------------------------------------------------------
-- 脚本库
--------------------------------------------------------------------------------
local SCRIPT_LIB = {
	{ name = "夜脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/ylt410/roblox-Script/refs/heads/main/yejiaoben"))()]] },
	{ name = "皮脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/xiaopi77/xiaopi77/main/QQ1002100032-Roblox-Pi-script.lua"))()]] },
	{ name = "恐脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/kongbaNB/9178/refs/heads/main/恐脚本.NB"))()]] },
	{ name = "黑脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("\x68\x74\x74\x70\x73\x3a\x2f\x2f\x72\x61\x77\x2e\x67\x69\x74\x68\x75\x62\x75\x73\x65\x72\x63\x6f\x6e\x74\x65\x6e\x74\x2e\x63\x6f\x6d\x2f\x68\x67\x76\x75\x79\x67\x75\x79\x67\x2f\x48\x45\x49\x4a\x49\x41\x4f\x42\x45\x4e\x2f\x6d\x61\x69\x6e\x2f\x61\x61\x61"))()]] },
	{ name = "XA脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://pastebin.com/raw/h8nC0fLb", true))()]] },
	{ name = "ROBV4脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/idrobsc/rob_script/refs/heads/main/rob.v4"))()]] },
	{ name = "情云脚本中心", cat = "脚本中心", code = [[loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()]] },
}

local function RunScript(entry)
	Notify("G2R5x", "正在执行: " .. entry.name, 3)
	local f, err = loadstring(entry.code)
	if not f then
		Notify("执行失败", "语法错误: " .. tostring(err):sub(1, 60), 5)
		warn("[G2R5x] " .. entry.name .. " 语法错误: " .. tostring(err))
		return false
	end
	local ok, rerr = pcall(f)
	if not ok then
		Notify("执行失败", tostring(rerr):sub(1, 60), 5)
		warn("[G2R5x] " .. entry.name .. " 运行错误: " .. tostring(rerr))
		return false
	end
	Notify("执行成功", entry.name .. " 已运行", 4)
	return true
end

--------------------------------------------------------------------------------
-- 加载 UI 库
--------------------------------------------------------------------------------
local WindUI = nil
local uiOk, uiErr = pcall(function()
	WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)
if not uiOk or not WindUI then
	Notify("G2R5x", "UI 库加载失败，功能不可用", 6)
	warn("[G2R5x] WindUI 加载失败: " .. tostring(uiErr))
	return
end

local Window = WindUI:CreateWindow({
	Title = HUB_NAME .. " " .. HUB_CN,
	Icon = "blocks",
	Theme = "Dark",
})

--------------------------------------------------------------------------------
-- 普通脚本
--------------------------------------------------------------------------------
local TabNormal = Window:Tab({ Title = "普通脚本", Icon = "scroll-text" })
for _, e in ipairs(SCRIPT_LIB) do
	if e.cat == "普通脚本" then
		TabNormal:Button({
			Title = e.name,
			Desc = "点击执行",
			Callback = function()
				RunScript(e)
			end,
		})
	end
end

--------------------------------------------------------------------------------
-- 脚本中心
--------------------------------------------------------------------------------
local TabHub = Window:Tab({ Title = "脚本中心", Icon = "layout-grid" })
for _, e in ipairs(SCRIPT_LIB) do
	if e.cat == "脚本中心" then
		TabHub:Button({
			Title = e.name,
			Desc = "点击执行",
			Callback = function()
				RunScript(e)
			end,
		})
	end
end

--------------------------------------------------------------------------------
-- 本地玩家修改
--------------------------------------------------------------------------------
local TabLocal = Window:Tab({ Title = "本地玩家修改", Icon = "person-standing" })

local SPD_MODES = { "方式一 WalkSpeed", "方式二 力度推进", "方式三 坐标位移" }
local JMP_MODES = { "方式一 JumpPower", "方式二 JumpHeight", "方式三 起跳推力" }

local SpeedMode = 1
local JumpMode = 1
local SpeedAuto = true
local JumpAuto = true
local SpeedVal = 16
local JumpVal = 50
local ModOn = false

local function GetChar()
	return LP.Character or LP.CharacterAdded:Wait()
end
local function GetHum()
	local c = LP.Character
	if not c then return nil end
	return c:FindFirstChildOfClass("Humanoid")
end
local function GetRoot()
	local c = LP.Character
	if not c then return nil end
	return c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
end

local VelObj = nil
local function EnsureVel(root)
	if VelObj and VelObj.Parent == root then return VelObj end
	pcall(function() if VelObj then VelObj:Destroy() end end)
	VelObj = nil
	pcall(function()
		local v = Instance.new("BodyVelocity")
		v.Name = "G2R5xVel"
		v.MaxForce = Vector3.new(0, 0, 0)
		v.Velocity = Vector3.new(0, 0, 0)
		v.P = 1250
		v.Parent = root
		VelObj = v
	end)
	return VelObj
end

local applySpeed = {}
applySpeed[1] = function(hum, v)
	hum.WalkSpeed = v
end
applySpeed[2] = function(hum, v)
	hum.WalkSpeed = v
	local root = GetRoot()
	if not root then return end
	EnsureVel(root)
	task.spawn(function()
		while ModOn and SpeedMode == 2 do
			pcall(function()
				local h = GetHum()
				local r = GetRoot()
				if not (h and r) then return end
				if VelObj and VelObj.Parent == r then
					local mv = h.MoveDirection
					VelObj.Velocity = mv * v
					VelObj.MaxForce = Vector3.new(9000, 0, 9000)
				end
			end)
			RS.Heartbeat:Wait()
		end
		pcall(function()
			if VelObj then VelObj.MaxForce = Vector3.new(0, 0, 0) VelObj.Velocity = Vector3.new(0, 0, 0) end
		end)
	end)
end
applySpeed[3] = function(hum, v)
	pcall(function() hum.WalkSpeed = 16 end)
	task.spawn(function()
		while ModOn and SpeedMode == 3 do
			pcall(function()
				local h = GetHum()
				local r = GetRoot()
				if not (h and r) then return end
				local mv = h.MoveDirection
				if mv.Magnitude > 0.01 then
					r.CFrame = r.CFrame + (mv.Unit * (v / 60))
				end
			end)
			RS.Heartbeat:Wait()
		end
	end)
end

local applyJump = {}
applyJump[1] = function(hum, v)
	pcall(function() hum.JumpPower = v end)
	pcall(function() hum.UseJumpPower = true end)
end
applyJump[2] = function(hum, v)
	pcall(function() hum.UseJumpPower = false end)
	pcall(function() hum.JumpHeight = v / 7.5 end)
end
applyJump[3] = function(hum, v)
	pcall(function() hum.JumpPower = 50 end)
	task.spawn(function()
		while ModOn and JumpMode == 3 do
			local conn
			conn = UIS.JumpRequest:Connect(function()
				pcall(function()
					local h = GetHum()
					local r = GetRoot()
					if h and r and h:GetState() ~= Enum.HumanoidStateType.Jumping then
						r.AssemblyLinearVelocity = Vector3.new(r.AssemblyLinearVelocity.X, v, r.AssemblyLinearVelocity.Z)
					end
				end)
			end)
			while ModOn and JumpMode == 3 do RS.Heartbeat:Wait() end
			pcall(function() if conn then conn:Disconnect() end end)
		end
	end)
end

local function DoSpeed()
	pcall(function()
		local h = GetHum()
		if h then applySpeed[SpeedMode](h, SpeedVal) end
	end)
end
local function DoJump()
	pcall(function()
		local h = GetHum()
		if h then applyJump[JumpMode](h, JumpVal) end
	end)
end

local function AutoWatch()
	task.spawn(function()
		while ModOn do
			pcall(function()
				local h = GetHum()
				if not h then return end
				if SpeedAuto then
					local ok = pcall(function() return h.WalkSpeed end)
					if ok and SpeedMode == 1 then
						if math.abs(h.WalkSpeed - SpeedVal) > 1 then
							SpeedMode = 2
							Notify("速度", "方式一被覆盖，切到方式二", 3)
							DoSpeed()
						elseif SpeedMode == 2 then
							local r = GetRoot()
							if r then
								local sp = Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z).Magnitude
								if h.MoveDirection.Magnitude > 0.01 and sp < SpeedVal * 0.5 then
									SpeedMode = 3
									Notify("速度", "方式二无效，切到方式三", 3)
									DoSpeed()
								end
							end
						end
					end
				end
				if JumpAuto then
					if JumpMode == 1 then
						local ok = pcall(function() return h.JumpPower end)
						if ok and math.abs(h.JumpPower - JumpVal) > 1 then
							JumpMode = 2
							Notify("跳跃", "方式一被覆盖，切到方式二", 3)
							DoJump()
						end
					elseif JumpMode == 2 then
						local ok2 = pcall(function() return h.JumpHeight end)
						if (not ok2) or (h.JumpHeight == nil) or h.JumpHeight <= 0 then
							JumpMode = 3
							Notify("跳跃", "方式二不支持，切到方式三", 3)
							DoJump()
						end
					end
				end
			end)
			task.wait(1.2)
		end
	end)
end

TabLocal:Toggle({
	Title = "启用本地修改",
	Value = false,
	Callback = function(state)
		ModOn = state
		if state then
			DoSpeed()
			DoJump()
			AutoWatch()
			Notify("本地修改", "已开启", 3)
		else
			pcall(function()
				local h = GetHum()
				if h then h.WalkSpeed = 16 h.JumpPower = 50 end
				if VelObj then VelObj:Destroy() VelObj = nil end
			end)
			Notify("本地修改", "已关闭", 3)
		end
	end,
})

TabLocal:Slider({
	Title = "移动速度",
	Range = { 16, 300 },
	CurrentValue = 16,
	Callback = function(val)
		SpeedVal = val
		if ModOn then DoSpeed() end
	end,
})

TabLocal:Dropdown({
	Title = "速度修改方式",
	Options = SPD_MODES,
	CurrentOption = SPD_MODES[1],
	Callback = function(op)
		for i, v in ipairs(SPD_MODES) do
			if v == op then SpeedMode = i end
		end
		if ModOn then DoSpeed() end
	end,
})

TabLocal:Toggle({
	Title = "速度方式自动切换",
	Value = true,
	Callback = function(state)
		SpeedAuto = state
	end,
})

TabLocal:Slider({
	Title = "跳跃高度",
	Range = { 10, 400 },
	CurrentValue = 50,
	Callback = function(val)
		JumpVal = val
		if ModOn then DoJump() end
	end,
})

TabLocal:Dropdown({
	Title = "跳跃修改方式",
	Options = JMP_MODES,
	CurrentOption = JMP_MODES[1],
	Callback = function(op)
		for i, v in ipairs(JMP_MODES) do
			if v == op then JumpMode = i end
		end
		if ModOn then DoJump() end
	end,
})

TabLocal:Toggle({
	Title = "跳跃方式自动切换",
	Value = true,
	Callback = function(state)
		JumpAuto = state
	end,
})

--------------------------------------------------------------------------------
-- 关于
--------------------------------------------------------------------------------
local TabAbout = Window:Tab({ Title = "关于", Icon = "info" })

TabAbout:Label({
	Title = "关于作者",
})
TabAbout:Button({
	Title = "作者永远不会跑路，但作者有可能会被累死",
	Desc = "点击左侧标题无效，此处仅为说明",
	Callback = function() end,
})
TabAbout:Label({
	Title = "有时脚本中心里的脚本无法执行，请放心，那可能只是卡顿或该脚本失效。通知作者，作者会修复。",
})
TabAbout:Button({
	Title = "作者Q号: 2122119096",
	Desc = "点击自动复制",
	Callback = function()
		if CopyText("2122119096") then
			Notify("复制成功", "作者Q号已复制到剪贴板", 4)
		else
			Notify("复制失败", "请手动记录: 2122119096", 5)
		end
	end,
})
TabAbout:Button({
	Title = "该脚本交流群: 1081093229",
	Desc = "点击自动复制",
	Callback = function()
		if CopyText("1081093229") then
			Notify("复制成功", "交流群号已复制到剪贴板", 4)
		else
			Notify("复制失败", "请手动记录: 1081093229", 5)
		end
	end,
})

TabAbout:Label({
	Title = "关于脚本",
})
TabAbout:Label({
	Title = "因为作者更新比较慢，来不及逐一查看某些脚本是否失效，这里请原谅。",
})
TabAbout:Label({
	Title = "⚠ 重点提醒",
})
TabAbout:Button({
	Title = "使用脚本本身已违反 Roblox 服务条款，如果被服务器封号，概不负责。",
	Desc = "红色 = 严重提醒，请自行权衡风险",
	Callback = function() end,
})
TabAbout:Label({
	Title = "⚠ 因违反 Roblox 条款而被封号、回收账号等一切后果，均由使用者自行承担，概不负责。",
})
TabAbout:Label({
	Title = "⚠ 部分脚本可能含有检测或风险内容，执行前请自行判断，后果概不负责。",
})

--------------------------------------------------------------------------------
-- 搜索（原生面板，硬匹配脚本名）
--------------------------------------------------------------------------------
task.spawn(function()
	local pg = LP:WaitForChild("PlayerGui", 10)
	if not pg then return end
	local sg = Instance.new("ScreenGui")
	sg.Name = "G2R5xSearch"
	sg.ResetOnSpawn = false
	sg.IgnoreGuiInset = true
	sg.DisplayOrder = 9000

	local openBtn = Instance.new("TextButton", sg)
	openBtn.Size = UDim2.new(0, 42, 0, 42)
	openBtn.Position = UDim2.new(0, 12, 0, 118)
	openBtn.BackgroundColor3 = Color3.fromRGB(24, 24, 32)
	openBtn.Text = "🔍"
	openBtn.TextSize = 20
	openBtn.TextColor3 = Color3.fromRGB(230, 230, 240)
	openBtn.BorderSizePixel = 0
	Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 10)

	local panel = Instance.new("Frame", sg)
	panel.Size = UDim2.new(0, 300, 0, 46)
	panel.Position = UDim2.new(0, 12, 0, 168)
	panel.BackgroundColor3 = Color3.fromRGB(18, 18, 26)
	panel.BorderSizePixel = 0
	panel.Visible = false
	Instance.new("UICorner", panel).CornerRadius = UDim.new(0, 10)

	local box = Instance.new("TextBox", panel)
	box.Size = UDim2.new(1, -16, 0, 30)
	box.Position = UDim2.new(0, 8, 0, 8)
	box.PlaceholderText = "搜索脚本名称（硬匹配）"
	box.Text = ""
	box.Font = Enum.Font.Gotham
	box.TextSize = 15
	box.TextColor3 = Color3.fromRGB(240, 240, 250)
	box.BackgroundColor3 = Color3.fromRGB(30, 30, 42)
	box.BorderSizePixel = 0
	box.ClearTextOnFocus = false
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

	local list = Instance.new("ScrollingFrame", panel)
	list.Size = UDim2.new(1, 0, 0, 200)
	list.Position = UDim2.new(0, 0, 0, 46)
	list.BackgroundTransparency = 1
	list.BorderSizePixel = 0
	list.ScrollBarThickness = 4
	list.CanvasSize = UDim2.new(0, 0, 0, 0)
	list.Visible = false

	local lay = Instance.new("UIListLayout", list)
	lay.Padding = UDim.new(0, 4)
	lay.SortOrder = Enum.SortOrder.LayoutOrder

	sg.Parent = pg

	local function ClearList()
		for _, c in ipairs(list:GetChildren()) do
			if c:IsA("TextButton") then c:Destroy() end
		end
	end

	local function Refresh()
		ClearList()
		local q = tostring(box.Text or "")
		if q == "" then
			list.Visible = false
			panel.Size = UDim2.new(0, 300, 0, 46)
			return
		end
		local ql = string.lower(q)
		local n = 0
		for _, e in ipairs(SCRIPT_LIB) do
			if string.find(string.lower(e.name), ql, 1, true) then
				n = n + 1
				local b = Instance.new("TextButton", list)
				b.Size = UDim2.new(1, -8, 0, 34)
				b.BackgroundColor3 = Color3.fromRGB(34, 34, 48)
				b.BorderSizePixel = 0
				b.Font = Enum.Font.Gotham
				b.TextSize = 15
				b.TextColor3 = Color3.fromRGB(235, 235, 245)
				b.Text = "▶ " .. e.name .. "  [" .. e.cat .. "]"
				b.LayoutOrder = n
				Instance.new("UICorner", b).CornerRadius = UDim.new(0, 8)
				b.MouseButton1Click:Connect(function()
					RunScript(e)
				end)
			end
		end
		if n > 0 then
			list.Visible = true
			list.CanvasSize = UDim2.new(0, 0, 0, n * 38)
			panel.Size = UDim2.new(0, 300, 0, math.min(46 + n * 38, 246))
		else
			list.Visible = false
			panel.Size = UDim2.new(0, 300, 0, 46)
		end
	end

	box:GetPropertyChangedSignal("Text"):Connect(Refresh)
	openBtn.MouseButton1Click:Connect(function()
		panel.Visible = not panel.Visible
		if panel.Visible then box:CaptureFocus() end
	end)
	Refresh()
end)

Notify("G2R5x 脚本中心", "加载完成  作者Q: 2122119096", 5)
