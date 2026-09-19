local Players = game:GetService("Players")
local Run = game:GetService("RunService")
local WS = game:GetService("Workspace")
local SG = game:GetService("StarterGui")
local LP = Players.LocalPlayer
local LIT = game:GetService("Lighting")

local NORM_CACHE = setmetatable({}, { __mode = "kv" })
local function Norm(s)
	if s == nil then return "" end
	if type(s) == "string" then
		local c = NORM_CACHE[s]
		if c ~= nil then return c end
	end
	local t = string.lower(tostring(s))
	local r = string.gsub(t, "[%s_%-]", "")
	if type(s) == "string" then NORM_CACHE[s] = r end
	return r
end

local EnsureUI

local CFG = {
	Tick = 1.5,
	TempTick = 1.0,
	MaxMark = 40,
	FreezePoint = 0,
	ItemColor = Color3.fromRGB(0, 170, 255),
	CursedColor = Color3.fromRGB(255, 60, 200),
	GhostColor = Color3.fromRGB(255, 220, 60),
	RoomColor = Color3.fromRGB(255, 180, 60),
	ExitColor = Color3.fromRGB(120, 255, 120),
	HideColor = Color3.fromRGB(160, 120, 255),
	MateColor = Color3.fromRGB(80, 255, 200),
	HuntColor = Color3.fromRGB(255, 40, 40),
	On = { Items = true, Cursed = true, Ghost = true, Temp = true, Bright = true, Dead = true,
		Hunt = true, Exit = true, Hide = true, Mate = true, Room = true, BigOutline = true, BigGlow = true,
		AutoJournal = true, Flash = true, Nav = true, Fuse = true, FPS = true, AutoPick = false },
	HuntThreshold = 50,
	HuntCooldown = 3,
	HuntTimeout = 75,
	DeadHelp = true,
	CursedWarn = 35,
	NavMax = 6,
	LowFPS = 20,
	FillAlpha = 0.25,
	GlowScale = 1.6,
	GlowAlpha = 0.55,
	BoxThick = 0.08,
	Bright = { Ambient = 1, Outdoor = 1, Brightness = 2.2, FogEnd = 100000,
		ClockTime = 13, Shadows = false, Exposure = 0 },
	MusicId = 124384558101360,
	MusicVolume = 0.5,
	ColdTick = 4,
	ScanBudget = 400,
	ScanDepth = 3,
	RoomScanBudget = 30,
	RoomPerTick = 2,
}

local ITEM_WORDS = "能量饮料 能量表 好运硬币 命运硬币 幸运币 硬币 护身符 除颤器 圣油 十字架 提灯 打火机 蜡烛 相机 玩偶 雷达 头戴摄像机 盐罐 盐弹枪 荧光棒 三脚架 熏香 圣木 预言票 命运票 点火器"
local ITEMS = {}
for w in string.gmatch(ITEM_WORDS, "%S+") do ITEMS[w] = w end
ITEMS["能量手表"] = "能量表"
ITEMS["幸运硬币"] = "好运硬币"
ITEMS["命运硬币"] = "好运硬币"
ITEMS["照相相机"] = "相机"
ITEMS["激光雷达"] = "雷达"
ITEMS["盐弹枪"] = "盐弹枪"
ITEMS["头戴摄像机"] = "头戴摄像机"
local ITEM_EN = "EnergyDrink 能量饮料 EnergyWatch 能量表 FortuneCoin 好运硬币 FortuneTicket 预言票 LuckyCoin 好运硬币 Luckycharm 好运硬币 Defibrillator 除颤器 HolyOil 圣油 Cross 十字架 Lantern 提灯 Lighter 打火机 Candle 蜡烛 PhotoCamera 相机 Plushie 玩偶 Lidar 雷达 HeadMountedCamera 头戴摄像机 HeadCam 头戴摄像机 SaltCanister 盐罐 RockSalt 盐弹枪 RockSaltShotgun 盐弹枪 Glowstick 荧光棒 Tripod 三脚架 Incense 熏香 SmudgeSticks 圣木 Igniter 点火器"
for k, v in string.gmatch(ITEM_EN, "(%S+)%s+(%S+)") do ITEMS[k] = v end


local CURSED_WORDS = "通灵板 显灵板 占卜板 幽灵板 魔板 灵应盘 碟仙板 巫板 诅咒镜 魔镜 邪镜子 血镜 骨镜 幽镜 阴镜 放大镜 放大透镜 凸透镜 窥镜 音乐盒 八音盒 音乐匣 旋律盒 发条盒 召唤阵 召唤圈 召唤法阵 仪式阵 魔法阵 五芒星 预言家 算命机 占卜机 预言机 命运机 塔罗牌 塔罗 卡牌 巫毒娃娃 巫毒 诅咒娃娃 骷髅头 头骨 骨颅 诅咒之书 邪书 魔导书 血书 黑书 诅咒物 被诅咒物 邪物 凶物 灵物 鬼器"
local CURSED = {}
for w in string.gmatch(CURSED_WORDS, "%S+") do CURSED[w] = w end
CURSED["Umbra板"] = "通灵板"
CURSED["能量表"] = nil
local CURSED_EN = "UmbraBoard 通灵板 Umbra 通灵板 UmbraPlate 通灵板 Umbra_Plate 通灵板 OuijaBoard 通灵板 Ouija 通灵板 SpiritBoard 通灵板 TalkingBoard 通灵板 WitchBoard 通灵板 Planchette 通灵板 DevilBoard 通灵板 GhostBoard 通灵板 HauntedMirror 诅咒镜 CursedMirror 诅咒镜 HauntedMirror2 诅咒镜 EvilMirror 诅咒镜 BloodMirror 血镜 BoneMirror 骨镜 DarkMirror 阴镜 GhostMirror 幽镜 MagnifyingGlass 放大镜 Magnifier 放大镜 MagnifyGlass 放大镜 SpyGlass 窥镜 MusicBox 音乐盒 MusicBoxes 音乐盒 Music_Box 音乐盒 WindUpBox 发条盒 MelodyBox 旋律盒 SummoningCircle 召唤阵 Summoning 召唤阵 SummonCircle 召唤阵 RitualCircle 仪式阵 Pentagram 五芒星 MagicCircle 魔法阵 FortuneTeller 预言家 FortuneTellerMachine 预言家 Fortune_Machine 预言机 FortuneMachine 占卜机 TarotCards 塔罗牌 Tarot 塔罗牌 VoodooDoll 巫毒娃娃 Voodoo 巫毒 Skull 骷髅头 CursedDoll 诅咒娃娃 CursedBook 诅咒之书 EvilBook 邪书 DarkBook 黑书 BloodBook 血书 CursedObject 诅咒物 CursedItem 诅咒物"
for k, v in string.gmatch(CURSED_EN, "(%S+)%s+(%S+)") do CURSED[k] = v end


local EVIDENCE = {
	EMF = "EMF5", HAND = "手印", BOX = "通灵盒", FREEZE = "低温",
	ORB = "鬼球", WRITE = "铭文", LASER = "激光投影", WITHER = "枯萎",
}

local EV_ORDER = { "EMF", "HAND", "BOX", "FREEZE", "ORB", "WRITE", "LASER", "WITHER" }

local EV_OBJ = {
	HAND = { handprint = 1, handprints = 1, fingerprint = 1, fingerprints = 1,
		footprint = 1, footprints = 1, print = 1, prints = 1,
		["手印"] = 1, ["指纹"] = 1, ["脚印"] = 1, ["掌印"] = 1 },
	ORB = { orb = 1, orbs = 1, ghostorb = 1, ghostorbs = 1,
		ghostorbfolder = 1, ["鬼球"] = 1, ["灵球"] = 1, ["光球"] = 1 },
	WRITE = { writing = 1, ghostwriting = 1, ghostwritings = 1,
		inscription = 1, inscriptions = 1, spiritbook = 1,
		spiritbooks = 1, book = 1, bookwriting = 1, notebook = 1,
		["鬼写字"] = 1, ["鬼写书"] = 1, ["铭文"] = 1, ["题字"] = 1,
		["灵书"] = 1, ["灵魂之书"] = 1, ["笔记"] = 1, ["笔记本"] = 1,
		["字迹"] = 1, ["涂鸦"] = 1, ["刻痕"] = 1 },
	WITHER = { wither = 1, withered = 1, wilt = 1, wilted = 1,
		rust = 1, rusted = 1, decay = 1, decayed = 1, distorted = 1,
		flower = 1, flowerpot = 1, deadflower = 1, rot = 1, rotten = 1,
		["枯萎"] = 1, ["凋谢"] = 1, ["生锈"] = 1, ["腐蚀"] = 1, ["扭曲"] = 1,
		["花"] = 1, ["花盆"] = 1, ["锈"] = 1, ["腐烂"] = 1 },
	LASER = { laser = 1, laserprojector = 1, laserproj = 1, projector = 1,
		projection = 1, laserprojection = 1, compactprojector = 1,
		discoball = 1, lasergrid = 1, beam = 1, ghostprojector = 1,
		["激光"] = 1, ["激光投影"] = 1, ["投影仪"] = 1, ["投影"] = 1,
		["激光灯"] = 1, ["镭射"] = 1 },
}

local GHOST_DB = {
	Aswang = { "EMF", "WRITE", "WITHER" },
	Banshee = { "FREEZE", "ORB", "HAND" },
	Demon = { "EMF", "FREEZE", "HAND" },
	Dullahan = { "FREEZE", "LASER", "WITHER" },
	Dybbuk = { "FREEZE", "HAND", "WITHER" },
	Entity = { "HAND", "LASER", "BOX" },
	Ghoul = { "FREEZE", "ORB", "BOX" },
	Keres = { "HAND", "BOX", "WITHER" },
	Leviathan = { "WRITE", "HAND", "ORB" },
	Nightmare = { "EMF", "ORB", "BOX" },
	Oni = { "FREEZE", "LASER", "BOX" },
	Phantom = { "EMF", "HAND", "ORB" },
	Ravager = { "EMF", "WRITE", "BOX" },
	Revenant = { "EMF", "FREEZE", "WRITE" },
	Shadow = { "EMF", "WRITE", "LASER" },
	Siren = { "EMF", "BOX", "WITHER" },
	Skinwalker = { "FREEZE", "WRITE", "BOX" },
	Specter = { "EMF", "FREEZE", "LASER" },
	Spirit = { "WRITE", "HAND", "BOX" },
	TheWisp = { "LASER", "ORB", "WITHER" },
	Umbra = { "HAND", "ORB", "LASER" },
	Vesper = { "WRITE", "HAND", "WITHER" },
	Vex = { "FREEZE", "ORB", "WITHER" },
	Wendigo = { "WRITE", "ORB", "LASER" },
	Wraith = { "EMF", "LASER", "BOX" },
	Abaddon = { "EMF", "ORB", "WITHER" },
}

local GHOST_CN = {
	Aswang = "阿斯旺", Banshee = "报丧女妖", Demon = "恶魔",
	Dullahan = "无头骑士", Dybbuk = "恶灵", Entity = "实体",
	Ghoul = "食尸鬼", Keres = "克瑞斯", Leviathan = "利维坦",
	Nightmare = "梦魇", Oni = "鬼武者", Phantom = "幻影",
	Ravager = "掠夺者", Revenant = "复仇者", Shadow = "影子",
	Siren = "塞壬", Skinwalker = "皮行者", Specter = "幽灵",
	Spirit = "灵魂", TheWisp = "鬼火", Umbra = "暗影",
	Vesper = "夜祷者", Vex = "穿墙者", Wendigo = "温迪戈",
	Wraith = "怨灵", Abaddon = "亚巴顿",
}


local EV_CN = {
	EMF = "EMF5", HAND = "手印", BOX = "通灵盒", FREEZE = "低温",
	ORB = "鬼球", WRITE = "铭文", LASER = "激光投影", WITHER = "枯萎",
}

local EV_CN_ALIAS = {
	emf = "EMF5", emf5 = "EMF5", emflevel5 = "EMF5",
	handprint = "手印", handprints = "手印", prints = "手印", print = "手印",
	fingerprint = "手印", footprint = "手印",
	spiritbox = "通灵盒", box = "通灵盒",
	freezing = "低温", freezingtemps = "低温", freezingtemperature = "低温",
	ghostorb = "鬼球", orb = "鬼球", orbs = "鬼球",
	ghostwriting = "铭文", inscription = "铭文", writing = "铭文",
	laser = "激光投影", laserprojector = "激光投影", projector = "激光投影",
	wither = "枯萎",
	["emf"] = "EMF5", ["emf5"] = "EMF5", ["五级"] = "EMF5",
	["手印"] = "手印", ["指纹"] = "手印", ["脚印"] = "手印", ["痕迹"] = "手印",
	["通灵盒"] = "通灵盒", ["灵盒"] = "通灵盒", ["灵魂盒"] = "通灵盒",
	["低温"] = "低温", ["寒冷"] = "低温", ["冰冻"] = "低温",
	["灵球"] = "鬼球", ["鬼球"] = "鬼球", ["光球"] = "鬼球",
	["铭文"] = "铭文", ["鬼写字"] = "铭文", ["鬼写"] = "铭文",
	["笔记"] = "铭文", ["灵书"] = "铭文", ["涂鸦"] = "铭文",
	["激光"] = "激光投影", ["投影"] = "激光投影", ["激光投影"] = "激光投影",
	["枯萎"] = "枯萎", ["凋谢"] = "枯萎", ["生锈"] = "枯萎",
}

local function GhostCN(name)
	if not name then return nil end
	if GHOST_CN[name] then return GHOST_CN[name] end
	local k = Norm(name)
	for en, c in pairs(GHOST_CN) do
		if Norm(en) == k then return c end
	end
	for en, c in pairs(GHOST_CN) do
		if string.find(k, Norm(en), 1, true) then return c end
	end
	return name
end

local function EvCN(key)
	if not key then return nil end
	if EVIDENCE[key] then return EVIDENCE[key] end
	if EV_CN[key] then return EV_CN[key] end
	local k = Norm(key)
	if EV_CN_ALIAS[k] then return EV_CN_ALIAS[k] end
	for kw, v in pairs(EV_CN_ALIAS) do
		if string.find(k, Norm(kw), 1, true) then return v end
	end
	return key
end

local EMF_NAMES = {
	emf = true, emfreader = true, emfmeter = true, emfdetector = true,
	["emf"] = true, ["emf读数器"] = true, ["emf读取器"] = true,
	["电磁场仪"] = true, ["电磁仪"] = true, ["emf仪"] = true,
}

local BOX_NAMES = {
	spiritbox = true, spiritboxes = true, ghostbox = true, spiritboxitem = true,
	["通灵盒"] = true, ["灵魂盒"] = true, ["灵盒"] = true, ["对话盒"] = true,
	["灵魂对讲机"] = true, ["通灵仪"] = true,
}
local BOX_BAD = { musicbox = true, fuse = true, toolbox = true, boombox = true,
	jukebox = true, mailbox = true, box = true, giftbox = true, ["音乐盒"] = true,
	["电闸"] = true, ["工具箱"] = true, ["礼物盒"] = true, }


local BOX_REPLY = {
	near = true, behind = true, window = true, door = true,
	turnaround = true, iamhere = true, lookbehindyou = true,
	hello = true, man = true, woman = true, women = true,
	here = true, there = true, yes = true, no = true,
	yearsold = true, old = true, sign = true, knock = true,
	["附近"] = true, ["后面"] = true, ["窗户"] = true, ["门"] = true,
	["转身"] = true, ["我在这"] = true, ["你好"] = true, ["在"] = true,
	["男"] = true, ["女"] = true, ["有"] = true, ["是"] = true,
}



local S = {
	Gui = nil, Lines = {}, TempText = nil,
	Mark = {}, MarkTag = {}, Box = {}, Items = {}, Cursed = {},
	HuntAt = nil, HuntCount = 0, DeadDone = false, DeadVisible = false,
	Evidence = {}, EvidenceKeys = {}, Room = nil, Temp = nil, LowRoom = nil,
	Ghost = nil, GhostMulti = false, GhostNotified = false, GhostCands = {}, FakeOrb = false, Music = nil, MusicOn = false,
	LowestTemp = nil, LowestRoom = nil, ColdNotified = false, Need = nil, ColdTimer = 0, ScrFrame = 0, ScrTemp = nil, ScrName = nil, PartCache = nil, WasDead = false, ChatRemotes = nil, WriteConfirmed = false, Hunting = false, HuntNotified = false, FuseObj = nil, FuseOn = nil, FuseNotified = false, GhostCur = nil, CursedBroken = false, BrokenNotified = false, TitleText = nil, RoomCache = nil, RoomCacheAt = 0, RoomFlat = nil,
	RoomIdx = 0, BatchLow = nil, BatchLowRoom = nil, ColdPass = 0,
	LitSaved = nil, Notified = {}, TempSrc = nil,
	Timer = 0, TempTimer = 0, Conn = {},
	FreezeNotified = false, TempNotified = false,
}

local function Fmt1(v)
	if v == nil then return "-" end
	local n = tonumber(v)
	if not n then return tostring(v) end
	local s2 = string.format("%.1f", n)
	return s2
end



