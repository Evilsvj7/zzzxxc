--[[
	G2R5x 脚本中心
	作者 Q: 2122119096   交流群: 1081093229
]]

local TS = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")
local RS = game:GetService("RunService")
local WS = game:GetService("Workspace")
local SoundService = game:GetService("SoundService")
local Players = game:GetService("Players")
local LP = Players.LocalPlayer
local HUB_NAME = "G2R5x"
local HUB_CN = "脚本中心"
local SV = {}
	SV.INTRO_STYLE = 1
	SV.introFn = {}
	SV.FS = {}
	SV.PendingConfirm = {}
	SV.WindUI = nil
	SV.SpeedMode = 1
	SV.JumpMode = 1
	SV.SpeedAuto = true
	SV.JumpAuto = true
	SV.SpeedVal = 16
	SV.JumpVal = 50
	SV.ModOn = false
	SV.VelObj = nil
	SV.applySpeed = {}
	SV.applyJump = {}
	SV.JumpConn = nil
	SV.JumpConn2 = nil
	SV.IJStateConn = nil
	SV.IJMode = 1
	SV.IJLast = 0
	SV.IJAuto = true
	SV.IJOn = false
	SV.IJVal = 50
	SV.IJConn = nil
	SV.IJAir = 0
	SV.IJMax = 0
	SV.applyIJ = {}
	SV.NCMode = 1
	SV.NCAuto = true
	SV.NCOn = false
	SV.NCVal = 3
	SV.NCSaved = {}
	SV.NCConn = nil
	SV.NCLastSafe = nil
	SV.NCLastSafeT = 0
	SV.applyNC = {}
	SV.FAIL_NEED = 2
	SV.MANUAL_PROTECT = 10
	SV.AutoSt = {}
	SV.OldLight = nil
	SV.LightOn = false
	SV.NVConn = nil
	SV.FOVOn = false
	SV.FOVVal = 120
	SV.FOVConn = nil
	SV.StamBinds = {}
	SV.NoFall = false
	SV.NoFallConn = nil
	SV.NoFallConn2 = nil
	SV.AntiKB = false
	SV.KBConn = nil
	SV.ClickTP = false
	SV.TPConn = nil
	SV.AutoJumpOn = false
	SV.AJConn = nil
	SV.ScaleVal = 1
	SV.ThirdOn = false
	SV.ThirdConn = nil
	SV.ThirdSaved = nil
	SV.AntiAFKOn = false
	SV.AFKConn = nil
	SV.AFKTick = nil
	SV.AFKLast = 0
	SV.FlyOn = false
	SV.FlyMobile = false
	SV.FlySpeed = 120
	SV.FlyBV = nil
	SV.FlyBG = nil
	SV.FlyConn = nil
	SV.FlyKeys = {}
	SV.FlyUp = 0
	SV.FlyGui = nil
	SV.FlyBtnUp = false
	SV.FlyBtnDown = false
	SV.FlyIsLinear = false
	SV.EspOn = false
	SV.EspTeam = true
	SV.EspRay = true
	SV.EspRayW = 2
	SV.EspDist = 500
	SV.EspColorMode = 0
	SV.EspGui = nil
	SV.EspObjs = {}
	SV.EspConn = nil
	SV.FunConns = {}
	SV.RainbowOn = false
	SV.SpinOn = false
	SV.HeadOn = false
	SV.HeadSaved = nil
	SV.GhostOn = false
	SV.GhostSaved = nil
	SV.FloatOn = false
	SV.DanceOn = false
	SV.DanceTrack = nil
	SV.DanceIdx = 1
	SV.EmoteTrack = nil
	SV.BounceOn = false
	SV.RECENT = {}
	SV.SCALE_MIN = 20
	SV.SCALE_MAX = 300
	SV.LastScaleMsg = 0
	SV.RescueBtn = nil

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

local INTRO_NAMES = { "风格一 淡入展开", "风格二 缩放弹入", "风格三 打字机" }


SV.introFn[1] = function()
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

SV.introFn[2] = function()
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

SV.introFn[3] = function()
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
	local fn = SV.introFn[SV.INTRO_STYLE] or SV.introFn[1]
	fn()
end

_G.__G2R5X_INTRO = { list = INTRO_NAMES, get = function() return SV.INTRO_STYLE end,
	set = function(i) SV.INTRO_STYLE = math.clamp(tonumber(i) or 1, 1, 3) end }

task.spawn(function()
	task.spawn(function()
		task.wait(0.2)
		local c = _G.__G2R5X_CFG
		if c and c.intro == false then return end
		if c and c.introStyle then SV.INTRO_STYLE = math.clamp(tonumber(c.introStyle) or 1, 1, 3) end
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

--------------------------------------------------------------------------------
-- 本地存档（换服务器 / 重进后仍然保留）
--------------------------------------------------------------------------------
SV.FS.ok = false
pcall(function()
	if type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function" then
		SV.FS.ok = true
	end
end)
local SAVE_DIR = "G2R5x"
function SV.FS.Save(name, data)
	if not SV.FS.ok then return false end
	local ok = pcall(function()
		if not isfolder(SAVE_DIR) then pcall(makefolder, SAVE_DIR) end
		local hs = game:GetService("HttpService")
		writefile(SAVE_DIR .. "/" .. name .. ".json", hs:JSONEncode(data))
	end)
	return ok
end
function SV.FS.Load(name)
	if not SV.FS.ok then return nil end
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

local CFG = {
	autoRun = false,
	autoName = "",
	theme = "Dark",
	scale = 1,
	intro = true,
	introStyle = 1,
	notifDur = 5,
	transparency = false,
	autoFit = true,
	notifSound = true,
	confirmBeforeRun = false,
	recentMax = 10,
	searchShowAll = true,
	autoHideAfterRun = false,
	lowPerf = false,
	sideBar = true,
	rescue = true,
}
local savedCfg = SV.FS.Load("config")
if type(savedCfg) == "table" then
	for k, v in pairs(savedCfg) do
		CFG[k] = v
	end
end
if type(CFG.recentMax) ~= "number" or CFG.recentMax < 10 then
	CFG.recentMax = 10
end
local function SaveCfg()
	SV.FS.Save("config", {
		autoRun = CFG.autoRun, autoName = CFG.autoName,
		theme = CFG.theme, scale = CFG.scale,
		intro = CFG.intro, introStyle = CFG.introStyle, notifDur = CFG.notifDur,
		transparency = CFG.transparency, autoFit = CFG.autoFit,
		notifSound = CFG.notifSound, confirmBeforeRun = CFG.confirmBeforeRun,
		recentMax = CFG.recentMax, searchShowAll = CFG.searchShowAll,
		autoHideAfterRun = CFG.autoHideAfterRun, lowPerf = CFG.lowPerf,
		sideBar = CFG.sideBar, rescue = CFG.rescue,
	})
end

local function Beep()
	if CFG.notifSound == false then return end
	task.spawn(function()
		pcall(function()
			local snd = Instance.new("Sound")
			snd.SoundId = "rbxassetid://9118823106"
			snd.Volume = 0.35
			snd.Parent = WS
			snd:Play()
			task.wait(1.2)
			snd:Destroy()
		end)
	end)
end

local function Notify(t1, t2, dur)
	Beep()
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
	{ name = "RT脚本免费版", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://gitee.com/founder-of-xt/rt-script-1/raw/master/script.lua",true))()]] },
	{ name = "星脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/zilinskaslandon/XingJiaoBen-2026-/refs/heads/main/%E6%98%9F%E8%84%9A%E6%9C%AC.lua"))()]] },
	{ name = "圣奥里", cat = "普通脚本", desc = "可能需要翻译因为这是英文", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/idkidevthings/improved-octo-chainsaw/refs/heads/main/sanx.lua"))()]] },
	{ name = "黑白脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet('https://raw.githubusercontent.com/tfcygvunbind/Apple/main/黑白脚本加载器'))()]] },
	{ name = "黑白脚本轻量版", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/tfcygvunbind/557/main/黑白脚本轻"))()]] },
	{ name = "R15无敌少侠", cat = "娱乐", code = [[loadstring(game:HttpGet("https://obj.wearedevs.net/197198/scripts/invincible%20flight%20animation.lua"))()]] },
	{ name = "寒脚本", cat = "普通脚本", code = [[getgenv().SCRIPT_KEY="ec1ecb11-0158-4854-b588-03f5c4c2ab7b";
loadstring(game:HttpGet("https://api.jnkie.com/api/v1/luascripts/public/d6c1170046d31cebd08f3d38ad1e462e19c29de580b544c6dd7088c2f1de0160/download"))()]] },
	{ name = "大司马中心", cat = "脚本中心", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/whenheer/dasimav6/refs/heads/main/dasimaV6.txt"))()]] },
	{ name = "安脚本中心", cat = "脚本中心", code = [[loadstring(game:HttpGet(('https://raw.githubusercontent.com/wucan114514/gegeyxjb/main/oww')))()]] },
	{ name = "BS黑洞中心", cat = "脚本中心", code = [[loadstring(game:HttpGet("https://gitee.com/BS_script/script/raw/master/BS_Script.Luau"))()]] },
	{ name = "情云脚本中心", cat = "脚本中心", code = [[loadstring(utf8.char((function() return table.unpack({108,111,97,100,115,116,114,105,110,103,40,103,97,109,101,58,72,116,116,112,71,101,116,40,34,104,116,116,112,115,58,47,47,114,97,119,46,103,105,116,104,117,98,117,115,101,114,99,111,110,116,101,110,116,46,99,111,109,47,67,104,105,110,97,81,89,47,45,47,109,97,105,110,47,37,69,54,37,56,51,37,56,53,37,69,52,37,66,65,37,57,49,34,41,41,40,41})end)()))()]] },
	{ name = "NH脚本", cat = "普通脚本", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/qweroot/NH-NM-HUB/main/NH%20HUB"))()]] },
}

local FUN_LIB = {
	{ name = "控制MPC", cat = "娱乐", code = [[loadstring(game:HttpGet("https://pastebin.com/raw/vFS0vfJa"))()]] },
	{ name = "爬墙脚本", cat = "娱乐", desc = "重置角色恢复", code = [[loadstring(game:HttpGet("https://pastebin.com/raw/5T7KsEWy", true))()]] },
	{ name = "伪装脚本", cat = "娱乐", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/YirdeX-Dev/scripts/refs/heads/main/伪装欺骗.lua"))()]] },
	{ name = "神秘的脚本", cat = "娱乐", desc = "玩儿这玩意儿生理不适的别来找我😱😭", code = [[loadstring(game:HttpGet("https://raw.githubusercontent.com/clemonlang/clemon_roclothes/refs/heads/main/ClemonRC.lua"))()]] },
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
	if CFG.confirmBeforeRun then
		if SV.PendingConfirm[entry.name] ~= true then
			SV.PendingConfirm[entry.name] = true
			Notify("G2R5x 脚本中心", "再点一次确认运行", 4)
			task.delay(5, function() SV.PendingConfirm[entry.name] = nil end)
			return false
		end
		SV.PendingConfirm[entry.name] = nil
	end
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
	if CFG.autoHideAfterRun then
		pcall(function()
			if Window and Window.Close then Window:Close() end
		end)
	end
	return true
end


--------------------------------------------------------------------------------
-- 加载 UI 库
--------------------------------------------------------------------------------
local uiOk, uiErr = pcall(function()
	SV.WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()
end)
if not uiOk or not SV.WindUI then
	Notify("G2R5x 脚本中心", "UI 库加载失败，功能不可用", 6)
	warn("[G2R5x] WindUI 加载失败: " .. tostring(uiErr))
	return
end

local Window = SV.WindUI:CreateWindow({
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
			Desc = e.desc or "点击执行",
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
			Desc = e.desc or "点击执行",
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

local SPD_MODES = { "方式一 WalkSpeed", "方式二 力度推进", "方式三 坐标位移", "方式四 强力推进", "方式五 速度直写" }
local JMP_MODES = { "方式一 JumpPower", "方式二 JumpHeight", "方式三 起跳推力", "方式四 脉冲上抛", "方式五 双通道叠加" }


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

local function EnsureVel(root)
	if SV.VelObj and SV.VelObj.Parent == root then return SV.VelObj end
	pcall(function() if SV.VelObj then SV.VelObj:Destroy() end end)
	SV.VelObj = nil
	pcall(function()
		local v = Instance.new("BodyVelocity")
		v.Name = "G2R5xVel"
		v.MaxForce = Vector3.new(0, 0, 0)
		v.Velocity = Vector3.new(0, 0, 0)
		v.P = 1250
		v.Parent = root
		SV.VelObj = v
	end)
	return SV.VelObj
end

SV.applySpeed[1] = function(hum, v)
	hum.WalkSpeed = v
end
SV.applySpeed[2] = function(hum, v)
	hum.WalkSpeed = v
	local root = GetRoot()
	if not root then return end
	EnsureVel(root)
	task.spawn(function()
		while SV.ModOn and SV.SpeedMode == 2 do
			pcall(function()
				local h = GetHum()
				local r = GetRoot()
				if not (h and r) then return end
				if SV.VelObj and SV.VelObj.Parent == r then
					local mv = h.MoveDirection
					SV.VelObj.Velocity = mv * v
					SV.VelObj.MaxForce = Vector3.new(9000, 0, 9000)
				end
			end)
			RS.Heartbeat:Wait()
		end
		pcall(function()
			if SV.VelObj then SV.VelObj.MaxForce = Vector3.new(0, 0, 0) SV.VelObj.Velocity = Vector3.new(0, 0, 0) end
		end)
	end)
end
SV.applySpeed[3] = function(hum, v)
	pcall(function() hum.WalkSpeed = 16 end)
	task.spawn(function()
		while SV.ModOn and SV.SpeedMode == 3 do
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

SV.applySpeed[4] = function(hum, v)
	pcall(function() hum.WalkSpeed = 16 end)
	local root = GetRoot()
	if not root then return end
	EnsureVel(root)
	task.spawn(function()
		while SV.ModOn and SV.SpeedMode == 4 do
			pcall(function()
				local h = GetHum()
				local r = GetRoot()
				if not (h and r) then return end
				if SV.VelObj and SV.VelObj.Parent == r then
					local mv = h.MoveDirection
					if mv.Magnitude > 0.01 then
						SV.VelObj.Velocity = Vector3.new(mv.X * v, 0, mv.Z * v)
						SV.VelObj.MaxForce = Vector3.new(1e5, 0, 1e5)
					else
						SV.VelObj.Velocity = Vector3.new(0, 0, 0)
						SV.VelObj.MaxForce = Vector3.new(1e5, 0, 1e5)
					end
				end
			end)
			RS.Heartbeat:Wait()
		end
		pcall(function()
			if SV.VelObj then SV.VelObj.MaxForce = Vector3.new(0, 0, 0) SV.VelObj.Velocity = Vector3.new(0, 0, 0) end
		end)
	end)
end

SV.applySpeed[5] = function(hum, v)
	pcall(function() hum.WalkSpeed = v end)
	task.spawn(function()
		while SV.ModOn and SV.SpeedMode == 5 do
			pcall(function()
				local h = GetHum()
				local r = GetRoot()
				if not (h and r) then return end
				if math.abs((h.WalkSpeed or 0) - v) > 1 then h.WalkSpeed = v end
				local mv = h.MoveDirection
				if mv.Magnitude > 0.01 then
					local cur = r.AssemblyLinearVelocity
					local want = v
					local flat = Vector3.new(cur.X, 0, cur.Z)
					if flat.Magnitude < (want * 0.9) then
						r.AssemblyLinearVelocity = Vector3.new(mv.X * want, cur.Y, mv.Z * want)
					end
				end
			end)
			RS.Heartbeat:Wait()
		end
	end)
end


local function StopJumpLoop()
	if SV.JumpConn then pcall(function() SV.JumpConn:Disconnect() end) end
	if SV.JumpConn2 then pcall(function() SV.JumpConn2:Disconnect() end) end
	SV.JumpConn = nil
	SV.JumpConn2 = nil
end

SV.applyJump[1] = function(hum, v)
	StopJumpLoop()
	SV.JumpConn = RS.Stepped:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 1 then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= true then h.UseJumpPower = true end
			if math.abs((h.JumpPower or 0) - v) > 0.01 then h.JumpPower = v end
		end)
	end)
	SV.JumpConn2 = RS.Heartbeat:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 1 then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= true then h.UseJumpPower = true end
			if math.abs((h.JumpPower or 0) - v) > 0.01 then h.JumpPower = v end
		end)
	end)
	pcall(function()
		local h = GetHum()
		if h then h.UseJumpPower = true h.JumpPower = v end
	end)
end

SV.applyJump[2] = function(hum, v)
	StopJumpLoop()
	local target = v / 7.5
	SV.JumpConn = RS.Stepped:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 2 then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= false then h.UseJumpPower = false end
			if math.abs((h.JumpHeight or 0) - target) > 0.01 then h.JumpHeight = target end
		end)
	end)
	SV.JumpConn2 = RS.Heartbeat:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 2 then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= false then h.UseJumpPower = false end
			if math.abs((h.JumpHeight or 0) - target) > 0.01 then h.JumpHeight = target end
		end)
	end)
	pcall(function()
		local h = GetHum()
		if h then h.UseJumpPower = false h.JumpHeight = target end
	end)
end

SV.applyJump[3] = function(hum, v)
	StopJumpLoop()
	SV.JumpConn = UIS.JumpRequest:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 3 then return end
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
			r.AssemblyLinearVelocity = Vector3.new(
				r.AssemblyLinearVelocity.X, v, r.AssemblyLinearVelocity.Z
			)
		end)
	end)
