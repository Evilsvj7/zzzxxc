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
	{ name = "DB脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Lisz123456789/7891DBNB/main/DB服务器"))()]] },
	{ name = "Atomic脚本免费版", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/123fa98/Xi_Pro/refs/heads/main/Atomic-Script"))()]] },
	{ name = "寒脚本", cat = "普通脚本", code = [[getgenv().SCRIPT_KEY="ec1ecb11-0158-4854-b588-03f5c4c2ab7b";
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d6c1170046d31cebd08f3d38ad1e462e19c29de580b544c6dd7088c2f1de0160/download"))()]] },
	{ name = "情云脚本中心", cat = "脚本中心", code = [[loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()]] },
}

local function SafeAdd(tab, method, cfg)
	if not tab then return nil end
	if type(tab[method]) ~= "function" then
		warn("[G2R5x] WindUI 无此方法: " .. tostring(method))
		return nil
	end
	local ok, r = pcall(function() return tab[method](tab, cfg) end)
	if not ok then
		warn("[G2R5x] " .. tostring(method) .. " 创建失败: " .. tostring(r))
		return nil
	end
	return r
end

local PushRecent
local RefreshRecent

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
	if PushRecent then pcall(PushRecent, entry) end
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

local function SafeTab(cfg)
	local ok, tab = pcall(function() return Window:Tab(cfg) end)
	if ok and tab then return tab end
	warn("[G2R5x] Tab 创建失败(" .. tostring(cfg.Title) .. ")，尝试去掉图标: " .. tostring(tab))
	local ok2, tab2 = pcall(function() return Window:Tab({ Title = cfg.Title }) end)
	if ok2 and tab2 then return tab2 end
	warn("[G2R5x] Tab 彻底失败: " .. tostring(cfg.Title))
	return nil
end


--------------------------------------------------------------------------------
-- 普通脚本
--------------------------------------------------------------------------------
local TabNormal = SafeTab({ Title = "普通脚本", Icon = "scroll-text" })
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
local TabRecent = SafeTab({ Title = "最近", Icon = "history" })
local TabHub = SafeTab({ Title = "脚本中心", Icon = "layout-grid" })
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
local TabLocal = SafeTab({ Title = "本地玩家修改", Icon = "person-standing" })

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

SafeAdd(TabLocal, "Slider", {
	Title = "移动速度",
	Desc = "拖动调整",
	Value = { Min = 16, Max = 300, Default = 16 },
	Step = 1,
	Range = { 16, 300 },
	CurrentValue = 16,
	Callback = function(val)
		if type(val) == "number" then
			SpeedVal = val
			if ModOn then DoSpeed() end
		end
	end,
})

SafeAdd(TabLocal, "Dropdown", {
	Title = "速度修改方式",
	Desc = "改不动就换一种",
	Values = SPD_MODES,
	Value = SPD_MODES[1],
	Multi = false,
	AllowNone = false,
	Options = SPD_MODES,
	CurrentOption = SPD_MODES[1],
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		for i, v in ipairs(SPD_MODES) do
			if v == pick then SpeedMode = i end
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

SafeAdd(TabLocal, "Slider", {
	Title = "跳跃高度",
	Desc = "拖动调整",
	Value = { Min = 10, Max = 400, Default = 50 },
	Step = 1,
	Range = { 10, 400 },
	CurrentValue = 50,
	Callback = function(val)
		if type(val) == "number" then
			JumpVal = val
			if ModOn then DoJump() end
		end
	end,
})

SafeAdd(TabLocal, "Dropdown", {
	Title = "跳跃修改方式",
	Desc = "改不动就换一种",
	Values = JMP_MODES,
	Value = JMP_MODES[1],
	Multi = false,
	AllowNone = false,
	Options = JMP_MODES,
	CurrentOption = JMP_MODES[1],
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		for i, v in ipairs(JMP_MODES) do
			if v == pick then JumpMode = i end
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
local TabAbout = SafeTab({ Title = "关于", Icon = "info" })

SafeAdd(TabAbout, "Section", { Title = "关于作者" })
SafeAdd(TabAbout, "Paragraph", {
	Title = "作者永远不会跑路，但作者有可能会被累死",
	Desc = "有时脚本中心里的脚本无法执行，请放心，那可能只是卡顿或该脚本失效。通知作者，作者会修复。",
})
SafeAdd(TabAbout, "Button", {
	Title = "作者Q号: 2122119096",
	Desc = "点击自动复制",
	Icon = "copy",
	Callback = function()
		if CopyText("2122119096") then
			Notify("复制成功", "作者Q号已复制到剪贴板", 4)
		else
			Notify("复制失败", "请手动记录: 2122119096", 5)
		end
	end,
})
SafeAdd(TabAbout, "Button", {
	Title = "该脚本交流群: 1081093229",
	Desc = "点击自动复制",
	Icon = "users",
	Callback = function()
		if CopyText("1081093229") then
			Notify("复制成功", "交流群号已复制到剪贴板", 4)
		else
			Notify("复制失败", "请手动记录: 1081093229", 5)
		end
	end,
})

SafeAdd(TabAbout, "Section", { Title = "关于脚本" })
SafeAdd(TabAbout, "Paragraph", {
	Title = "更新说明",
	Desc = "因为作者更新比较慢，来不及逐一查看某些脚本是否失效，这里请原谅。",
})
SafeAdd(TabAbout, "Paragraph", {
	Title = "⚠️ 概不负责 ⚠️",
	Desc = "使用脚本本身已违反 Roblox 服务条款，如果被服务器封号，概不负责。",
})
SafeAdd(TabAbout, "Paragraph", {
	Title = "⚠️ 后果自负 ⚠️",
	Desc = "因违反 Roblox 条款而被封号、回收账号等一切后果，均由使用者自行承担，概不负责。",
})
SafeAdd(TabAbout, "Paragraph", {
	Title = "⚠️ 风险自担 ⚠️",
	Desc = "部分脚本可能含有检测或风险内容，执行前请自行判断，后果概不负责。",
})

SafeAdd(TabAbout, "Paragraph", {
	Title = "关于更新",
	Desc = "本脚本目前有点垃圾，所以脚本和脚本中心比较少，但是后续会更新。",
})

--------------------------------------------------------------------------------
-- 最近运行（最多 3 条）
--------------------------------------------------------------------------------
local RECENT = {}

RefreshRecent = function()
	local tab = TabRecent
	if not tab then return end
	local cf = tab.UIElements and tab.UIElements.ContainerFrame
	if not cf then return end
	for _, c in ipairs(cf:GetChildren()) do
		if c.Name == "G2R5xRecentItem" then
			pcall(function() c:Destroy() end)
		end
	end
	if #RECENT == 0 then
		local lb = Instance.new("TextLabel", cf)
		lb.Name = "G2R5xRecentItem"
		lb.Size = UDim2.new(1, 0, 0, 34)
		lb.BackgroundTransparency = 1
		lb.Text = "暂无记录，运行脚本后自动出现"
		lb.TextColor3 = Color3.fromRGB(150, 150, 170)
		lb.Font = Enum.Font.Gotham
		lb.TextSize = 14
		lb.LayoutOrder = -900
		return
	end
	for idx, e in ipairs(RECENT) do
		local row = Instance.new("Frame", cf)
		row.Name = "G2R5xRecentItem"
		row.Size = UDim2.new(1, 0, 0, 38)
		row.BackgroundTransparency = 1
		row.LayoutOrder = -900 + idx

		local b = Instance.new("TextButton", row)
		b.Size = UDim2.new(1, 0, 1, 0)
		b.BackgroundColor3 = Color3.fromRGB(30, 30, 44)
		b.BorderSizePixel = 0
		b.Font = Enum.Font.Gotham
		b.TextSize = 15
		b.TextColor3 = Color3.fromRGB(235, 235, 245)
		b.Text = "▶ " .. e.name .. "  [" .. e.cat .. "]"
		b.AutoButtonColor = false
		Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
		b.MouseButton1Click:Connect(function()
			RunScript(e)
		end)
	end
end

PushRecent = function(entry)
	if not entry then return end
	for i = #RECENT, 1, -1 do
		if RECENT[i].name == entry.name then table.remove(RECENT, i) end
	end
	table.insert(RECENT, 1, entry)
	while #RECENT > 3 do table.remove(RECENT, #RECENT) end
	pcall(RefreshRecent)
end

--------------------------------------------------------------------------------
-- 搜索（内嵌在普通脚本页顶部 / 只列候选，不自动执行）
--------------------------------------------------------------------------------
local function ScoreMatch(name, q)
	local n = string.lower(tostring(name))
	local k = string.lower(tostring(q))
	if k == "" then return nil end
	if n == k then return 0 end
	if string.sub(n, 1, #k) == k then return 1 end
	local pos = string.find(n, k, 1, true)
	if pos then return 2 + pos / 1000 end
	return nil
end

local function BuildInlineSearch(tab)
	if not tab then return false end
	local cf = tab.UIElements and tab.UIElements.ContainerFrame
	if not cf then
		warn("[G2R5x] 拿不到页容器，搜索框未内嵌")
		return false
	end
	for _, c in ipairs(cf:GetChildren()) do
		if c.Name == "G2R5xSearchWrap" then
			pcall(function() c:Destroy() end)
		end
	end

	local wrap = Instance.new("Frame", cf)
	wrap.Name = "G2R5xSearchWrap"
	wrap.LayoutOrder = -9999
	wrap.Size = UDim2.new(1, 0, 0, 40)
	wrap.BackgroundTransparency = 1
	wrap.BorderSizePixel = 0

	local box = Instance.new("TextBox", wrap)
	box.Name = "Box"
	box.Size = UDim2.new(1, -84, 0, 32)
	box.Position = UDim2.new(0, 0, 0, 4)
	box.PlaceholderText = "搜索脚本"
	box.PlaceholderColor3 = Color3.fromRGB(140, 140, 165)
	box.Text = ""
	box.Font = Enum.Font.Gotham
	box.TextSize = 15
	box.TextColor3 = Color3.fromRGB(240, 240, 250)
	box.BackgroundColor3 = Color3.fromRGB(28, 28, 42)
	box.BorderSizePixel = 0
	box.ClearTextOnFocus = false
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 9)

	local sbtn = Instance.new("TextButton", wrap)
	sbtn.Name = "Btn"
	sbtn.Size = UDim2.new(0, 76, 0, 32)
	sbtn.Position = UDim2.new(1, -76, 0, 4)
	sbtn.BackgroundColor3 = Color3.fromRGB(48, 48, 70)
	sbtn.BorderSizePixel = 0
	sbtn.Font = Enum.Font.GothamBold
	sbtn.TextSize = 14
	sbtn.TextColor3 = Color3.fromRGB(235, 235, 250)
	sbtn.Text = "搜索"
	sbtn.AutoButtonColor = false
	Instance.new("UICorner", sbtn).CornerRadius = UDim.new(0, 9)

	local res = Instance.new("Frame", cf)
	res.Name = "G2R5xSearchWrap"
	res.LayoutOrder = -9998
	res.Size = UDim2.new(1, 0, 0, 0)
	res.BackgroundTransparency = 1
	res.BorderSizePixel = 0

	local lay = Instance.new("UIListLayout", res)
	lay.Padding = UDim.new(0, 5)
	lay.SortOrder = Enum.SortOrder.LayoutOrder

	local function ClearRes()
		for _, c in ipairs(res:GetChildren()) do
			if c:IsA("TextButton") then pcall(function() c:Destroy() end) end
		end
		res.Size = UDim2.new(1, 0, 0, 0)
	end

	local function DoSearch()
		ClearRes()
		local q = tostring(box.Text or "")
		if q == "" then return end
		local hits = {}
		for _, e in ipairs(SCRIPT_LIB) do
			local sc = ScoreMatch(e.name, q)
			if sc then hits[#hits + 1] = { e = e, sc = sc } end
		end
		table.sort(hits, function(a, b) return a.sc < b.sc end)
		for i, h in ipairs(hits) do
			local b = Instance.new("TextButton", res)
			b.Size = UDim2.new(1, 0, 0, 34)
			b.BackgroundColor3 = Color3.fromRGB(34, 34, 50)
			b.BorderSizePixel = 0
			b.Font = Enum.Font.Gotham
			b.TextSize = 15
			b.TextColor3 = Color3.fromRGB(235, 235, 245)
			b.Text = "▶ " .. h.e.name .. "  [" .. h.e.cat .. "]"
			b.LayoutOrder = i
			b.AutoButtonColor = false
			Instance.new("UICorner", b).CornerRadius = UDim.new(0, 9)
			b.MouseButton1Click:Connect(function()
				RunScript(h.e)
			end)
		end
		res.Size = UDim2.new(1, 0, 0, #hits * 39)
	end

	sbtn.MouseButton1Click:Connect(DoSearch)
	box.FocusLost:Connect(function(enter)
		if enter then DoSearch() end
	end)
	return true
end

task.spawn(function()
	task.wait(0.5)
	pcall(BuildInlineSearch, TabNormal)
	pcall(RefreshRecent)
end)

pcall(function()
	getgenv().G2R5X = {
		Lib = SCRIPT_LIB,
		Recent = RECENT,
		Run = RunScript,
		PushRecent = PushRecent,
		RefreshRecent = RefreshRecent,
		BuildSearch = BuildInlineSearch,
		Search = function(q)
			local hits = {}
			for _, e in ipairs(SCRIPT_LIB) do
				local sc = ScoreMatch(e.name, q)
				if sc then hits[#hits + 1] = { e = e, sc = sc } end
			end
			table.sort(hits, function(a, b) return a.sc < b.sc end)
			local out = {}
			for _, h in ipairs(hits) do out[#out + 1] = h.e.name end
			return out
		end,
	}
end)

Notify("G2R5x 脚本中心", "加载完成  作者Q: 2122119096", 5)
