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
local function UCharCount(str)
	if type(utf8) == "table" and type(utf8.len) == "function" then
		local n = nil
		pcall(function() n = utf8.len(str) end)
		if n then return n end
	end
	return #str
end

local function USub(str, i)
	if type(utf8) == "table" and type(utf8.offset) == "function" then
		local ok, e = pcall(function() return utf8.offset(str, i + 1) end)
		if ok and e then return string.sub(str, 1, e - 1) end
		local ok2, st = pcall(function() return utf8.offset(str, i) end)
		if ok2 and st then
			local code = nil
			pcall(function() code = utf8.codepoint(str, st) end)
			if code then return string.sub(str, 1, st - 1) .. utf8.char(code) end
		end
	end
	return string.sub(str, 1, i)
end

local function MkIntroGui()
	local pg = LP:WaitForChild("PlayerGui")
	local gui = Instance.new("ScreenGui")
	gui.Name = "G2R5xIntro"
	gui.IgnoreGuiInset = true
	gui.ResetOnSpawn = false
	gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	gui.DisplayOrder = 9999

	local bg = Instance.new("Frame", gui)
	bg.Name = "BG"
	bg.Size = UDim2.new(1, 0, 1, 0)
	bg.BackgroundColor3 = Color3.fromRGB(8, 8, 12)
	bg.BackgroundTransparency = 0
	bg.BorderSizePixel = 0

	local holder = Instance.new("Frame", bg)
	holder.Name = "Holder"
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
	bar.Name = "Bar"
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
	sub.Name = "Sub"
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
	return gui, bg, en, bar, cn, sub
end