end

SV.applyJump[4] = function(hum, v)
	StopJumpLoop()
	SV.JumpConn = UIS.JumpRequest:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 4 then return end
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
			local vel = Instance.new("BodyVelocity")
			vel.MaxForce = Vector3.new(0, 1e6, 0)
			vel.Velocity = Vector3.new(0, v, 0)
			vel.P = 1250
			vel.Parent = r
			task.delay(0.18, function()
				pcall(function() vel:Destroy() end)
			end)
		end)
	end)
end

SV.applyJump[5] = function(hum, v)
	StopJumpLoop()
	pcall(function()
		local h = GetHum()
		if h then
			h.UseJumpPower = true
			h.JumpPower = v
		end
	end)
	SV.JumpConn = RS.Stepped:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 5 then return end
		pcall(function()
			local h = GetHum()
			if not h then return end
			if h.UseJumpPower ~= true then h.UseJumpPower = true end
			if math.abs((h.JumpPower or 0) - v) > 0.01 then h.JumpPower = v end
		end)
	end)
	SV.JumpConn2 = UIS.JumpRequest:Connect(function()
		if not SV.ModOn or SV.JumpMode ~= 5 then return end
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			task.wait(0.03)
			local cur = r.AssemblyLinearVelocity
			if cur.Y < v * 0.6 then
				r.AssemblyLinearVelocity = Vector3.new(cur.X, v, cur.Z)
			end
		end)
	end)
end

local function DoSpeed()
	pcall(function()
		local h = GetHum()
		if h then SV.applySpeed[SV.SpeedMode](h, SV.SpeedVal) end
	end)
end
local function DoJump()
	pcall(function()
		local h = GetHum()
		if h then SV.applyJump[SV.JumpMode](h, SV.JumpVal) end
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

local function CountAir()
	SV.IJAir = SV.IJAir + 1
end

local IJ_MODES = { "方式一 状态重置", "方式二 Jump 直写", "方式三 速度注入", "方式四 双通道", "方式五 强跳注入" }

local function BindIJReset()
	if SV.IJStateConn then pcall(function() SV.IJStateConn:Disconnect() end) end
	SV.IJStateConn = nil
	pcall(function()
		local h = GetHum()
		if not h then return end
		SV.IJStateConn = h.StateChanged:Connect(function(_, ns)
			if ns == Enum.HumanoidStateType.Landed then SV.IJAir = 0 end
		end)
	end)
end

local function StopIJ()
	if SV.IJConn then pcall(function() SV.IJConn:Disconnect() end) end
	SV.IJConn = nil
	if SV.IJReqConn then pcall(function() SV.IJReqConn:Disconnect() end) end
	SV.IJReqConn = nil
	if SV.IJPollConn then pcall(function() SV.IJPollConn:Disconnect() end) end
	SV.IJPollConn = nil
	SV.IJAir = 0
end

local function IJCanJump()
	if SV.IJMax <= 0 then return true end
	return SV.IJAir < SV.IJMax
end

local function IJAfterJump()
	task.delay(0.15, function()
		pcall(function()
			local r = GetRoot()
			if not r then return end
			SV.IJVy = r.AssemblyLinearVelocity.Y
			SV.IJTested = true
		end)
	end)
end

local IJLastJumpFlag = false

local function IJFire(fn)
	if not SV.IJOn then return end
	if (tick() - (SV.IJLastT or 0)) < 0.12 then return end
	if not IJCanJump() then return end
	SV.IJLastT = tick()
	CountAir()
	fn()
	IJAfterJump()
end

local function IJInject(r, v)
	if not (r and v) then return end
	local nv = v
	if not nv or nv <= 0 then nv = 50 end
	pcall(function()
		local cur = r.AssemblyLinearVelocity
		if cur.Y < nv * 0.8 then
			r.AssemblyLinearVelocity = Vector3.new(cur.X, nv, cur.Z)
		end
	end)
end

local function BindIJ(fn)
	StopIJ()
	BindIJReset()
	SV.IJReqConn = nil
	SV.IJPollConn = nil
	pcall(function()
		SV.IJReqConn = UIS.JumpRequest:Connect(function()
			IJFire(fn)
		end)
	end)
	pcall(function()
		SV.IJPollConn = RS.Heartbeat:Connect(function()
			if not SV.IJOn then return end
			local h = GetHum()
			if not h then return end
			local j = false
			pcall(function() j = h.Jump end)
			if j and not IJLastJumpFlag then IJFire(fn) end
			IJLastJumpFlag = j or false
			if SV.IJAir > 0 then
				if IsGrounded(h) then SV.IJAir = 0 end
			end
		end)
	end)
end

SV.applyIJ[1] = function(hum, v)
	BindIJ(function()
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h.PlatformStand = false end)
			pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
			IJInject(r, v)
		end)
	end)
end

SV.applyIJ[2] = function(hum, v)
	BindIJ(function()
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h.PlatformStand = false end)
			if h.Jump ~= true then h.Jump = true end
			IJInject(r, v)
		end)
	end)
end

SV.applyIJ[3] = function(hum, v)
	BindIJ(function()
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h.PlatformStand = false end)
			pcall(function()
				local cur = r.AssemblyLinearVelocity
				r.AssemblyLinearVelocity = Vector3.new(cur.X, v, cur.Z)
			end)
		end)
	end)
end

SV.applyIJ[4] = function(hum, v)
	BindIJ(function()
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h.PlatformStand = false end)
			if h.Jump ~= true then h.Jump = true end
			pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
			pcall(function()
				local cur = r.AssemblyLinearVelocity
				r.AssemblyLinearVelocity = Vector3.new(cur.X, v, cur.Z)
			end)
		end)
	end)
end

SV.applyIJ[5] = function(hum, v)
	BindIJ(function()
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			if h:GetState() == Enum.HumanoidStateType.Dead then return end
			pcall(function() h.PlatformStand = false end)
			pcall(function()
				if h.UseJumpPower ~= true then h.UseJumpPower = true end
				local nv = v
				if not nv or nv <= 0 then nv = 50 end
				if h.JumpPower ~= nv then h.JumpPower = nv end
			end)
			pcall(function() h:ChangeState(Enum.HumanoidStateType.Jumping) end)
			if h.Jump ~= true then h.Jump = true end
			IJInject(r, v)
		end)
	end)
end


--------------------------------------------------------------------------------
-- 穿墙 3 种方式
--------------------------------------------------------------------------------
local NC_MODES = { "方式一 逐帧关碰撞", "方式二 碰撞分组", "方式三 RootPart穿透", "方式四 闪现穿透", "方式五 关碰撞+推进" }
local NCGroup = "G2R5xNoClip"