local ROOMS = {
	masterbedroom = "主卧", bedroom = "卧室", bathroom = "浴室",
	livingroom = "客厅", kitchen = "厨房", garage = "车库",
	basement = "地下室", attic = "阁楼", hallway = "走廊",
	hall = "大厅", diningroom = "餐厅", nursery = "婴儿房",
	office = "办公室", study = "书房", laundry = "洗衣房",
	closet = "储藏室", pantry = "食品间", cellar = "地窖",
	garden = "花园", backyard = "后院", frontyard = "前院",
	porch = "门廊", balcony = "阳台", stairs = "楼梯",
	foyer = "门厅", entrance = "入口", exit = "出口",
	utilityroom = "杂物间", utility = "杂物间",
	storageroom = "杂物间", storage = "杂物间",
	supplyroom = "杂物间", utilitycloset = "杂物间",
	["杂物间"] = "杂物间", ["储藏室"] = "储藏室",
	["主卧"] = "主卧", ["卧室"] = "卧室", ["浴室"] = "浴室",
	["客厅"] = "客厅", ["厨房"] = "厨房", ["车库"] = "车库",
	["地下室"] = "地下室", ["阁楼"] = "阁楼", ["走廊"] = "走廊",
	["大厅"] = "大厅", ["餐厅"] = "餐厅", ["婴儿房"] = "婴儿房",
	["办公室"] = "办公室", ["书房"] = "书房", ["洗衣房"] = "洗衣房",
	["地窖"] = "地窖", ["花园"] = "花园",
	englishclassroom = "英语教室", scienceclassroom = "科学教室",
	mathclassroom = "数学教室", artclassroom = "美术教室",
	englishclass = "英语教室", scienceclass = "科学教室",
	sciencelab = "科学实验室", chemistrylab = "化学实验室",
	computerlab = "电脑室", schoollibrary = "学校图书馆",
	principaloffice = "校长办公室", teacherslounge = "教师休息室",
	boilerroom = "锅炉房", furnaceroom = "锅炉房",
	cafeteria = "食堂", gym = "体育馆", gymnasium = "体育馆",
	lunchroom = "食堂", library = "图书馆", classroom = "教室",
	principaloffice = "校长办公室", sciencelab = "科学实验室",
	englishclassroom = "英语教室", schoollibrary = "学校图书馆",
	storageroom2 = "储藏间", lockerroom = "更衣室",
	storageroom2 = "储藏间", lockerroom = "更衣室",
	utilityroom2 = "杂物间", cafeteria2 = "食堂",
	["后院"] = "后院", ["前院"] = "前院", ["门廊"] = "门廊",
	["阳台"] = "阳台", ["楼梯"] = "楼梯", ["门厅"] = "门厅",
}