local function IntroFadeOut(gui, bg, en, bar, cn, sub)
	TS:Create(bg, TweenInfo.new(0.55, Enum.EasingStyle.Quad, Enum.EasingDirection.In), { BackgroundTransparency = 1 }):Play()
	TS:Create(en, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
	TS:Create(cn, TweenInfo.new(0.45), { TextTransparency = 1 }):Play()
	TS:Create(bar, TweenInfo.new(0.45), { BackgroundTransparency = 1 }):Play()
	TS:Create(sub, TweenInfo.new(0.4), { TextTransparency = 1 }):Play()
	task.wait(0.6)
	pcall(function() gui:Destroy() end)
end

local INTRO_STYLE = 1
local INTRO_NAMES = { "风格一 淡入展开", "风格二 缩放弹入", "风格三 打字机" }

local introFn = {}

introFn[1] = function()
	local gui, bg, en, bar, cn, sub = MkIntroGui()
	local ti = TweenInfo.new(0.9, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
	TS:Create(en, ti, { TextTransparency = 0 }):Play()
	task.wait(0.55)
	TS:Create(bar, TweenInfo.new(0.45, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { BackgroundTransparency = 0 }):Play()
	TS:Create(cn, ti, { TextTransparency = 0 }):Play()
	task.wait(0.75)
	TS:Create(sub, TweenInfo.new(0.5), { TextTransparency = 0 }):Play()
	task.wait(1.05)
	IntroFadeOut(gui, bg, en, bar, cn, sub)
end

introFn[2] = function()
	local gui, bg, en, bar, cn, sub = MkIntroGui()
	en.TextTransparency = 0
	cn.TextTransparency = 0
	bar.BackgroundTransparency = 0
	sub.TextTransparency = 0
	local sc = Instance.new("UIScale", gui)
	sc.Scale = 0.35
	bg.BackgroundTransparency = 1
	TS:Create(bg, TweenInfo.new(0.35), { BackgroundTransparency = 0 }):Play()
	TS:Create(sc, TweenInfo.new(0.75, Enum.EasingStyle.Back, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	task.wait(0.85)
	TS:Create(sc, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), { Scale = 1.08 }):Play()
	task.wait(0.3)
	TS:Create(sc, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), { Scale = 1 }):Play()
	task.wait(1.0)
	IntroFadeOut(gui, bg, en, bar, cn, sub)
end

introFn[3] = function()
	local gui, bg, en, bar, cn, sub = MkIntroGui()
	en.Text = ""
	cn.Text = ""
	en.TextTransparency = 0
	cn.TextTransparency = 0
	sub.TextTransparency = 0
	task.spawn(function()
		local nEn = UCharCount(HUB_NAME)
		for i = 1, nEn do
			if not gui.Parent then return end
			en.Text = USub(HUB_NAME, i)
			task.wait(0.09)
		end
		TS:Create(bar, TweenInfo.new(0.3), { BackgroundTransparency = 0 }):Play()
		task.wait(0.3)
		local nCn = UCharCount(HUB_CN)
		for i = 1, nCn do
			if not gui.Parent then return end
			cn.Text = USub(HUB_CN, i)
			task.wait(0.11)
		end
	end)
	task.wait(2.4)
	IntroFadeOut(gui, bg, en, bar, cn, sub)
end

local function PlayIntro()
	local fn = introFn[INTRO_STYLE] or introFn[1]
	fn()
end

_G.__G2R5X_INTRO = { list = INTRO_NAMES, get = function() return INTRO_STYLE end,
	set = function(i) INTRO_STYLE = math.clamp(tonumber(i) or 1, 1, 3) end }

task.spawn(function()
	task.spawn(function()
		task.wait(0.2)
		local c = _G.__G2R5X_CFG
		if c and c.intro == false then return end
		if c and c.introStyle then INTRO_STYLE = math.clamp(tonumber(c.introStyle) or 1, 1, 3) end
		pcall(PlayIntro)
	end)
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
-- 本地存档（换服务器 / 重进后仍然保留）
--------------------------------------------------------------------------------
local FS = {}
FS.ok = false
pcall(function()
	if type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function" then
		FS.ok = true
	end
end)
local SAVE_DIR = "G2R5x"
function FS.Save(name, data)
	if not FS.ok then return false end
	local ok = pcall(function()
		if not isfolder(SAVE_DIR) then pcall(makefolder, SAVE_DIR) end
		local hs = game:GetService("HttpService")
		writefile(SAVE_DIR .. "/" .. name .. ".json", hs:JSONEncode(data))
	end)
	return ok
end
function FS.Load(name)
	if not FS.ok then return nil end
	local out = nil
	pcall(function()
		local path = SAVE_DIR .. "/" .. name .. ".json"
		if isfile(path) then
			local hs = game:GetService("HttpService")
			out = hs:JSONDecode(readfile(path))
		end
	end)
	return out
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
	{ name = "RT脚本免费版", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://gitee.com/founder-of-xt/rt-script-1/raw/master/script.lua",true))()]] },
	{ name = "寒脚本", cat = "普通脚本", code = [[getgenv().SCRIPT_KEY="ec1ecb11-0158-4854-b588-03f5c4c2ab7b";
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d6c1170046d31cebd08f3d38ad1e462e19c29de580b544c6dd7088c2f1de0160/download"))()]] },
	{ name = "安脚本中心", cat = "脚本中心", code = [[loadstring(game:HttpGet(('https://raw.githubusercontent.com/wucan114514/gegeyxjb/main/oww')))()]] },
	{ name = "BS黑洞中心", cat = "脚本中心", code = [[loadstring(game:HttpGet("https://gitee.com/BS_script/script/raw/master/BS_Script.Luau"))()]] },
	{ name = "情云脚本中心", cat = "脚本中心", code = [[loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()]] },
}

local FUN_LIB = {
	{ name = "伪装脚本", cat = "娱乐", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/scripts/refs/heads/main/伪装欺骗.lua"))()]] },
}

local MAIN_LINK = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/Evilsvj7/zzzxxc/refs/heads/main/G2R5x%20%E8%84%9A%E6%9C%AC%E4%B8%AD%E5%BF%83.lua"))()
]]

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
	Notify("G2R5x 脚本中心", "正在执行...", 3)
	local f, err = loadstring(entry.code)
	if not f then
		Notify("G2R5x 脚本中心", "执行失败，换一个试试", 5)
		warn("[G2R5x] " .. entry.name .. " 语法错误: " .. tostring(err))
		return false
	end
	local ok, rerr = pcall(f)
	if not ok then
		Notify("G2R5x 脚本中心", "执行失败，换一个试试", 5)
		warn("[G2R5x] " .. entry.name .. " 运行错误: " .. tostring(rerr))
		return false
	end
	Notify("G2R5x 脚本中心", "执行完成", 4)
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
	Notify("G2R5x 脚本中心", "UI 库加载失败，功能不可用", 6)
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
local TabHub = SafeTab({ Title = "脚本中心", Icon = "layout-grid" })
local TabRecent = SafeTab({ Title = "最近", Icon = "history" })
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
local JumpConn = nil
local function StopJumpLoop()
	if JumpConn then pcall(function() if JumpConn.Disconnect then JumpConn:Disconnect() end end) end
	JumpConn = nil
end

applyJump[1] = function(hum, v)
	StopJumpLoop()
	JumpConn = RS.Stepped:Connect(function()
		if not ModOn then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= true then h.UseJumpPower = true end
			if math.abs((h.JumpPower or 0) - v) > 0.01 then h.JumpPower = v end
		end)
	end)
end

applyJump[2] = function(hum, v)
	StopJumpLoop()
	local target = v / 7.5
	JumpConn = RS.Stepped:Connect(function()
		if not ModOn then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= false then h.UseJumpPower = false end
			if math.abs((h.JumpHeight or 0) - target) > 0.01 then h.JumpHeight = target end
		end)
	end)
end

applyJump[3] = function(hum, v)
	StopJumpLoop()
	local conn
	conn = UIS.JumpRequest:Connect(function()
		if not ModOn then return end
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			r.AssemblyLinearVelocity = Vector3.new(
				r.AssemblyLinearVelocity.X,
				v,
				r.AssemblyLinearVelocity.Z
			)
		end)
	end)
	JumpConn = conn
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

--------------------------------------------------------------------------------
-- 无限跳跃 3 种方式
--------------------------------------------------------------------------------
local function IsGrounded(h)
	local st = h:GetState()
	if st == Enum.HumanoidStateType.Running then return true end
	if st == Enum.HumanoidStateType.RunningNoPhysics then return true end
	if st == Enum.HumanoidStateType.Landed then return true end
	local fm = nil
	pcall(function() fm = h.FloorMaterial end)
	if fm ~= nil and fm ~= Enum.Material.Air then return true end
	return false
end
local function IJAirCap()
	return (IJMax > 0) and (IJAir >= IJMax)
end
local function CountAir()
	IJAir = IJAir + 1
end

local IJ_MODES = { "方式一 状态重置", "方式二 冷却计数", "方式三 速度注入" }
local IJMode = 1
local IJAuto = true
local IJOn = false
local IJVal = 50
local IJConn = nil
local IJCool = 0.12
local IJAir = 0
local IJMax = 0

local function StopIJ()
	if IJConn then pcall(function() IJConn:Disconnect() end) end
	IJConn = nil
	IJAir = 0
end

local applyIJ = {}

applyIJ[1] = function(hum, v)
	StopIJ()
	IJConn = UIS.JumpRequest:Connect(function()
		if not IJOn then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			if IJAirCap() then return end
			if not IsGrounded(h) then CountAir() end
			h:ChangeState(Enum.HumanoidStateType.Jumping)
		end)
	end)
end

applyIJ[2] = function(hum, v)
	StopIJ()
	pcall(function()
		local h = GetHum()
		if h then
			h.StateChanged:Connect(function(_, ns)
				if ns == Enum.HumanoidStateType.Landed then IJAir = 0 end
			end)
		end
	end)
	IJConn = UIS.JumpRequest:Connect(function()
		if not IJOn then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			if IJAirCap() then return end
			if not IsGrounded(h) then
				CountAir()
				h:ChangeState(Enum.HumanoidStateType.Jumping)
				task.wait(IJCool)
			else
				IJAir = 0
			end
		end)
	end)
end

applyIJ[3] = function(hum, v)
	StopIJ()
	IJConn = UIS.JumpRequest:Connect(function()
		if not IJOn then return end
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			if IJAirCap() then return end
			if not IsGrounded(h) then CountAir() end
			pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
			r.AssemblyLinearVelocity = Vector3.new(
				r.AssemblyLinearVelocity.X,
				v,
				r.AssemblyLinearVelocity.Z
			)
		end)
	end)