local function CharParts()
	local c = LP.Character
	if not c then return {} end
	local out = {}
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("BasePart") then out[#out + 1] = d end
	end
	return out
end


local function RootPart()
	local c = LP.Character
	if not c then return nil end
	return c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
end

local function OverlapCount(cf)
	local n = 0
	pcall(function()
		local box = Instance.new("Part")
		box.Anchored = true
		box.CanCollide = false
		box.Transparency = 1
		box.Size = Vector3.new(3.2, 5.2, 3.2)
		box.CFrame = cf
		box.Parent = WS
		local params = OverlapParams.new()
		params.FilterType = Enum.RaycastFilterType.Blacklist
		params.FilterDescendantsInstances = { LP.Character }
		local list = WS:GetPartBoundsInBox(cf, box.Size, params)
		n = #list
		box:Destroy()
	end)
	return n
end

local function RecordSafe()
	local r = RootPart()
	if not r then return end
	if OverlapCount(r.CFrame) == 0 then
		SV.NCLastSafe = r.CFrame
		SV.NCLastSafeT = tick()
	end
end

local function FindFreeSpot()
	local r = RootPart()
	if not r then return nil end
	local origin = r.Position
	local dirs = {}
	for a = 0, 7 do
		local ang = (math.pi * 2) * (a / 8)
		dirs[#dirs + 1] = Vector3.new(math.cos(ang), 0, math.sin(ang))
	end
	dirs[#dirs + 1] = Vector3.new(0, 1, 0)
	dirs[#dirs + 1] = Vector3.new(0, -1, 0)
	for _, d in ipairs(dirs) do
		for dist = 3, 40, 2.5 do
			local cf = CFrame.new(origin + (d * dist))
			if OverlapCount(cf) == 0 then return cf end
		end
	end
	return nil
end

local function Unstuck()
	local r = RootPart()
	if not r then return false end
	if OverlapCount(r.CFrame) == 0 then return true end
	local h = nil
	pcall(function() h = LP.Character:FindFirstChildOfClass("Humanoid") end)
	if SV.NCLastSafe and (tick() - SV.NCLastSafeT) < 600 then
		if OverlapCount(SV.NCLastSafe) == 0 then
			pcall(function() r.CFrame = SV.NCLastSafe + Vector3.new(0, 1, 0) end)
			if OverlapCount(r.CFrame) == 0 then return true end
		end
	end
	local spot = FindFreeSpot()
	if spot then
		pcall(function() r.CFrame = spot + Vector3.new(0, 1, 0) end)
		if OverlapCount(r.CFrame) == 0 then return true end
	end
	return false
end

local function StopNC()
	SV.NCOn = false
	if SV.NCConn then pcall(function() SV.NCConn:Disconnect() end) end
	SV.NCConn = nil
	local ok = false
	pcall(function() ok = Unstuck() end)
	task.wait(0.08)
	pcall(function()
		for p, v in pairs(SV.NCSaved) do p.CanCollide = v end
	end)
	SV.NCSaved = {}
	pcall(function()
		local ps = game:GetService("PhysicsService")
		for _, p in ipairs(CharParts()) do
			pcall(function() ps:SetPartCollisionGroup(p, "Default") end)
		end
	end)
	if not ok then
		Notify("穿墙", "未能自动脱困，请点『卡墙脱困』", 5)
	end
	return ok
end


SV.applyNC[1] = function()
	for _, p in ipairs(CharParts()) do
		if SV.NCSaved[p] == nil then SV.NCSaved[p] = p.CanCollide end
	end
	if SV.NCConn then pcall(function() SV.NCConn:Disconnect() end) end
	SV.NCConn = RS.Stepped:Connect(function()
		if not SV.NCOn then return end
		for _, p in ipairs(CharParts()) do
			if SV.NCSaved[p] == nil then SV.NCSaved[p] = p.CanCollide end
			if p.CanCollide then p.CanCollide = false end
		end
	end)
end

SV.applyNC[2] = function()
	pcall(function()
		local ps = game:GetService("PhysicsService")
		pcall(function() ps:CreateCollisionGroup(NCGroup) end)
		pcall(function() ps:CollisionGroupSetCollidable(NCGroup, "Default", false) end)
		for _, p in ipairs(CharParts()) do
			pcall(function() ps:SetPartCollisionGroup(p, NCGroup) end)
		end
	end)
	if SV.NCConn then pcall(function() SV.NCConn:Disconnect() end) end
	SV.NCConn = RS.Stepped:Connect(function()
		if not SV.NCOn then return end
		pcall(function()
			local ps = game:GetService("PhysicsService")
			for _, p in ipairs(CharParts()) do
				ps:SetPartCollisionGroup(p, NCGroup)
			end
		end)
	end)
end

SV.applyNC[3] = function()
	local c = LP.Character
	if not c then return end
	local root = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
	if not root then return end
	if SV.NCSaved[root] == nil then SV.NCSaved[root] = root.CanCollide end
	root.CanCollide = false
	if SV.NCConn then pcall(function() SV.NCConn:Disconnect() end) end
	SV.NCConn = RS.Stepped:Connect(function()
		if not SV.NCOn then return end
		pcall(function()
			local cc = LP.Character
			if not cc then return end
			local r = cc:FindFirstChild("HumanoidRootPart") or cc.PrimaryPart
			if not r then return end
			if r.CanCollide then r.CanCollide = false end
			local h = cc:FindFirstChildOfClass("Humanoid")
			if h and h.MoveDirection.Magnitude > 0.01 then
				r.CFrame = r.CFrame + (h.MoveDirection.Unit * (SV.NCVal / 60))
			end
		end)
	end)
end

SV.applyNC[4] = function()
	local c = LP.Character
	if not c then return end
	local root = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
	if not root then return end
	if SV.NCSaved[root] == nil then SV.NCSaved[root] = root.CanCollide end
	root.CanCollide = false
	if SV.NCConn then pcall(function() SV.NCConn:Disconnect() end) end
	SV.NCConn = RS.Stepped:Connect(function()
		if not SV.NCOn then return end
		pcall(function()
			local cc = LP.Character
			if not cc then return end
			local r = cc:FindFirstChild("HumanoidRootPart") or cc.PrimaryPart
			if not r then return end
			if r.CanCollide then r.CanCollide = false end
			local h = cc:FindFirstChildOfClass("Humanoid")
			if h and h.MoveDirection.Magnitude > 0.01 then
				pcall(function()
					r.CFrame = r.CFrame + (h.MoveDirection.Unit * (SV.NCVal / 20))
				end)
			end
		end)
	end)
end

SV.applyNC[5] = function()
	for _, p in ipairs(CharParts()) do
		if SV.NCSaved[p] == nil then SV.NCSaved[p] = p.CanCollide end
	end
	if SV.NCConn then pcall(function() SV.NCConn:Disconnect() end) end
	SV.NCConn = RS.Stepped:Connect(function()
		if not SV.NCOn then return end
		pcall(function()
			local cc = LP.Character
			if not cc then return end
			local r = cc:FindFirstChild("HumanoidRootPart") or cc.PrimaryPart
			for _, p in ipairs(CharParts()) do
				if SV.NCSaved[p] == nil then SV.NCSaved[p] = p.CanCollide end
				if p.CanCollide then p.CanCollide = false end
			end
			if r then
				local h = cc:FindFirstChildOfClass("Humanoid")
				if h and h.MoveDirection.Magnitude > 0.01 then
					r.CFrame = r.CFrame + (h.MoveDirection.Unit * (SV.NCVal / 45))
				end
			end
		end)
	end)
end

local function DoIJ()
	pcall(function()
		local h = GetHum()
		if h then SV.applyIJ[SV.IJMode](h, SV.IJVal) end
	end)
end
task.spawn(function()
	while true do
		task.wait(0.6)
		if SV.NCOn then pcall(RecordSafe) end
	end
end)

local function DoNC()
	pcall(function()
		SV.applyNC[SV.NCMode]()
	end)
end

local SWITCH_COOL = 3.5

local function StOf(key)
	if not SV.AutoSt[key] then
		SV.AutoSt[key] = { lastSwitch = 0, fail = 0, tried = {}, dead = false, manualUntil = 0 }
	end
	return SV.AutoSt[key]
end

local function MarkManual(key)
	local st = StOf(key)
	st.tried = {}
	st.fail = 0
	st.dead = false
	st.manualUntil = tick() + SV.MANUAL_PROTECT
end

local SpeedProbe = { pos = nil, t = 0 }

local function MeasureFlat()
	local r = GetRoot()
	if not r then return nil end
	local now = tick()
	local p = r.Position
	if SpeedProbe.pos and (now - SpeedProbe.t) > 0.12 then
		local d = Vector3.new(p.X - SpeedProbe.pos.X, 0, p.Z - SpeedProbe.pos.Z).Magnitude
		local v = d / (now - SpeedProbe.t)
		SpeedProbe.pos = p
		SpeedProbe.t = now
		return v
	end
	SpeedProbe.pos = p
	SpeedProbe.t = now
	return nil
end

local function TestSpeed(mode)
	local h = GetHum()
	if not h then return true end
	if mode == 1 or mode == 5 then
		local ws = nil
		pcall(function() ws = h.WalkSpeed end)
		if ws == nil then return false end
		if math.abs(ws - SV.SpeedVal) > 1.5 then return false end
		if mode == 1 then return true end
	end
	if h.MoveDirection.Magnitude < 0.01 then return true end
	local v = MeasureFlat()
	if v == nil then return true end
	return v >= (SV.SpeedVal * 0.3)
end

local function TestJump(mode)
	local h = GetHum()
	if not h then return true end
	local jp, jh, ujp = nil, nil, nil
	pcall(function() jp = h.JumpPower end)
	pcall(function() jh = h.JumpHeight end)
	pcall(function() ujp = h.UseJumpPower end)
	if mode == 1 or mode == 5 then
		if jp == nil or ujp ~= true then return false end
		if math.abs(jp - SV.JumpVal) > 1.5 then return false end
		return true
	end
	if mode == 2 then
		if jh == nil or ujp ~= false or jh <= 0 then return false end
		return true
	end
	return true
end

local function TestIJ(mode)
	if not SV.IJTested then return true end
	SV.IJTested = false
	local vy = SV.IJVy
	if vy == nil then return true end
	return vy > 2
end

local function TestNC(mode)
	local c = LP.Character
	if not c then return true end
	local r = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
	if not r then return true end
	if mode == 2 then return true end
	local bad = 0
	for _, p in ipairs(CharParts()) do
		if p.CanCollide then bad = bad + 1 end
	end
	return bad == 0
end

local function TryAdvance(key, modeVar, setter, total, tester, label)
	local st = StOf(key)
	if st.dead then return end
	if tick() < st.manualUntil then return end
	if (tick() - st.lastSwitch) < SWITCH_COOL then return end
	if not tester(modeVar()) then
		st.fail = st.fail + 1
		if st.fail < SV.FAIL_NEED then return end
		st.fail = 0
		st.tried[modeVar()] = true
		local next = nil
		for i = 1, total do
			local cand = (modeVar() % total) + i
			if cand > total then cand = cand - total end
			if not st.tried[cand] then next = cand break end
		end
		if not next then
			st.dead = true
			if label then Notify(label, "全部方式都试过了，自动切换已停", 5) end
			return
		end
		setter(next)
		st.lastSwitch = tick()
		if label then Notify(label, "方式" .. tostring(modeVar()) .. "无效，切到方式" .. tostring(next), 3) end
		return true
	else
		st.fail = 0
	end
end

local function AutoWatch()
	task.spawn(function()
		while SV.ModOn do
			pcall(function()
				if SV.SpeedAuto then
					local changed = TryAdvance("speed",
						function() return SV.SpeedMode end,
						function(v) SV.SpeedMode = v DoSpeed() end,
						5, TestSpeed, "速度")
					if changed then return end
				end
				if SV.JumpAuto then
					TryAdvance("jump",
						function() return SV.JumpMode end,
						function(v) SV.JumpMode = v DoJump() end,
						5, TestJump, "跳跃")
				end
			end)
			task.wait(1.5)
		end
	end)
end

local function IJWatch()
	task.spawn(function()
		while SV.IJOn do
			pcall(function()
				if SV.IJAuto then
					TryAdvance("ij",
						function() return SV.IJMode end,
						function(v) SV.IJMode = v DoIJ() end,
						5, TestIJ, "无限跳")
				end
			end)
			task.wait(2)
		end
	end)
end

local function NCWatch()
	task.spawn(function()
		while SV.NCOn do
			pcall(function()
				if SV.NCAuto then
					TryAdvance("nc",
						function() return SV.NCMode end,
						function(v) SV.NCMode = v DoNC() end,
						5, TestNC, "穿墙")
				end
			end)
			task.wait(2)
		end
	end)
end

TabLocal:Toggle({
	Title = "启用本地修改",
	Value = false,
	Callback = function(state)
		SV.ModOn = state
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
				if SV.VelObj then SV.VelObj:Destroy() SV.VelObj = nil end
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
			SV.SpeedVal = val
			if SV.ModOn then DoSpeed() end
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
			if v == pick then SV.SpeedMode = i end
		end
		MarkManual("speed")
		if SV.ModOn then DoSpeed() end
		MarkManual("speed")
	end,
})

TabLocal:Toggle({
	Title = "速度方式自动切换",
	Value = true,
	Callback = function(state)
		SV.SpeedAuto = state
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
			SV.JumpVal = val
			if SV.ModOn then DoJump() end
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
			if v == pick then SV.JumpMode = i end
		end
		MarkManual("jump")
		if SV.ModOn then DoJump() end
	end,
})

TabLocal:Toggle({
	Title = "跳跃方式自动切换",
	Value = true,
	Callback = function(state)
		SV.JumpAuto = state
	end,
})

SafeAdd(TabLocal, "Section", { Title = "无限跳跃" })
TabLocal:Toggle({
	Title = "启用无限跳跃",
	Value = false,
	Callback = function(state)
		SV.IJOn = state
		if state then
			MarkManual("ij")
			DoIJ()
			IJWatch()
			Notify("本地修改", "无限跳跃已开启（按跳跃键，空中也能跳）", 3)
		else
			StopIJ()
			StOf("ij").dead = false
			StOf("ij").tried = {}
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
			SV.IJVal = val
			if SV.IJOn then DoIJ() end
		end
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "空中连跳上限",
	Desc = "0 = 无限；N = 空中最多跳 N 次",
	Value = { Min = 0, Max = 20, Default = 0 },
	Step = 1,
	Range = { 0, 20 },
	CurrentValue = 0,
	Callback = function(val)
		if type(val) == "number" then SV.IJMax = val end
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
			if v == pick then SV.IJMode = i end
		end
		MarkManual("ij")
		if SV.IJOn then DoIJ() end
	end,
})
TabLocal:Toggle({
	Title = "无限跳跃方式自动切换",
	Value = true,
	Callback = function(state)
		SV.IJAuto = state
	end,
})

SafeAdd(TabLocal, "Section", { Title = "穿墙" })
TabLocal:Toggle({
	Title = "启用穿墙",
	Value = false,
	Callback = function(state)
		if state then
			SV.NCOn = true
			SV.NCLastSafe = nil
			RecordSafe()
			MarkManual("nc")
			DoNC()
			NCWatch()
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
		if type(val) == "number" then SV.NCVal = val end
	end,
})
SafeAdd(TabLocal, "Button", {
	Title = "卡墙脱困",
	Desc = "被卡在墙里时点这个，自动挪到最近的空地",
	Icon = "log-out",
	Callback = function()
		local ok = false
		pcall(function() ok = Unstuck() end)
		if ok then
			Notify("脱困", "已挪出墙体", 4)
		else
			Notify("脱困", "没找到空地，试试重新开穿墙走出来", 5)
		end
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
			if v == pick then SV.NCMode = i end
		end
		MarkManual("nc")
		if SV.NCOn then DoNC() end
	end,
})
TabLocal:Toggle({
	Title = "穿墙方式自动切换",
	Value = true,
	Callback = function(state)
		SV.NCAuto = state
	end,
})

--------------------------------------------------------------------------------
-- 视觉 / 身体 增强
--------------------------------------------------------------------------------

local function SetFullbright(on)
	pcall(function()
		local l = game:GetService("Lighting")
		if on then
			SV.OldLight = { l.Ambient, l.Brightness, l.OutdoorAmbient, l.GlobalShadows, l.FogEnd }
			l.Ambient = Color3.fromRGB(255, 255, 255)
			l.OutdoorAmbient = Color3.fromRGB(255, 255, 255)
			l.Brightness = 3
			l.GlobalShadows = false
			l.FogEnd = 1e6
		elseif SV.OldLight then
			l.Ambient = SV.OldLight[1]
			l.Brightness = SV.OldLight[2]
			l.OutdoorAmbient = SV.OldLight[3]
			l.GlobalShadows = SV.OldLight[4]
			l.FogEnd = SV.OldLight[5]
			SV.OldLight = nil
		end
	end)
end

local function SetNightVision(on)
	if SV.NVConn then pcall(function() SV.NVConn:Disconnect() end) SV.NVConn = nil end
	if not on then
		pcall(function()
			local l = game:GetService("Lighting")
			for _, e in ipairs(l:GetChildren()) do
				if e.Name == "G2R5xNV" then e:Destroy() end
			end
		end)
		return
	end
	pcall(function()
		local l = game:GetService("Lighting")
		local cc = Instance.new("ColorCorrectionEffect")
		cc.Name = "G2R5xNV"
		cc.Brightness = 0.35
		cc.Contrast = 0.4
		cc.Saturation = -1
		cc.TintColor = Color3.fromRGB(120, 255, 140)
		cc.Parent = l
	end)
end

local function SetFOV(on)
	SV.FOVOn = on
	if SV.FOVConn then pcall(function() SV.FOVConn:Disconnect() end) SV.FOVConn = nil end
	if not on then
		pcall(function()
			local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
			if cam then cam.FieldOfView = 70 end
		end)
		return
	end
	SV.FOVConn = RS.Heartbeat:Connect(function()
		if not SV.FOVOn then return end
		pcall(function()
			local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
			if cam and math.abs(cam.FieldOfView - SV.FOVVal) > 0.5 then
				cam.FieldOfView = SV.FOVVal
			end
		end)
	end)
end

local InfStam = false
local StamConn = nil

local STAM_KEYS = { "stam", "stamina", "energy", "breath", "oxygen", "sp", "mp", "体力", "耐力", "气" }

local function IsStamName(n)
	local low = string.lower(n or "")
	for _, k in ipairs(STAM_KEYS) do
		if string.find(low, k, 1, true) then return true end
	end
	return false
end

local function FindMaxFor(obj)
	local parent = obj.Parent
	if not parent then return nil end
	local base = obj.Name
	local cands = { base .. "Max", "Max" .. base, base .. "MaxValue", "Max" .. base .. "Value" }
	for _, cn in ipairs(cands) do
		local f = parent:FindFirstChild(cn)
		if f and (f:IsA("NumberValue") or f:IsA("IntValue")) then return f.Value end
	end
	local num = nil
	pcall(function() num = obj:FindFirstChild("MaxValue") end)
	if num and (num:IsA("NumberValue") or num:IsA("IntValue")) then return num.Value end
	return nil
end

local function FillOne(v)
	pcall(function()
		if not (v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("DoubleConstrainedValue")) then return end
		if not IsStamName(v.Name) then return end
		local mx = FindMaxFor(v)
		local target = mx
		if target == nil then target = 100 end
		if v.Value ~= target then v.Value = target end
	end)
end

local function ScanStamina()
	local c = LP.Character
	if not c then return end
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("NumberValue") or d:IsA("IntValue") or d:IsA("DoubleConstrainedValue") then
			if IsStamName(d.Name) then
				FillOne(d)
				if not SV.StamBinds[d] then
					SV.StamBinds[d] = true
					pcall(function()
						d.Changed:Connect(function()
							if InfStam then FillOne(d) end
						end)
					end)
				end
			end
		end
	end
end

local function SetInfStamina(on)
	InfStam = on
	if StamConn then pcall(function() StamConn:Disconnect() end) StamConn = nil end
	if not on then return end
	StamConn = RS.Heartbeat:Connect(function()
		if not InfStam then return end
		pcall(function()
			local c = LP.Character
			if not c then return end
			for _, d in ipairs(c:GetDescendants()) do
				if d:IsA("NumberValue") or d:IsA("IntValue") or d:IsA("DoubleConstrainedValue") then
					if IsStamObj(d) then
						pcall(function()
							local mx = d:FindFirstChild("MaxValue")
							if mx and type(mx.Value) == "number" then
								d.Value = mx.Value
							else
								d.Value = 100
							end
						end)
					end
				end
			end
		end)
	end)
	task.spawn(function()
		while InfStam do
			pcall(function()
				local h = GetHum()
				if h then
					pcall(function() h:SetAttribute("Stamina", 100) end)
					pcall(function() h:SetAttribute("Energy", 100) end)
				end
			end)
			task.wait(0.5)
		end
	end)
end



local function GroundDist(r)
	local ok, res = pcall(function()
		local params = RaycastParams.new()
		params.FilterType = Enum.RaycastFilterType.Blacklist
		params.FilterDescendantsInstances = { LP.Character }
		local rr = WS:Raycast(r.Position, Vector3.new(0, -500, 0), params)
		if rr then return rr.Distance end
		return nil
	end)
	if ok and res then return res end
	return nil
end

local function SetNoFall(on)
	SV.NoFall = on
	if SV.NoFallConn then pcall(function() SV.NoFallConn:Disconnect() end) SV.NoFallConn = nil end
	if not on then return end
	SV.NoFallConn = RS.Heartbeat:Connect(function()
		if not SV.NoFall then return end
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			local v = r.AssemblyLinearVelocity
			if v.Y > -60 then return end
			local st = h:GetState()
			if st == Enum.HumanoidStateType.Jumping then return end
			r.AssemblyLinearVelocity = Vector3.new(v.X, -60, v.Z)
		end)
	end)
end

local function SetAntiKB(on)
	SV.AntiKB = on
	if SV.KBConn then pcall(function() SV.KBConn:Disconnect() end) SV.KBConn = nil end
	if not on then return end
	SV.KBConn = RS.Stepped:Connect(function()
		if not SV.AntiKB then return end
		pcall(function()
			local h = GetHum()
			if h then h.PlatformStand = false end
			local r = GetRoot()
			if not r then return end
			for _, d in ipairs(r:GetChildren()) do
				if d:IsA("BodyVelocity") or d:IsA("VectorForce") or d:IsA("BodyThrust") then
					if d.Name ~= "G2R5xVel" and d.Name ~= "G2R5xFlyVel" then
						pcall(function() d:Destroy() end)
					end
				end
			end
		end)
	end)
end

local function SetClickTP(on)
	SV.ClickTP = on
	if SV.TPConn then pcall(function() SV.TPConn:Disconnect() end) SV.TPConn = nil end
	if not on then return end
	local mouse = LP:GetMouse()
	SV.TPConn = mouse.Button1Down:Connect(function()
		if not SV.ClickTP then return end
		pcall(function()
			local c = LP.Character
			if not c then return end
			local r = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
			if not r then return end
			if mouse.Target then
				r.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0, 4, 0))
			end
		end)
	end)
end

local function SetAutoJump(on)
	SV.AutoJumpOn = on
	if SV.AJConn then pcall(function() SV.AJConn:Disconnect() end) SV.AJConn = nil end
	if not on then return end
	SV.AJConn = RS.Heartbeat:Connect(function()
		if not SV.AutoJumpOn then return end
		pcall(function()
			local h = GetHum()
			if h and h.MoveDirection.Magnitude > 0.01 then
				if h:GetState() ~= Enum.HumanoidStateType.Jumping
					and h:GetState() ~= Enum.HumanoidStateType.Freefall then
					h:ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end
		end)
	end)
end

local function EnsureScale(h)
	local names = { "BodyHeightScale", "BodyWidthScale", "BodyDepthScale", "HeadScale" }
	for _, n in ipairs(names) do
		if not h:FindFirstChild(n) then
			pcall(function()
				local nv = Instance.new("NumberValue")
				nv.Name = n
				nv.Value = 1
				nv.Parent = h
			end)
		end
	end
end

local function SetBodyScale(v)
	SV.ScaleVal = v
	pcall(function()
		local h = GetHum()
		if not h then return end
		EnsureScale(h)
		pcall(function()
			if h:FindFirstChild("BodyHeightScale") then h.BodyHeightScale.Value = v end
			if h:FindFirstChild("BodyWidthScale") then h.BodyWidthScale.Value = v end
			if h:FindFirstChild("BodyDepthScale") then h.BodyDepthScale.Value = v end
			if h:FindFirstChild("HeadScale") then h.HeadScale.Value = v end
		end)
	end)
end

local function SetThird(on)
	SV.ThirdOn = on
	if SV.ThirdConn then pcall(function() SV.ThirdConn:Disconnect() end) SV.ThirdConn = nil end
	if not on then
		pcall(function()
			if SV.ThirdSaved then
				LP.CameraMaxZoomDistance = SV.ThirdSaved[1]
				LP.CameraMinZoomDistance = SV.ThirdSaved[2]
				LP.CameraMode = SV.ThirdSaved[3]
				SV.ThirdSaved = nil
			end
			local h = GetHum()
			local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
			if h and cam then cam.CameraSubject = h end
		end)
		return
	end
	if not SV.ThirdSaved then
		SV.ThirdSaved = { LP.CameraMaxZoomDistance, LP.CameraMinZoomDistance, LP.CameraMode }
	end
	pcall(function()
		LP.CameraMode = Enum.CameraMode.Classic
		LP.CameraMaxZoomDistance = 25
		LP.CameraMinZoomDistance = 25
	end)
	SV.ThirdConn = RS.Heartbeat:Connect(function()
		if not SV.ThirdOn then return end
		pcall(function()
			local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
			if not cam then return end
			local c = LP.Character
			if not c then return end
			local h = c:FindFirstChildOfClass("Humanoid")
			if h and cam.CameraSubject ~= h then cam.CameraSubject = h end
			if cam.CameraType ~= Enum.CameraType.Custom then
				cam.CameraType = Enum.CameraType.Custom
			end
			if LP.CameraMaxZoomDistance < 20 then LP.CameraMaxZoomDistance = 25 end
			if LP.CameraMinZoomDistance < 20 then LP.CameraMinZoomDistance = 25 end
		end)
	end)
end


local function SetAntiAFK(on)
	SV.AntiAFKOn = on
	if SV.AFKConn then pcall(function() SV.AFKConn:Disconnect() end) SV.AFKConn = nil end
	if not on then return end
	SV.AFKLast = tick()
	SV.AFKConn = RS.Heartbeat:Connect(function()
		if not SV.AntiAFKOn then return end
		if (tick() - SV.AFKLast) < 55 then return end
		SV.AFKLast = tick()
		pcall(function()
			local h = GetHum()
			local r = GetRoot()
			if not (h and r) then return end
			h:Move(Vector3.new(math.random(-10, 10) / 10, 0, math.random(-10, 10) / 10), false)
			task.wait(0.25)
			h:Move(Vector3.new(0, 0, 0), false)
			h.Jump = true
		end)
	end)
end

SafeAdd(TabLocal, "Section", { Title = "视觉" })
TabLocal:Toggle({
	Title = "全亮",
	Desc = "去掉黑夜和阴影",
	Value = false,
	Callback = function(state)
		SV.LightOn = state
		SetFullbright(state)
	end,
})
TabLocal:Toggle({
	Title = "夜视",
	Desc = "绿色夜视画面",
	Value = false,
	Callback = function(state)
		SetNightVision(state)
	end,
})
TabLocal:Toggle({
	Title = "广角视野",
	Desc = "拉大 FOV，看得更远",
	Value = false,
	Callback = function(state)
		SetFOV(state)
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "FOV 数值",
	Desc = "70 - 120",
	Value = { Min = 70, Max = 120, Default = 120 },
	Step = 1,
	Range = { 70, 120 },
	CurrentValue = 120,
	Callback = function(val)
		if type(val) == "number" then
			SV.FOVVal = val
			if SV.FOVOn then SetFOV(true) end
		end
	end,
})

local function SetInfHealth(on)
	SV.InfHealth = on
	if SV.HealConn then pcall(function() SV.HealConn:Disconnect() end) SV.HealConn = nil end
	if not on then return end
	SV.HealConn = RS.Heartbeat:Connect(function()
		if not SV.InfHealth then return end
		pcall(function()
			local h = GetHum()
			if h and h.MaxHealth > 0 and h.Health < h.MaxHealth then
				h.Health = h.MaxHealth
			end
		end)
	end)
end

TabLocal:Toggle({
	Title = "无限血量",
	Value = false,
	Callback = function(state)
		SetInfHealth(state)
	end,
})

SafeAdd(TabLocal, "Section", { Title = "身体" })
TabLocal:Toggle({
	Title = "无限体力",
	Desc = "只补体力，不动血量",
	Value = false,
	Callback = function(state)
		SetInfStamina(state)
	end,
})
TabLocal:Toggle({
	Title = "防摔落伤害",
	Desc = "限制下落速度",
	Value = false,
	Callback = function(state)
		SetNoFall(state)
	end,
})
TabLocal:Toggle({
	Title = "防击退",
	Desc = "清掉外力推挤",
	Value = false,
	Callback = function(state)
		SetAntiKB(state)
	end,
})
TabLocal:Toggle({
	Title = "自动跳",
	Desc = "移动时自动起跳",
	Value = false,
	Callback = function(state)
		SetAutoJump(state)
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "角色缩放",
	Desc = "0.3 倍 ~ 3 倍",
	Value = { Min = 30, Max = 300, Default = 100 },
	Step = 5,
	Range = { 30, 300 },
	CurrentValue = 100,
	Callback = function(val)
		if type(val) == "number" then SetBodyScale(val / 100) end
	end,
})

SafeAdd(TabLocal, "Section", { Title = "移动辅助" })
TabLocal:Toggle({
	Title = "点击传送",
	Desc = "点地面直接飞过去",
	Value = false,
	Callback = function(state)
		SetClickTP(state)
	end,
})
TabLocal:Toggle({
	Title = "第三人称",
	Value = false,
	Callback = function(state)
		SetThird(state)
	end,
})
TabLocal:Toggle({
	Title = "防挂机踢出",
	Value = false,
	Callback = function(state)
		SetAntiAFK(state)
	end,
})

--------------------------------------------------------------------------------
-- 飞行
--------------------------------------------------------------------------------

local function CamCFrame()
	local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
	if not cam then
		pcall(function() cam = game:GetService("Workspace").CurrentCamera end)
	end
	if not cam then return nil end
	return cam.CFrame
end


local function SetFlyVel(vec)
	if not SV.FlyBV then return end
	pcall(function()
		if SV.FlyIsLinear then
			SV.FlyBV.VectorVelocity = vec
		else
			SV.FlyBV.Velocity = vec
		end
	end)
end

local function KillFlyParts()
	SV.FlyIsLinear = false
	if SV.FlyBV then pcall(function() SV.FlyBV:Destroy() end) SV.FlyBV = nil end
	if SV.FlyBG then pcall(function() SV.FlyBG:Destroy() end) SV.FlyBG = nil end
end

local function StopFly()
	SV.FlyOn = false
	if SV.FlyConn then pcall(function() SV.FlyConn:Disconnect() end) SV.FlyConn = nil end
	SV.FlyKeys = {}
	SV.FlyUp = 0
	SV.FlyBtnUp = false
	SV.FlyBtnDown = false
	KillFlyParts()
	if SV.FlyGui then pcall(function() SV.FlyGui:Destroy() end) SV.FlyGui = nil end
	pcall(function()
		local h = GetHum()
		if h then h.PlatformStand = false end
	end)
end

local function MakeFlyParts()
	KillFlyParts()
	local r = GetRoot()
	if not r then return nil end
	local ok = pcall(function()
		SV.FlyBV = Instance.new("BodyVelocity")
		SV.FlyBV.Name = "G2R5xFlyVel"
		SV.FlyBV.MaxForce = Vector3.new(1e6, 1e6, 1e6)
		SV.FlyBV.Velocity = Vector3.zero
		SV.FlyBV.P = 1250
		SV.FlyBV.Parent = r
		SV.FlyIsLinear = false
	end)
	if not ok or not SV.FlyBV then
		SV.FlyBV = nil
		pcall(function()
			local att = r:FindFirstChild("RootAttachment")
			if not att then
				att = Instance.new("Attachment")
				att.Name = "G2R5xFlyAtt"
				att.Parent = r
			end
			SV.FlyBV = Instance.new("LinearVelocity")
			SV.FlyBV.Name = "G2R5xFlyVel"
			SV.FlyBV.MaxForce = 1e6
			SV.FlyBV.VectorVelocity = Vector3.zero
			SV.FlyBV.Attachment0 = att
			SV.FlyBV.Parent = r
			SV.FlyIsLinear = true
		end)
	end
	pcall(function()
		SV.FlyBG = Instance.new("BodyGyro")
		SV.FlyBG.MaxTorque = Vector3.new(9e5, 9e5, 9e5)
		SV.FlyBG.P = 9e4
		SV.FlyBG.CFrame = r.CFrame
		SV.FlyBG.Parent = r
	end)
	return SV.FlyBV
end

local function MakeMobileFlyGui()
	if SV.FlyGui then pcall(function() SV.FlyGui:Destroy() end) SV.FlyGui = nil end
	local ok = pcall(function()
		local parent = nil
		if gethui then pcall(function() parent = gethui() end) end
		if not parent then pcall(function() parent = game:GetService("CoreGui") end) end
		if not parent then parent = LP:WaitForChild("PlayerGui") end
		local g = Instance.new("ScreenGui")
		g.Name = "G2R5xFly"
		g.ResetOnSpawn = false
		g.IgnoreGuiInset = true
		g.DisplayOrder = 2147483646
		g.Parent = parent
		local function mkOff(txt, offY, onDown, onUp)
			local b = Instance.new("TextButton", g)
			b.Size = UDim2.new(0, 62, 0, 62)
			b.AnchorPoint = Vector2.new(0, 0.5)
			b.Position = UDim2.new(1, -78, 0.5, offY)
			b.BackgroundColor3 = Color3.fromRGB(40, 40, 60)
			b.BackgroundTransparency = 0.25
			b.Text = txt
			b.TextColor3 = Color3.fromRGB(255, 255, 255)
			b.TextSize = 22
			b.Font = Enum.Font.GothamBold
			b.Active = true
			pcall(function()
				local c = Instance.new("UICorner", b)
				c.CornerRadius = UDim.new(0, 31)
			end)
			local function set(v)
				if v then onDown() else onUp() end
			end
			b.InputBegan:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.Touch
					or i.UserInputType == Enum.UserInputType.MouseButton1 then
					set(true)
				end
			end)
			b.InputEnded:Connect(function(i)
				if i.UserInputType == Enum.UserInputType.Touch
					or i.UserInputType == Enum.UserInputType.MouseButton1 then
					set(false)
				end
			end)
			return b
		end
		mkOff("UP", -72, function() SV.FlyBtnUp = true end, function() SV.FlyBtnUp = false end)
		mkOff("DN", 8, function() SV.FlyBtnDown = true end, function() SV.FlyBtnDown = false end)
		SV.FlyGui = g
	end)
	return ok