local ROOM_KEYS = nil
local function RoomKeys()
	if ROOM_KEYS then return ROOM_KEYS end
	ROOM_KEYS = {}
	for k in pairs(ROOMS) do ROOM_KEYS[#ROOM_KEYS + 1] = k end
	table.sort(ROOM_KEYS, function(a, b) return #a > #b end)
	return ROOM_KEYS
end

local function RoomCN(n)
	if not n then return nil end
	local k = Norm(n)
	if ROOMS[k] then return ROOMS[k] end
	for _, kw in ipairs(RoomKeys()) do
		if string.find(k, Norm(kw), 1, true) then
			return ROOMS[kw]
		end
	end
	return tostring(n)
end

local function Match(tbl, n)
	local k = Norm(n)
	if tbl[k] then return tbl[k] end
	for kw, lab in pairs(tbl) do
		if string.find(k, Norm(kw), 1, true) then return lab end
	end
	return nil
end

local function GetGhost()
	return WS:FindFirstChild("Ghost")
end

local function Notify(title, text, dur, key)
	if key then
		if S.Notified[key] then return end
		S.Notified[key] = true
	end
	pcall(function()
		SG:SetCore("SendNotification", {
			Title = title,
			Text = text,
			Duration = dur or 5,
		})
	end)
end

local function GetHum()
	local c = LP.Character
	if not c then return nil end
	local h = c:FindFirstChildOfClass("Humanoid")
	if not h then
		pcall(function() h = c:FindFirstChild("Humanoid") end)
	end
	return h
end

local DEAD_KEYS = { dead = 1, isdead = 1, died = 1, deadbody = 1, alive = 1,
	isalive = 1, killed = 1, deceased = 1, ghostmode = 1, spectate = 1,
	spectating = 1, downed = 1, down = 1, knocked = 1,
	["死亡"] = 1, ["已死"] = 1, ["阵亡"] = 1, ["活着"] = 1, ["存活"] = 1,
	["倒下"] = 1, ["观战"] = 1, ["灵魂"] = 1 }
local DEAD_TRUE = { dead = 1, isdead = 1, died = 1, deadbody = 1, killed = 1,
	deceased = 1, ghostmode = 1, spectate = 1, spectating = 1, downed = 1,
	down = 1, knocked = 1, ["死亡"] = 1, ["已死"] = 1, ["阵亡"] = 1,
	["倒下"] = 1, ["观战"] = 1, ["灵魂"] = 1 }

local function IsDead()
	if S.ForceDead then return true end
	local h = GetHum()
	if not h then
		local c = LP.Character
		if not c then return true end
		return false
	end
	local ok, hp = pcall(function() return h.Health end)
	if ok and hp and hp <= 0 then return true end
	local ok2, st = pcall(function() return h:GetState() end)
	if ok2 and st and tostring(st):find("Dead") then return true end
	local c2 = LP.Character
	if c2 then
		local ok3, attrs = pcall(function() return c2:GetAttributes() end)
		if not (ok3 and attrs) then
			attrs = nil
		end
		if attrs then
			for k, v in pairs(attrs) do
				local kk = Norm(k)
				if DEAD_KEYS[kk] then
					if v == true or v == 1 or tostring(v) == "true" then
						if DEAD_TRUE[kk] then return true end
						return false
					end
					if v == false or v == 0 or tostring(v) == "false" then
						if not DEAD_TRUE[kk] then return true end
						return false
					end
				end
			end
		end
		local ok4 = nil
		pcall(function()
			for _, d in ipairs(c2:GetChildren()) do
				local kk = Norm(d.Name)
				if DEAD_KEYS[kk] and d:IsA("BoolValue") then
					local v = nil
					pcall(function() v = d.Value end)
					if v == true then
						if DEAD_TRUE[kk] then ok4 = true return end
						ok4 = false
						return
					end
					if v == false then
						if not DEAD_TRUE[kk] then ok4 = true return end
						ok4 = false
						return
					end
				end
			end
		end)
		if ok4 ~= nil then return ok4 end
	end
	return false
end









local function CollectChatRemotes()
	pcall(function()
		local cands = {}
		pcall(function()
			local rs = game:GetService("ReplicatedStorage")
			for _, d in ipairs(rs:GetDescendants()) do
				if d:IsA("RemoteEvent") then
					local nm = Norm(d.Name)
					if string.find(nm, "say", 1, true)
						or string.find(nm, "message", 1, true)
						or string.find(nm, "chat", 1, true)
						or string.find(nm, "talk", 1, true) then
						cands[#cands + 1] = d
					end
				end
			end
		end)
		S.ChatRemotes = cands
	end)
end

local CHAT_BLOCK = {
	chat = true, chatgui = true, bubblechat = true, chatmain = true,
	chatbar = true, chatmessage = true, textchat = true,
	["聊天"] = true, ["对话"] = true,
}
local function IsChatUI(d)
	local node = d
	for _ = 1, 6 do
		if not node then return false end
		local ok, nm = pcall(function() return node.Name end)
		if ok and nm then
			local k = Norm(nm)
			if CHAT_BLOCK[k] then return true end
			for kw in pairs(CHAT_BLOCK) do
				if string.find(k, kw, 1, true) then return true end
			end
		end
		node = node.Parent
	end
	return false
end
local function DeadChatFix()
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		local function fix(g)
			if not g then return end
			for _, d in ipairs(g:GetDescendants()) do
				if IsChatUI(d) then
					pcall(function()
						d.Visible = true
						if d:IsA("TextBox") then
							d.Editable = true
							d.Active = true
							d.TextEditable = true
						end
					end)
				end
			end
		end
		fix(pg)
		pcall(function()
			local cg = game:GetService("CoreGui")
			fix(cg)
		end)
	end)
end

local function Say(msg, ch)
	if not msg or msg == "" then return false end
	local sent = false
	pcall(function()
		local rs = game:GetService("ReplicatedStorage")
		local d = rs:FindFirstChild("SayMessageRequest")
		if d and d:IsA("RemoteEvent") then
			local ok = pcall(function() d:FireServer(tostring(msg), ch or "All") end)
			if ok then sent = true end
		end
	end)
	if sent then return true end
	if (not S.ChatRemotes) or #S.ChatRemotes == 0 then
		CollectChatRemotes()
	end
	pcall(function()
		for _, r in ipairs(S.ChatRemotes or {}) do
			pcall(function() r:FireServer(tostring(msg), ch or "All") end)
			sent = true
		end
	end)
	return sent
end




local function DeadStep()
	if not CFG.On.Dead then return end
	if (not IsDead()) and not S.WasDead then return end
	if IsDead() and not S.WasDead then
		S.WasDead = true
		pcall(function() DeadChatFix() end)
	end
end


local function GetRoot()
	local ok, r = pcall(function()
		local c = LP.Character
		if not c then return nil end
		local p = c:FindFirstChild("HumanoidRootPart")
		if p then return p end
		p = c.PrimaryPart
		if p then return p end
		for _, d in ipairs(c:GetChildren()) do
			if d:IsA("BasePart") then return d end
		end
		local h = c:FindFirstChildOfClass("Humanoid")
		if h and h.RootPart then return h.RootPart end
	end)
	if ok and r then return r end
	return nil
end

local ROOM_CONTAINERS = {
	"Rooms", "Room", "Zones", "Zone", "Regions", "Region",
	"Areas", "Area", "Locations", "Location", "Sectors",
}
local ROOM_NAME_HINT = { room = true, zone = true, region = true, area = true, sector = true }

local function LooksLikeRoom(n)
	local k = Norm(n)
	if ROOM_NAME_HINT[k] then return true end
	for kw in pairs(ROOM_NAME_HINT) do
		if string.find(k, Norm(kw), 1, true) then return true end
	end
	return false
end

local function GetRooms()
	local seen, found = {}, {}
	local function add(f)
		if f and not seen[f] then seen[f] = true found[#found + 1] = f end
	end
	pcall(function()
		local m = WS:FindFirstChild("Map")
		if m then
			for _, cn in ipairs(ROOM_CONTAINERS) do add(m:FindFirstChild(cn)) end
			for _, d in ipairs(m:GetChildren()) do
				if LooksLikeRoom(d.Name) then add(d) end
			end
		end
		for _, cn in ipairs(ROOM_CONTAINERS) do add(WS:FindFirstChild(cn)) end
		for _, d in ipairs(WS:GetChildren()) do
			if LooksLikeRoom(d.Name) then add(d) end
		end
	end)
	if #found == 0 then return nil end
	return found
end


local function NumFromText(v)
	if v == nil then return nil end
	local x = tonumber(v)
	if x then return x end
	local str = tostring(v)
	local n = string.match(str, "%-?%d+%.?%d*")
	if n then return tonumber(n) end
	return nil
end

local TEMP_HINT = { temperature = true, temp = true, freezing = true, degree = true, celsius = true }

local function IsTempKey(n)
	local k = Norm(n)
	if TEMP_HINT[k] then return true end
	for kw in pairs(TEMP_HINT) do
		if string.find(k, Norm(kw), 1, true) then return true end
	end
	return false
end

local function ReadTemp(o)
	if not o then return nil end
	local ok1, v1 = pcall(function()
		for k, v in pairs(o:GetAttributes()) do
			if IsTempKey(k) then
				local x = NumFromText(v)
				if x then return x end
			end
		end
		return nil
	end)
	if ok1 and v1 then return v1 end
	local ok2, v2 = pcall(function()
		local budget = CFG.RoomScanBudget
		for _, d in ipairs(o:GetChildren()) do
			budget = budget - 1
			if budget <= 0 then return nil end
			if d:IsA("NumberValue") or d:IsA("IntValue") or d:IsA("StringValue") then
				if IsTempKey(d.Name) then
					local x = NumFromText(d.Value)
					if x then return x end
				end
			end
		end
		return nil
	end)
	if ok2 and v2 then return v2 end
	return nil
end


local THERMO_NAMES = {
	thermometer = true, thermo = true, temperature = true, temp = true,
	tempgun = true, tempreader = true, heatreader = true,
	thermogun = true, thermometergun = true, temperaturegun = true,
	tempdetector = true, heatgun = true, thermalgun = true,
	thermalscanner = true, tempscanner = true, gun = true,
	["温度计"] = true, ["体温计"] = true, ["测温计"] = true,
	["测温仪"] = true, ["温度枪"] = true, ["测温枪"] = true,
	["温度计枪"] = true, ["测温枪械"] = true, ["热像仪"] = true,
	["温度探测仪"] = true, ["测温器"] = true,
}

local function IsThermoName(n)
	local k = Norm(n)
	if THERMO_NAMES[k] then return true end
	for kw in pairs(THERMO_NAMES) do
		if string.find(k, Norm(kw), 1, true) then return true end
	end
	return false
end



local function ReadThermoValue(o)
	if not o then return nil, nil end
	local ok, a = pcall(function() return o:GetAttribute("Temperature") end)
	if ok then
		local x = NumFromText(a)
		if x then return x, "属性Temperature" end
	end
	pcall(function()
		for k, v in pairs(o:GetAttributes()) do
			local kk = Norm(k)
			if string.find(kk, "temp", 1, true) then
				local x = NumFromText(v)
				if x then return x, "属性" .. tostring(k) end
			end
		end
	end)
	pcall(function()
		for _, d in ipairs(o:GetDescendants()) do
			if d:IsA("NumberValue") or d:IsA("IntValue") then
				local kk = Norm(d.Name)
				if string.find(kk, "temp", 1, true) or d.Name == "Value" then
					local x = NumFromText(d.Value)
					if x then return x, d.Name end
				end
			elseif d:IsA("StringValue") then
				local kk = Norm(d.Name)
				if string.find(kk, "temp", 1, true) or string.find(kk, "display", 1, true) then
					local x = NumFromText(d.Value)
					if x then return x, d.Name end
				end
			elseif d:IsA("TextLabel") or d:IsA("TextButton") then
				local t = d.Text
				if t and (string.find(t, "%%C") or string.find(t, "°") or string.find(t, "C")) then
					local x = NumFromText(t)
					if x then return x, "文本" end
				end
			end
		end
	end)
	return nil, nil
end

local function HasThermoEquipped()
	local has = false
	pcall(function()
		local c = LP.Character
		if c then
			for _, d in ipairs(c:GetDescendants()) do
				if IsThermoName(d.Name) then has = true return end
			end
		end
	end)
	if has then return true end
	pcall(function()
		local bp = LP:FindFirstChild("Backpack")
		if bp then
			for _, d in ipairs(bp:GetDescendants()) do
				if IsThermoName(d.Name) then has = true return end
			end
		end
	end)
	return has
end

local function ScanScreenTemp()
	if not HasThermoEquipped() then return nil, nil end
	S.ScrFrame = (S.ScrFrame or 0) + 1
	if S.ScrTemp and (S.ScrFrame % 2) ~= 0 then
		return S.ScrTemp, S.ScrName
	end
	local best = nil
	local bestName = nil
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then return end
		for _, g in ipairs(pg:GetChildren()) do
			local ok, descs = pcall(function() return g:GetDescendants() end)
			if ok and descs then
				for _, d in ipairs(descs) do
					if d:IsA("TextLabel") or d:IsA("TextButton") then
						local t = d.Text
						if t and t ~= "" then
							local pats = {
								"%-?%d+%.?%d*%s*°%s*[Cc]",
								"%-?%d+%.?%d*%s*°",
								"%-?%d+%.?%d*%s*[Cc]$",
							}
							for _, pat in ipairs(pats) do
								local m = string.match(t, pat)
								if m then
									local x = NumFromText(m)
									if x and x > -60 and x < 100 then
										best = x
										bestName = d.Name
										return
									end
								end
							end
						end
					end
				end
			end
			if best then return end
		end
	end)
	S.ScrTemp = best
	S.ScrName = bestName
	return best, bestName
end

local function FindThermometer()
	local found = nil
	pcall(function()
		local c = LP.Character
		if c then
			for _, d in ipairs(c:GetDescendants()) do
				if IsThermoName(d.Name) then
					local v, src = ReadThermoValue(d)
					if v then found = { v, src, d.Name } return end
				end
			end
		end
	end)
	if found then return found[1], found[2], found[3] end
	pcall(function()
		local bp = LP:FindFirstChild("Backpack")
		if bp then
			for _, d in ipairs(bp:GetDescendants()) do
				if IsThermoName(d.Name) then
					local v, src = ReadThermoValue(d)
					if v then found = { v, src, d.Name } return end
				end
			end
		end
	end)
	if found then return found[1], found[2], found[3] end
	return nil, nil, nil
end

local function MeasureTemp(skipRooms)
	local cur, lowest, lowRoom = nil, nil, nil
	local root = GetRoot()
	local sv, sname = ScanScreenTemp()
	if sv then
		cur = sv
		S.TempSrc = "屏幕"
	else
		local tv, tsrc, tname = FindThermometer()
		if tv then
			cur = tv
			S.TempSrc = tname or "体温计"
		end
	end

	if not skipRooms then
	pcall(function()
		local containers = S.RoomCache
		local now = os.clock()
		if (not containers) or (not S.RoomCacheAt) or (now - S.RoomCacheAt > 30) then
			containers = GetRooms()
			S.RoomCache = containers
			S.RoomCacheAt = now
			S.RoomFlat = nil
			S.RoomIdx = 0
		end
		if not containers then return end
		if not S.RoomFlat then
			local flat = {}
			for _, c in ipairs(containers) do
				for _, r in ipairs(c:GetChildren()) do flat[#flat + 1] = r end
			end
			S.RoomFlat = flat
			S.RoomIdx = 0
		end
		local flat = S.RoomFlat
		if #flat == 0 then return end
		local nearDist, nearTemp, nearName = nil, nil, nil
		for _ = 1, CFG.RoomPerTick do
			S.RoomIdx = S.RoomIdx + 1
			if S.RoomIdx > #flat then
				S.RoomIdx = 1
				S.ColdPass = (S.ColdPass or 0) + 1
				if S.BatchLow then
					S.LowestTemp = S.BatchLow
					S.LowestRoom = S.BatchLowRoom
				end
				S.BatchLow = nil
				S.BatchLowRoom = nil
				if not S.RoomFlat then
				else
					local reflat = {}
					for _, c in ipairs(containers) do
						for _, r in ipairs(c:GetChildren()) do reflat[#reflat + 1] = r end
					end
					S.RoomFlat = reflat
					flat = reflat
				end
			end
			local r = flat[S.RoomIdx]
			local t = ReadTemp(r)
			if t then
				if (not S.BatchLow) or t < S.BatchLow then
					S.BatchLow = t
					S.BatchLowRoom = r.Name
				end
				local d = nil
				if root and root.Position then
					local pcf = S.PartCache or {}
					S.PartCache = pcf
					local rp = pcf[r]
					if rp == nil then
						pcall(function()
							rp = r:FindFirstChildWhichIsA("BasePart") or r.PrimaryPart
						end)
						pcf[r] = rp or false
					end
					if rp == false then rp = nil end
					if rp and rp.Position then
						local ok, dd = pcall(function()
							return (rp.Position - root.Position).Magnitude
						end)
						if ok and dd then d = dd end
					end
				end
				if d and (not nearDist or d < nearDist) then
					nearDist = d
					nearTemp = t
					nearName = r.Name
				end
			end
		end
		if S.LowestTemp == nil and S.BatchLow then
			S.LowestTemp = S.BatchLow
			S.LowestRoom = S.BatchLowRoom
		end
		if not cur and nearTemp then
			cur = nearTemp
			if not S.TempSrc then S.TempSrc = nearName end
		end
	end)
	end

	if not cur then
		pcall(function()
			local c = LP.Character
			if not c then return end
			for _, v in ipairs(c:GetDescendants()) do
				if v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue") then
					local k = Norm(v.Name)
					if string.find(k, "temp", 1, true)
						or string.find(k, "temperature", 1, true)
						or string.find(k, "freezing", 1, true) then
						local x = tonumber(v.Value)
						if x then cur = x return end
					end
				end
			end
		end)
	end

	if not cur then
		pcall(function()
			for _, v in ipairs(LP:GetDescendants()) do
				if v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue") then
					local k = Norm(v.Name)
					if string.find(k, "temp", 1, true) then
						local x = tonumber(v.Value)
						if x then cur = x return end
					end
				end
			end
		end)
	end

	if not cur then
		pcall(function()
			local g = GetGhost()
			if g then
				local ok, t = pcall(function() return g:GetAttribute("Temperature") end)
				if ok and tonumber(t) then cur = tonumber(t) return end
				local gg = g:GetAttribute("RoomTemperature")
				if tonumber(gg) then cur = tonumber(gg) return end
			end
		end)
	end

	if not cur then
		pcall(function()
			local n = 0
			for _, d in ipairs(WS:GetDescendants()) do
				n = n + 1
				if n > 600 then break end
				local ok, t = pcall(function() return d:GetAttribute("Temperature") end)
				if ok and tonumber(t) then
					local tv = tonumber(t)
					if not lowest or tv < lowest then
						lowest = tv
						lowRoom = d.Name
					end
				end
			end
		end)
	end

	if not S.Room and lowRoom then S.Room = RoomCN(lowRoom) end
	return cur, lowest, lowRoom
end


local function CheckTemp()
	if not CFG.On.Temp then return end
	S.Temp = nil
	local cur = MeasureTemp(false)
	S.Temp = cur
	local lowest, lowRoom = S.LowestTemp, S.LowestRoom
	if lowest and lowest < CFG.FreezePoint and not S.ColdNotified then
		S.ColdNotified = true
		Notify("低温证据成立", "最冷 " .. (RoomCN(lowRoom) or lowRoom or "?")
			.. " " .. tostring(lowest) .. "°C", 7, "cold")
	end
	if (not lowest) or lowest >= CFG.FreezePoint then S.ColdNotified = false end
	if not S.Room and lowRoom then S.Room = lowRoom end
	if cur then
		if not S.TempText then EnsureUI() end
		if S.TempText then
			pcall(function()
				local src = ""
				if S.TempSrc then
					local cn = RoomCN(S.TempSrc)
					if cn and cn ~= S.TempSrc then
						src = "[" .. cn .. "]"
					else
						src = "[" .. S.TempSrc .. "]"
					end
				end
				S.TempText.Text = string.format("当前温度 %.1f°C %s", cur, src)
			end)
		end
		if cur < CFG.FreezePoint then
			if not S.FreezeNotified then
				S.FreezeNotified = true
				Notify("低温警告", string.format("所在处 %.1f°C 低于零度 证据:低温", cur), 6)
			end
		else
			S.FreezeNotified = false
		end
	else
		if not S.TempText then EnsureUI() end
		if S.TempText then
			pcall(function()
				S.TempText.Text = "当前温度 -"
			end)
		end
	end
end


local function SaveLighting()
	if S.LitSaved then return end
	local ok = pcall(function()
		S.LitSaved = {
			Ambient = LIT.Ambient,
			OutdoorAmbient = LIT.OutdoorAmbient,
			Brightness = LIT.Brightness,
			FogEnd = LIT.FogEnd,
			FogStart = LIT.FogStart,
			ClockTime = LIT.ClockTime,
			GlobalShadows = LIT.GlobalShadows,
			ExposureCompensation = LIT.ExposureCompensation,
		}
	end)
	if not ok then S.LitSaved = nil end
end

local function ApplyBright()
	if not CFG.On.Bright then return end
	SaveLighting()
	pcall(function()
		LIT.Ambient = Color3.new(CFG.Bright.Ambient, CFG.Bright.Ambient, CFG.Bright.Ambient)
		LIT.OutdoorAmbient = Color3.new(CFG.Bright.Outdoor, CFG.Bright.Outdoor, CFG.Bright.Outdoor)
		LIT.Brightness = CFG.Bright.Brightness
		LIT.FogEnd = CFG.Bright.FogEnd
		LIT.FogStart = 0
		LIT.ClockTime = CFG.Bright.ClockTime
		LIT.GlobalShadows = CFG.Bright.Shadows
		LIT.ExposureCompensation = CFG.Bright.Exposure
	end)
	pcall(function()
		for _, v in ipairs(LIT:GetChildren()) do
			if v:IsA("Atmosphere") then
				v.Density = 0
				v.Haze = 0
				v.Glare = 0
				v.Offset = 0
			elseif v:IsA("Sky") then
				v.StarCount = 0
			elseif v:IsA("BloomEffect") or v:IsA("ColorCorrectionEffect") then
				v.Enabled = false
			end
		end
	end)
	pcall(function()
		local t = LIT:FindFirstChildOfClass("ColorCorrectionEffect")
		if t then t.Brightness = 0.15 end
	end)
end

local function RestoreBright()
	if not S.LitSaved then return end
	pcall(function()
		LIT.Ambient = S.LitSaved.Ambient
		LIT.OutdoorAmbient = S.LitSaved.OutdoorAmbient
		LIT.Brightness = S.LitSaved.Brightness
		LIT.FogEnd = S.LitSaved.FogEnd
		LIT.FogStart = S.LitSaved.FogStart
		LIT.ClockTime = S.LitSaved.ClockTime
		LIT.GlobalShadows = S.LitSaved.GlobalShadows
		LIT.ExposureCompensation = S.LitSaved.ExposureCompensation
	end)
	S.LitSaved = nil
end

local function Mark(obj, color, tag)
	if not obj or not obj.Parent then return end
	tag = tag or "item"
	local m = S.Mark[obj]
	if m and m.Parent then
		pcall(function()
			m.FillColor = color
			m.OutlineColor = color
		end)
		S.MarkTag[obj] = tag
		return
	end
	local n = Instance.new("Highlight")
	n.Name = "DHL"
	n.Adornee = obj
	n.FillColor = color
	n.OutlineColor = color
	n.FillTransparency = CFG.FillAlpha
	n.OutlineTransparency = 0
	n.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	if tag == "ghost" then n.FillTransparency = 0.82 end
	if tag == "room" or tag == "ghostroom" then n.FillTransparency = 0.88 end
	pcall(function() n.Parent = obj end)
	S.Mark[obj] = n
	S.MarkTag[obj] = tag
	local GLOW_SKIP = { ghost = true, room = true, ghostroom = true, exit = true, hide = true, mate = true, self = true }
	if CFG.On.BigGlow and not GLOW_SKIP[tag] then
		pcall(function()
			local host = obj
			if obj:IsA("Model") then
				host = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
			end
			if host and host:IsA("BasePart") then
				local r = 2.0
				local ok3, sz = pcall(function() return host.Size end)
				if ok3 and sz and sz.X and sz.Y and sz.Z then
					r = math.max(sz.X, sz.Y, sz.Z) * CFG.GlowScale
					if r < 1.2 then r = 1.2 end
					if r > 9 then r = 9 end
				end
				local sp = Instance.new("SphereHandleAdornment")
				sp.Name = "DHGlow"
				sp.Adornee = host
				sp.Radius = r
				sp.Color3 = color
				sp.Transparency = CFG.GlowAlpha
				sp.AlwaysOnTop = true
				sp.ZIndex = 1
				sp.Parent = host
				S.Glow[obj] = sp
			end
		end)
	end
	if CFG.On.BigOutline then
		pcall(function()
			local host = obj
			if obj:IsA("Model") then
				host = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
			end
			if host and host:IsA("BasePart") then
				local box = Instance.new("SelectionBox")
				box.Name = "DHBox"
				box.Adornee = host
				box.Color3 = color
				box.LineThickness = 0.06
				box.Transparency = 0
				box.SurfaceTransparency = 0.85
				box.SurfaceColor3 = color
				box.Parent = host
				S.Box[obj] = box
			end
		end)
	end
end

local function MarkTagOf(obj)
	return S.MarkTag and S.MarkTag[obj] or nil
end

local function Unmark(obj)
	local m = S.Mark[obj]
	if m then
		pcall(function() m:Destroy() end)
		S.Mark[obj] = nil
	end
	if S.MarkTag then S.MarkTag[obj] = nil end
	pcall(function() if S.Glow and S.Glow[obj] then S.Glow[obj]:Destroy() S.Glow[obj] = nil end end)
	pcall(function() if S.Box and S.Box[obj] then S.Box[obj]:Destroy() S.Box[obj] = nil end end)
	local b = S.Box and S.Box[obj]
	if b then
		pcall(function() b:Destroy() end)
		S.Box[obj] = nil
	end
end

local function IsStarterGear(o)
	local bp = LP:FindFirstChild("Backpack")
	if bp and o:IsDescendantOf(bp) then return true end
	local c = LP.Character
	if c and o:IsDescendantOf(c) then return true end
	return false
end

local NEGATIVE = {
	whiteboard = true, blackboard = true, chalkboard = true,
	noticeboard = true, bulletinboard = true, scoreboard = true,
	dashboard = true, skateboard = true, cardboard = true,
	floorboard = true, baseboard = true, cupboard = true,
	switchboard = true, keyboard = true, clipboard = true,
	shelf = true, cabinet = true, table = true, chair = true,
	sofa = true, bed = true, lamp = true, light = true,
	headlight = true, window = true, door = true, wall = true,
	floor = true, ceiling = true, roof = true, stairs = true,
	painting = true, picture = true, frame = true, poster = true,
	book = true, books = true, journal = true, notebook = true, diary = true,
	logbook = true, spiritbook = true, ghostbook = true, textbook = true,
	["书"] = true, ["书籍"] = true, ["灵书"] = true, ["灵魂之书"] = true,
	["笔记"] = true, ["笔记本"] = true, ["日志"] = true, ["日记"] = true,
	["书柜"] = true, ["书架"] = true, ["课本"] = true, ["杂志"] = true,
	carpet = true, rug = true, curtain = true, plant = true,
	tree = true, bush = true, rock = true, trash = true,
	["白板"] = true, ["黑板"] = true, ["布告栏"] = true,
	["公告板"] = true, ["柜子"] = true, ["书架"] = true,
	["桌子"] = true, ["椅子"] = true, ["沙发"] = true,
	["床"] = true, ["灯"] = true, ["落地灯"] = true,
	["车灯"] = true, ["窗户"] = true, ["门"] = true,
	["墙壁"] = true, ["地板"] = true, ["天花板"] = true,
	["楼梯"] = true, ["画"] = true, ["相框"] = true,
	["海报"] = true, ["地毯"] = true, ["窗帘"] = true,
	["植物"] = true, ["树"] = true, ["石头"] = true,
	["垃圾桶"] = true, ["蒙娜丽莎"] = true,
}

local function IsNegative(n)
	local k = Norm(n)
	if NEGATIVE[k] then return true end
	for kw in pairs(NEGATIVE) do
		if string.find(k, Norm(kw), 1, true) then return true end
	end
	return false
end

local function Classify(o)
	if IsNegative(o.Name) then return nil, nil end
	local c = Match(CURSED, o.Name)
	if c then return "cursed", c end
	local it = Match(ITEMS, o.Name)
	if it then return "item", it end
	return nil, nil
end

local PART_JUNK = { part = 1, parts = 1, mesh = 1, meshpart = 1, union = 1,
	handle = 1, wedge = 1, cornerwedgepart = 1, trusspart = 1, motor = 1,
	body = 1, root = 1, humanoidrootpart = 1, torso = 1, head = 1,
	arm = 1, leg = 1, main = 1, base = 1, hitbox = 1, collider = 1,
	["零件"] = 1, ["主体"] = 1, ["把手"] = 1, ["头部"] = 1, ["身体"] = 1 }
local GEAR_ANCESTOR = { book = 1, books = 1, journal = 1, notebook = 1, diary = 1,
	logbook = 1, spiritbook = 1, ghostbook = 1, textbook = 1, magazine = 1,
	bookshelf = 1, bookcase = 1, backpack = 1, bag = 1, inventory = 1,
	["书"] = 1, ["书籍"] = 1, ["灵书"] = 1, ["灵魂之书"] = 1, ["笔记"] = 1,
	["笔记本"] = 1, ["日志"] = 1, ["日记"] = 1, ["课本"] = 1, ["杂志"] = 1,
	["书柜"] = 1, ["书架"] = 1, ["背包"] = 1, ["物品栏"] = 1 }

local function IsComponent(o)
	if not (o:IsA("BasePart") or o:IsA("MeshPart")) then return false end
	local p = o.Parent
	if not p then return false end
	local ok, cls = pcall(function() return p.ClassName end)
	if not ok or not cls then return false end
	if cls ~= "Model" and cls ~= "Tool" then return false end
	local kn = Norm(o.Name)
	local kp = Norm(p.Name)
	if kn == kp then return true end
	if PART_JUNK[kn] then return true end
	if kn ~= "" and kp ~= "" then
		if string.find(kn, kp, 1, true) or string.find(kp, kn, 1, true) then
			return true
		end
	end
	return false
end

local function HasGearAncestor(o)
	local node = o.Parent
	local depth = 0
	while node and depth < 5 do
		local ok, nm = pcall(function() return node.Name end)
		if ok and nm then
			local k = Norm(nm)
			if GEAR_ANCESTOR[k] then return true end
			for kw in pairs(GEAR_ANCESTOR) do
				if string.find(k, kw, 1, true) then return true end
			end
		end
		node = node.Parent
		depth = depth + 1
	end
	return false
end

local function Handle(o)
	if not o or not o.Parent then return end
	if not (o:IsA("Model") or o:IsA("BasePart") or o:IsA("MeshPart") or o:IsA("Tool")) then return end
	if IsStarterGear(o) then return end
	if HasGearAncestor(o) then return end
	if IsComponent(o) then return end
	local kind, lab = Classify(o)
	if not kind then return end
	local t = (kind == "cursed") and S.Cursed or S.Items
	if kind == "cursed" and not CFG.On.Cursed then return end
	if kind == "item" and not CFG.On.Items then return end
	for _, e in ipairs(t) do
		for _, x in ipairs(e.objs) do
			if x == o then return end
		end
	end
	for _, e in ipairs(t) do
		for _, x in ipairs(e.objs) do
			if o:IsDescendantOf(x) then
				Mark(o, e.color)
				return
			end
			if x:IsDescendantOf(o) then
				for j = #e.objs, 1, -1 do
					if e.objs[j] == x then
						table.remove(e.objs, j)
						e.count = e.count - 1
						Unmark(x)
						break
					end
				end
				if e.count <= 0 then
					for j = #t, 1, -1 do
						if t[j] == e then table.remove(t, j) break end
					end
				end
			end
		end
	end
	for _, e in ipairs(t) do
		if e.lab == lab then
			e.count = e.count + 1
			e.objs[#e.objs + 1] = o
			if #e.objs <= CFG.MaxMark then Mark(o, e.color) end
			return
		end
	end
	if #t >= 60 then return end
	local color = (kind == "cursed") and CFG.CursedColor or CFG.ItemColor
	local entry = { lab = lab, count = 1, objs = { o }, color = color, name = o.Name }
	t[#t + 1] = entry
	Mark(o, color)
end

local function RescanItems()
	S.Items = {}
	S.Cursed = {}
	local n = 0
	local curseFirst = { "CursedPossessions", "CursedPossessionHolder",
		"CursedPossession", "Cursed", "CursedItems", "CursedObjects",
		"CursedItem", "CursedPossessionFolder", "Rare", "Special" }
	local containers = { "Items", "Props", "Pickups", "Interactables",
		"ItemFolder", "MapItems", "Loot", "SpawnedItems" }
	local map = WS:FindFirstChild("Map")
	local function addUnder(parent, names)
		if not parent then return end
		for _, cn in ipairs(names) do
			local f = parent:FindFirstChild(cn)
			if f then containers[#containers + 1] = f end
		end
	end
	local scanned = {}
	-- 先扫诅咒物容器, 保证不被 Items 的预算挤掉
	local function scanContainer(f)
		if not f or scanned[f] then return end
		scanned[f] = true
		local budget = CFG.ScanBudget
		pcall(function()
			for _, d in ipairs(f:GetDescendants()) do
				budget = budget - 1
				if budget <= 0 then return end
				n = n + 1
				Handle(d)
			end
		end)
	end
	for _, cn in ipairs(curseFirst) do
		scanContainer(WS:FindFirstChild(cn))
		if map then scanContainer(map:FindFirstChild(cn)) end
	end
	-- 再扫普通道具容器
	for _, cn in ipairs(containers) do
		if type(cn) == "string" then
			scanContainer(WS:FindFirstChild(cn))
		else
			scanContainer(cn)
		end
	end
	addUnder(map, curseFirst)
	addUnder(map, { "Items", "Props", "Pickups", "Interactables", "ItemFolder",
		"MapItems", "Loot", "SpawnedItems" })
	for _, cn in ipairs(containers) do
		if type(cn) ~= "string" then scanContainer(cn) end
	end
	pcall(function()
		local budget = CFG.ScanBudget
		local function walkTop(f, depth)
			if budget <= 0 or depth > 2 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 then return end
				if not scanned[d] then
					scanned[d] = true
					Handle(d)
				end
				if depth < 2 then
					local cnt = 0
					pcall(function() cnt = #d:GetChildren() end)
					if cnt > 0 and cnt < 300 then walkTop(d, depth + 1) end
				end
			end
		end
		walkTop(WS, 1)
	end)
	pcall(function()
		local m2 = WS:FindFirstChild("Map")
		if m2 and not scanned[m2] then
			scanned[m2] = true
			local budget = CFG.ScanBudget
			local function walk(f, depth)
				if budget <= 0 or depth > CFG.ScanDepth then return end
				for _, d in ipairs(f:GetChildren()) do
					budget = budget - 1
					if budget <= 0 then return end
					if not scanned[d] then
						scanned[d] = true
						Handle(d)
					end
					if depth < CFG.ScanDepth and #d:GetChildren() > 0
						and #d:GetChildren() < 400 then
						walk(d, depth + 1)
					end
				end
			end
			walk(m2, 1)
		end
	end)
	for i = #S.Items, 1, -1 do
		local e = S.Items[i]
		for j = #e.objs, 1, -1 do
			local o = e.objs[j]
			if not o.Parent or IsStarterGear(o) then table.remove(e.objs, j) end
		end
		e.count = #e.objs
		if e.count <= 0 then table.remove(S.Items, i) end
	end
	for i = #S.Cursed, 1, -1 do
		local e = S.Cursed[i]
		for j = #e.objs, 1, -1 do
			local o = e.objs[j]
			if not o.Parent or IsStarterGear(o) then table.remove(e.objs, j) end
		end
		e.count = #e.objs
		if e.count <= 0 then table.remove(S.Cursed, i) end
	end
	local keep = {}
	for _, e in ipairs(S.Items) do
		for _, o in ipairs(e.objs) do keep[o] = true end
	end
	for _, e in ipairs(S.Cursed) do
		for _, o in ipairs(e.objs) do keep[o] = true end
	end
	local drop = {}
	for obj in pairs(S.Mark) do
		local tag = MarkTagOf(obj)
		if tag == "item" or tag == "cursed" then
			if not keep[obj] then drop[#drop + 1] = obj end
		elseif tag == "mate" then
			local still = false
			pcall(function()
				for _, p in ipairs(game:GetService("Players"):GetPlayers()) do
					if p ~= LP and p.Character == obj then still = true break end
				end
			end)
			if still then
				S.MateMiss[obj] = 0
			else
				S.MateMiss[obj] = (S.MateMiss[obj] or 0) + 1
				if S.MateMiss[obj] >= 8 then drop[#drop + 1] = obj S.MateMiss[obj] = nil end
			end
		elseif tag == "self" then
			if not CFG.DeadHelp then drop[#drop + 1] = obj end
		elseif tag == "hide" or tag == "exit" or tag == "room" or tag == "ghostroom" then
			if not obj.Parent then drop[#drop + 1] = obj end
		elseif tag == "ghost" then
			local g = GetGhost()
			local still = false
			if g then
				still = (obj == g) or (obj.Parent ~= nil and obj:IsDescendantOf(g))
			end
			if not still then drop[#drop + 1] = obj end
		end
	end
	for _, obj in ipairs(drop) do Unmark(obj) end
end

local function IsHunting()
	local g = GetGhost()
	if not g then return false end
	local hunt = false
	pcall(function()
		local v = g:GetAttribute("Hunting") or g:GetAttribute("IsHunting") or g:GetAttribute("Hunt")
		if v == true or v == 1 or tostring(v) == "true" then hunt = true end
	end)
	if hunt then return true end
	pcall(function()
		for _, d in ipairs(g:GetDescendants()) do
			if d:IsA("BoolValue") then
				local k = Norm(d.Name)
				if string.find(k, "hunt", 1, true) and d.Value then hunt = true return end
			end
		end
	end)
	return hunt
end

local function MatchEvGroup(n)
	local k = Norm(n)
	for ev, tbl in pairs(EV_OBJ) do
		if tbl[k] then return ev end
		for kw in pairs(tbl) do
			if string.find(k, Norm(kw), 1, true) then return ev end
		end
	end
	return nil
end

local function FindTool(names)
	local hit = nil
	pcall(function()
		local c = LP.Character
		if c then
			for _, d in ipairs(c:GetDescendants()) do
				if names[Norm(d.Name)] then hit = d return end
				for kw in pairs(names) do
					if string.find(Norm(d.Name), Norm(kw), 1, true) then hit = d return end
				end
			end
		end
	end)
	if hit then return hit end
	pcall(function()
		local bp = LP:FindFirstChild("Backpack")
		if bp then
			for _, d in ipairs(bp:GetDescendants()) do
				if names[Norm(d.Name)] then hit = d return end
				for kw in pairs(names) do
					if string.find(Norm(d.Name), Norm(kw), 1, true) then hit = d return end
				end
			end
		end
	end)
	return hit
end

local function ToolNumber(o, hints)
	if not o then return nil end
	local ok1, v1 = pcall(function()
		for k, v in pairs(o:GetAttributes()) do
			local kk = Norm(k)
			for _, h in ipairs(hints) do
				if string.find(kk, Norm(h), 1, true) then
					local x = NumFromText(v)
					if x then return x end
				end
			end
		end
		return nil
	end)
	if ok1 and v1 then return v1 end
	local ok2, v2 = pcall(function()
		for _, d in ipairs(o:GetDescendants()) do
			if d:IsA("NumberValue") or d:IsA("IntValue") or d:IsA("StringValue") then
				local kk = Norm(d.Name)
				for _, h in ipairs(hints) do
					if string.find(kk, Norm(h), 1, true) then
						local x = NumFromText(d.Value)
						if x then return x end
					end
				end
			end
			if d:IsA("TextLabel") or d:IsA("TextButton") then
				local t = d.Text
				if t and t ~= "" then
					local x = NumFromText(t)
					if x then
						for _, h in ipairs(hints) do
							if string.find(Norm(t), Norm(h), 1, true) then return x end
						end
					end
				end
			end
		end
		return nil
	end)
	if ok2 and v2 then return v2 end
	return nil
end

local function ScanEMF()
	if IsHunting() then return nil end
	local tool = FindTool(EMF_NAMES)
	if not tool then return nil end
	local v = ToolNumber(tool, { "emf", "level", "reading", "strength" })
	if v and v >= 5 then return "EMF" end
	return nil
end

local function IsRedText(d)
	local ok, c = pcall(function() return d.TextColor3 end)
	if not ok or not c then return false end
	local r = c.r or c.R or 0
	local g = c.g or c.G or 0
	local b = c.b or c.B or 0
	if r > 0.55 and g < 0.35 and b < 0.35 then return true end
	return false
end





local BOX_STRICT = {
	near = true, behind = true, window = true, turnaround = true,
	iamhere = true, lookbehindyou = true, yearsold = true,
	["附近"] = true, ["后面"] = true, ["窗户"] = true, ["转身"] = true,
	["我在这"] = true, ["你在哪"] = true, ["你好"] = true,
}

local function IsRealBox(n)
	local k = Norm(n)
	if BOX_NAMES[k] then return true end
	if BOX_BAD[k] then return false end
	for kw in pairs(BOX_BAD) do
		if string.find(k, kw, 1, true) then return false end
	end
	for kw in pairs(BOX_NAMES) do
		if string.find(k, kw, 1, true) then return true end
	end
	return false
end
local function ScanBoxReply()
	local got = false
	local hasTool = false
	pcall(function()
		local c = LP.Character
		local bp = LP:FindFirstChild("Backpack")
		local function walk(f)
			if not f then return end
			for _, d in ipairs(f:GetDescendants()) do
				if d:IsA("Tool") and not BOX_BAD[Norm(d.Name)] and IsRealBox(d.Name) then
					hasTool = true
					return
				end
			end
		end
		walk(c)
		if not hasTool then walk(bp) end
	end)
	if not hasTool then return nil end
	pcall(function()
		local roots = {}
		local pg = LP:FindFirstChild("PlayerGui")
		if pg then roots[#roots + 1] = pg end
		for _, root in ipairs(roots) do
			for _, d in ipairs(root:GetDescendants()) do
				if d:IsA("TextLabel") or d:IsA("TextButton") then
					local t = d.Text
					if t and t ~= "" and string.len(t) < 90 then
						if not IsChatUI(d) then
							local low = Norm(t)
							for kw in pairs(BOX_STRICT) do
								if string.find(low, Norm(kw), 1, true) then
									got = true
									return
								end
							end
						end
						if IsRedText(d) then
							for kw in pairs(BOX_REPLY) do
								if string.find(Norm(t), Norm(kw), 1, true) then
									got = true
									return
								end
							end
						end
					end
				end
				if got then return end
			end
			if got then return end
		end
	end)
	if got then return "BOX" end
	return nil
end


local JOURNAL_EV = {
	emf = "EMF", emflevel5 = "EMF", emf5 = "EMF",
	handprint = "HAND", prints = "HAND", print = "HAND",
	fingerprint = "HAND", footprint = "HAND", handprints = "HAND",
	spiritbox = "BOX", box = "BOX",
	freezing = "FREEZE", freezingtemps = "FREEZE", temperature = "FREEZE",
	ghostorb = "ORB", orb = "ORB", orbs = "ORB",
	ghostwriting = "WRITE", inscription = "WRITE", writing = "WRITE",
	laser = "LASER", laserprojector = "LASER", projector = "LASER",
	wither = "WITHER",
	["emf"] = "EMF", ["emf5"] = "EMF", ["电磁"] = "EMF",
	["手印"] = "HAND", ["指纹"] = "HAND", ["脚印"] = "HAND", ["痕迹"] = "HAND",
	["通灵盒"] = "BOX", ["灵盒"] = "BOX", ["灵魂盒"] = "BOX",
	["低温"] = "FREEZE", ["寒冷"] = "FREEZE", ["冰冻"] = "FREEZE",
	["灵球"] = "ORB", ["鬼球"] = "ORB", ["光球"] = "ORB",
	["铭文"] = "WRITE", ["鬼写字"] = "WRITE", ["笔记"] = "WRITE",
	["鬼写"] = "WRITE", ["灵书"] = "WRITE",
	["激光"] = "LASER", ["投影"] = "LASER",
	["枯萎"] = "WITHER", ["凋谢"] = "WITHER", ["生锈"] = "WITHER",
}

local function MatchJournalEv(n)
	local k = Norm(n)
	if JOURNAL_EV[k] then return JOURNAL_EV[k] end
	for kw, ev in pairs(JOURNAL_EV) do
		if string.find(k, Norm(kw), 1, true) then return ev end
	end
	return nil
end

local function IsMarked(o)
	local marked = false
	pcall(function()
		for k, v in pairs(o:GetAttributes()) do
			local kk = Norm(k)
			if string.find(kk, "check", 1, true) or string.find(kk, "mark", 1, true)
				or string.find(kk, "select", 1, true) or string.find(kk, "confirm", 1, true)
				or string.find(kk, "found", 1, true) or string.find(kk, "toggle", 1, true)
				or string.find(kk, "active", 1, true) or string.find(kk, "enabled", 1, true) then
				if v == true or v == 1 or tostring(v) == "true" then marked = true end
			end
		end
	end)
	if marked then return true end
	pcall(function()
		local nm = Norm(o.Name)
		if string.find(nm, "checked", 1, true) or string.find(nm, "marked", 1, true)
			or string.find(nm, "selected", 1, true) or string.find(nm, "confirmed", 1, true)
			or string.find(nm, "found", 1, true) then marked = true end
	end)
	if marked then return true end
	pcall(function()
		if o:IsA("TextLabel") or o:IsA("TextButton") then
			local c = o.TextColor3
			if c then
				local r, g, b = c.r or c.R or 0, c.g or c.G or 0, c.b or c.B or 0
				if r > 0.7 and g > 0.6 and b < 0.4 then marked = true end
			end
		end
	end)
	return marked
end

local function ScanJournal()
	local found = {}
	local seen = {}
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then return end
		for _, g in ipairs(pg:GetChildren()) do
			local gname = Norm(g.Name)
			local isJournal = string.find(gname, "journal", 1, true)
				or string.find(gname, "notebook", 1, true)
				or string.find(gname, "evidence", 1, true)
				or string.find(gname, "diary", 1, true)
				or string.find(gname, "日志", 1, true)
				or string.find(gname, "笔记", 1, true)
			if isJournal then
				for _, d in ipairs(g:GetDescendants()) do
					local ev = MatchJournalEv(d.Name)
					if not ev and (d:IsA("TextLabel") or d:IsA("TextButton")) then
						if d.Text and d.Text ~= "" then
							ev = MatchJournalEv(d.Text)
						end
					end
					if ev and not seen[ev] then
						if IsMarked(d) then
							seen[ev] = true
							found[#found + 1] = ev
						end
					end
				end
			end
		end
	end)
	return found
end

local BOOK_NAMES = {
	spiritbook = true, book = true, notebook = true, ghostbook = true,
	["灵书"] = true, ["灵魂之书"] = true, ["灵魂书"] = true,
	["笔记"] = true, ["笔记本"] = true, ["书"] = true,
}

local BOOK_WRITE_HINT = {
	written = true, haswriting = true, iswritten = true, wrote = true,
	marked = true, inscribed = true, inscription = true, hasmark = true,
	hasinscription = true, dirty = true, used = true, active = true,
	["已写"] = true, ["写字"] = true, ["铭文"] = true,
}

local function IsBookWritten(o)
	local hit = false
	pcall(function()
		for k, v in pairs(o:GetAttributes()) do
			local kk = Norm(k)
			if BOOK_WRITE_HINT[kk] then
				if v == true or v == 1 or tostring(v) == "true" then hit = true return end
			end
			for kw in pairs(BOOK_WRITE_HINT) do
				if string.find(kk, Norm(kw), 1, true) then
					if v == true or v == 1 or tostring(v) == "true" then hit = true return end
				end
			end
		end
	end)
	if hit then return true end
	pcall(function()
		for _, d in ipairs(o:GetDescendants()) do
			if d:IsA("BoolValue") then
				local kk = Norm(d.Name)
				for kw in pairs(BOOK_WRITE_HINT) do
					if string.find(kk, Norm(kw), 1, true) then
						if d.Value then hit = true return end
					end
				end
			end
			if d:IsA("Decal") or d:IsA("Texture") then
				local tn = Norm(d.Name) .. Norm(d.Texture)
				if string.find(tn, "writ", 1, true) or string.find(tn, "inscri", 1, true)
					or string.find(tn, "mark", 1, true) or string.find(tn, "scribble", 1, true) then
					hit = true
					return
				end
			end
			if d:IsA("TextLabel") then
				local t = d.Text
				if t and t ~= "" and string.len(t) > 0 then
					local tn = Norm(t)
					if string.find(tn, "writ", 1, true) or string.find(tn, "inscri", 1, true)
						or string.find(tn, "mark", 1, true) then hit = true return end
				end
			end
			if hit then return end
		end
	end)
	return hit
end

local function IsBookName(n)
	local k = Norm(n)
	if BOOK_NAMES[k] then return true end
	for kw in pairs(BOOK_NAMES) do
		if string.find(k, Norm(kw), 1, true) then return true end
	end
	return false
end

local function ScanBookWriting()
	if S.WriteConfirmed then return "WRITE" end
	local hit = false
	pcall(function()
		for _, e in ipairs(S.Items) do
			if IsBookName(e.key) or IsBookName(e.lab) then
				for _, o in ipairs(e.objs) do
					if IsBookWritten(o) then hit = true return end
				end
			end
			if hit then return end
		end
	end)
	if hit then S.WriteConfirmed = true return "WRITE" end
	local budget = CFG.ScanBudget
	pcall(function()
		local function look(f)
			if not f or budget <= 0 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 then return end
				if IsBookName(d.Name) then
					if IsBookWritten(d) then hit = true return end
				end
				if #d:GetChildren() > 0 and #d:GetChildren() < 60 then
					for _, g in ipairs(d:GetChildren()) do
						budget = budget - 1
						if budget <= 0 then return end
						if IsBookName(g.Name) then
							if IsBookWritten(g) then hit = true return end
						end
					end
				end
			end
		end
		look(WS)
		look(WS:FindFirstChild("Map"))
		local c = LP.Character
		if c then look(c) end
		local bp = LP:FindFirstChild("Backpack")
		if bp then look(bp) end
	end)
	if hit then S.WriteConfirmed = true return "WRITE" end
	return nil
end

local EV_SKIP = { emfreader = 1, emf = 1, thermometer = 1, thermo = 1, thermogun = 1,
	videocamera = 1, camera = 1, photocamera = 1, camcorder = 1,
	spiritbox = 1, box = 1, ghostbox = 1, flashlight = 1, torch = 1,
	blacklight = 1, uvlight = 1, uv = 1, flowerpot = 1, flower = 1,
	laserprojector = 1, projector = 1, compactprojector = 1, spiritbook = 1,
	book = 1, journal = 1, notebook = 1, radio = 1, headmountedcamera = 1,
	lidar = 1, salt = 1, saltcanister = 1, lighter = 1, lantern = 1,
	["电磁场仪"] = 1, ["温度计"] = 1, ["测温枪"] = 1, ["摄像机"] = 1, ["相机"] = 1,
	["通灵盒"] = 1, ["手电"] = 1, ["手电筒"] = 1, ["紫外灯"] = 1, ["花盆"] = 1,
	["激光投影仪"] = 1, ["投影仪"] = 1, ["灵书"] = 1, ["日志"] = 1, ["笔记"] = 1,
	["收音机"] = 1, ["盐罐"] = 1, ["打火机"] = 1, ["提灯"] = 1 }
local function IsGearName(n)
	local k = Norm(n)
	if EV_SKIP[k] then return true end
	for kw in pairs(EV_SKIP) do
		if string.find(k, kw, 1, true) then return true end
	end
	return false
end

local EV_ATTR = { evidence1 = 1, evidence2 = 1, evidence3 = 1, evidencea = 1, evidenceb = 1,
	evidencec = 1, firstevidence = 1, secondevidence = 1, thirdevidence = 1,
	evidences = 1, evidence = 1, evidencedata = 1, ghostevidence = 1 }
local EV_VAL = { emf5 = "EMF", emf = "EMF", emflevel5 = "EMF", ["emf5"] = "EMF",
	spiritbox = "BOX", box = "BOX", ghostbox = "BOX",
	freezing = "FREEZE", freezingtemp = "FREEZE", coldtemp = "FREEZE",
	["低温"] = "FREEZE", ["刺骨寒冷"] = "FREEZE", ["通灵盒"] = "BOX", ["灵盒"] = "BOX" }

local function EvFromValue(v)
	if v == nil then return nil end
	if type(v) == "boolean" then return nil end
	local k = Norm(tostring(v))
	if EV_VAL[k] then return EV_VAL[k] end
	return MatchEvGroup(tostring(v))
end

local function ScanEvidenceObjects()
	local found = {}
	local seen = {}
	local src = {}
	local function put(e, sname)
		if e and not seen[e] then
			seen[e] = true
			found[#found + 1] = e
			src[e] = sname or "对象"
		end
	end
	local function isPlayerStuff(o)
		local c = LP.Character
		if c and o:IsDescendantOf(c) then return true end
		local bp = LP:FindFirstChild("Backpack")
		if bp and o:IsDescendantOf(bp) then return true end
		local pg = LP:FindFirstChild("PlayerGui")
		if pg and o:IsDescendantOf(pg) then return true end
		return false
	end
	local budget = { n = 1500 }
	local function deepScan(root, depth)
		if not root or budget.n <= 0 then return end
		pcall(function()
			for _, d in ipairs(root:GetChildren()) do
				budget.n = budget.n - 1
				if budget.n <= 0 then return end
				if (not isPlayerStuff(d)) and (not IsGearName(d.Name)) then
					local ev = MatchEvGroup(d.Name)
					if ev then
						local isEmptyFolder = false
						pcall(function()
							if d:IsA("Folder") and #d:GetChildren() == 0 then isEmptyFolder = true end
						end)
						if not isEmptyFolder then put(ev, "场景对象") end
					elseif depth > 1 then
						local n = 0
						pcall(function() n = #d:GetChildren() end)
						if n > 0 and n < 400 then deepScan(d, depth - 1) end
					end
				end
			end
		end)
	end
	for _, nm in ipairs({ "Handprints", "Fingerprints", "Footprints", "Handprint",
		"GhostOrb", "GhostOrbs", "Orb", "Orbs", "OrbFolder",
		"GhostWriting", "GhostWritings", "Inscription", "Inscriptions",
		"Withered", "Wither", "Rusted", "Decay", "LaserProjector", "Projector",
		"Evidence", "EvidenceFolder", "Evidences", "FoundEvidence" }) do
		local o = WS:FindFirstChild(nm)
		if o and not IsGearName(o.Name) then
			local ev = MatchEvGroup(o.Name)
			if ev then
				local empty = false
				pcall(function() if o:IsA("Folder") and #o:GetChildren() == 0 then empty = true end end)
				if not empty then put(ev, "顶层对象") end
			end
		end
	end
	pcall(function()
		local g = GetGhost()
		if not g then return end
		for _, v in ipairs(g:GetChildren()) do
			if not isPlayerStuff(v) then
				local ev = MatchEvGroup(v.Name)
				if ev then
					local empty = false
					pcall(function() if v:IsA("Folder") and #v:GetChildren() == 0 then empty = true end end)
					if not empty then put(ev, "鬼身") end
				else
					local n = 0
					pcall(function() n = #v:GetChildren() end)
					if n > 0 and n < 200 then
						for _, w in ipairs(v:GetChildren()) do
							local e2 = MatchEvGroup(w.Name)
							if e2 then put(e2, "鬼身") end
						end
					end
				end
			end
		end
		for k, val in pairs(g:GetAttributes()) do
			local kk = Norm(k)
			if EV_ATTR[kk] then
				local ev = EvFromValue(val)
				if ev then put(ev, "鬼数据") end
			else
				local ev = MatchEvGroup(k)
				if ev and (val == true or val == 1 or tostring(val) == "true") then
					put(ev, "鬼数据")
				end
			end
		end
	end)
	deepScan(WS, 3)
	pcall(function()
		local m = WS:FindFirstChild("Map")
		if m then deepScan(m, 3) end
	end)
	pcall(function()
		local cs = GetRooms()
		if cs then for _, c in ipairs(cs) do deepScan(c, 2) end end
	end)
	if S.ManEv then
		for k in pairs(S.ManEv) do put(k, "手动") end
	end
	if S.LowestTemp and S.LowestTemp < CFG.FreezePoint then put("FREEZE", "温度实测") end
	local emf = ScanEMF()
	if emf then put(emf, "EMF读数") end
	local box = ScanBoxReply()
	if box then put(box, "鬼回应") end
	local bk = ScanBookWriting()
	if bk then put(bk, "灵书") end
	pcall(function()
		for _, ev in ipairs(ScanJournal()) do put(ev, "日志") end
	end)
	local out = {}
	local ocn = {}
	for _, ev in ipairs(found) do
		local cn = EvCN(ev)
		if cn and not ocn[cn] then
			ocn[cn] = true
			out[#out + 1] = cn
		end
	end
	table.sort(out)
	return out, found, src
end


local function SolveGhost(keys)
	if not keys or #keys < 1 then return nil, nil end
	local set = {}
	for _, k in ipairs(keys) do set[k] = true end

	local function exact(ks)
		local st = {}
		for _, k in ipairs(ks) do st[k] = true end
		local hits = {}
		for name, combo in pairs(GHOST_DB) do
			if #combo == #ks then
				local all = true
				for _, c in ipairs(combo) do
					if not st[c] then all = false break end
				end
				if all then hits[#hits + 1] = name end
			end
		end
		return hits
	end

	local function containing(ks)
		local hits = {}
		for name, combo in pairs(GHOST_DB) do
			local cset = {}
			for _, c in ipairs(combo) do cset[c] = true end
			local all = true
			for _, k in ipairs(ks) do
				if not cset[k] then all = false break end
			end
			if all then hits[#hits + 1] = name end
		end
		table.sort(hits)
		return hits
	end

	local hits = exact(keys)
	if #hits == 1 then return hits[1], { hits[1] } end

	local hasOrb = false
	for _, k in ipairs(keys) do
		if k == "ORB" then hasOrb = true end
	end

	if hasOrb then
		local rest = {}
		for _, k in ipairs(keys) do
			if k ~= "ORB" then rest[#rest + 1] = k end
		end
		local h2 = exact(rest)
		if #h2 == 1 then
			S.FakeOrb = true
			return h2[1], { h2[1] }
		end
		if #rest > 0 then
			local h3 = containing(rest)
			if #rest >= 2 and #keys > #rest then
				S.FakeOrb = true
			end
			if #h3 >= 1 then return nil, h3 end
		end
	end

	local cands = containing(keys)
	if #cands == 1 then return cands[1], { cands[1] } end
	return nil, cands
end


local function NeedEvidence(keys, cands)
	if not cands or #cands == 0 then return nil end
	local kset = {}
	for _, k in ipairs(keys) do kset[k] = true end
	local need = {}
	local seen = {}
	for _, name in ipairs(cands) do
		local combo = GHOST_DB[name]
		if combo then
			for _, c in ipairs(combo) do
				if not kset[c] and not seen[c] then
					seen[c] = true
					need[#need + 1] = c
				end
			end
		end
	end
	table.sort(need)
	if #need == 0 then return nil end
	return need
end

local function CheckEvidence()
	local out, keys, src = ScanEvidenceObjects()
	S.EvSrc = src or {}
	if #keys == #S.EvidenceKeys and #keys > 0 then
		local same = true
		for i, k in ipairs(keys) do
			if S.EvidenceKeys[i] ~= k then same = false break end
		end
		if same then
			S.Evidence = out
			return
		end
	end
	for _, k in ipairs(keys) do
		local exist = false
		for _, x in ipairs(S.EvidenceKeys) do
			if x == k then exist = true end
		end
		if not exist then
			Notify("发现证据", EvCN(k), 5, "ev|" .. k)
		end
	end
	S.EvidenceKeys = keys
	S.Evidence = out
	S.FakeOrb = false
	local name, cands = SolveGhost(keys)
	S.Ghost = name
	S.GhostCands = cands or {}
	S.GhostMulti = (name == nil)
	S.Need = NeedEvidence(keys, cands)
	if name and not S.GhostNotified then
		S.GhostNotified = true
		local cn = GHOST_CN[name] or name
		if S.FakeOrb then
			Notify("鬼种确定", cn .. " (灵球系伪造!)", 7, "ghost|" .. name)
		else
			Notify("鬼种确定", cn .. " (证据齐全)", 6, "ghost|" .. name)
		end
	end
	if not name then S.GhostNotified = false end
end



local HUNT_KEYS = { "hunting", "ishunting", "hunt", "huntingmode", "chasing", "aggro", "angry" }
local EXIT_KEYS = { "exit", "entrance", "frontdoor", "frontentrance", "maindoor",
	"backdoor", "sidedoor", "gate", "outside", "escape", "exitdoor", "exitsign" }
local HIDE_KEYS = { "closet", "locker", "hide", "hiding", "cabinet", "wardrobe", "hideout", "safe" }
local ROOM_KEYS = { "favoriteroom", "currentroom", "ghostroom", "room", "locatedroom" }

local function IsNameHit(n, keys)
	local k = Norm(n)
	for _, kw in ipairs(keys) do
		if string.find(k, kw, 1, true) then return true end
	end
	return false
end

local function AttrToBool(a)
	if a == true then return true end
	if a == false then return false end
	if a == 1 then return true end
	if a == 0 then return false end
	if type(a) == "string" then
		local low = string.lower(tostring(a))
		if low == "true" or low == "yes" or low == "on" then return true end
		if low == "false" or low == "no" or low == "off" then return false end
	end
	return nil
end

local function ReadAttrAny(o, keys)
	if not o then return nil, nil, nil end
	local ok, name, val, b = pcall(function()
		local ga = o.GetAttributes
		local attrs = nil
		if ga then
			local ok2, r2 = pcall(function() return ga(o) end)
			if ok2 then attrs = r2 end
		end
		if attrs then
			for k, v in pairs(attrs) do
				local nk = Norm(k)
				for _, kw in ipairs(keys) do
					if string.find(nk, kw, 1, true) or string.find(kw, nk, 1, true) then
						return k, v, AttrToBool(v)
					end
				end
			end
		end
		for _, n in ipairs(keys) do
			local a = o:GetAttribute(n)
			if a ~= nil then return n, a, AttrToBool(a) end
		end
	end)
	if ok and name then return name, val, b end
	return nil, nil, nil
end

local function ReadAttrBool(o, names)
	if not o then return nil end
	local _, _, b = ReadAttrAny(o, names)
	if b ~= nil then return b end
	return nil
end
local function ReadAttrNum(o, names)
	if not o then return nil end
	local ok, _, v, _ = pcall(function() return ReadAttrAny(o, names) end)
	if ok and v and tonumber(v) then return tonumber(v) end
	return nil
end



local function GetEnergy()
	local cands = { "Energy", "EnergyValue", "EnergyLevel", "CurrentEnergy", "PlayerEnergy" }
	local src = nil
	pcall(function()
		local plr = LP
		for _, n in ipairs(cands) do
			local v = plr:FindFirstChild(n)
			if v then
				local ok, val = pcall(function() return v.Value end)
				if ok and tonumber(val) then src = tonumber(val) return end
			end
		end
		local c = plr.Character
		if c then
			for _, n in ipairs(cands) do
				local v = c:FindFirstChild(n)
				if v then
					local ok, val = pcall(function() return v.Value end)
					if ok and tonumber(val) then src = tonumber(val) return end
				end
			end
		end
		local g = GetGhost()
		src = src or ReadAttrNum(plr, { "Energy", "CurrentEnergy" })
	end)
	return src
end

local function DetectHunt()
	local hunting = nil
	pcall(function()
		local g = GetGhost()
		local _, _, b = ReadAttrAny(g, HUNT_KEYS)
		if b == true then hunting = true return end
		if b == false then hunting = false return end
	end)
	if hunting ~= nil then return hunting end
	pcall(function()
		for _, o in ipairs(WS:GetChildren()) do
			if IsNameHit(o.Name, HUNT_KEYS) then
				local _, _, bb = ReadAttrAny(o, HUNT_KEYS)
				if bb == true then hunting = true return end
				if bb == false then hunting = false return end
			end
		end
		local m = WS:FindFirstChild("Map")
		if m then
			for _, o in ipairs(m:GetChildren()) do
				if IsNameHit(o.Name, HUNT_KEYS) then
					local _, _, bb = ReadAttrAny(o, HUNT_KEYS)
					if bb == true then hunting = true return end
					if bb == false then hunting = false return end
				end
			end
		end
	end)
	if hunting ~= nil then return hunting end
	return false
end

local function HuntSound()
	pcall(function()
		local ss = game:GetService("SoundService")
		local snd = Instance.new("Sound")
		snd.SoundId = "rbxassetid://9118823106"
		snd.Volume = 1
		snd.Parent = ss
		snd:Play()
		game:GetService("Debris"):AddItem(snd, 3)
	end)
end

local function NowSec()
	local ok, t = pcall(function()
		if tick then return tick() end
		if os and os.time then return os.time() end
	end)
	if ok and tonumber(t) then return tonumber(t) end
	return S.Mono or 0
end

local STATE_KEYS = { "state", "ghoststate", "mode", "behavior", "activity", "phase" }
local STATE_CN = {
	hunt = "猎杀中", hunting = "猎杀中", chase = "猎杀中", chaseing = "猎杀中",
	roam = "游荡中", roaming = "游荡中", wander = "游荡中", wandering = "游荡中",
	idle = "静止", calm = "平静", passive = "平静", normal = "平静",
	event = "显灵中", manifest = "显灵中", appearing = "显灵中",
	attack = "攻击中", angry = "暴怒",
}

local function GhostState()
	local g = GetGhost()
	if not g then return nil, nil end
	local raw = nil
	pcall(function()
		local _, v, _ = ReadAttrAny(g, STATE_KEYS)
		if v then
			raw = tostring(v)
		else
			local ok2, v2 = pcall(function() return g:GetAttribute("State") end)
			if ok2 and v2 then raw = tostring(v2) end
		end
	end)
	local cn = nil
	if raw then
		local k = Norm(raw)
		for kw, v in pairs(STATE_CN) do
			if string.find(k, kw, 1, true) then cn = v break end
		end
		if not cn then
			for kw, v in pairs(STATE_CN) do
				if string.find(kw, k, 1, true) then cn = v break end
			end
		end
	end
	if S.Hunting and (not cn or cn ~= "猎杀中") then cn = "猎杀中" end
	if not cn and S.Hunting then cn = "猎杀中" end
	return cn, raw
end

local function HuntAlert(on)
	local now = NowSec()
	if S.HuntLockAt and (now - S.HuntLockAt) < 10 then
		on = false
	elseif S.HuntLockAt and (now - S.HuntLockAt) >= 10 then
		S.HuntLockAt = nil
	end
	if on and CFG.HuntTimeout and S.HuntSince then
		if (now - S.HuntSince) > CFG.HuntTimeout then
			on = false
			S.HuntLockAt = now
		end
	end
	if on then
		if not S.HuntSince then S.HuntSince = now end
		S.HuntDur = now - S.HuntSince
		if S.HuntAt ~= S.HuntSince then
			S.HuntAt = S.HuntSince
			S.HuntCount = (S.HuntCount or 0) + 1
			Notify("猎杀预警 #" .. tostring(S.HuntCount), "鬼开始猎杀了 快躲起来或跑", 6, nil)
			HuntSound()
		end
	else
		S.HuntSince = nil
		S.HuntDur = nil
	end
	S.Hunting = on
end

local function GetDist(a, b)
	local ok, d = pcall(function()
		local pa = a:IsA("Model") and (a.PrimaryPart or a:FindFirstChild("HumanoidRootPart")) or a
		local pb = b:IsA("Model") and (b.PrimaryPart or b:FindFirstChild("HumanoidRootPart")) or b
		if pa and pb and pa.Position and pb.Position then
			return (pa.Position - pb.Position).Magnitude
		end
	end)
	if ok and d then return d end
	return nil
end

local function MarkExits()
	if not CFG.On.Exit then return end
	local count = 0
	pcall(function()
		local budget = 120
		local function walk(f, depth)
			if budget <= 0 or depth > 2 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 then return end
				if IsNameHit(d.Name, EXIT_KEYS) then
					Mark(d, CFG.ExitColor, "exit")
					count = count + 1
					if not S.ExitNav then S.ExitNav = d end
				end
				if depth < 2 and #d:GetChildren() > 0 and #d:GetChildren() < 200 then
					walk(d, depth + 1)
				end
			end
		end
		walk(WS, 1)
		local m = WS:FindFirstChild("Map")
		if m then walk(m, 1) end
	end)
	S.ExitCount = count
end

local function MarkHides()
	if not CFG.On.Hide then return end
	local count = 0
	pcall(function()
		local budget = 120
		local function walk(f, depth)
			if budget <= 0 or depth > 2 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 then return end
				if not IsNegative(d.Name) and IsNameHit(d.Name, HIDE_KEYS) then
					Mark(d, CFG.HideColor, "hide")
					count = count + 1
				end
				if depth < 2 and #d:GetChildren() > 0 and #d:GetChildren() < 200 then
					walk(d, depth + 1)
				end
			end
		end
		walk(WS, 1)
		local m = WS:FindFirstChild("Map")
		if m then walk(m, 1) end
	end)
	S.HideCount = count
end

local function MateLabel(char, name)
	pcall(function()
		if not CFG.On.Mate then return end
		local host = char:IsA("Model") and (char:FindFirstChild("Head") or char.PrimaryPart or char:FindFirstChildWhichIsA("BasePart")) or char
		if not host then return end
		local bb = host:FindFirstChild("DHMate")
		if bb then
			local lb = bb:FindFirstChild("DHMateText")
			if lb then lb.Text = name end
			return
		end
		local g = Instance.new("BillboardGui")
		g.Name = "DHMate"
		g.Adornee = host
		g.Size = UDim2.new(0, 100, 0, 22)
		g.StudsOffset = Vector3.new(0, 2.2, 0)
		g.AlwaysOnTop = true
		g.MaxDistance = 400
		local lb = Instance.new("TextLabel")
		lb.Name = "DHMateText"
		lb.Size = UDim2.new(1, 0, 1, 0)
		lb.BackgroundTransparency = 0.45
		lb.BackgroundColor3 = Color3.fromRGB(0, 30, 30)
		lb.TextColor3 = CFG.MateColor
		lb.Text = name
		lb.TextScaled = true
		lb.Font = Enum.Font.Code
		lb.Parent = g
		g.Parent = host
	end)
end

local function MarkMates()
	if not CFG.On.Mate then return end
	local count = 0
	pcall(function()
		local plrs = game:GetService("Players")
		for _, p in ipairs(plrs:GetPlayers()) do
			if p ~= LP and p.Character then
				Mark(p.Character, CFG.MateColor, "mate")
				MateLabel(p.Character, p.Name)
				count = count + 1
			end
		end
	end)
	S.MateCount = count
end

local function MarkGhostRoom()
	if not CFG.On.Room then return end
	pcall(function()
		local nm = nil
		local g = GetGhost()
		if g then
			local ok, v = pcall(function()
				return g:GetAttribute("FavoriteRoom") or g:GetAttribute("CurrentRoom") or g:GetAttribute("Room")
			end)
			if ok and v then nm = tostring(v) end
		end
		if not nm and S.LowestRoom then nm = S.LowestRoom end
		if not nm then return end
		local rooms = GetRooms()
		if not rooms then return end
		for _, r in ipairs(rooms:GetChildren()) do
			if Norm(r.Name) == Norm(nm) then
				Mark(r, CFG.RoomColor, "room")
				S.RoomMarked = r
				return
			end
		end
	end)
end

local function FuseState()
	if not CFG.On.Fuse then return nil, nil end
	local obj, on = nil, nil
	pcall(function()
		local budget = 200
		local function walk(f, depth)
			if obj or budget <= 0 or depth > 3 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 or obj then return end
				if IsNameHit(d.Name, { "fuse", "breaker", "electric", "powerbox" }) then
					obj = d
					on = ReadAttrBool(d, { "On", "Enabled", "Active", "Powered" })
					return
				end
				if depth < 3 and #d:GetChildren() > 0 and #d:GetChildren() < 200 then
					walk(d, depth + 1)
				end
			end
		end
		walk(WS, 1)
		local m = WS:FindFirstChild("Map")
		if m and not obj then walk(m, 1) end
	end)
	S.FuseObj, S.FuseOn = obj, on
	return obj, on
end

local function AutoJournal()
	if not CFG.On.AutoJournal then return end
	pcall(function()
		if not S.Evidence or #S.Evidence == 0 then return end
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then return end
		for _, ev in ipairs(S.Evidence) do
			local cn = EvCN(ev)
			if cn then
				for _, d in ipairs(pg:GetDescendants()) do
					if d:IsA("TextButton") or d:IsA("ImageButton") then
						local ok, txt = pcall(function() return d.Name .. tostring(d.Text) end)
						if ok and txt and string.find(Norm(txt), Norm(cn), 1, true) then
							pcall(function()
								if not IsMarked(d) then
									for _, e in ipairs({ "MouseButton1Click", "Activated", "MouseButton1Down" }) do
										if d[e] then d[e]:Fire() break end
									end
								end
							end)
						end
					end
				end
			end
		end
	end)
end

local function AutoFlash()
	if not CFG.On.Flash then return end
	pcall(function()
		local c = LP.Character
		if not c then return end
		for _, t in ipairs(c:GetChildren()) do
			if t:IsA("Tool") and IsNameHit(t.Name, { "flashlight", "lantern", "torch", "手电", "提灯", "灯笼" }) then
				pcall(function() t.Enabled = true end)
				local h = t:FindFirstChild("Handle")
				if h then
					for _, l in ipairs(h:GetDescendants()) do
						if l:IsA("SpotLight") or l:IsA("PointLight") then
							pcall(function() l.Enabled = true end)
						end
					end
				end
			end
		end
	end)
end

local function AutoPickup()
	if not CFG.On.AutoPick then return end
	pcall(function()
		local root = GetRoot()
		if not root then return end
		for _, e in ipairs(S.Cursed) do
			for _, o in ipairs(e.objs) do
				pcall(function()
					if not o.Parent then return end
					local d = GetDist(root, o)
					if d and d < 12 then
						local pr = o:FindFirstChildOfClass("ProximityPrompt")
						if pr then
							pr.HoldDuration = 0
							pr.MaxActivationDistance = 30
							pr.RequiresLineOfSight = false
							pcall(function() pr:InputHoldBegin() pr:InputHoldEnd() end)
						end
					end
				end)
			end
		end
	end)
end

local function DeadKeepVisible()
	pcall(function()
		local c = LP.Character
		if not c then return end
		for _, d in ipairs(c:GetDescendants()) do
			pcall(function()
				if d:IsA("BasePart") or d:IsA("MeshPart") then
					if d.Transparency and d.Transparency > 0.05 then d.Transparency = 0 end
					d.LocalTransparencyModifier = 0
					d.CanCollide = false
				end
				if d:IsA("Decal") or d:IsA("Texture") then
					if d.Transparency and d.Transparency > 0.05 then d.Transparency = 0 end
				end
			end)
		end
	end)
end

local function DeadEnableTools()
	pcall(function()
		local c = LP.Character
		local bp = LP:FindFirstChild("Backpack")
		local n = 0
		local function on(t)
			pcall(function()
				t.Enabled = true
				t.CanBeDropped = true
				t.Parent = c
				n = n + 1
			end)
		end
		if bp then
			for _, t in ipairs(bp:GetChildren()) do
				if t:IsA("Tool") then on(t) end
			end
		end
		if c then
			for _, t in ipairs(c:GetChildren()) do
				if t:IsA("Tool") then pcall(function() t.Enabled = true end) end
			end
		end
		return n
	end)
end

local function DeadOpenPrompts()
	pcall(function()
		local n = 0
		local budget = 400
		local function walk(f, depth)
			if budget <= 0 or depth > 3 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 then return end
				if d:IsA("ProximityPrompt") then
					pcall(function()
						d.Enabled = true
						d.MaxActivationDistance = 30
						d.HoldDuration = 0
						d.RequiresLineOfSight = false
					end)
					n = n + 1
				end
				if depth < 3 and #d:GetChildren() > 0 and #d:GetChildren() < 300 then
					walk(d, depth + 1)
				end
			end
		end
		walk(WS, 1)
		return n
	end)
end

local function DeadUnlockUI()
	pcall(function()
		local pg = LP:FindFirstChild("PlayerGui")
		if not pg then return end
		for _, d in ipairs(pg:GetDescendants()) do
			pcall(function()
				if d:IsA("TextButton") or d:IsA("ImageButton") then
					if d.Visible == false then d.Visible = true end
				elseif d:IsA("TextBox") then
					d.Visible = true
					d.Editable = true
					d.Active = true
				end
			end)
		end
	end)
end

local function DeadAssist()
	if not CFG.On.Dead then return end
	if not CFG.DeadHelp then return end
	if not IsDead() then
		if S.DeadDone then
			S.DeadDone = false
			S.DeadVisible = false
		end
		return
	end
	if S.DeadDone then
		if S.DeadTick then
			S.DeadTick = S.DeadTick + 1
			if S.DeadTick % 30 == 0 then
				DeadKeepVisible()
			end
		end
		return
	end
	S.DeadDone = true
	S.DeadTick = 0
	DeadKeepVisible()
	DeadEnableTools()
	DeadOpenPrompts()
	DeadUnlockUI()
	pcall(DeadChatFix)
	pcall(function()
		local c = LP.Character
		if c then Mark(c, Color3.fromRGB(255, 255, 255), "self") end
	end)
	Notify("死亡协助", "已恢复可见/互动 你仍可帮队友", 6, "deadassist")
end

local function NavLabel(obj, txt, col)
	if not obj or not CFG.On.Nav then return end
	if S.NavUsed and S.NavUsed >= CFG.NavMax then return end
	pcall(function()
		if obj:FindFirstChild("DHNav") then
			local old = obj:FindFirstChild("DHNav")
			local lb = old:FindFirstChild("DHNavText")
			if lb then lb.Text = txt end
			return
		end
		local host = obj
		if obj:IsA("Model") then
			host = obj.PrimaryPart or obj:FindFirstChild("HumanoidRootPart") or obj:FindFirstChildWhichIsA("BasePart")
		end
		if not host then return end
		local bb = Instance.new("BillboardGui")
		bb.Name = "DHNav"
		bb.Adornee = host
		bb.Size = UDim2.new(0, 120, 0, 26)
		bb.StudsOffset = Vector3.new(0, 2.5, 0)
		bb.AlwaysOnTop = true
		bb.MaxDistance = 250
		local lb = Instance.new("TextLabel")
		lb.Name = "DHNavText"
		lb.Size = UDim2.new(1, 0, 1, 0)
		lb.BackgroundTransparency = 0.4
		lb.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
		lb.TextColor3 = col or Color3.fromRGB(255, 255, 255)
		lb.Text = txt
		lb.TextScaled = true
		lb.Font = Enum.Font.Code
		lb.Parent = bb
		bb.Parent = host
		S.NavUsed = (S.NavUsed or 0) + 1
	end)
end

local function UpdateNav()
	if not CFG.On.Nav then return end
	pcall(function()
		S.NavUsed = 0
		local root = GetRoot()
		if not root then return end
		local function lbl(o, name, col)
			if not o then return end
			local d = GetDist(root, o)
			local txt = name
			if d then txt = name .. " " .. Fmt1(d) .. "m" end
			NavLabel(o, txt, col)
		end
		if S.RoomMarked then lbl(S.RoomMarked, "鬼房", CFG.RoomColor) end
		if S.Hunting then
			local g = GetGhost()
			if g then lbl(g, "鬼", CFG.HuntColor) end
		end
	end)
end

local function ClearNav()
	pcall(function()
		local n = 0
		for _, d in ipairs(WS:GetDescendants()) do
			if d.Name == "DHNav" then
				d:Destroy()
				n = n + 1
				if n > 40 then break end
			end
		end
	end)
	S.NavUsed = 0
end

local function NearestHide()
	local root = GetRoot()
	if not root then return nil, nil end
	local best, bd = nil, nil
	pcall(function()
		for obj in pairs(S.Mark) do
			if S.MarkTag[obj] == "hide" then
				local d = GetDist(root, obj)
				if d and (not bd or d < bd) then bd, best = d, obj end
			end
		end
	end)
	return best, bd
end

local function GuideHide()
	if not CFG.On.Hide then return end
	if not S.Hunting then
		if S.HideGuide then ClearNav() S.HideGuide = nil end
		return
	end
	pcall(function()
		local o, d = NearestHide()
		if o then
			S.HideGuide = o
			NavLabel(o, "躲这里 " .. Fmt1(d) .. "m", CFG.HideColor)
		elseif S.ExitNav then
			NavLabel(S.ExitNav, "出口", CFG.ExitColor)
		end
	end)
end

local function TempTrend()
	if not S.LowestTemp then return end
	pcall(function()
		S.TempLog = S.TempLog or {}
		local last = S.TempLog[#S.TempLog]
		if (not last) or math.abs(last - S.LowestTemp) > 0.4 then
			S.TempLog[#S.TempLog + 1] = S.LowestTemp
			if #S.TempLog > 12 then table.remove(S.TempLog, 1) end
		end
		if #S.TempLog >= 3 then
			local a = S.TempLog[#S.TempLog - 2]
			local b = S.TempLog[#S.TempLog]
			if b < a - 0.8 then S.TempDir = "下降"
			elseif b > a + 0.8 then S.TempDir = "回升"
			else S.TempDir = "平稳" end
		end
	end)
end

local function MateDeathWatch()
	pcall(function()
		local plrs = game:GetService("Players")
		for _, p in ipairs(plrs:GetPlayers()) do
			if p ~= LP and p.Character then
				local hum = p.Character:FindFirstChildOfClass("Humanoid")
				local dead = false
				if hum then
					local ok, hp = pcall(function() return hum.Health end)
					if ok and hp and hp <= 0 then dead = true end
				end
				if dead and not S.MateDead[p] then
					S.MateDead[p] = true
					Notify("队友倒下", tostring(p.Name) .. " 已死亡", 5, nil)
				elseif (not dead) and S.MateDead[p] then
					S.MateDead[p] = false
				end
			end
		end
	end)
end

local function DoneHint()
	if S.DoneHinted then return end
	if S.Ghost and (not S.FakeOrb) then
		S.DoneHinted = true
		Notify("可以撤了", "鬼种已确定: " .. tostring(GhostCN(S.Ghost)) .. " 回卡车交差", 6, "done")
	end
end

local function CursedWarn()
	pcall(function()
		local e = GetEnergy()
		if not e then return end
		if e < CFG.CursedWarn and not S.CursedWarned then
			S.CursedWarned = true
			Notify("能量过低", "当前 " .. Fmt1(e) .. "% 别再用诅咒物 会触发猎杀", 6, "energy")
		elseif e >= CFG.CursedWarn then
			S.CursedWarned = false
		end
	end)
end

local function ShowGhost(g)
	if not g or not CFG.On.Ghost then return end
	if CFG.On.GhostAlways ~= false then
		pcall(function()
			for _, d in ipairs(g:GetDescendants()) do
				if d:IsA("BasePart") or d:IsA("MeshPart") then
					pcall(function()
						if d.Transparency and d.Transparency > 0.02 then d.Transparency = 0 end
						d.LocalTransparencyModifier = 0
					end)
				end
			end
		end)
	end
	local parts = {}
	if g:IsA("BasePart") or g:IsA("MeshPart") then
		parts[#parts + 1] = g
	else
		local vp = g:FindFirstChild("VisibleParts")
		pcall(function()
			for _, c in ipairs((vp or g):GetDescendants()) do
				if c:IsA("MeshPart") or c:IsA("BasePart") then
					parts[#parts + 1] = c
				end
			end
		end)
	end
	for _, p in ipairs(parts) do
		pcall(function()
			p.Transparency = 0
			p.LocalTransparencyModifier = 0
			p.CanCollide = false
		end)
	end
	Mark(g, CFG.GhostColor, "ghost")
end

local function BuildUI()
	if S.Gui then pcall(function() S.Gui:Destroy() end) end
	local pg = LP:FindFirstChild("PlayerGui")
	if not pg then
		local ok, r = pcall(function() return LP:WaitForChild("PlayerGui", 8) end)
		if ok then pg = r end
	end
	if not pg then return end
	local g = Instance.new("ScreenGui")
	g.Name = "DemonUI"
	g.ResetOnSpawn = false
	g.Parent = pg
	S.Gui = g
	local p = Instance.new("Frame", g)
	p.Size = UDim2.new(0.50, 0, 0.94, 0)
	p.Position = UDim2.new(0.48, 0, 0.03, 0)
	p.BackgroundColor3 = Color3.fromRGB(10, 10, 16)
	p.BackgroundTransparency = 0.15
	p.BorderSizePixel = 0
	p.Active = true
	p.Draggable = true
	local t = Instance.new("TextLabel", p)
	t.Size = UDim2.new(1, 0, 0, 26)
	t.Text = "恶魔学"
	t.TextColor3 = Color3.fromRGB(255, 120, 120)
	t.BackgroundTransparency = 1
	t.TextScaled = true
	t.Font = Enum.Font.Code
	S.TitleText = t
	local tt = Instance.new("TextLabel", p)
	tt.Size = UDim2.new(1, -10, 0, 22)
	tt.Position = UDim2.new(0, 5, 0, 28)
	tt.Text = "温度 -"
	tt.TextColor3 = Color3.fromRGB(150, 220, 255)
	tt.BackgroundTransparency = 1
	tt.TextScaled = true
	tt.Font = Enum.Font.Code
	tt.TextXAlignment = Enum.TextXAlignment.Left
	S.TempText = tt
	for i = 1, 52 do
		pcall(function()
			local l = Instance.new("TextLabel")
			l.Name = "DL" .. i
			l.Size = UDim2.new(1, -10, 0, 12)
			l.Position = UDim2.new(0, 5, 0, 46 + (i - 1) * 12)
			l.BackgroundTransparency = 1
			l.Text = ""
			l.TextScaled = true
			l.Parent = p
			pcall(function() l.TextColor3 = Color3.fromRGB(215, 215, 225) end)
			pcall(function() l.Font = Enum.Font.Code end)
			pcall(function() l.TextXAlignment = Enum.TextXAlignment.Left end)
			S.Lines[i] = l
		end)
	end
end

EnsureUI = function()
	local n = 0
	for _ in pairs(S.Lines) do n = n + 1 end
	if n < 26 or not S.Gui or not S.Gui.Parent then
		pcall(BuildUI)
	end
end

local function SetLine(i, txt, col)
	local l = S.Lines[i]
	if not l then return end
	pcall(function()
		l.Text = txt or ""
		l.TextColor3 = col or Color3.fromRGB(215, 215, 225)
	end)
end

local function DrawUI()
	EnsureUI()
	local y = 0
	local function add(txt, col)
		y = y + 1
		SetLine(y, txt, col)
	end
	local st = S.GhostState
	if st then
		local sc = Color3.fromRGB(200, 200, 210)
		if st == "猎杀中" then sc = CFG.HuntColor
		elseif st == "显灵中" or st == "攻击中" or st == "暴怒" then sc = Color3.fromRGB(255, 140, 80)
		elseif st == "游荡中" then sc = Color3.fromRGB(255, 220, 120) end
		add("鬼状态 " .. st, sc)
		if S.Hunting and S.HuntDur then
			add("  已持续 " .. Fmt1(S.HuntDur) .. "s", CFG.HuntColor)
		end
	end
	if S.Hunting then
		add("!! 猎杀中 !!", CFG.HuntColor)
		if S.HuntCount and S.HuntCount > 1 then
			add("  第 " .. S.HuntCount .. " 次", CFG.HuntColor)
		end
		if S.HideCount and S.HideCount > 0 then
			add("  躲藏点 " .. S.HideCount .. " 紫框", CFG.HideColor)
		end
		if S.ExitCount and S.ExitCount > 0 then
			add("  出口 " .. S.ExitCount .. " 绿框", CFG.ExitColor)
		end
	end
	local gd = S.GhostDist
	if gd then
		local gc = S.Hunting and CFG.HuntColor or Color3.fromRGB(255, 200, 200)
		local mark = ""
		if gd < 8 then mark = " !近!" end
		add("鬼距离 " .. Fmt1(gd) .. "m" .. mark, gc)
	end
	if st or S.Hunting or gd then
		y = y + 1
	end
	local en = S.Energy
	if en then
		local col = Color3.fromRGB(160, 255, 160)
		if en < CFG.CursedWarn then col = Color3.fromRGB(255, 120, 120)
		elseif en < CFG.HuntThreshold then col = Color3.fromRGB(255, 200, 100) end
		add("能量 " .. Fmt1(en) .. "%", col)
	end
	if S.GhostDist then
		add("鬼距离 " .. Fmt1(S.GhostDist) .. "m", S.Hunting and CFG.HuntColor or Color3.fromRGB(255, 200, 200))
	end
	if S.HuntCount and S.HuntCount > 0 then
		add("猎杀次数 " .. tostring(S.HuntCount), Color3.fromRGB(255, 150, 150))
	end
	if S.DeadDone then
		add("死亡协助 已开启", Color3.fromRGB(180, 255, 220))
	end
	if S.FuseOn ~= nil then
		add("电闸 " .. (S.FuseOn and "开" or "关"), S.FuseOn and Color3.fromRGB(160, 255, 160) or Color3.fromRGB(255, 160, 160))
	end
	if CFG.On.FPS and S.FPS then
		add("FPS " .. tostring(S.FPS), Color3.fromRGB(120, 140, 160))
	end
	if S.MateCount and S.MateCount > 0 then
		add("队友 " .. S.MateCount .. " 青框", CFG.MateColor)
	end
	if S.Hunting or en or S.GhostDist or (S.FuseOn ~= nil) or (CFG.On.FPS and S.FPS)
		or (S.MateCount and S.MateCount > 0) or S.DeadDone or (S.HuntCount and S.HuntCount > 0) then
		y = y + 1
	end
	add("证据 " .. #S.Evidence, Color3.fromRGB(255, 220, 100))
	if #S.Evidence == 0 then
		add("  未确认", Color3.fromRGB(120, 120, 130))
	else
		for _, e in ipairs(S.Evidence) do
			local sname = nil
			if S.EvSrc and #S.EvidenceKeys == #S.Evidence then
				for i2, k2 in ipairs(S.EvidenceKeys) do
					if EvCN(k2) == e then sname = S.EvSrc[k2] break end
				end
			end
			add("  " .. e .. (sname and (" (" .. sname .. ")") or ""), Color3.fromRGB(230, 255, 150))
		end
	end
	y = y + 1
	if S.LowestTemp then
		local cn = RoomCN(S.LowestRoom) or S.LowestRoom or "?"
		local col = Color3.fromRGB(150, 220, 255)
		if S.LowestTemp < CFG.FreezePoint then col = Color3.fromRGB(120, 200, 255) end
		add("最冷 " .. Fmt1(S.LowestTemp) .. "°C (" .. cn .. ")", col)
		if S.TempDir then
			local tc = Color3.fromRGB(150, 220, 255)
			if S.TempDir == "下降" then tc = Color3.fromRGB(120, 210, 255) end
			add("  趋势 " .. S.TempDir, tc)
		end
	end
	y = y + 1
	add("鬼房", CFG.RoomColor)
	if S.Room then
		add("  " .. tostring(S.Room), CFG.RoomColor)
	else
		add("  未确定", Color3.fromRGB(120, 120, 130))
	end
	y = y + 1
	if S.Ghost then
		local cn = GhostCN(S.Ghost)
		if S.FakeOrb then
			add("鬼种 " .. cn, Color3.fromRGB(255, 210, 120))
			add("  ⚠灵球系伪造", Color3.fromRGB(255, 120, 120))
		else
			add("鬼种 " .. cn, Color3.fromRGB(160, 255, 160))
		end
	else
		local n = #S.EvidenceKeys
		if S.FakeOrb then
			add("⚠灵球疑似伪造", Color3.fromRGB(255, 120, 120))
		end
		if n > 0 then
			add("鬼种 待定(" .. n .. "/3)", Color3.fromRGB(160, 200, 255))
		else
			add("鬼种 未开始", Color3.fromRGB(120, 120, 130))
		end
		local cs = S.GhostCands
		if cs and #cs > 0 then
			local names = {}
			for i = 1, math.min(#cs, 3) do
				names[#names + 1] = GhostCN(cs[i])
			end
			add("  可能是 " .. table.concat(names, "/"), Color3.fromRGB(220, 200, 160))
			if #cs > 3 then
				add("  +" .. (#cs - 3) .. "种", Color3.fromRGB(120, 120, 130))
			end
			if S.Need and #S.Need > 0 then
				local nn = {}
				for i = 1, math.min(#S.Need, 4) do
					nn[#nn + 1] = EvCN(S.Need[i])
				end
				add("  去查: " .. table.concat(nn, "/"), Color3.fromRGB(255, 230, 140))
			end
		end
	end
	y = y + 1
	local function totalItems()
		local n = 0
		for _, e in ipairs(S.Items) do n = n + e.count end
		return n
	end
	add("道具 " .. totalItems(), CFG.ItemColor)
	if #S.Items == 0 then
		add("  未发现", Color3.fromRGB(120, 120, 130))
	else
		for i = 1, math.min(#S.Items, 8) do
			local e = S.Items[i]
			local txt = e.lab
			if e.count > 1 then txt = txt .. " x" .. e.count end
			add("  " .. txt, CFG.ItemColor)
		end
		if #S.Items > 8 then
			local rest = 0
			for i = 9, #S.Items do rest = rest + S.Items[i].count end
			add("  +" .. rest, Color3.fromRGB(120, 120, 130))
		end
	end
	y = y + 1
	if #S.Cursed == 0 then
		add("诅咒物 无", Color3.fromRGB(130, 130, 140))
	else
		local cn = 0
		for _, e in ipairs(S.Cursed) do cn = cn + e.count end
		add("诅咒物 x" .. cn, CFG.CursedColor)
		for i = 1, math.min(#S.Cursed, 5) do
			local e = S.Cursed[i]
			local txt = e.lab
			if e.count > 1 then txt = txt .. " x" .. e.count end
			add("  " .. txt, CFG.CursedColor)
		end
	end
end

local function Tick()
	pcall(CheckTemp)
	pcall(CheckEvidence)
	pcall(function()
		local g = GetGhost()
		if g then
			pcall(function()
				local r = g:GetAttribute("FavoriteRoom") or g:GetAttribute("CurrentRoom")
				if r then S.Room = RoomCN(r) end
			end)
			ShowGhost(g)
		end
		if not S.Room then
			local _, _, lowRoom = MeasureTemp()
			if lowRoom then S.Room = RoomCN(lowRoom) end
		end
	end)
	pcall(RescanItems)
	pcall(DrawUI)
end

local function Step(dt)
	dt = (type(dt) == "number" and dt > 0 and dt < 1) and dt or 0.016
	S.Mono = (S.Mono or 0) + dt
	S.Frame = (S.Frame or 0) + 1
	S.FpsAcc = (S.FpsAcc or 0) + dt
	if S.FpsAcc >= 0.5 then
		S.FPS = math.floor(S.Frame / S.FpsAcc + 0.5)
		S.Frame, S.FpsAcc = 0, 0
		if CFG.On.FPS and S.FPS and S.FPS < CFG.LowFPS then
			CFG.Tick = math.min(3, CFG.Tick + 0.5)
			CFG.TempTick = math.min(3, CFG.TempTick + 0.5)
		elseif CFG.On.FPS and S.FPS and S.FPS > 45 then
			CFG.Tick = math.max(1.5, CFG.Tick - 0.25)
			CFG.TempTick = math.max(1, CFG.TempTick - 0.25)
		end
	end
	S.Timer = S.Timer + dt
	if S.Timer >= CFG.Tick then
		S.Timer = 0
		pcall(Tick)
	end
	S.TempTimer = S.TempTimer + dt
	if S.TempTimer >= CFG.TempTick then
		S.TempTimer = 0
		pcall(CheckTemp)
	end
	S.FastTimer = (S.FastTimer or 0) + dt
	if S.FastTimer >= 0.25 then
		S.FastTimer = 0
		pcall(function()
			local e = GetEnergy()
			S.Energy = e
		end)
		pcall(function()
			local h = DetectHunt() == true
			S.Hunting = h
			HuntAlert(h)
		end)
		pcall(function()
			local g = GetGhost()
			local root = GetRoot()
			if g and root then
				local d = GetDist(root, g)
				S.GhostDist = d
				S.HuntDist = d
			end
		end)
		pcall(function()
			local cn, raw = GhostState()
			S.GhostState = cn
			S.GhostStateRaw = raw
		end)
		pcall(MarkMates)
		pcall(CursedWarn)
		pcall(MateDeathWatch)
	end
	S.SlowTimer = (S.SlowTimer or 0) + dt
	if S.SlowTimer >= 3 then
		S.SlowTimer = 0
		pcall(MarkExits)
		pcall(MarkHides)
		pcall(MarkGhostRoom)
		pcall(FuseState)
		pcall(AutoFlash)
		pcall(UpdateNav)
		pcall(GuideHide)
		pcall(TempTrend)
		pcall(DoneHint)
	end
	S.MidTimer = (S.MidTimer or 0) + dt
	if S.MidTimer >= 5 then
		S.MidTimer = 0
		pcall(AutoJournal)
		pcall(AutoPickup)
	end
	pcall(DeadStep)
	pcall(DeadAssist)
	S.BrightTimer = (S.BrightTimer or 0) + dt
	if S.BrightTimer >= 2 then
		S.BrightTimer = 0
		if CFG.On.Bright then ApplyBright() end
	end
end

local function StartMusic()
	local snd = nil
	pcall(function()
		local ss = game:GetService("SoundService")
		snd = Instance.new("Sound")
		snd.Name = "DemonologyMusic"
		snd.SoundId = "rbxassetid://" .. tostring(CFG.MusicId)
		snd.Looped = true
		snd.Volume = CFG.MusicVolume
		snd.Parent = ss
	end)
	if not snd then return false end
	pcall(function() snd:Play() end)
	S.Music = snd
	S.MusicOn = true
	return true
end

local function StopMusic()
	pcall(function()
		if S.Music then
			S.Music:Stop()
			S.Music:Destroy()
		end
	end)
	S.Music = nil
	S.MusicOn = false
end
local API = {}
API.Rescan = function() pcall(Tick) end
API.Diag = function()
	print("===== DIAG =====")
	pcall(function()
		local g = WS:FindFirstChild("Ghost")
		print("Ghost:", g and g.Name or "nil")
		if g then
			for k, v in pairs(g:GetAttributes()) do print("  " .. tostring(k) .. "=" .. tostring(v)) end
		end
		for _, n in ipairs({ "Handprints", "GhostOrb", "GhostWriting", "Items", "CursedPossessions", "Map", "Rooms" }) do
			local f = WS:FindFirstChild(n)
			print(string.format("  %s: %s", n, f and ("有 子" .. #f:GetChildren()) or "无"))
		end
		local rooms = GetRooms()
		if rooms then
			for _, r in ipairs(rooms:GetChildren()) do
				print("  room " .. r.Name .. " temp=" .. tostring(ReadTemp(r)))
			end
		end
		local c = 0
		for _, d in ipairs(WS:GetDescendants()) do
			if d:IsA("Tool") or (d:IsA("Model") and d.Parent == WS) then
				c = c + 1
				if c <= 30 then print("  obj " .. d.Name .. " [" .. d.ClassName .. "]") end
			end
		end
		print("  顶层/工具 " .. c)
	end)
		local tv, tsrc, tname = FindThermometer()
		print("体温计: " .. tostring(tname) .. " 读数=" .. tostring(tv) .. " 来源=" .. tostring(tsrc))
		pcall(function()
			local c = LP.Character
			local bp = LP:FindFirstChild("Backpack")
			local n = 0
			local function dump(o)
				n = n + 1
				if n > 40 then return end
				print("  候选 " .. tostring(o.Name) .. " [" .. o.ClassName .. "]")
				for k, v in pairs(o:GetAttributes()) do
					print("    attr " .. tostring(k) .. "=" .. tostring(v))
				end
				for _, d in ipairs(o:GetDescendants()) do
					if d:IsA("NumberValue") or d:IsA("IntValue") or d:IsA("StringValue") then
						print("    val " .. tostring(d.Name) .. "=" .. tostring(d.Value))
					elseif d:IsA("TextLabel") and d.Text and d.Text ~= "" then
						print("    text " .. tostring(d.Name) .. "=" .. tostring(d.Text))
					end
				end
			end
			if c then
				for _, d in ipairs(c:GetDescendants()) do
					if IsThermoName(d.Name) then dump(d) end
				end
			end
			if bp then
				for _, d in ipairs(bp:GetDescendants()) do
					if IsThermoName(d.Name) then dump(d) end
				end
			end
		end)
	print("===== END =====")
end
API.Unload = function()
	RestoreBright()
	pcall(ClearNav)
	pcall(StopMusic)
	for obj in pairs(S.Mark) do Unmark(obj) end
	if S.Gui then pcall(function() S.Gui:Destroy() end) end
	S.Gui = nil
	S.Lines = {}
	for _, c in ipairs(S.Conn) do pcall(function() c:Disconnect() end) end
	S.Conn = {}
end
API.SetBright = function(v)
	CFG.On.Bright = (v ~= false)
	if CFG.On.Bright then
		ApplyBright()
	else
		RestoreBright()
	end
end
API.SetBrightLevel = function(v)
	local b = tonumber(v)
	if b then
		CFG.Bright.Brightness = b
		ApplyBright()
	end
end
API.AddItem = function(n, lab) if n then ITEMS[Norm(n)] = lab or tostring(n) end end
API.AddCursed = function(n, lab) if n then CURSED[Norm(n)] = lab or tostring(n) end end
API.AddEvidence = function(n, lab) if n then EVIDENCE[Norm(n)] = lab or tostring(n) end end
API.Notify = Notify
API.GetEvidence = function() return S.Evidence end
API.GetTemp = function() return S.Temp end
API.SetFreezePoint = function(v) CFG.FreezePoint = tonumber(v) or 0 end

API.SetMusic = function(id, vol)
	if id then CFG.MusicId = id end
	if vol then CFG.MusicVolume = vol end
	pcall(StopMusic)
	return StartMusic()
end

API.StopMusic = function()
	StopMusic()
	return true
end

API.MusicOn = function()
	return S.MusicOn == true
end

API.GetNeed = function()
	if not S.Need then return nil end
	local out = {}
	for _, k in ipairs(S.Need) do out[#out + 1] = EvCN(k) end
	return out
end

API.DebugWords = function(n)
	if not n then return "nil" end
	local k = Norm(n)
	local direct = RoomCN(n)
	local reverse = nil
	for key, cn in pairs(ROOMS) do
		if cn == direct or cn == k then reverse = (reverse and (reverse .. ",") or "") .. tostring(key) end
	end
	return "输入=" .. tostring(n) .. " 归一=" .. tostring(k)
		.. " 翻译=" .. tostring(direct)
		.. " 反向key=" .. tostring(reverse or "无")
end

API.CnRoom = function(n)
	return RoomCN(n)
end

API.GetEnergy = function() return S.Energy end
API.IsHunting = function() return S.Hunting == true end
API.GetGhostDist = function() return S.GhostDist end
API.GetFuse = function() return S.FuseOn end
API.GetFPS = function() return S.FPS end
API.SetAutoPick = function(v) CFG.On.AutoPick = (v == true) return CFG.On.AutoPick end
local EV_ALL = { "HAND", "ORB", "WRITE", "FREEZE", "BOX", "EMF", "LASER", "WITHER" }
local function EvKeyFromCN(cn)
	if not cn then return nil end
	for _, k in ipairs(EV_ALL) do
		if EvCN(k) == cn then return k end
	end
	local n = Norm(cn)
	for _, k in ipairs(EV_ALL) do
		local c = EvCN(k)
		if c and (string.find(Norm(c), n, 1, true) or string.find(n, Norm(c), 1, true)) then return k end
	end
	return nil
end

local SYS_SKIP = { ghost = 1, ghosts = 1, character = 1, characters = 1, player = 1,
	players = 1, map = 1, workspace = 1, terrain = 1, camera = 1, rooms = 1,
	room = 1, lighting = 1, spawnlocation = 1, spawn = 1, truck = 1, van = 1,
	npc = 1, dummy = 1, rig = 1, humanoid = 1, sky = 1, sun = 1,
	["鬼"] = 1, ["幽灵"] = 1, ["角色"] = 1, ["玩家"] = 1, ["地图"] = 1,
	["房间"] = 1, ["卡車"] = 1, ["卡车"] = 1, ["出生点"] = 1 }

local function IsPlayerThing(o)
	local nm = nil
	pcall(function() nm = tostring(o.Name) end)
	if not nm then return false end
	local k = Norm(nm)
	local ok = false
	pcall(function()
		local ps = game:GetService("Players")
		local list = nil
		if type(ps.GetPlayers) == "function" then
			list = ps:GetPlayers()
		end
		if (not list) and type(ps.GetChildren) == "function" then
			list = ps:GetChildren()
		end
		if not list then return end
		for _, p in ipairs(list) do
			if k == Norm(tostring(p.Name)) then ok = true return end
			if p.Character and o:IsDescendantOf(p.Character) then ok = true return end
		end
	end)
	if ok then return true end
	if LP then
		local okc = false
		pcall(function()
			if LP.Character and o:IsDescendantOf(LP.Character) then okc = true end
			if k == Norm(tostring(LP.Name)) then okc = true end
		end)
		if okc then return true end
	end
	local ok2 = false
	pcall(function()
		if o.FindFirstChildWhichIsA and o:FindFirstChildWhichIsA("Humanoid") then ok2 = true end
	end)
	return ok2
end

local function LooksLikeObject(n)
	local k = Norm(n)
	if k == "" then return false end
	if SYS_SKIP[k] then return false end
	for kw in pairs(SYS_SKIP) do
		if string.find(k, kw, 1, true) then return false end
	end
	if IsNegative(n) then return false end
	if IsGearName and IsGearName(n) then return false end
	if PART_JUNK[k] then return false end
	local junk2 = { part = 1, mesh = 1, union = 1, wedge = 1, terrain = 1,
		folder = 1, model = 1, terraindetail = 1, workspace = 1, camera = 1,
		["地形"] = 1, ["文件夹"] = 1, ["模型"] = 1 }
	if junk2[k] then return false end
	if string.match(k, "^[%d%s_%-]+$") then return false end
	if string.len(k) < 2 then return false end
	return true
end

API.Unknowns = function(maxShow)
	maxShow = tonumber(maxShow) or 25
	local out = {}
	local seen = {}
	local known = {}
	for _, e in ipairs(S.Items) do
		for _, o in ipairs(e.objs) do known[o] = true end
	end
	for _, e in ipairs(S.Cursed) do
		for _, o in ipairs(e.objs) do known[o] = true end
	end
	pcall(function()
		local budget = 1200
		local function walk(f, depth)
			if budget <= 0 or depth > 3 then return end
			for _, d in ipairs(f:GetChildren()) do
				budget = budget - 1
				if budget <= 0 then return end
				if (not known[d]) and (not IsStarterGear(d)) and (not HasGearAncestor(d))
					and (not IsPlayerThing(d)) then
					local isc = false
					pcall(function()
						if d:IsA("Model") or d:IsA("BasePart") or d:IsA("MeshPart")
							or d:IsA("Tool") then isc = true end
					end)
					if isc and LooksLikeObject(d.Name) then
						local nm = tostring(d.Name)
						if not seen[nm] then
							seen[nm] = true
							out[#out + 1] = nm
						end
					end
				end
				if depth < 3 then
					local c = 0
					pcall(function() c = #d:GetChildren() end)
					if c > 0 and c < 200 then walk(d, depth + 1) end
				end
			end
		end
		walk(WS, 1)
	end)
	table.sort(out)
	local res = {}
	for i = 1, math.min(maxShow, #out) do res[#res + 1] = out[i] end
	local txt = table.concat(res, ", ")
	print("[DH] 场景里未识别的对象(" .. tostring(#out) .. "种): " .. txt)
	return txt, #out
end

API.ForceDead = function(v)
	if v == nil then v = true end
	S.ForceDead = (v and true) or nil
	if S.ForceDead then
		S.WasDead = false
		S.DeadDone = false
	end
	return S.ForceDead == true
end

API.DeadNow = function()
	S.WasDead = false
	S.DeadDone = false
	pcall(DeadAssist)
	pcall(DeadStep)
	return true
end

API.ClearHunt = function()
	S.Hunting = false
	S.HuntLockAt = nil
	S.HuntSince = nil
	S.HuntDur = nil
	S.HuntAt = nil
	S.GhostState = nil
	S.HuntNotified = false
	return true
end

API.MarkEvidence = function(cn)
	local k = EvKeyFromCN(cn)
	if not k then return false end
	S.ManEv = S.ManEv or {}
	S.ManEv[k] = true
	pcall(Tick)
	return true
end

API.UnmarkEvidence = function(cn)
	local k = EvKeyFromCN(cn)
	if not k then return false end
	if S.ManEv then S.ManEv[k] = nil end
	pcall(Tick)
	return true
end

API.SetEvidence = function(list)
	S.ManEv = {}
	if not list then pcall(Tick) return true end
	local n = 0
	for w in string.gmatch(tostring(list), "[^,%s/、]+") do
		local k = EvKeyFromCN(w)
		if k then S.ManEv[k] = true n = n + 1 end
	end
	pcall(Tick)
	return n
end

API.ListEvidenceNames = function()
	local out = {}
	for _, k in ipairs(EV_ALL) do out[#out + 1] = EvCN(k) end
	return table.concat(out, ",")
end

API.Find = function(name)
	if not name then return nil end
	local k = Norm(name)
	local hit = nil
	pcall(function()
		for _, e in ipairs(S.Items) do
			if Norm(e.lab) == k or string.find(Norm(e.lab), k, 1, true) then
				hit = e.objs[1]
				break
			end
		end
		if not hit then
			for _, e in ipairs(S.Cursed) do
				if Norm(e.lab) == k or string.find(Norm(e.lab), k, 1, true) then
					hit = e.objs[1]
					break
				end
			end
		end
	end)
	if not hit then return nil end
	pcall(function()
		ClearNav()
		S.NavUsed = 0
		local root = GetRoot()
		local d = root and GetDist(root, hit) or nil
		NavLabel(hit, tostring(name) .. (d and (" " .. Fmt1(d) .. "m") or ""), CFG.ItemColor)
		Mark(hit, Color3.fromRGB(255, 255, 255), "find")
	end)
	return hit
end

API.ListItems = function()
	local out = {}
	for _, e in ipairs(S.Items) do out[#out + 1] = e.lab .. (e.count > 1 and ("x" .. e.count) or "") end
	return table.concat(out, ",")
end

API.ListCursed = function()
	local out = {}
	for _, e in ipairs(S.Cursed) do out[#out + 1] = e.lab .. (e.count > 1 and ("x" .. e.count) or "") end
	return table.concat(out, ",")
end

API.Help = function()
	return [[
DEMONOLOGY 用法
  GetEvidence() 证据  GetTemp() 温度  GetLowest() 最冷房
  GetGhost() 鬼种  GetCandidates() 候选  GetNeed() 还差什么
  GetEnergy() 能量  IsHunting() 是否猎杀  GetGhostState() 鬼状态
  GetGhostDist() 鬼距离(米)  GetFuse() 电闸  GetFPS() 帧率
  Find("能量饮料") 高亮并导航到该物品
  ListItems() 列出道具  ListCursed() 列出诅咒物
  Say("消息") 死后也能发  Snapshot() 一次拿全部状态
  开关: SetBright/SetGlow/SetBox/SetNav/SetHunt/SetAutoPick/SetAutoJournal
  调整: SetBrightLevel(3) SetGlowSize(2,0.4) SetFreezePoint(-5)
  音乐: SetMusic(id,音量) StopMusic() MusicOn()
  自定义: AddItem("名","显示") AddCursed() AddEvidence()
  死亡协助: DeadNow() 立即触发  ForceDead(true) 强制标记死亡
  猎杀清除: ClearHunt() 手动清除卡住的猎杀状态
  手动证据: MarkEvidence("手印") UnmarkEvidence("鬼球")
            SetEvidence("手印,鬼球,低温") ListEvidenceNames()
  诊断: Diag() Unknowns() 未识别对象  DebugWords("房间名") CnRoom("英文名")
  卸载: Unload()
]]
end

API.SetAll = function(v)
	local on = (v ~= false)
	for _, k in ipairs({ "Items", "Cursed", "Ghost", "Temp", "Bright", "Hunt", "Exit", "Hide", "Mate", "Room", "Nav", "Fuse", "AutoJournal", "Flash" }) do
		CFG.On[k] = on
	end
	if not on then
		RestoreBright()
		ClearNav()
		for obj in pairs(S.Mark) do Unmark(obj) end
	end
	return on
end

API.SetGlow = function(v) CFG.On.BigGlow = (v ~= false) return CFG.On.BigGlow end
API.SetBox = function(v) CFG.On.BigOutline = (v ~= false) return CFG.On.BigOutline end
API.SetGlowSize = function(scale, alpha)
	if scale then CFG.GlowScale = tonumber(scale) or 1.6 end
	if alpha then CFG.GlowAlpha = tonumber(alpha) or 0.55 end
	return true
end
API.GetGhostState = function() return S.GhostState, S.GhostStateRaw end
API.SetNav = function(v) CFG.On.Nav = (v ~= false) if not CFG.On.Nav then ClearNav() end return CFG.On.Nav end
API.SetHunt = function(v) CFG.On.Hunt = (v ~= false) return CFG.On.Hunt end
API.SetAutoJournal = function(v) CFG.On.AutoJournal = (v ~= false) return CFG.On.AutoJournal end
API.MarkExits = function() MarkExits() return S.ExitCount or 0 end
API.MarkHides = function() MarkHides() return S.HideCount or 0 end
API.ClearNav = function() ClearNav() return true end
API.Snapshot = function()
	local ok, res = pcall(function()
		return {
			Evidence = S.Evidence, Ghost = S.Ghost and GhostCN(S.Ghost) or nil,
			Candidates = API.GetCandidates(), Room = S.Room, Temp = S.Temp,
			Lowest = S.LowestTemp, LowestRoom = S.LowestRoom,
			Energy = S.Energy, Hunting = S.Hunting, GhostDist = S.GhostDist,
			Fuse = S.FuseOn, FPS = S.FPS, Need = API.GetNeed(),
		}
	end)
	if ok then return res end
	return nil
end

API.IsDead = function() return IsDead() end
API.DeadAssist = function() DeadAssist() return true end
API.KeepVisible = function() DeadKeepVisible() return true end
API.EnableTools = function() return DeadEnableTools() end
API.OpenPrompts = function() return DeadOpenPrompts() end
API.SetDeadHelp = function(v) CFG.DeadHelp = (v ~= false) return CFG.DeadHelp end
API.SetBigOutline = function(v)
	CFG.On.BigOutline = (v ~= false)
	if not CFG.On.BigOutline then
		pcall(function()
			for obj, b in pairs(S.Box or {}) do
				pcall(function() b:Destroy() end)
				S.Box[obj] = nil
			end
		end)
	end
	return CFG.On.BigOutline
end
API.GetHuntCount = function() return S.HuntCount or 0 end
API.SetHuntCooldown = function(v) CFG.HuntCooldown = tonumber(v) or 8 return CFG.HuntCooldown end

API.Say = function(msg, ch) return Say(msg, ch) end
API.SetDead = function(v) CFG.On.Dead = (v ~= false) return CFG.On.Dead end

API.GetRoom = function()
	if not S.Room then return nil end
	return S.Room
end

API.GetLowest = function()
	if not S.LowestTemp then return nil end
	return S.LowestTemp, (RoomCN(S.LowestRoom) or S.LowestRoom)
end

API.GetGhost = function()
	if not S.Ghost then return nil end
	return S.Ghost, GhostCN(S.Ghost), S.FakeOrb
end

API.GetCandidates = function()
	if not S.GhostCands or #S.GhostCands == 0 then return nil end
	local out = {}
	for _, n in ipairs(S.GhostCands) do out[#out + 1] = GhostCN(n) end
	return out
end

API.IsFakeOrb = function()
	return S.FakeOrb
end



getgenv().DEMONOLOGY = API

pcall(BuildUI)
pcall(Tick)
pcall(CheckTemp)
pcall(ApplyBright)

pcall(function()
	S.Conn[#S.Conn + 1] = WS.ChildAdded:Connect(function(o)
		Handle(o)
		if o.Name == "Handprints" or o.Name == "GhostOrb" or o.Name == "GhostOrbs" then
			S.Timer = CFG.Tick
		end
	end)
end)
pcall(function()
	for _, cn in ipairs({ "Items", "CursedPossessions" }) do
		local f = WS:FindFirstChild(cn)
		if f then
			S.Conn[#S.Conn + 1] = f.DescendantAdded:Connect(Handle)
		end
	end
end)
pcall(function()
	S.Conn[#S.Conn + 1] = Run.Heartbeat:Connect(Step)
end)
pcall(function()
	S.Conn[#S.Conn + 1] = LP.CharacterAdded:Connect(function()
		wait(1)
		pcall(BuildUI)
	end)
end)
pcall(CollectChatRemotes)
pcall(StartMusic)
print("[DH] loaded")

return API