end

--------------------------------------------------------------------------------
-- 穿墙 3 种方式
--------------------------------------------------------------------------------
local NC_MODES = { "方式一 逐帧关碰撞", "方式二 碰撞分组", "方式三 RootPart穿透" }
local NCMode = 1
local NCAuto = true
local NCOn = false
local NCVal = 3
local NCSaved = {}
local NCGroup = "G2R5xNoClip"
local NCConn = nil

local function CharParts()
	local c = LP.Character
	if not c then return {} end
	local out = {}
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("BasePart") then out[#out + 1] = d end
	end
	return out
end

local function StopNC()
	NCOn = false
	if NCConn then pcall(function() NCConn:Disconnect() end) end
	NCConn = nil
	pcall(function()
		for p, v in pairs(NCSaved) do p.CanCollide = v end
	end)
	NCSaved = {}
	pcall(function()
		local ps = game:GetService("PhysicsService")
		for _, p in ipairs(CharParts()) do
			pcall(function() ps:SetPartCollisionGroup(p, "Default") end)
		end
	end)
end

local applyNC = {}

applyNC[1] = function()
	for _, p in ipairs(CharParts()) do
		if NCSaved[p] == nil then NCSaved[p] = p.CanCollide end
	end
	if NCConn then pcall(function() NCConn:Disconnect() end) end
	NCConn = RS.Stepped:Connect(function()
		if not NCOn then return end
		for _, p in ipairs(CharParts()) do
			if NCSaved[p] == nil then NCSaved[p] = p.CanCollide end
			if p.CanCollide then p.CanCollide = false end
		end
	end)
end

applyNC[2] = function()
	pcall(function()
		local ps = game:GetService("PhysicsService")
		pcall(function() ps:CreateCollisionGroup(NCGroup) end)
		pcall(function() ps:CollisionGroupSetCollidable(NCGroup, "Default", false) end)
		for _, p in ipairs(CharParts()) do
			pcall(function() ps:SetPartCollisionGroup(p, NCGroup) end)
		end
	end)
	if NCConn then pcall(function() NCConn:Disconnect() end) end
	NCConn = RS.Stepped:Connect(function()
		if not NCOn then return end
		pcall(function()
			local ps = game:GetService("PhysicsService")
			for _, p in ipairs(CharParts()) do
				ps:SetPartCollisionGroup(p, NCGroup)
			end
		end)
	end)
end

applyNC[3] = function()
	local c = LP.Character
	if not c then return end
	local root = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
	if not root then return end
	if NCSaved[root] == nil then NCSaved[root] = root.CanCollide end
	root.CanCollide = false
	if NCConn then pcall(function() NCConn:Disconnect() end) end
	NCConn = RS.Stepped:Connect(function()
		if not NCOn then return end
		pcall(function()
			local cc = LP.Character
			if not cc then return end
			local r = cc:FindFirstChild("HumanoidRootPart") or cc.PrimaryPart
			if not r then return end
			if r.CanCollide then r.CanCollide = false end
			local h = cc:FindFirstChildOfClass("Humanoid")
			if h and h.MoveDirection.Magnitude > 0.01 then
				r.CFrame = r.CFrame + (h.MoveDirection.Unit * (NCVal / 60))
			end
		end)
	end)
end

local function DoIJ()
	pcall(function()
		local h = GetHum()
		if h then applyIJ[IJMode](h, IJVal) end
	end)
end
local function DoNC()
	pcall(function()
		applyNC[NCMode]()
	end)
end

local function AutoWatch()
	task.spawn(function()
		while ModOn do
			pcall(function()
				local h = GetHum()
				if not h then return end

				if SpeedAuto then
					local ws = nil
					pcall(function() ws = h.WalkSpeed end)
					if SpeedMode == 1 then
						if ws == nil or math.abs(ws - SpeedVal) > 1 then
							SpeedMode = 2
							Notify("速度", "方式一被覆盖，切到方式二", 3)
							DoSpeed()
						end
					elseif SpeedMode == 2 then
						local r = GetRoot()
						if r then
							local mv = h.MoveDirection
							local flat = Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z).Magnitude
							if mv.Magnitude > 0.01 and flat < (SpeedVal * 0.4) then
								SpeedMode = 3
								Notify("速度", "方式二无效，切到方式三", 3)
								DoSpeed()
							end
						end
					elseif SpeedMode == 3 then
						local r = GetRoot()
						if r then
							local mv = h.MoveDirection
							local flat = Vector3.new(r.AssemblyLinearVelocity.X, 0, r.AssemblyLinearVelocity.Z).Magnitude
							if mv.Magnitude > 0.01 and flat < (SpeedVal * 0.4) then
								SpeedMode = 1
								Notify("速度", "回到方式一", 3)
								DoSpeed()
							end
						end
					end
				end

				if JumpAuto then
					local jp, jh, ujp = nil, nil, nil
					pcall(function() jp = h.JumpPower end)
					pcall(function() jh = h.JumpHeight end)
					pcall(function() ujp = h.UseJumpPower end)
					if JumpMode == 1 then
						if jp == nil or ujp ~= true or math.abs(jp - JumpVal) > 1 then
							JumpMode = 2
							Notify("跳跃", "方式一被覆盖，切到方式二", 3)
							DoJump()
						end
					elseif JumpMode == 2 then
						if jh == nil or ujp ~= false or jh <= 0 then
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
			StopJumpLoop()
			pcall(function()
				local h = GetHum()
				if h then h.WalkSpeed = 16 h.JumpPower = 50 h.UseJumpPower = true end
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

SafeAdd(TabLocal, "Section", { Title = "无限跳跃" })
TabLocal:Toggle({
	Title = "启用无限跳跃",
	Value = false,
	Callback = function(state)
		IJOn = state
		if state then
			DoIJ()
			Notify("本地修改", "无限跳跃已开启（空中按跳跃键）", 3)
		else
			StopIJ()
			Notify("本地修改", "无限跳跃已关闭", 3)
		end
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "跳跃力度",
	Desc = "仅方式三生效：空中每次跳的上升速度",
	Value = { Min = 20, Max = 300, Default = 50 },
	Step = 1,
	Range = { 20, 300 },
	CurrentValue = 50,
	Callback = function(val)
		if type(val) == "number" then
			IJVal = val
			if IJOn then DoIJ() end
		end
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "空中连跳上限",
	Desc = "0 = 无限跳；仅方式二生效",
	Value = { Min = 0, Max = 20, Default = 0 },
	Step = 1,
	Range = { 0, 20 },
	CurrentValue = 0,
	Callback = function(val)
		if type(val) == "number" then IJMax = val end
	end,
})
SafeAdd(TabLocal, "Dropdown", {
	Title = "无限跳跃方式",
	Desc = "在空中按跳跃键可再次起跳，跳不动就换一种",
	Values = IJ_MODES,
	Value = IJ_MODES[1],
	Multi = false,
	AllowNone = false,
	Options = IJ_MODES,
	CurrentOption = IJ_MODES[1],
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		for i, v in ipairs(IJ_MODES) do
			if v == pick then IJMode = i end
		end
		if IJOn then DoIJ() end
	end,
})
TabLocal:Toggle({
	Title = "无限跳跃方式自动切换",
	Value = true,
	Callback = function(state)
		IJAuto = state
	end,
})

SafeAdd(TabLocal, "Section", { Title = "穿墙" })
TabLocal:Toggle({
	Title = "启用穿墙",
	Value = false,
	Callback = function(state)
		if state then
			NCOn = true
			DoNC()
			Notify("本地修改", "穿墙已开启", 3)
		else
			StopNC()
			Notify("本地修改", "穿墙已关闭", 3)
		end
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "穿透步长",
	Desc = "仅方式三生效",
	Value = { Min = 1, Max = 12, Default = 3 },
	Step = 1,
	Range = { 1, 12 },
	CurrentValue = 3,
	Callback = function(val)
		if type(val) == "number" then NCVal = val end
	end,
})
SafeAdd(TabLocal, "Dropdown", {
	Title = "穿墙方式",
	Desc = "穿不过就换一种",
	Values = NC_MODES,
	Value = NC_MODES[1],
	Multi = false,
	AllowNone = false,
	Options = NC_MODES,
	CurrentOption = NC_MODES[1],
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		for i, v in ipairs(NC_MODES) do
			if v == pick then NCMode = i end
		end
		if NCOn then DoNC() end
	end,
})
TabLocal:Toggle({
	Title = "穿墙方式自动切换",
	Value = true,
	Callback = function(state)
		NCAuto = state
	end,
})

--------------------------------------------------------------------------------
-- 娱乐
--------------------------------------------------------------------------------
local TabFun = SafeTab({ Title = "娱乐", Icon = "gamepad-2" })
for _, e in ipairs(FUN_LIB) do
	SafeAdd(TabFun, "Button", {
		Title = e.name,
		Desc = "点击执行",
		Callback = function()
			RunScript(e)
		end,
	})
end

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
task.spawn(function()
	local saved = FS.Load("recent")
	if type(saved) == "table" then
		for _, nm in ipairs(saved) do
			for _, e in ipairs(SCRIPT_LIB) do
				if e.name == nm then RECENT[#RECENT + 1] = e break end
			end
			for _, e in ipairs(FUN_LIB) do
				if e.name == nm then RECENT[#RECENT + 1] = e break end
			end
			if #RECENT >= 3 then break end
		end
	end
end)

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
	local names = {}
	for _, e in ipairs(RECENT) do names[#names + 1] = e.name end
	FS.Save("recent", names)
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

--------------------------------------------------------------------------------
-- 设置
--------------------------------------------------------------------------------
local TabSet = SafeTab({ Title = "设置", Icon = "settings" })

local CFG = {
	autoRun = false,
	autoName = "",
	theme = "Dark",
	scale = 1,
	intro = true,
	introStyle = 1,
	notifDur = 5,
}
local savedCfg = FS.Load("config")
if type(savedCfg) == "table" then
	for k, v in pairs(savedCfg) do
		if CFG[k] ~= nil then CFG[k] = v end
	end
end
local function SaveCfg()
	FS.Save("config", {
		autoRun = CFG.autoRun, autoName = CFG.autoName,
		theme = CFG.theme, scale = CFG.scale,
		intro = CFG.intro, introStyle = CFG.introStyle, notifDur = CFG.notifDur,
	})
end

SafeAdd(TabSet, "Section", { Title = "主链接" })
SafeAdd(TabSet, "Button", {
	Title = "复制脚本主链接",
	Desc = "点击复制到剪贴板",
	Icon = "copy",
	Callback = function()
		if CopyText(MAIN_LINK) then
			Notify("复制成功", "主脚本链接已复制", 4)
		else
			Notify("复制失败", "剪贴板不可用", 5)
		end
	end,
})

SafeAdd(TabSet, "Section", { Title = "自启动" })
SafeAdd(TabSet, "Paragraph", {
	Title = "⚠️ 默认关闭",
	Desc = "默认在关闭状态的原因是防止有些服务器检测并封禁，这是为了安全着想，应该不是他只是测试版不稳定。",
})
SafeAdd(TabSet, "Toggle", {
	Title = "进入服务器时自启动",
	Value = CFG.autoRun,
	Callback = function(state)
		CFG.autoRun = state
		SaveCfg()
	end,
})
local AUTO_NAMES = { "(未选择)" }
for _, e in ipairs(SCRIPT_LIB) do AUTO_NAMES[#AUTO_NAMES + 1] = e.name end
for _, e in ipairs(FUN_LIB) do AUTO_NAMES[#AUTO_NAMES + 1] = e.name end
SafeAdd(TabSet, "Dropdown", {
	Title = "自启动运行的脚本",
	Desc = "需先开启上面的开关",
	Values = AUTO_NAMES,
	Value = (CFG.autoName ~= "" and CFG.autoName) or AUTO_NAMES[1],
	Multi = false,
	AllowNone = false,
	Options = AUTO_NAMES,
	CurrentOption = (CFG.autoName ~= "" and CFG.autoName) or AUTO_NAMES[1],
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		CFG.autoName = (pick == AUTO_NAMES[1]) and "" or pick
		SaveCfg()
	end,
})

SafeAdd(TabSet, "Section", { Title = "脚本配置" })
SafeAdd(TabSet, "Dropdown", {
	Title = "界面主题",
	Values = { "Dark", "Rose", "Sky", "Violet", "Amber" },
	Value = CFG.theme,
	Multi = false,
	AllowNone = false,
	Options = { "Dark", "Rose", "Sky", "Violet", "Amber" },
	CurrentOption = CFG.theme,
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		CFG.theme = tostring(pick or "Dark")
		pcall(function() WindUI:SetTheme(CFG.theme) end)
		SaveCfg()
	end,
})
local SCALE_MIN = 60
local SCALE_MAX = 300
local AutoFitOn = true

local function ClampScale(v)
	v = tonumber(v) or 100
	if v < SCALE_MIN then v = SCALE_MIN end
	if v > SCALE_MAX then v = SCALE_MAX end
	return v
end

local function ApplyScale(pct, quiet)
	pct = ClampScale(pct)
	CFG.scale = pct / 100
	pcall(function()
		if Window and Window.SetUIScale then
			Window:SetUIScale(CFG.scale)
			return
		end
		if WindUI and WindUI.ScreenGui then
			local us = WindUI.ScreenGui:FindFirstChild("UIScale")
			if us then us.Scale = CFG.scale end
		end
	end)
	SaveCfg()
	if not quiet then Notify("界面大小", "已设为 " .. tostring(pct) .. "%", 3) end
end

local function Viewport()
	local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
	if cam then return cam.ViewportSize end
	return Vector2.new(1280, 720)
end

local function FitScale()
	local vs = Viewport()
	local main = nil
	pcall(function()
		if Window and Window.UIElements and Window.UIElements.Main then
			main = Window.UIElements.Main
		end
	end)
	local sx, sy = vs.X, vs.Y
	if main then
		pcall(function()
			local a = main.AbsoluteSize
			if a.X > 0 then sx = a.X * CFG.scale end
			if a.Y > 0 then sy = a.Y * CFG.scale end
		end)
	end
	local mx = sx / vs.X
	local my = sy / vs.Y
	local over = math.max(mx, my)
	if over <= 0.92 then return nil end
	return ClampScale(math.floor((CFG.scale / over) * 100 * 0.9))
end

task.spawn(function()
	while true do
		task.wait(1.5)
		if AutoFitOn and CFG.intro ~= nil then
			pcall(function()
				local fit = FitScale()
				if fit and math.abs(fit - math.floor(CFG.scale * 100)) > 2 then
					ApplyScale(fit, false)
					Notify("界面大小", "超出屏幕，已自动调整为 " .. tostring(fit) .. "%", 4)
				end
			end)
		end
	end
end)

SafeAdd(TabSet, "Section", { Title = "界面大小" })
SafeAdd(TabSet, "Input", {
	Title = "缩放百分比",
	Desc = "输入数字后回车（" .. tostring(SCALE_MIN) .. " - " .. tostring(SCALE_MAX) .. "）",
	Placeholder = "例如 100",
	Value = tostring(math.floor(CFG.scale * 100)),
	InputIcon = "percent",
	Type = "Input",
	Callback = function(txt)
		local n = tonumber(tostring(txt or ""))
		if not n then
			Notify("界面大小", "请输入数字", 3)
			return
		end
		ApplyScale(n, false)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "恢复 100%",
	Desc = "一键回到默认大小",
	Callback = function()
		ApplyScale(100, false)
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "自动调节界面大小",
	Desc = "界面超出或过小时自动调回适合屏幕",
	Value = true,
	Callback = function(state)
		AutoFitOn = state
		Notify("界面大小", state and "自动调节已开启" or "自动调节已关闭", 3)
	end,
})

SafeAdd(TabSet, "Slider", {
	Title = "通知停留时间",
	Desc = "单位: 秒",
	Value = { Min = 2, Max = 12, Default = CFG.notifDur },
	Step = 1,
	Range = { 2, 12 },
	CurrentValue = CFG.notifDur,
	Callback = function(val)
		if type(val) == "number" then
			CFG.notifDur = val
			SaveCfg()
		end
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "开场动画",
	Value = CFG.intro,
	Callback = function(state)
		CFG.intro = state
		SaveCfg()
	end,
})
SafeAdd(TabSet, "Dropdown", {
	Title = "开场动画风格",
	Desc = "选一个你喜欢的",
	Values = INTRO_NAMES,
	Value = INTRO_NAMES[CFG.introStyle] or INTRO_NAMES[1],
	Multi = false,
	AllowNone = false,
	Options = INTRO_NAMES,
	CurrentOption = INTRO_NAMES[CFG.introStyle] or INTRO_NAMES[1],
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		for i, v in ipairs(INTRO_NAMES) do
			if v == pick then CFG.introStyle = i INTRO_STYLE = i end
		end
		SaveCfg()
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "预览开场动画",
	Desc = "立即播放一次当前风格",
	Callback = function()
		task.spawn(function() pcall(PlayIntro) end)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "清空最近记录",
	Desc = "删除本地保存的最近运行",
	Callback = function()
		RECENT = {}
		FS.Save("recent", {})
		pcall(RefreshRecent)
		Notify("设置", "最近记录已清空", 4)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "恢复默认设置",
	Desc = "重置全部配置",
	Callback = function()
		CFG.autoRun = false
		CFG.autoName = ""
		CFG.theme = "Dark"
		CFG.scale = 1
		CFG.intro = true
		CFG.introStyle = 1
		CFG.notifDur = 5
		SaveCfg()
		Notify("设置", "已恢复默认", 4)
	end,
})

task.spawn(function()
	if not CFG.autoRun then return end
	if CFG.autoName == "" then return end
	task.wait(2)
	for _, e in ipairs(SCRIPT_LIB) do
		if e.name == CFG.autoName then RunScript(e) return end
	end
	for _, e in ipairs(FUN_LIB) do
		if e.name == CFG.autoName then RunScript(e) return end
	end
end)

_G.__G2R5X_CFG = CFG

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

task.spawn(function()
	task.wait(0.6)
	if CFG.scale ~= 1 then
		pcall(function()
			if Window and Window.SetUIScale then
				Window:SetUIScale(CFG.scale)
			elseif WindUI and WindUI.ScreenGui then
				local us = WindUI.ScreenGui:FindFirstChild("UIScale")
				if us then us.Scale = CFG.scale end
			end
		end)
	end
end)

Notify("G2R5x 脚本中心", "加载完成", CFG.notifDur or 5)