end

local function FlyTick()
	local h = GetHum()
	local r = GetRoot()
	if not (h and r) then return end
	if h.PlatformStand ~= true then h.PlatformStand = true end
	if not SV.FlyBV then
		if not MakeFlyParts() then return end
	end
	local cf = CamCFrame()
	if not cf then return end
	local move = Vector3.zero
	local md = h.MoveDirection
	if md.Magnitude > 0.01 then
		local f = cf.LookVector
		local rt = cf.RightVector
		local fy = Vector3.new(f.X, 0, f.Z)
		local ry = Vector3.new(rt.X, 0, rt.Z)
		if fy.Magnitude < 0.001 then fy = Vector3.new(0, 0, -1) end
		if ry.Magnitude < 0.001 then ry = Vector3.new(1, 0, 0) end
		fy = fy.Unit
		ry = ry.Unit
		move = (ry * md.X) + (fy * -md.Z)
		if move.Magnitude > 0.01 then move = move.Unit end
	end
	local vert = 0
	if SV.FlyMobile then
		vert = (SV.FlyBtnUp and 1 or 0) - (SV.FlyBtnDown and 1 or 0)
	else
		vert = (SV.FlyKeys.up and 1 or 0) - (SV.FlyKeys.down and 1 or 0)
	end
	local final = (move * SV.FlySpeed) + Vector3.new(0, vert * SV.FlySpeed, 0)
	pcall(function() r.AssemblyLinearVelocity = final end)
	if SV.FlyBG then
		SV.FlyBG.CFrame = CFrame.new(r.Position, r.Position + cf.LookVector)
	end
end


local function StartFly(mobile)
	SV.FlyMobile = mobile and true or false
	SV.FlyOn = true
	if not MakeFlyParts() then
		Notify("飞行", "找不到角色，稍后再试", 4)
		SV.FlyOn = false
		return false
	end
	if SV.FlyMobile then MakeMobileFlyGui() end
	if SV.FlyConn then pcall(function() SV.FlyConn:Disconnect() end) end
	SV.FlyConn = RS.Heartbeat:Connect(function()
		if not SV.FlyOn then return end
		pcall(FlyTick)
	end)
	return true
end

UIS.InputBegan:Connect(function(input, gpe)
	if not SV.FlyOn or SV.FlyMobile then return end
	if gpe then return end
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	local k = input.KeyCode
	if k == Enum.KeyCode.Space then SV.FlyKeys.up = true end
	if k == Enum.KeyCode.LeftShift or k == Enum.KeyCode.RightShift
		or k == Enum.KeyCode.LeftControl or k == Enum.KeyCode.RightControl
		or k == Enum.KeyCode.LeftAlt then SV.FlyKeys.down = true end
end)
UIS.InputEnded:Connect(function(input)
	if not SV.FlyOn or SV.FlyMobile then return end
	if input.UserInputType ~= Enum.UserInputType.Keyboard then return end
	local k = input.KeyCode
	if k == Enum.KeyCode.Space then SV.FlyKeys.up = false end
	if k == Enum.KeyCode.LeftShift or k == Enum.KeyCode.RightShift
		or k == Enum.KeyCode.LeftControl or k == Enum.KeyCode.RightControl
		or k == Enum.KeyCode.LeftAlt then SV.FlyKeys.down = false end
end)

SafeAdd(TabLocal, "Section", { Title = "飞行" })
TabLocal:Toggle({
	Title = "电脑端飞行",
	Desc = "WASD 移动，空格上升，Shift/Ctrl 下降",
	Value = false,
	Callback = function(state)
		if state then
			StopFly()
			if StartFly(false) then
				Notify("飞行", "电脑端飞行已开启：WASD + 空格/Shift", 4)
			end
		else
			StopFly()
			Notify("飞行", "飞行已关闭", 3)
		end
	end,
})
TabLocal:Toggle({
	Title = "手机端飞行",
	Desc = "右侧两个圆按钮控升降，摇杆控方向",
	Value = false,
	Callback = function(state)
		if state then
			StopFly()
			if StartFly(true) then
				Notify("飞行", "手机端飞行已开启：右侧 UP/DN 按钮", 4)
			end
		else
			StopFly()
			Notify("飞行", "飞行已关闭", 3)
		end
	end,
})
SafeAdd(TabLocal, "Slider", {
	Title = "飞行速度",
	Desc = "16 - 800",
	Value = { Min = 16, Max = 800, Default = 100 },
	Step = 4,
	Range = { 16, 800 },
	CurrentValue = 100,
	Callback = function(val)
		if type(val) == "number" then SV.FlySpeed = val end
	end,
})

--------------------------------------------------------------------------------
-- ESP
--------------------------------------------------------------------------------

local TeamCache = nil
local TeamCacheT = 0
local function HasTeams()
	local now = tick()
	if TeamCache ~= nil and (now - TeamCacheT) < 5 then return TeamCache end
	local res = false
	pcall(function()
		local seen = {}
		local n = 0
		for _, pl in ipairs(Players:GetPlayers()) do
			local t = pl.Team
			if t ~= nil then
				if seen[t] == nil then
					seen[t] = true
					n = n + 1
				end
			end
		end
		res = (n >= 2)
	end)
	TeamCache = res
	TeamCacheT = now
	return res
end

local function EspParent()
	local par = nil
	if gethui then pcall(function() par = gethui() end) end
	if not par then pcall(function() par = game:GetService("CoreGui") end) end
	if not par then par = LP:WaitForChild("PlayerGui") end
	return par
end

local function MakeEspGui()
	if SV.EspGui then return SV.EspGui end
	pcall(function()
		local g = Instance.new("ScreenGui")
		g.Name = "G2R5xEsp"
		g.ResetOnSpawn = false
		g.IgnoreGuiInset = true
		g.DisplayOrder = 2147483640
		g.Parent = EspParent()
		SV.EspGui = g
	end)
	return SV.EspGui
end

local function ClearEsp()
	for pl, o in pairs(SV.EspObjs) do
		pcall(function()
			if o.box then o.box:Destroy() end
			if o.name then o.name:Destroy() end
			if o.ray then o.ray:Destroy() end
		end)
	end
	SV.EspObjs = {}
end

local EspLastPos = {}
local function GetPartPos(pl)
	local c = pl.Character
	local r = nil
	if c then
		r = c:FindFirstChild("HumanoidRootPart") or c.PrimaryPart
	end
	if r then
		EspLastPos[pl] = { pos = r.Position, t = tick(), c = c }
		return r.Position, c
	end
	local rec = EspLastPos[pl]
	if rec and (tick() - rec.t) < 6 then
		return rec.pos, rec.c
	end
	return nil
end

local function EspStep()
	local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
	if not cam then return end
	local vp = cam.ViewportSize
	local seen = {}
	for _, pl in ipairs(Players:GetPlayers()) do
		if pl ~= LP then
			local pos, c = GetPartPos(pl)
			local hum = c and c:FindFirstChildOfClass("Humanoid")
			if pos and (not hum or hum.Health > 0) then
				local sp, onScreen = cam:WorldToViewportPoint(pos)
				local dist = math.floor((cam.CFrame.Position - pos).Magnitude)
				local isTeam = (pl.Team and LP.Team and pl.Team == LP.Team)
				if not SV.EspTeam and isTeam then
				elseif dist <= SV.EspDist then
					seen[pl] = true
					local o = SV.EspObjs[pl]
					if not o then
						o = {}
						local box = Instance.new("Frame", SV.EspGui)
						box.BackgroundTransparency = 1
						box.Size = UDim2.new(0, 60, 0, 90)
						pcall(function()
							local s1 = Instance.new("UIStroke", box)
							s1.Thickness = 1.5
							box:SetAttribute("stroke", true)
						end)
						local nm = Instance.new("TextLabel", SV.EspGui)
						nm.BackgroundTransparency = 1
						nm.Size = UDim2.new(0, 160, 0, 18)
						nm.TextXAlignment = Enum.TextXAlignment.Center
						nm.TextSize = 13
						nm.Font = Enum.Font.GothamBold
						nm.TextStrokeTransparency = 0.5
						local ray = Instance.new("Frame", SV.EspGui)
						ray.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						ray.BorderSizePixel = 0
						ray.AnchorPoint = Vector2.new(0, 0.5)
						ray.BackgroundTransparency = 0
						ray.Size = UDim2.new(0, 1, 0, SV.EspRayW)
						o.box = box
						o.name = nm
						o.ray = ray
						SV.EspObjs[pl] = o
					end
					seen[pl] = true
					local vis = onScreen
					local col
				if SV.EspColorMode == 1 then
					col = Color3.fromRGB(255, 210, 60)
				elseif SV.EspColorMode == 2 then
					if not HasTeams() then
						col = Color3.fromRGB(255, 210, 60)
					else
						col = isTeam and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 60, 60)
					end
				else
					if not HasTeams() then
						col = Color3.fromRGB(255, 210, 60)
					else
						col = isTeam and Color3.fromRGB(0, 255, 120) or Color3.fromRGB(255, 60, 60)
					end
				end
					local h = 90 * (1 / math.max(dist, 1) * 12)
					if h < 18 then h = 18 end
					if h > 260 then h = 260 end
					local w = h * 0.55
					o.box.Size = UDim2.new(0, w, 0, h)
					o.box.Position = UDim2.new(0, sp.X - w / 2, 0, sp.Y - h / 2)
					o.box.Visible = vis
					o.name.Visible = vis
					pcall(function()
						local st = o.box:FindFirstChildOfClass("UIStroke")
						if st then st.Color = col else
							o.box.BorderSizePixel = 2
							o.box.BorderColor3 = col
						end
					end)
					o.name.Text = pl.Name .. "  " .. tostring(dist) .. "m"
					o.name.TextColor3 = col
					o.name.Position = UDim2.new(0, sp.X - 80, 0, sp.Y - h / 2 - 16)
					if SV.EspRay then
						o.ray.Visible = true
						local bx = vp.X / 2
						local by = vp.Y
						local tx, ty = sp.X, sp.Y
						if not vis then
							local dx0 = sp.X - bx
							local dy0 = sp.Y - by
							local m = math.abs(dx0)
							local m2 = math.abs(dy0)
							local sc = 1
							if m > 0.001 or m2 > 0.001 then
								local sx = math.abs((vp.X * 0.5) / (dx0 ~= 0 and dx0 or 0.001))
								local sy = math.abs((vp.Y * 0.5) / (dy0 ~= 0 and dy0 or 0.001))
								sc = math.min(sx, sy)
							end
							tx = bx + dx0 * sc
							ty = by + dy0 * sc
						end
						local dx = tx - bx
						local dy = ty - by
						local len = math.sqrt(dx * dx + dy * dy)
						if len < 2 then len = 2 end
						o.ray.Size = UDim2.new(0, len, 0, SV.EspRayW)
						o.ray.Position = UDim2.new(0, bx, 0, by)
						o.ray.Rotation = math.deg(math.atan2(dy, dx))
						o.ray.BackgroundColor3 = col
						o.ray.BackgroundTransparency = vis and 0 or 0.35
					else
						o.ray.Visible = false
					end
				end
			end
		end
	end
	for pl, o in pairs(SV.EspObjs) do
		if not seen[pl] then
			pcall(function()
				o.box.Visible = false
				o.name.Visible = false
				o.ray.Visible = false
			end)
		end
	end
end

local function SetEsp(on)
	SV.EspOn = on
	if SV.EspConn then pcall(function() SV.EspConn:Disconnect() end) SV.EspConn = nil end
	if not on then
		ClearEsp()
		if SV.EspGui then pcall(function() SV.EspGui:Destroy() end) SV.EspGui = nil end
		return
	end
	MakeEspGui()
	SV.EspConn = RS.Heartbeat:Connect(function()
		if not SV.EspOn then return end
		pcall(EspStep)
	end)
end

---------------------------------------------------------------------------------
-- 娱乐
--------------------------------------------------------------------------------
local TabFun = SafeTab({ Title = "娱乐", Icon = "gamepad-2" })
for _, e in ipairs(SCRIPT_LIB) do
	if e.cat == "娱乐" then
		SafeAdd(TabFun, "Button", {
			Title = e.name,
			Desc = e.desc or "点击执行",
			Callback = function()
				RunScript(e)
			end,
		})
	end
end
for _, e in ipairs(FUN_LIB) do
	SafeAdd(TabFun, "Button", {
		Title = e.name,
		Desc = e.desc or "点击执行",
		Callback = function()
			RunScript(e)
		end,
	})
end

--------------------------------------------------------------------------------
-- 娱乐功能（纯本地视觉/动画，不改服务端数据）
--------------------------------------------------------------------------------
local function FunStop(key)
	if SV.FunConns[key] then pcall(function() SV.FunConns[key]:Disconnect() end) end
	SV.FunConns[key] = nil
end
local function FunRun(key, fn)
	FunStop(key)
	pcall(function() SV.FunConns[key] = fn() end)
end

local function PartList()
	local c = LP.Character
	if not c then return {} end
	local out = {}
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("BasePart") then out[#out + 1] = d end
	end
	return out
end

local BODY_NAMES = {
	Head = 1, Torso = 1, UpperTorso = 1, LowerTorso = 1,
	LeftArm = 1, RightArm = 1, LeftUpperArm = 1, RightUpperArm = 1,
	LeftLowerArm = 1, RightLowerArm = 1, LeftHand = 1, RightHand = 1,
	LeftLeg = 1, RightLeg = 1, LeftUpperLeg = 1, RightUpperLeg = 1,
	LeftLowerLeg = 1, RightLowerLeg = 1, LeftFoot = 1, RightFoot = 1,
	HumanoidRootPart = 1,
}
local function BodyParts(c)
	local out = {}
	for _, d in ipairs(c:GetDescendants()) do
		if d:IsA("BasePart") and BODY_NAMES[d.Name] then
			out[#out + 1] = d
		end
	end
	return out
end

local RainbowSaved = nil
local function SetRainbow(on)
	SV.RainbowOn = on
	if not on then
		FunStop("rainbow")
		pcall(function()
			if RainbowSaved then
				for p, c in pairs(RainbowSaved) do
					pcall(function() p.Color = c end)
				end
				RainbowSaved = nil
			end
		end)
		return
	end
	pcall(function()
		local c = LP.Character
		if not c then return end
		RainbowSaved = {}
		for _, p in ipairs(BodyParts(c)) do
			RainbowSaved[p] = p.Color
		end
	end)
	FunRun("rainbow", function()
		local t = 0
		return RS.Heartbeat:Connect(function(dt)
			if not SV.RainbowOn then return end
			t = (t + dt * 0.6) % 1
			local col = Color3.fromHSV(t, 1, 1)
			pcall(function()
				local c = LP.Character
				if not c then return end
				for _, p in ipairs(BodyParts(c)) do
					pcall(function() p.Color = col end)
				end
			end)
		end)
	end)
end

local function SetSpin(on)
	SV.SpinOn = on
	if not on then FunStop("spin") return end
	FunRun("spin", function()
		return RS.Heartbeat:Connect(function()
			if not SV.SpinOn then return end
			pcall(function()
				local r = GetRoot()
				if r then r.CFrame = r.CFrame * CFrame.Angles(0, math.rad(9), 0) end
			end)
		end)
	end)
end

local function SetBigHead(on)
	SV.HeadOn = on
	if not on then
		FunStop("head")
		pcall(function()
			if SV.HeadSaved then
				for p, s in pairs(SV.HeadSaved) do
					pcall(function() p.Size = s end)
				end
				SV.HeadSaved = nil
			end
		end)
		return
	end
	pcall(function()
		local c = LP.Character
		if not c then return end
		SV.HeadSaved = {}
		local head = c:FindFirstChild("Head")
		if head then
			SV.HeadSaved[head] = head.Size
			head.Size = head.Size * 3
		end
		for _, d in ipairs(c:GetDescendants()) do
			if d:IsA("SpecialMesh") or d:IsA("BlockMesh") then
				if d.Parent and d.Parent.Name == "Head" then
					SV.HeadSaved[d] = d.Scale
					d.Scale = d.Scale * 3
				end
			end
		end
	end)
	FunRun("head", function()
		return RS.Heartbeat:Connect(function()
			if not SV.HeadOn then return end
			pcall(function()
				local c = LP.Character
				if not c then return end
				local head = c:FindFirstChild("Head")
				if head and head.Size.Magnitude < 3 then
					head.Size = Vector3.new(2, 1, 1) * 3
				end
			end)
		end)
	end)
end

local function SetGhost(on)
	SV.GhostOn = on
	if not on then
		FunStop("ghost")
		pcall(function()
			if SV.GhostSaved then
				for p, v in pairs(SV.GhostSaved) do
					pcall(function() p.Transparency = v end)
				end
				SV.GhostSaved = nil
			end
		end)
		return
	end
	pcall(function()
		SV.GhostSaved = {}
		for _, p in ipairs(PartList()) do
			SV.GhostSaved[p] = p.Transparency
			p.Transparency = 0.75
		end
	end)
	FunRun("ghost", function()
		return RS.Heartbeat:Connect(function()
			if not SV.GhostOn then return end
			pcall(function()
				for _, p in ipairs(PartList()) do
					if p.Transparency < 0.5 then p.Transparency = 0.75 end
				end
			end)
		end)
	end)
end

local FloatBase = nil
local function SetFloat(on)
	SV.FloatOn = on
	if not on then
		FunStop("float")
		pcall(function()
			local h = GetHum()
			if h then h.PlatformStand = false end
			local r = GetRoot()
			if r and FloatBase then
				r.CFrame = CFrame.new(r.Position.X, FloatBase, r.Position.Z)
			end
		end)
		FloatBase = nil
		return
	end
	pcall(function()
		local r = GetRoot()
		if r then FloatBase = r.Position.Y + 3 end
	end)
	FunRun("float", function()
		local t = 0
		return RS.Heartbeat:Connect(function(dt)
			if not SV.FloatOn then return end
			t = t + dt
			pcall(function()
				local r = GetRoot()
				if not r then return end
				if not FloatBase then FloatBase = r.Position.Y + 3 end
				local cur = r.AssemblyLinearVelocity
				r.AssemblyLinearVelocity = Vector3.new(cur.X, 0, cur.Z)
				r.CFrame = CFrame.new(
					r.Position.X,
					FloatBase + math.sin(t * 2.2) * 1.2,
					r.Position.Z
				) * (r.CFrame - r.CFrame.Position)
			end)
		end)
	end)
end

local DANCE_IDS = { "rbxassetid://507771019", "rbxassetid://507776043", "rbxassetid://507770818" }
local function StopDance()
	if SV.DanceTrack then pcall(function() SV.DanceTrack:Stop() end) end
	SV.DanceTrack = nil
end
local function SetDance(on)
	SV.DanceOn = on
	StopDance()
	FunStop("dance")
	if not on then return end
	local function play()
		pcall(function()
			local h = GetHum()
			if not h then return end
			local an = Instance.new("Animation")
			an.AnimationId = DANCE_IDS[SV.DanceIdx]
			local tr = h:LoadAnimation(an)
			tr.Looped = true
			tr:Play()
			SV.DanceTrack = tr
		end)
	end
	play()
	FunRun("dance", function()
		return RS.Heartbeat:Connect(function()
			if not SV.DanceOn then return end
			if not SV.DanceTrack then return end
			pcall(function()
				if not SV.DanceTrack.IsPlaying then SV.DanceTrack:Play() end
			end)
		end)
	end)
end

local EMOTE_IDS = {
	{ n = "挥手", id = "rbxassetid://507770239" },
	{ n = "指", id = "rbxassetid://507770453" },
	{ n = "大笑", id = "rbxassetid://507770818" },
	{ n = "坐下", id = "rbxassetid://2506281703" },
	{ n = "啦啦队", id = "rbxassetid://507771955" },
	{ n = "庆祝", id = "rbxassetid://507771019" },
	{ n = "耸肩", id = "rbxassetid://507770818" },
}
local function PlayEmote(id)
	local ok = false
	pcall(function()
		if SV.EmoteTrack then pcall(function() SV.EmoteTrack:Stop() end) end
		local h = GetHum()
		if not h then return end
		if type(id) ~= "string" then return end
		if not string.find(id, "rbxassetid") then
			if not string.find(id, "%d") then return end
			id = "rbxassetid://" .. tostring(id):match("%d+")
		end
		local an = Instance.new("Animation")
		an.AnimationId = id
		local tr = h:LoadAnimation(an)
		tr:Play()
		SV.EmoteTrack = tr
		ok = true
	end)
	if not ok then Notify("动作", "播放失败，游戏可能不支持", 3) end
end

local function SetBounce(on)
	SV.BounceOn = on
	if not on then FunStop("bounce") return end
	FunRun("bounce", function()
		return RS.Heartbeat:Connect(function()
			if not SV.BounceOn then return end
			pcall(function()
				local h = GetHum()
				local r = GetRoot()
				if not (h and r) then return end
				if IsGrounded(h) then
					r.AssemblyLinearVelocity = Vector3.new(
						r.AssemblyLinearVelocity.X, 60, r.AssemblyLinearVelocity.Z
					)
				end
			end)
		end)
	end)
end

local SndObj = nil
local function PlaySoundId(id, vol)
	local ok = false
	pcall(function()
		if SndObj then pcall(function() SndObj:Stop() SndObj:Destroy() end) end
		SndObj = nil
		local n = tonumber(tostring(id):match("%d+"))
		if not n then return end
		local snd = Instance.new("Sound")
		snd.SoundId = "rbxassetid://" .. tostring(n)
		snd.Volume = vol or 1
		snd.Looped = false
		snd.Parent = SoundService or LP:WaitForChild("PlayerGui")
		local waited = 0
		while not snd.IsLoaded and waited < 6 do
			task.wait(0.25)
			waited = waited + 0.25
		end
		if not snd.IsLoaded then
			snd:Destroy()
			return
		end
		snd:Play()
		SndObj = snd
		ok = true
		task.delay(math.max(snd.TimeLength, 1) + 1, function()
			pcall(function() if SndObj == snd then snd:Destroy() SndObj = nil end end)
		end)
	end)
	if not ok then Notify("音效", "播放失败，ID 可能无效或未过审", 3) end
end

SafeAdd(TabFun, "Section", { Title = "ESP" })
TabFun:Toggle({
	Title = "启用 ESP",
	Desc = "方框 + 名字 + 距离 + 射线",
	Value = false,
	Callback = function(state)
		SetEsp(state)
	end,
})
TabFun:Toggle({
	Title = "显示队友",
	Value = true,
	Callback = function(state)
		SV.EspTeam = state
	end,
})
TabFun:Toggle({
	Title = "显示射线",
	Value = true,
	Callback = function(state)
		SV.EspRay = state
	end,
})
SafeAdd(TabFun, "Dropdown", {
	Title = "ESP 颜色",
	Desc = "无队伍游戏一律中性黄，不会瞎标红",
	Values = { "自动识别", "统一黄色", "队友绿/敌人红" },
	Value = "自动识别",
	Multi = false,
	AllowNone = false,
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		local map = { ["自动识别"] = 0, ["统一黄色"] = 1, ["队友绿/敌人红"] = 2 }
		if map[pick] then SV.EspColorMode = map[pick] end
	end,
})
SafeAdd(TabFun, "Slider", {
	Title = "射线粗细",
	Desc = "1 - 6 像素",
	Value = { Min = 1, Max = 6, Default = 2 },
	Step = 1,
	Range = { 1, 6 },
	CurrentValue = 2,
	Callback = function(val)
		if type(val) == "number" then SV.EspRayW = val end
	end,
})
SafeAdd(TabFun, "Slider", {
	Title = "ESP 最远距离",
	Value = { Min = 50, Max = 2000, Default = 500 },
	Step = 50,
	Range = { 50, 2000 },
	CurrentValue = 500,
	Callback = function(val)
		if type(val) == "number" then SV.EspDist = val end
	end,
})

SafeAdd(TabFun, "Section", { Title = "视觉娱乐" })
TabFun:Toggle({
	Title = "彩虹角色",
	Desc = "身体循环变色",
	Value = false,
	Callback = function(state) SetRainbow(state) end,
})
TabFun:Toggle({
	Title = "自旋转",
	Desc = "原地鬼畜转圈",
	Value = false,
	Callback = function(state) SetSpin(state) end,
})
TabFun:Toggle({
	Title = "大头模式",
	Value = false,
	Callback = function(state) SetBigHead(state) end,
})
TabFun:Toggle({
	Title = "幽灵半透明",
	Desc = "自己变半透明",
	Value = false,
	Callback = function(state) SetGhost(state) end,
})
TabFun:Toggle({
	Title = "悬浮摇摆",
	Desc = "离地上下浮动",
	Value = false,
	Callback = function(state) SetFloat(state) end,
})
TabFun:Toggle({
	Title = "跳舞",
	Desc = "循环播放舞蹈动画",
	Value = false,
	Callback = function(state) SetDance(state) end,
})
SafeAdd(TabFun, "Dropdown", {
	Title = "舞蹈切换",
	Values = { "舞蹈一", "舞蹈二", "舞蹈三" },
	Value = "舞蹈一",
	Multi = false,
	AllowNone = false,
	Callback = function(op)
		local pick = op
		if type(op) == "table" then pick = op[1] or op.Value end
		local map = { ["舞蹈一"] = 1, ["舞蹈二"] = 2, ["舞蹈三"] = 3 }
		if map[pick] then
			SV.DanceIdx = map[pick]
			if SV.DanceOn then SetDance(true) end
		end
	end,
})
TabFun:Toggle({
	Title = "弹簧蹦跳",
	Desc = "落地自动弹起",
	Value = false,
	Callback = function(state) SetBounce(state) end,
})
SafeAdd(TabFun, "Section", { Title = "表情动作" })
for _, it in ipairs(EMOTE_IDS) do
	SafeAdd(TabFun, "Button", {
		Title = it.n,
		Desc = "播放动作",
		Callback = function() PlayEmote(it.id) end,
	})
end
SafeAdd(TabFun, "Input", {
	Title = "自定义动作 ID",
	Desc = "输入动画 ID，回车播放",
	Placeholder = "例如 507770239",
	Callback = function(txt)
		pcall(function()
			local n = tostring(txt):match("%d+")
			if n then PlayEmote(n) end
		end)
	end,
})
SafeAdd(TabFun, "Section", { Title = "音效" })
SafeAdd(TabFun, "Input", {
	Title = "播放音效",
	Desc = "输入音频 ID，回车播放",
	Placeholder = "例如 9118823106",
	Callback = function(txt)
		pcall(function()
			local n = tonumber(tostring(txt):match("%d+"))
			if n then
				PlaySoundId(n, 1)
				Notify("音效", "已播放", 3)
			end
		end)
	end,
})

--------------------------------------------------------------------------------
-- 关于
--------------------------------------------------------------------------------
LP.CharacterAdded:Connect(function()
	task.wait(1.2)
	pcall(function()
		if SV.ModOn then
			SV.IJAir = 0
			if SV.JumpMode == 1 or SV.JumpMode == 2 then DoJump() else DoJump() end
			DoSpeed()
			if SV.SpeedAuto or SV.JumpAuto then AutoWatch() end
		end
		if SV.IJOn then StopIJ() DoIJ() end
		if SV.NCOn then
			SV.NCSaved = {}
			SV.NCLastSafe = nil
			task.wait(0.3)
			RecordSafe()
			DoNC()
		end
		if SV.FlyOn then
			local mb = SV.FlyMobile
			StopFly()
			task.wait(0.4)
			StartFly(mb)
		end
	end)
end)

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
-- 最近运行（默认最多 10 条，可设置）
--------------------------------------------------------------------------------
task.spawn(function()
	local saved = SV.FS.Load("recent")
	if type(saved) == "table" then
		for _, it in ipairs(saved) do
			local nm = it
			if type(it) == "table" then nm = it.name end
			if type(nm) == "string" then
				local hit = nil
				for _, e in ipairs(SCRIPT_LIB) do
					if e.name == nm then hit = e break end
				end
				if not hit then
					for _, e in ipairs(FUN_LIB) do
						if e.name == nm then hit = e break end
					end
				end
				if hit then
					if not hit.cat then hit.cat = "娱乐" end
					local dup = false
					for _, x in ipairs(SV.RECENT) do
						if x.name == nm then dup = true break end
					end
					if not dup then SV.RECENT[#SV.RECENT + 1] = hit end
				end
			end
			if #SV.RECENT >= (CFG.recentMax or 10) then break end
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
	if #SV.RECENT == 0 then
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
	for idx, e in ipairs(SV.RECENT) do
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
	for i = #SV.RECENT, 1, -1 do
		if SV.RECENT[i].name == entry.name then table.remove(SV.RECENT, i) end
	end
	table.insert(SV.RECENT, 1, entry)
	local cap = CFG.recentMax or 10
	while #SV.RECENT > cap do table.remove(SV.RECENT, #SV.RECENT) end
	local names = {}
	for _, e in ipairs(SV.RECENT) do names[#names + 1] = e.name end
	SV.FS.Save("recent", names)
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
		local pool = {}
		for _, e in ipairs(SCRIPT_LIB) do pool[#pool + 1] = e end
		for _, e in ipairs(FUN_LIB) do
			if not e.cat then e.cat = "娱乐" end
			pool[#pool + 1] = e
		end
		for _, e in ipairs(pool) do
			local sc = ScoreMatch(e.name, q)
			if sc then hits[#hits + 1] = { e = e, sc = sc } end
		end
		table.sort(hits, function(a, b) return a.sc < b.sc end)
		if CFG.searchShowAll == false and #hits > 8 then
			local cut = {}
			for i = 1, 8 do cut[i] = hits[i] end
			hits = cut
		end
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
		pcall(function() SV.WindUI:SetTheme(CFG.theme) end)
		SaveCfg()
	end,
})
local AutoFitOn = (CFG.autoFit ~= false)

local function Viewport()
	local cam = WS:FindFirstChild("Camera") or WS.CurrentCamera
	if cam then return cam.ViewportSize end
	return Vector2.new(1280, 720)
end

local function AllUIScale()
	local out = {}
	pcall(function()
		if SV.WindUI and SV.WindUI.ScreenGui then
			local us = SV.WindUI.ScreenGui:FindFirstChild("UIScale")
			if us then out[#out + 1] = us end
		end
	end)
	pcall(function()
		if SV.WindUI and SV.WindUI.NotificationGui then
			local us = SV.WindUI.NotificationGui:FindFirstChild("UIScale")
			if us then out[#out + 1] = us end
		end
	end)
	pcall(function()
		if SV.WindUI and SV.WindUI.DropdownGui then
			local us = SV.WindUI.DropdownGui:FindFirstChild("UIScale")
			if us then out[#out + 1] = us end
		end
	end)
	pcall(function()
		if Window and Window.UIElements and Window.UIElements.Main then
			local us = Window.UIElements.Main:FindFirstChild("UIScale")
			if us then out[#out + 1] = us end
		end
	end)
	if #out == 0 then
		pcall(function()
			for _, g in ipairs(LP.PlayerGui:GetChildren()) do
				if g:IsA("ScreenGui") and (g.Name == "WindUI" or g.Name:find("WindUI")) then
					local us = g:FindFirstChild("UIScale")
					if us then out[#out + 1] = us end
				end
			end
		end)
	end
	return out
end

local function CollectScaleTargets()
	local out = {}
	local seen = {}
	local function add(us)
		if us and us:IsA("UIScale") and not seen[us] then
			seen[us] = true
			out[#out + 1] = us
		end
	end
	pcall(function()
		if SV.WindUI and SV.WindUI.ScreenGui then add(SV.WindUI.ScreenGui:FindFirstChildWhichIsA("UIScale")) end
	end)
	pcall(function()
		if SV.WindUI and SV.WindUI.NotificationGui then add(SV.WindUI.NotificationGui:FindFirstChildWhichIsA("UIScale")) end
	end)
	pcall(function()
		if SV.WindUI and SV.WindUI.DropdownGui then add(SV.WindUI.DropdownGui:FindFirstChildWhichIsA("UIScale")) end
	end)
	pcall(function()
		local roots = {}
		if gethui then pcall(function() roots[#roots + 1] = gethui() end) end
		pcall(function() roots[#roots + 1] = game:GetService("CoreGui") end)
		pcall(function() roots[#roots + 1] = LP:FindFirstChild("PlayerGui") end)
		for _, root in ipairs(roots) do
			if root then
				for _, d in ipairs(root:GetDescendants()) do
					if d:IsA("UIScale") and (d.Name == "G2R5xScale" or d.Name == "UIScale") then
						local p = d.Parent
						local isWin = false
						pcall(function()
							if p and (p.Name == "WindUI" or tostring(p.Name):find("WindUI")) then isWin = true end
						end)
						if isWin or d.Name == "G2R5xScale" then add(d) end
					end
				end
			end
		end
	end)
	return out
end

local function EnsureOwnScale()
	local own = nil
	pcall(function()
		if Window and Window.UIElements and Window.UIElements.Main then
			local main = Window.UIElements.Main
			own = main:FindFirstChild("G2R5xScale")
			if not own then
				own = Instance.new("UIScale")
				own.Name = "G2R5xScale"
				own.Scale = 1
				own.Parent = main
			end
		end
	end)
	return own
end

local function RawSetScale(v)
	local own = EnsureOwnScale()
	local targets = CollectScaleTargets()
	local n = 0
	for _, us in ipairs(targets) do
		pcall(function()
			us.Scale = v
			n = n + 1
		end)
	end
	pcall(function()
		if SV.WindUI then SV.WindUI.UIScale = v end
	end)
	pcall(function()
		if Window and Window.SetUIScale then Window:SetUIScale(v) end
	end)
	if own then
		pcall(function() own.Scale = 1 end)
	else
		pcall(function()
			if Window and Window.SetUIScale then Window:SetUIScale(v) end
		end)
	end
	return n
end

local function RawSetScaleRetry(v)
	RawSetScale(v)
	task.spawn(function()
		task.wait(0.25)
		pcall(function() RawSetScale(v) end)
		task.wait(0.45)
		pcall(function() RawSetScale(v) end)
	end)
end

local BaseW, BaseH = nil, nil

local function MeasureBase()
	pcall(function()
		if Window and Window.UIElements and Window.UIElements.Main then
			local a = Window.UIElements.Main.AbsoluteSize
			local cur = CFG.scale or 1
			if cur <= 0 then cur = 1 end
			if a.X > 2 and a.Y > 2 then
				BaseW = a.X / cur
				BaseH = a.Y / cur
			end
		end
	end)
	if (not BaseW) or (not BaseH) or BaseW < 40 or BaseH < 40 then
		BaseW = nil
		BaseH = nil
	end
end

local HardMax = SV.SCALE_MAX

local function DynMax()
	MeasureBase()
	if not BaseW or not BaseH then return HardMax end
	local vp = Viewport()
	local mx = (vp.X * 0.94) / BaseW
	local my = (vp.Y * 0.94) / BaseH
	local m = math.floor(math.min(mx, my) * 100)
	if m < SV.SCALE_MIN then m = SV.SCALE_MIN end
	if m > HardMax then m = HardMax end
	return m
end

local function ClampScale(v, force)
	v = tonumber(v) or 100
	if force then
		if v < SV.SCALE_MIN then v = SV.SCALE_MIN end
		if v > HardMax then v = HardMax end
		return v
	end
	local mx = DynMax()
	if v < SV.SCALE_MIN then v = SV.SCALE_MIN end
	if v > mx then v = mx end
	return v
end


local function ApplyScale(pct, quiet, force)
	pct = ClampScale(pct, force)
	CFG.scale = pct / 100
	local n = RawSetScale(CFG.scale)
	RawSetScaleRetry(CFG.scale)
	SaveCfg()
	if not quiet then
		if tick() - SV.LastScaleMsg > 0.4 then
			SV.LastScaleMsg = tick()
			Notify("界面大小", "已设为 " .. tostring(pct) .. "%", 3)
		end
	end
	if n == 0 then
		Notify("界面大小", "UI 缩放未生效，请重进或换版本", 5)
	end
	return n
end



local function MakeRescueBtn()
	local ok = pcall(function()
		local parent = nil
		if gethui then pcall(function() parent = gethui() end) end
		if not parent then pcall(function() parent = game:GetService("CoreGui") end) end
		if not parent then parent = LP:WaitForChild("PlayerGui") end

		local g = Instance.new("ScreenGui")
		g.Name = "G2R5xRescue"
		g.ResetOnSpawn = false
		g.IgnoreGuiInset = true
		g.DisplayOrder = 2147483647
		g.Parent = parent

		local b = Instance.new("TextButton", g)
		b.Name = "Btn"
		b.Size = UDim2.new(0, 52, 0, 52)
		b.Position = UDim2.new(0, 6, 0.5, -26)
		b.BackgroundColor3 = Color3.fromRGB(196, 44, 44)
		b.BackgroundTransparency = 0.15
		b.Text = "100%"
		b.TextColor3 = Color3.fromRGB(255, 255, 255)
		b.TextSize = 15
		b.Font = Enum.Font.GothamBold
		b.Active = true
		b.Draggable = false
		pcall(function()
			local c = Instance.new("UICorner", b)
			c.CornerRadius = UDim.new(0, 26)
		end)
		pcall(function()
			local st = Instance.new("UIStroke", b)
			st.Color = Color3.fromRGB(255, 255, 255)
			st.Thickness = 1.5
			st.Transparency = 0.5
		end)

		local dragging, dragStart, startPos = false, nil, nil
		b.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1
				or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = b.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then dragging = false end
				end)
			end
		end)
		UIS.InputChanged:Connect(function(input)
			if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
				or input.UserInputType == Enum.UserInputType.Touch) then
				local delta = input.Position - dragStart
				b.Position = UDim2.new(
					startPos.X.Scale, startPos.X.Offset + delta.X,
					startPos.Y.Scale, startPos.Y.Offset + delta.Y
				)
			end
		end)

		local tapped = 0
		b.MouseButton1Click:Connect(function()
			if tick() - tapped < 0.05 then return end
			tapped = tick()
			ApplyScale(100, false, true)
			pcall(function()
				if SetCfg then end
			end)
			Notify("界面大小", "已强制恢复 100%", 4)
		end)

		SV.RescueBtn = g
	end)
	return ok
end

local function SetRescue(on)
	if on then
		if not SV.RescueBtn then MakeRescueBtn() end
	else
		if SV.RescueBtn then
			pcall(function() SV.RescueBtn:Destroy() end)
			SV.RescueBtn = nil
		end
	end
end

local function FitScale()
	MeasureBase()
	if not BaseW or not BaseH then return nil end
	local cur = math.floor((CFG.scale or 1) * 100)
	local w = (BaseW * (CFG.scale or 1))
	local h = (BaseH * (CFG.scale or 1))
	local vp = Viewport()
	local over = math.max(w / vp.X, h / vp.Y)
	if over <= 0.94 then return nil end
	local fit = math.floor(cur / over * 0.9)
	if fit < SV.SCALE_MIN then fit = SV.SCALE_MIN end
	local mxp = DynMax()
	if fit > mxp then fit = mxp end
	if fit >= cur then return nil end
	return fit
end

task.spawn(function()
	task.wait(3)
	while true do
		task.wait(2.5)
		if AutoFitOn then
			if CFG.lowPerf then task.wait(4) end
			pcall(function()
				local fit = FitScale()
				if fit then
					ApplyScale(fit, true)
					Notify("界面大小", "超出屏幕，已自动调整为 " .. tostring(fit) .. "%", 4)
					task.wait(3)
				end
			end)
		end
	end
end)

SafeAdd(TabSet, "Section", { Title = "界面大小" })
SafeAdd(TabSet, "Input", {
	Title = "缩放百分比",
	Desc = "输入数字后回车（" .. tostring(SV.SCALE_MIN) .. " - " .. tostring(SV.SCALE_MAX) .. "，超出屏幕会自动收小）",
	Placeholder = "例如 100",
	Value = tostring(math.floor((CFG.scale or 1) * 100)),
	InputIcon = "percent",
	Type = "Input",
	Callback = function(txt)
		local n = tonumber(tostring(txt or ""))
		if not n then
			Notify("界面大小", "请输入数字，例如 100", 3)
			return
		end
		ApplyScale(n, false, true)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "恢复 100%",
	Desc = "强制回到 100%，不受自动限制影响",
	Icon = "rotate-ccw",
	Callback = function()
		ApplyScale(100, false, true)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "缩小一档",
	Desc = "当前基础上 -10%",
	Callback = function()
		ApplyScale(math.floor((CFG.scale or 1) * 100) - 10, false, true)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "放大一档",
	Desc = "当前基础上 +10%",
	Callback = function()
		ApplyScale(math.floor((CFG.scale or 1) * 100) + 10, false, true)
	end,
})
SafeAdd(TabSet, "Button", {
	Title = "适应屏幕",
	Desc = "自动算出刚好不超出屏幕的大小",
	Icon = "maximize",
	Callback = function()
		MeasureBase()
		if not BaseW then
			Notify("界面大小", "还没量到窗口尺寸，稍等再试", 4)
			return
		end
		local mxp = DynMax()
		ApplyScale(mxp, false, true)
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "自动调节界面大小",
	Desc = "只在界面超出屏幕时自动收小，不会乱改你的设置",
	Value = true,
	Value = AutoFitOn,
	Callback = function(state)
		AutoFitOn = state
		CFG.autoFit = state
		SaveCfg()
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
			if v == pick then CFG.introStyle = i SV.INTRO_STYLE = i end
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
SafeAdd(TabSet, "Section", { Title = "界面与提示" })
SafeAdd(TabSet, "Toggle", {
	Title = "界面透明",
	Desc = "窗口背景半透明",
	Value = CFG.transparency,
	Callback = function(state)
		CFG.transparency = state
		SaveCfg()
		pcall(function()
			if Window and Window.ToggleTransparency then Window:ToggleTransparency(state) end
		end)
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "侧边栏",
	Desc = "关闭后隐藏左侧标签栏",
	Value = CFG.sideBar,
	Callback = function(state)
		CFG.sideBar = state
		SaveCfg()
		pcall(function()
			if Window and Window.UIElements and Window.UIElements.SideBar then
				Window.UIElements.SideBar.Frame.Visible = state
			end
		end)
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "通知音效",
	Desc = "弹通知时带一声提示音",
	Value = CFG.notifSound,
	Callback = function(state)
		CFG.notifSound = state
		SaveCfg()
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "紧急恢复按钮",
	Desc = "屏幕左边的小红球，界面调到看不见时点它恢复 100%",
	Value = CFG.rescue ~= false,
	Callback = function(state)
		CFG.rescue = state
		SaveCfg()
		SetRescue(state)
		Notify("设置", state and "紧急按钮已显示" or "紧急按钮已隐藏", 3)
	end,
})

SafeAdd(TabSet, "Section", { Title = "脚本行为" })
SafeAdd(TabSet, "Toggle", {
	Title = "执行前确认",
	Desc = "点脚本时先弹一次确认，防止误触",
	Value = CFG.confirmBeforeRun,
	Callback = function(state)
		CFG.confirmBeforeRun = state
		SaveCfg()
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "运行后自动关闭界面",
	Desc = "执行完脚本把窗口收起来",
	Value = CFG.autoHideAfterRun,
	Callback = function(state)
		CFG.autoHideAfterRun = state
		SaveCfg()
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "低性能模式",
	Desc = "减少后台扫描，机器卡时打开",
	Value = CFG.lowPerf,
	Callback = function(state)
		CFG.lowPerf = state
		SaveCfg()
	end,
})
SafeAdd(TabSet, "Slider", {
	Title = "最近记录上限",
	Desc = "最多保留几条最近运行",
	Value = { Min = 1, Max = 20, Default = CFG.recentMax },
	Step = 1,
	Range = { 1, 20 },
	CurrentValue = CFG.recentMax,
	Callback = function(val)
		if type(val) == "number" then
			CFG.recentMax = val
			SaveCfg()
			while #SV.RECENT > CFG.recentMax do table.remove(SV.RECENT, #SV.RECENT) end
			local ns = {}
			for _, e in ipairs(SV.RECENT) do ns[#ns + 1] = e.name end
			SV.FS.Save("recent", ns)
			pcall(RefreshRecent)
		end
	end,
})
SafeAdd(TabSet, "Toggle", {
	Title = "搜索显示全部",
	Desc = "关闭后只显示前 8 条结果",
	Value = CFG.searchShowAll,
	Callback = function(state)
		CFG.searchShowAll = state
		SaveCfg()
	end,
})

SafeAdd(TabSet, "Button", {
	Title = "清空最近记录",
	Desc = "删除本地保存的最近运行",
	Callback = function()
		SV.RECENT = {}
		SV.FS.Save("recent", {})
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
		CFG.transparency = false
		CFG.autoFit = true
		CFG.notifSound = true
		CFG.confirmBeforeRun = false
		CFG.recentMax = 10
		CFG.searchShowAll = true
		CFG.autoHideAfterRun = false
		CFG.lowPerf = false
		CFG.sideBar = true
		CFG.rescue = true
		SV.INTRO_STYLE = 1
		AutoFitOn = true
		SaveCfg()
		pcall(function() if SV.WindUI and SV.WindUI.SetTheme then SV.WindUI:SetTheme("Dark") end end)
		pcall(function()
			if Window and Window.ToggleTransparency then Window:ToggleTransparency(false) end
		end)
		ApplyScale(100, false, true)
		SetRescue(true)
		Notify("设置", "已恢复默认并应用", 4)
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

task.spawn(function()
	task.wait(1.5)
	if CFG.rescue ~= false then pcall(MakeRescueBtn) end
end)

pcall(function()
	getgenv().G2R5X = {
		Lib = SCRIPT_LIB,
		Recent = SV.RECENT,
		Run = RunScript,
		Scale = function(v) return ApplyScale(v, false, true) end,
		Rescue = function(v) SetRescue(v ~= false) end,
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
			elseif SV.WindUI and SV.WindUI.ScreenGui then
				local us = SV.WindUI.ScreenGui:FindFirstChild("UIScale")
				if us then us.Scale = CFG.scale end
			end
		end)
	end
end)

Notify("G2R5x 脚本中心", "加载完成", CFG.notifDur or 5)
