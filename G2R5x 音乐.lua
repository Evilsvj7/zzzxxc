local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local UIS=game:GetService("UserInputService")
local RS=game:GetService("RunService")
local HS=game:GetService("HttpService")
local MPS=game:GetService("MarketplaceService")
local SoundService=game:GetService("SoundService")
local LP=Players.LocalPlayer
local PG=LP:WaitForChild("PlayerGui")
local Cam=workspace.CurrentCamera
local APP="G2R5x 音乐"
local old=PG:FindFirstChild("G2R5xMusicHub")
if old then old:Destroy() end
local gui=Instance.new("ScreenGui")
gui.Name="G2R5xMusicHub"
gui.ResetOnSpawn=false
gui.IgnoreGuiInset=true
gui.DisplayOrder=9999
gui.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
gui.Parent=PG
local vw,vh=Cam.ViewportSize.X,Cam.ViewportSize.Y
local W=math.min(430,vw-16)
local H=math.min(610,vh-50)
local FONT=Enum.Font.Gotham
local THEMES={
{name="暗紫",bg=Color3.fromRGB(16,16,24),top=Color3.fromRGB(28,26,42),card=Color3.fromRGB(38,36,54),acc=Color3.fromRGB(124,92,240),txt=Color3.fromRGB(236,236,248),sub=Color3.fromRGB(142,136,172),bar=Color3.fromRGB(55,52,74)},
{name="纯黑",bg=Color3.fromRGB(8,8,10),top=Color3.fromRGB(18,18,20),card=Color3.fromRGB(26,26,30),acc=Color3.fromRGB(255,255,255),txt=Color3.fromRGB(245,245,245),sub=Color3.fromRGB(130,130,138),bar=Color3.fromRGB(45,45,50)},
{name="深海",bg=Color3.fromRGB(10,16,26),top=Color3.fromRGB(18,28,44),card=Color3.fromRGB(26,38,58),acc=Color3.fromRGB(60,170,255),txt=Color3.fromRGB(230,240,255),sub=Color3.fromRGB(120,145,180),bar=Color3.fromRGB(40,58,84)},
{name="森语",bg=Color3.fromRGB(12,20,16),top=Color3.fromRGB(22,34,28),card=Color3.fromRGB(30,46,38),acc=Color3.fromRGB(80,210,150),txt=Color3.fromRGB(232,248,240),sub=Color3.fromRGB(120,155,140),bar=Color3.fromRGB(40,62,52)},
}
local TI=1
local function C(k) return THEMES[TI][k] end
local themed={}
local function reg(o,p,k) table.insert(themed,{o=o,p=p,k=k}) o[p]=C(k) return o end
local function applyTheme() for _,t in ipairs(themed) do t.o[t.p]=C(t.k) end end
local intro=Instance.new("Frame")
intro.Name="IntroBlack"
intro.Size=UDim2.new(1,0,1,0)
intro.BackgroundColor3=Color3.fromRGB(6,6,12)
intro.BorderSizePixel=0
intro.ZIndex=300
intro.Parent=gui
task.delay(6,function()
	local g=PG:FindFirstChild("G2R5xMusicHub")
	if not g then return end
	local iv=g:FindFirstChild("IntroBlack")
	if iv then iv:Destroy() end
	local m=g:FindFirstChild("Main")
	if m then m.Visible=true end
end)
local ig=Instance.new("TextLabel")
ig.Size=UDim2.new(1,0,0,150) ig.Position=UDim2.new(0.5,0,0.5,-34) ig.AnchorPoint=Vector2.new(0.5,0.5)
ig.BackgroundTransparency=1 ig.Font=Enum.Font.GothamBold ig.Text="" ig.TextColor3=Color3.fromRGB(150,115,255) ig.TextTransparency=0.4 ig.TextScaled=true ig.ZIndex=301 ig.Parent=intro
local it=Instance.new("TextLabel")
it.Size=UDim2.new(1,0,0,150) it.Position=UDim2.new(0.5,0,0.5,-34) it.AnchorPoint=Vector2.new(0.5,0.5)
it.BackgroundTransparency=1 it.Font=Enum.Font.GothamBold it.Text="" it.TextColor3=Color3.fromRGB(238,235,255) it.TextScaled=true it.ZIndex=302 it.Parent=intro
local isub=Instance.new("TextLabel")
isub.Size=UDim2.new(1,0,0,30) isub.Position=UDim2.new(0.5,0,0.5,54) isub.AnchorPoint=Vector2.new(0.5,0.5)
isub.BackgroundTransparency=1 isub.Font=FONT isub.Text="LOADING" isub.TextColor3=Color3.fromRGB(125,115,175) isub.TextSize=14 isub.TextTransparency=1 isub.ZIndex=302 isub.Parent=intro
local main=Instance.new("Frame")
main.Name="Main"
main.Size=UDim2.new(0,W,0,H) main.Position=UDim2.new(0,(vw-W)/2,0,(vh-H)/2)
main.BackgroundColor3=C("bg") main.BorderSizePixel=0 main.Visible=false main.ZIndex=10 main.Parent=gui
local mcn=Instance.new("UICorner") mcn.CornerRadius=UDim.new(0,16) mcn.Parent=main
local mst=Instance.new("UIStroke") mst.Color=C("acc") mst.Thickness=1.4 mst.Transparency=0.35 mst.Parent=main
local musc=Instance.new("UIScale") musc.Scale=0.86 musc.Parent=main
reg(main,"BackgroundColor3","bg") reg(mst,"Color","acc")
local top=Instance.new("Frame")
top.Size=UDim2.new(1,0,0,46) top.BackgroundColor3=C("top") top.BorderSizePixel=0 top.ZIndex=11 top.Parent=main
local tcn=Instance.new("UICorner") tcn.CornerRadius=UDim.new(0,16) tcn.Parent=top
local tfx=Instance.new("Frame") tfx.Size=UDim2.new(1,0,0,18) tfx.Position=UDim2.new(0,0,0,28) tfx.BackgroundColor3=C("top") tfx.BorderSizePixel=0 tfx.ZIndex=11 tfx.Parent=top
reg(top,"BackgroundColor3","top") reg(tfx,"BackgroundColor3","top")
local title=Instance.new("TextLabel")
title.Size=UDim2.new(1,-150,1,0) title.Position=UDim2.new(0,16,0,0) title.BackgroundTransparency=1
title.Text=APP title.Font=Enum.Font.GothamBold title.TextSize=16 title.TextXAlignment=Enum.TextXAlignment.Left title.TextColor3=C("txt") title.ZIndex=12 title.Parent=top
reg(title,"TextColor3","txt")
local function mkBtn(txt,xo,col,sz)
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0,sz or 30,0,sz or 30) b.Position=UDim2.new(1,xo,0.5,0) b.AnchorPoint=Vector2.new(0,0.5)
	b.BackgroundColor3=col b.BackgroundTransparency=0.15 b.BorderSizePixel=0 b.Text=txt b.Font=Enum.Font.GothamBold b.TextSize=15 b.TextColor3=Color3.fromRGB(244,244,255) b.ZIndex=12 b.Parent=top
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,9) c.Parent=b
	return b
end
local bSearch=mkBtn("S",-152,Color3.fromRGB(70,66,110))
local bMenu=mkBtn("*",-116,Color3.fromRGB(70,66,110))
local bMin=mkBtn("-",-80,Color3.fromRGB(80,72,132))
local bX=mkBtn("X",-42,Color3.fromRGB(150,50,60))
local tabs=Instance.new("Frame")
tabs.Size=UDim2.new(1,0,0,40) tabs.Position=UDim2.new(0,0,0,46) tabs.BackgroundTransparency=1 tabs.ZIndex=11 tabs.Parent=main
local function mkTab(t,i)
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(1/3,0,1,0) b.Position=UDim2.new((i-1)/3,0,0,0) b.BackgroundTransparency=1 b.BorderSizePixel=0
	b.Text=t b.Font=Enum.Font.GothamBold b.TextSize=14 b.TextColor3=C("sub") b.ZIndex=12 b.Parent=tabs
	return b
end
local tabNow=mkTab("正在播放",1)
local tabLib=mkTab("我的音乐",2)
local tabSet=mkTab("设置",3)
local tline=Instance.new("Frame")
tline.Size=UDim2.new(1/3,-24,0,2.5) tline.Position=UDim2.new(0,12,1,-3) tline.BackgroundColor3=C("acc") tline.BorderSizePixel=0 tline.ZIndex=12 tline.Parent=tabs
local tlc=Instance.new("UICorner") tlc.CornerRadius=UDim.new(1,0) tlc.Parent=tline
reg(tline,"BackgroundColor3","acc")
local body=Instance.new("Frame")
body.Size=UDim2.new(1,0,1,-86) body.Position=UDim2.new(0,0,0,86) body.BackgroundTransparency=1 body.ClipsDescendants=true body.ZIndex=11 body.Parent=main
local function mkPage()
	local f=Instance.new("Frame")
	f.Size=UDim2.new(1,0,1,0) f.BackgroundTransparency=1 f.Visible=false f.ZIndex=12 f.Parent=body
	return f
end
local pNow=mkPage()
local pLib=mkPage()
local pSet=mkPage()
local DB={songs={},pls={},hist={},queue={},fav={}}
local cur=nil
local curIdx=0
local playing=false
local LOOPMODE={"列表循环","单曲循环","顺序播放"}
local loopI=1
local shuffle=false
local SPEEDS={0.5,0.75,1,1.25,1.5,2}
local speedI=3
local TIMERS={0,15,30,60}
local timerI=1
local timerEnd=0
local vol=0.7
local muted=false
local SET={fade=true,spec=true,lyric=true,quality="标准",cover="静止",theme=1}
local sound=Instance.new("Sound")
sound.Parent=SoundService
sound.Volume=vol
sound.PlaybackSpeed=1
local function sid(s) return "rbxassetid://"..tostring(s) end
local function fmt(t)
	if not t or t~=t or t<0 then t=0 end
	local m=math.floor(t/60) local s=math.floor(t%60)
	return string.format("%02d:%02d",m,s)
end
local toastLbl
local function Toast(msg)
	if not toastLbl then
		toastLbl=Instance.new("TextLabel")
		toastLbl.Size=UDim2.new(0,W-40,0,36) toastLbl.Position=UDim2.new(0.5,0,1,-20) toastLbl.AnchorPoint=Vector2.new(0.5,1)
		toastLbl.BackgroundColor3=Color3.fromRGB(40,38,58) toastLbl.BorderSizePixel=0 toastLbl.Font=FONT toastLbl.TextSize=13
		toastLbl.TextColor3=Color3.fromRGB(240,240,250) toastLbl.TextWrapped=true toastLbl.ZIndex=400
		local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,10) c.Parent=toastLbl
		toastLbl.Parent=gui
	end
	toastLbl.Text=msg
	toastLbl.TextTransparency=0
	toastLbl.BackgroundTransparency=0
	toastLbl.Position=UDim2.new(0.5,0,1,10)
	TweenService:Create(toastLbl,TweenInfo.new(0.3,Enum.EasingStyle.Back),{Position=UDim2.new(0.5,0,1,-20)}):Play()
	task.spawn(function()
		task.wait(1.9)
		TweenService:Create(toastLbl,TweenInfo.new(0.3),{TextTransparency=1,BackgroundTransparency=1}):Play()
	end)
end
local modalBox,modalInput,modalTitle,modalOk,modalCancel,modalCb
local function buildModal()
	modalBox=Instance.new("Frame")
	modalBox.Size=UDim2.new(1,0,1,0) modalBox.BackgroundColor3=Color3.fromRGB(0,0,0) modalBox.BackgroundTransparency=0.5 modalBox.BorderSizePixel=0 modalBox.Visible=false modalBox.ZIndex=500 modalBox.Parent=gui
	local card=Instance.new("Frame")
	card.Size=UDim2.new(0,W-50,0,210) card.Position=UDim2.new(0.5,0,0.5,0) card.AnchorPoint=Vector2.new(0.5,0.5)
	card.BackgroundColor3=C("bg") card.BorderSizePixel=0 card.ZIndex=501 card.Parent=modalBox
	local cc=Instance.new("UICorner") cc.CornerRadius=UDim.new(0,14) cc.Parent=card
	local cs=Instance.new("UIStroke") cs.Color=C("acc") cs.Thickness=1.2 cs.Transparency=0.4 cs.Parent=card
	reg(card,"BackgroundColor3","bg") reg(cs,"Color","acc")
	modalTitle=Instance.new("TextLabel")
	modalTitle.Size=UDim2.new(1,-30,0,30) modalTitle.Position=UDim2.new(0,15,0,14) modalTitle.BackgroundTransparency=1
	modalTitle.Font=Enum.Font.GothamBold modalTitle.TextSize=15 modalTitle.TextXAlignment=Enum.TextXAlignment.Left modalTitle.TextColor3=C("txt") modalTitle.ZIndex=502 modalTitle.Parent=card
	reg(modalTitle,"TextColor3","txt")
	modalInput=Instance.new("TextBox")
	modalInput.Size=UDim2.new(1,-30,0,92) modalInput.Position=UDim2.new(0,15,0,50) modalInput.BackgroundColor3=C("card")
	modalInput.BorderSizePixel=0 modalInput.ClearTextOnFocus=false modalInput.Font=FONT modalInput.TextSize=14 modalInput.MultiLine=true
	modalInput.TextColor3=C("txt") modalInput.PlaceholderColor3=C("sub") modalInput.TextXAlignment=Enum.TextXAlignment.Left modalInput.TextYAlignment=Enum.TextYAlignment.Top modalInput.ZIndex=502 modalInput.Parent=card
	local ic=Instance.new("UICorner") ic.CornerRadius=UDim.new(0,9) ic.Parent=modalInput
	local ip=Instance.new("UIPadding") ip.PaddingLeft=UDim.new(0,10) ip.PaddingRight=UDim.new(0,10) ip.PaddingTop=UDim.new(0,8) ip.Parent=modalInput
	reg(modalInput,"BackgroundColor3","card") reg(modalInput,"TextColor3","txt")
	modalCancel=Instance.new("TextButton")
	modalCancel.Size=UDim2.new(0.5,-20,0,38) modalCancel.Position=UDim2.new(0,15,1,-50) modalCancel.BackgroundColor3=C("card") modalCancel.BorderSizePixel=0
	modalCancel.Text="取消" modalCancel.Font=Enum.Font.GothamBold modalCancel.TextSize=14 modalCancel.TextColor3=C("sub") modalCancel.ZIndex=502 modalCancel.Parent=card
	local xc=Instance.new("UICorner") xc.CornerRadius=UDim.new(0,9) xc.Parent=modalCancel
	modalOk=Instance.new("TextButton")
	modalOk.Size=UDim2.new(0.5,-20,0,38) modalOk.Position=UDim2.new(1,-15,1,-50) modalOk.AnchorPoint=Vector2.new(1,0) modalOk.BackgroundColor3=C("acc") modalOk.BorderSizePixel=0
	modalOk.Text="确定" modalOk.Font=Enum.Font.GothamBold modalOk.TextSize=14 modalOk.TextColor3=Color3.fromRGB(255,255,255) modalOk.ZIndex=502 modalOk.Parent=card
	local oc=Instance.new("UICorner") oc.CornerRadius=UDim.new(0,9) oc.Parent=modalOk
	reg(modalCancel,"BackgroundColor3","card") reg(modalCancel,"TextColor3","sub") reg(modalOk,"BackgroundColor3","acc")
	modalOk.MouseButton1Click:Connect(function()
		modalBox.Visible=false
		if modalCb then modalCb(modalInput.Text,true) end
	end)
	modalCancel.MouseButton1Click:Connect(function()
		modalBox.Visible=false
		if modalCb then modalCb(nil,false) end
	end)
end
buildModal()
local function Modal(t,ph,dv,cb)
	modalTitle.Text=t modalInput.PlaceholderText=ph or "" modalInput.Text=dv or "" modalCb=cb modalBox.Visible=true
end
local function Confirm(t,cb)
	Modal(t,"","",function(_,ok) if ok then cb() end end)
end
local menuBox=nil
local function closeMenu()
	if menuBox then menuBox:Destroy() menuBox=nil end
end
local function Menu(x,y,items)
	closeMenu()
	local f=Instance.new("Frame")
	f.Size=UDim2.new(0,170,0,#items*36+10) f.Position=UDim2.new(0,x,0,y)
	f.BackgroundColor3=C("bg") f.BorderSizePixel=0 f.ZIndex=600 f.Parent=gui
	if f.AbsolutePosition.Y+f.AbsoluteSize.Y>vh then f.Position=UDim2.new(0,x,0,math.max(4,vh-#items*36-14)) end
	if f.AbsolutePosition.X+f.AbsoluteSize.X>vw then f.Position=UDim2.new(0,vw-174,0,f.Position.Y.Offset) end
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,12) c.Parent=f
	local s=Instance.new("UIStroke") s.Color=C("acc") s.Thickness=1 s.Transparency=0.5 s.Parent=f
	local l=Instance.new("UIListLayout") l.Padding=UDim.new(0,2) l.SortOrder=Enum.SortOrder.LayoutOrder l.Parent=f
	local p=Instance.new("UIPadding") p.PaddingTop=UDim.new(0,5) p.PaddingLeft=UDim.new(0,5) p.PaddingRight=UDim.new(0,5) p.Parent=f
	reg(f,"BackgroundColor3","bg") reg(s,"Color","acc")
	for i,it2 in ipairs(items) do
		local b=Instance.new("TextButton")
		b.Size=UDim2.new(1,0,0,34) b.BackgroundColor3=C("card") b.BackgroundTransparency=0.4 b.BorderSizePixel=0
		b.Text=it2.t b.Font=FONT b.TextSize=13 b.TextColor3=it2.danger and Color3.fromRGB(255,110,110) or C("txt")
		b.TextXAlignment=Enum.TextXAlignment.Left b.ZIndex=601 b.Parent=f
		local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,8) bc.Parent=b
		local bp=Instance.new("UIPadding") bp.PaddingLeft=UDim.new(0,10) bp.Parent=b
		reg(b,"BackgroundColor3","card")
		if not it2.danger then reg(b,"TextColor3","txt") end
		b.MouseButton1Click:Connect(function() closeMenu() if it2.f then it2.f() end end)
	end
	menuBox=f
	task.spawn(function()
		task.wait(0.15)
		local conn
		conn=UIS.InputBegan:Connect(function(i2)
			if i2.UserInputType==Enum.UserInputType.MouseButton1 or i2.UserInputType==Enum.UserInputType.Touch then
				task.wait(0.05)
				closeMenu() conn:Disconnect()
			end
		end)
	end)
end
local function mkSlider(parent,pos,sz,init,cb)
	local t=Instance.new("TextButton")
	t.Size=sz t.Position=pos t.BackgroundColor3=C("bar") t.BorderSizePixel=0 t.Text="" t.AutoButtonColor=false t.ZIndex=20 t.Parent=parent
	local tc=Instance.new("UICorner") tc.CornerRadius=UDim.new(1,0) tc.Parent=t
	local fl=Instance.new("Frame")
	fl.Size=UDim2.new(init,0,1,0) fl.BackgroundColor3=C("acc") fl.BorderSizePixel=0 fl.ZIndex=21 fl.Parent=t
	local fc=Instance.new("UICorner") fc.CornerRadius=UDim.new(1,0) fc.Parent=fl
	local kn=Instance.new("Frame")
	kn.Size=UDim2.new(0,12,0,12) kn.Position=UDim2.new(init,0,0.5,0) kn.AnchorPoint=Vector2.new(0.5,0.5)
	kn.BackgroundColor3=Color3.fromRGB(255,255,255) kn.BorderSizePixel=0 kn.ZIndex=22 kn.Parent=t
	local kc=Instance.new("UICorner") kc.CornerRadius=UDim.new(1,0) kc.Parent=kn
	reg(t,"BackgroundColor3","bar") reg(fl,"BackgroundColor3","acc")
	local drag=false
	local function setX(x)
		local r=math.clamp((x-t.AbsolutePosition.X)/math.max(1,t.AbsoluteSize.X),0,1)
		fl.Size=UDim2.new(r,0,1,0) kn.Position=UDim2.new(r,0,0.5,0)
		cb(r)
	end
	t.InputBegan:Connect(function(i2)
		if i2.UserInputType==Enum.UserInputType.MouseButton1 or i2.UserInputType==Enum.UserInputType.Touch then
			drag=true setX(i2.Position.X)
		end
	end)
	UIS.InputChanged:Connect(function(i2)
		if drag and (i2.UserInputType==Enum.UserInputType.MouseMovement or i2.UserInputType==Enum.UserInputType.Touch) then setX(i2.Position.X) end
	end)
	UIS.InputEnded:Connect(function(i2)
		if i2.UserInputType==Enum.UserInputType.MouseButton1 or i2.UserInputType==Enum.UserInputType.Touch then drag=false end
	end)
	return t,function(v)
		fl.Size=UDim2.new(v,0,1,0) kn.Position=UDim2.new(v,0,0.5,0)
	end
end
local coverBig=Instance.new("Frame")
coverBig.Size=UDim2.new(0,150,0,150) coverBig.Position=UDim2.new(0.5,0,0,18) coverBig.AnchorPoint=Vector2.new(0.5,0)
coverBig.BackgroundColor3=C("card") coverBig.BorderSizePixel=0 coverBig.ZIndex=13 coverBig.Parent=pNow
local cbc=Instance.new("UICorner") cbc.CornerRadius=UDim.new(0,18) cbc.Parent=coverBig
local cbs=Instance.new("UIStroke") cbs.Color=C("acc") cbs.Thickness=2 cbs.Transparency=0.4 cbs.Parent=coverBig
reg(coverBig,"BackgroundColor3","card") reg(cbs,"Color","acc")
local coverImg=Instance.new("ImageLabel")
coverImg.Size=UDim2.new(1,0,1,0) coverImg.BackgroundTransparency=1 coverImg.BorderSizePixel=0 coverImg.Image="" coverImg.ScaleType=Enum.ScaleType.Crop coverImg.ZIndex=13 coverImg.Parent=coverBig
local ci=Instance.new("UICorner") ci.CornerRadius=UDim.new(0,18) ci.Parent=coverImg
local coverMask=Instance.new("TextButton")
coverMask.Size=UDim2.new(0,54,0,54) coverMask.Position=UDim2.new(0.5,0,0.5,0) coverMask.AnchorPoint=Vector2.new(0.5,0.5)
coverMask.BackgroundColor3=Color3.fromRGB(12,12,18) coverMask.BackgroundTransparency=0.35 coverMask.BorderSizePixel=0
coverMask.Text="▶" coverMask.Font=Enum.Font.GothamBold coverMask.TextSize=22 coverMask.TextColor3=Color3.fromRGB(255,255,255) coverMask.ZIndex=14 coverMask.Parent=coverBig
local cmc=Instance.new("UICorner") cmc.CornerRadius=UDim.new(1,0) cmc.Parent=coverMask
local nmLbl=Instance.new("TextLabel")
nmLbl.Size=UDim2.new(1,-40,0,24) nmLbl.Position=UDim2.new(0.5,0,0,182) nmLbl.AnchorPoint=Vector2.new(0.5,0)
nmLbl.BackgroundTransparency=1 nmLbl.Font=Enum.Font.GothamBold nmLbl.TextSize=17 nmLbl.Text="未在播放" nmLbl.TextColor3=C("txt") nmLbl.ZIndex=13 nmLbl.Parent=pNow
reg(nmLbl,"TextColor3","txt")
local arLbl=Instance.new("TextLabel")
arLbl.Size=UDim2.new(1,-40,0,18) arLbl.Position=UDim2.new(0.5,0,0,208) arLbl.AnchorPoint=Vector2.new(0.5,0)
arLbl.BackgroundTransparency=1 arLbl.Font=FONT arLbl.TextSize=12 arLbl.Text="从下方添加音乐 ID" arLbl.TextColor3=C("sub") arLbl.ZIndex=13 arLbl.Parent=pNow
reg(arLbl,"TextColor3","sub")
local spec=Instance.new("Frame")
spec.Size=UDim2.new(1,-40,0,34) spec.Position=UDim2.new(0.5,0,0,232) spec.AnchorPoint=Vector2.new(0.5,0)
spec.BackgroundTransparency=1 spec.ZIndex=13 spec.Parent=pNow
local bars={}
for i=1,20 do
	local b=Instance.new("Frame")
	b.Size=UDim2.new(0,10,0,3) b.Position=UDim2.new((i-1)/20,0,1,0) b.AnchorPoint=Vector2.new(0,1)
	b.BackgroundColor3=C("acc") b.BorderSizePixel=0 b.ZIndex=13 b.Parent=spec
	local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,2) bc.Parent=b
	reg(b,"BackgroundColor3","acc")
	bars[i]=b
end
local progBar,setProg=mkSlider(pNow,UDim2.new(0.5,0,0,278),UDim2.new(0,W-50,0,6),0,function(r)
	if cur and sound.TimeLength>0 then sound.TimePosition=r*sound.TimeLength end
end)
progBar.AnchorPoint=Vector2.new(0.5,0)
local tCur=Instance.new("TextLabel")
tCur.Size=UDim2.new(0,50,0,16) tCur.Position=UDim2.new(0,20,0,288) tCur.BackgroundTransparency=1
tCur.Font=FONT tCur.TextSize=11 tCur.Text="00:00" tCur.TextColor3=C("sub") tCur.TextXAlignment=Enum.TextXAlignment.Left tCur.ZIndex=13 tCur.Parent=pNow
local tAll=Instance.new("TextLabel")
tAll.Size=UDim2.new(0,50,0,16) tAll.Position=UDim2.new(1,-20,0,288) tAll.AnchorPoint=Vector2.new(1,0) tAll.BackgroundTransparency=1
tAll.Font=FONT tAll.TextSize=11 tAll.Text="00:00" tAll.TextColor3=C("sub") tAll.TextXAlignment=Enum.TextXAlignment.Right tAll.ZIndex=13 tAll.Parent=pNow
reg(tCur,"TextColor3","sub") reg(tAll,"TextColor3","sub")
local function mkRound(txt,x,y,sz,col,par)
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0,sz,0,sz) b.Position=UDim2.new(0.5,x,0,y) b.AnchorPoint=Vector2.new(0.5,0)
	b.BackgroundColor3=col b.BorderSizePixel=0 b.Text=txt b.Font=Enum.Font.GothamBold b.TextSize=sz<40 and 15 or 20 b.TextColor3=Color3.fromRGB(255,255,255) b.ZIndex=14 b.Parent=par
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(1,0) c.Parent=b
	return b
end
local bPrev=mkRound("|<<",-72,312,40,C("card"),pNow)
local bPlay=mkRound(">",0,308,52,C("acc"),pNow)
local bNext=mkRound(">>|",72,312,40,C("card"),pNow)
reg(bPrev,"BackgroundColor3","card") reg(bNext,"BackgroundColor3","card") reg(bPlay,"BackgroundColor3","acc")
local function mkChip(txt,x,y,w,par)
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0,w,0,30) b.Position=UDim2.new(0,x,0,y) b.BackgroundColor3=C("card") b.BackgroundTransparency=0.3 b.BorderSizePixel=0
	b.Text=txt b.Font=FONT b.TextSize=12 b.TextColor3=C("txt") b.ZIndex=14 b.Parent=par
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,9) c.Parent=b
	reg(b,"BackgroundColor3","card") reg(b,"TextColor3","txt")
	return b
end
local pad=24
local cw=math.floor((W-pad*2-16)/4)
local chipLoop=mkChip("列表循环",pad,372,cw,pNow)
local chipShuf=mkChip("随机 关",pad+cw+4,372,cw,pNow)
local chipSpeed=mkChip("1.0x",pad+(cw+4)*2,372,cw,pNow)
local chipTimer=mkChip("定时 关",pad+(cw+4)*3,372,cw,pNow)
local chipFav=mkChip("收藏",pad,408,cw,pNow)
local chipLyric=mkChip("歌词",pad+cw+4,408,cw,pNow)
local chipQueue=mkChip("队列",pad+(cw+4)*2,408,cw,pNow)
local chipInfo=mkChip("详情",pad+(cw+4)*3,408,cw,pNow)
local vIcon=Instance.new("TextLabel")
vIcon.Size=UDim2.new(0,26,0,26) vIcon.Position=UDim2.new(0,pad,0,448) vIcon.BackgroundTransparency=1
vIcon.Font=Enum.Font.GothamBold vIcon.TextSize=15 vIcon.Text="V" vIcon.TextColor3=C("sub") vIcon.ZIndex=14 vIcon.Parent=pNow
reg(vIcon,"TextColor3","sub")
local vIconBtn=Instance.new("TextButton")
vIconBtn.Size=UDim2.new(0,26,0,26) vIconBtn.Position=UDim2.new(0,pad,0,448) vIconBtn.BackgroundTransparency=1 vIconBtn.Text="" vIconBtn.ZIndex=15 vIconBtn.Parent=pNow
local volBar,setVol=mkSlider(pNow,UDim2.new(0,pad+34,0,457),UDim2.new(0,W-pad*2-70,0,6),vol,function(r)
	vol=r muted=false
	vIcon.Text=r==0 and "M" or "V"
	sound.Volume=r
	vTxt.Text=math.floor(r*100).."%"
end)
local vTxt=Instance.new("TextLabel")
vTxt.Size=UDim2.new(0,36,0,26) vTxt.Position=UDim2.new(1,-pad,0,448) vTxt.AnchorPoint=Vector2.new(1,0) vTxt.BackgroundTransparency=1
vTxt.Font=FONT vTxt.TextSize=11 vTxt.Text="70%" vTxt.TextColor3=C("sub") vTxt.TextXAlignment=Enum.TextXAlignment.Right vTxt.ZIndex=14 vTxt.Parent=pNow
reg(vTxt,"TextColor3","sub")
local idRow=Instance.new("Frame")
idRow.Size=UDim2.new(1,-pad*2,0,40) idRow.Position=UDim2.new(0,pad,0,478) idRow.BackgroundColor3=C("card") idRow.BorderSizePixel=0 idRow.ZIndex=14 idRow.Parent=pNow
local irc=Instance.new("UICorner") irc.CornerRadius=UDim.new(0,10) irc.Parent=idRow
reg(idRow,"BackgroundColor3","card")
local idInput=Instance.new("TextBox")
idInput.Size=UDim2.new(1,-90,1,0) idInput.Position=UDim2.new(0,12,0,0) idInput.BackgroundTransparency=1
idInput.ClearTextOnFocus=false idInput.Font=FONT idInput.TextSize=13 idInput.PlaceholderText="音乐ID 或 名称,ID"
idInput.PlaceholderColor3=C("sub") idInput.TextColor3=C("txt") idInput.TextXAlignment=Enum.TextXAlignment.Left idInput.ZIndex=15 idInput.Parent=idRow
reg(idInput,"TextColor3","txt")
local idAdd=Instance.new("TextButton")
idAdd.Size=UDim2.new(0,74,0,30) idAdd.Position=UDim2.new(1,-6,0.5,0) idAdd.AnchorPoint=Vector2.new(1,0.5)
idAdd.BackgroundColor3=C("acc") idAdd.BorderSizePixel=0 idAdd.Text="添加播放" idAdd.Font=Enum.Font.GothamBold idAdd.TextSize=12 idAdd.TextColor3=Color3.fromRGB(255,255,255) idAdd.ZIndex=15 idAdd.Parent=idRow
local iac=Instance.new("UICorner") iac.CornerRadius=UDim.new(0,8) iac.Parent=idAdd
reg(idAdd,"BackgroundColor3","acc")
local libBar=Instance.new("Frame")
libBar.Size=UDim2.new(1,0,0,36) libBar.BackgroundTransparency=1 libBar.ZIndex=13 libBar.Parent=pLib
local subTabs={"收藏","歌单","历史","全部"}
local subBtns={}
for i,t in ipairs(subTabs) do
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0.25,0,1,0) b.Position=UDim2.new((i-1)*0.25,0,0,0) b.BackgroundTransparency=1 b.BorderSizePixel=0
	b.Text=t b.Font=Enum.Font.GothamBold b.TextSize=13 b.TextColor3=C("sub") b.ZIndex=14 b.Parent=libBar
	subBtns[i]=b
end
local sline=Instance.new("Frame")
sline.Size=UDim2.new(0.25,-16,0,2.5) sline.Position=UDim2.new(0,8,1,-2) sline.BackgroundColor3=C("acc") sline.BorderSizePixel=0 sline.ZIndex=14 sline.Parent=libBar
local slc=Instance.new("UICorner") slc.CornerRadius=UDim.new(1,0) slc.Parent=sline
reg(sline,"BackgroundColor3","acc")
local searchRow=Instance.new("Frame")
searchRow.Size=UDim2.new(1,-32,0,34) searchRow.Position=UDim2.new(0,16,0,40) searchRow.BackgroundColor3=C("card") searchRow.BorderSizePixel=0 searchRow.ZIndex=13 searchRow.Parent=pLib
local src=Instance.new("UICorner") src.CornerRadius=UDim.new(0,9) src.Parent=searchRow
reg(searchRow,"BackgroundColor3","card")
local searchBox=Instance.new("TextBox")
searchBox.Size=UDim2.new(1,-40,1,0) searchBox.Position=UDim2.new(0,12,0,0) searchBox.BackgroundTransparency=1
searchBox.ClearTextOnFocus=false searchBox.Font=FONT searchBox.TextSize=13 searchBox.PlaceholderText="搜索歌名/作者/ID"
searchBox.PlaceholderColor3=C("sub") searchBox.TextColor3=C("txt") searchBox.TextXAlignment=Enum.TextXAlignment.Left searchBox.ZIndex=14 searchBox.Parent=searchRow
reg(searchBox,"TextColor3","txt")
local sClear=Instance.new("TextButton")
sClear.Size=UDim2.new(0,28,0,28) sClear.Position=UDim2.new(1,-4,0.5,0) sClear.AnchorPoint=Vector2.new(1,0.5)
sClear.BackgroundTransparency=1 sClear.Text="X" sClear.Font=Enum.Font.GothamBold sClear.TextSize=13 sClear.TextColor3=C("sub") sClear.ZIndex=14 sClear.Parent=searchRow
reg(sClear,"TextColor3","sub")
local libBody=Instance.new("Frame")
libBody.Size=UDim2.new(1,0,1,-84) libBody.Position=UDim2.new(0,0,0,80) libBody.BackgroundTransparency=1 libBody.ZIndex=13 libBody.Parent=pLib
local listScroll=Instance.new("ScrollingFrame")
listScroll.Size=UDim2.new(1,0,1,0) listScroll.BackgroundTransparency=1 listScroll.BorderSizePixel=0
listScroll.ScrollBarThickness=3 listScroll.ScrollBarImageColor3=C("acc") listScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y listScroll.CanvasSize=UDim2.new(0,0,0,0) listScroll.ZIndex=14 listScroll.Parent=libBody
local ll=Instance.new("UIListLayout") ll.Padding=UDim.new(0,6) ll.SortOrder=Enum.SortOrder.LayoutOrder ll.Parent=listScroll
local lp2=Instance.new("UIPadding") lp2.PaddingTop=UDim.new(0,4) lp2.PaddingBottom=UDim.new(0,10) lp2.PaddingLeft=UDim.new(0,8) lp2.PaddingRight=UDim.new(0,8) lp2.Parent=listScroll
reg(listScroll,"ScrollBarImageColor3","acc")
local plScroll=Instance.new("ScrollingFrame")
plScroll.Size=UDim2.new(1,0,1,0) plScroll.BackgroundTransparency=1 plScroll.BorderSizePixel=0
plScroll.ScrollBarThickness=3 plScroll.ScrollBarImageColor3=C("acc") plScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y plScroll.CanvasSize=UDim2.new(0,0,0,0) plScroll.Visible=false plScroll.ZIndex=14 plScroll.Parent=libBody
local pll=Instance.new("UIListLayout") pll.Padding=UDim.new(0,6) pll.SortOrder=Enum.SortOrder.LayoutOrder pll.Parent=plScroll
local plp=Instance.new("UIPadding") plp.PaddingTop=UDim.new(0,4) plp.PaddingBottom=UDim.new(0,10) plp.PaddingLeft=UDim.new(0,8) plp.PaddingRight=UDim.new(0,8) plp.Parent=plScroll
reg(plScroll,"ScrollBarImageColor3","acc")
local backRow=Instance.new("Frame")
backRow.Size=UDim2.new(1,-16,0,32) backRow.Position=UDim2.new(0,8,0,0) backRow.BackgroundTransparency=1 backRow.Visible=false backRow.ZIndex=15 backRow.Parent=libBody
local bBack=Instance.new("TextButton")
bBack.Size=UDim2.new(0,80,0,28) bBack.Position=UDim2.new(0,0,0.5,0) bBack.AnchorPoint=Vector2.new(0,0.5)
bBack.BackgroundColor3=C("card") bBack.BackgroundTransparency=0.3 bBack.BorderSizePixel=0 bBack.Text="< 返回" bBack.Font=Enum.Font.GothamBold bBack.TextSize=12 bBack.TextColor3=C("txt") bBack.ZIndex=16 bBack.Parent=backRow
local bbc=Instance.new("UICorner") bbc.CornerRadius=UDim.new(0,8) bbc.Parent=bBack
reg(bBack,"BackgroundColor3","card") reg(bBack,"TextColor3","txt")
local plName=Instance.new("TextLabel")
plName.Size=UDim2.new(1,-180,1,0) plName.Position=UDim2.new(0,88,0,0) plName.BackgroundTransparency=1
plName.Font=Enum.Font.GothamBold plName.TextSize=13 plName.TextColor3=C("txt") plName.TextXAlignment=Enum.TextXAlignment.Left plName.ZIndex=16 plName.Parent=backRow
reg(plName,"TextColor3","txt")
local bPlMenu=Instance.new("TextButton")
bPlMenu.Size=UDim2.new(0,80,0,28) bPlMenu.Position=UDim2.new(1,0,0.5,0) bPlMenu.AnchorPoint=Vector2.new(1,0.5)
bPlMenu.BackgroundColor3=C("card") bPlMenu.BackgroundTransparency=0.3 bPlMenu.BorderSizePixel=0 bPlMenu.Text="管理" bPlMenu.Font=Enum.Font.GothamBold bPlMenu.TextSize=12 bPlMenu.TextColor3=C("txt") bPlMenu.ZIndex=16 bPlMenu.Parent=backRow
local bpc=Instance.new("UICorner") bpc.CornerRadius=UDim.new(0,8) bpc.Parent=bPlMenu
reg(bPlMenu,"BackgroundColor3","card") reg(bPlMenu,"TextColor3","txt")
local setScroll=Instance.new("ScrollingFrame")
setScroll.Size=UDim2.new(1,0,1,0) setScroll.BackgroundTransparency=1 setScroll.BorderSizePixel=0
setScroll.ScrollBarThickness=3 setScroll.ScrollBarImageColor3=C("acc") setScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y setScroll.CanvasSize=UDim2.new(0,0,0,0) setScroll.ZIndex=13 setScroll.Parent=pSet
local sl2=Instance.new("UIListLayout") sl2.Padding=UDim.new(0,6) sl2.SortOrder=Enum.SortOrder.LayoutOrder sl2.Parent=setScroll
local sp2=Instance.new("UIPadding") sp2.PaddingTop=UDim.new(0,8) sp2.PaddingBottom=UDim.new(0,14) sp2.PaddingLeft=UDim.new(0,12) sp2.PaddingRight=UDim.new(0,12) sp2.Parent=setScroll
reg(setScroll,"ScrollBarImageColor3","acc")
local function mkSetRow(h)
	local f=Instance.new("Frame")
	f.Size=UDim2.new(1,0,0,h) f.BackgroundColor3=C("card") f.BackgroundTransparency=0.35 f.BorderSizePixel=0 f.ZIndex=14 f.Parent=setScroll
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,10) c.Parent=f
	reg(f,"BackgroundColor3","card")
	return f
end
local function mkSwitch(text,init,cb)
	local f=mkSetRow(44)
	local l=Instance.new("TextLabel")
	l.Size=UDim2.new(1,-80,1,0) l.Position=UDim2.new(0,14,0,0) l.BackgroundTransparency=1
	l.Font=FONT l.TextSize=13 l.Text=text l.TextColor3=C("txt") l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=15 l.Parent=f
	reg(l,"TextColor3","txt")
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0,44,0,24) b.Position=UDim2.new(1,-14,0.5,0) b.AnchorPoint=Vector2.new(1,0.5)
	b.BackgroundColor3=init and C("acc") or C("bar") b.BorderSizePixel=0 b.Text="" b.ZIndex=15 b.Parent=f
	local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(1,0) bc.Parent=b
	local k=Instance.new("Frame")
	k.Size=UDim2.new(0,18,0,18) k.Position=init and UDim2.new(1,-21,0.5,0) or UDim2.new(0,3,0.5,0) k.AnchorPoint=Vector2.new(0,0.5)
	k.BackgroundColor3=Color3.fromRGB(255,255,255) k.BorderSizePixel=0 k.ZIndex=16 k.Parent=b
	local kc=Instance.new("UICorner") kc.CornerRadius=UDim.new(1,0) kc.Parent=k
	local st={v=init}
	b.MouseButton1Click:Connect(function()
		st.v=not st.v
		b.BackgroundColor3=st.v and C("acc") or C("bar")
		k.Position=st.v and UDim2.new(1,-21,0.5,0) or UDim2.new(0,3,0.5,0)
		cb(st.v)
	end)
	return f,b,st
end
local function mkChoice(text,opts,init,cb)
	local f=mkSetRow(44)
	local l=Instance.new("TextLabel")
	l.Size=UDim2.new(1,-140,1,0) l.Position=UDim2.new(0,14,0,0) l.BackgroundTransparency=1
	l.Font=FONT l.TextSize=13 l.Text=text l.TextColor3=C("txt") l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=15 l.Parent=f
	reg(l,"TextColor3","txt")
	local idx=init
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0,120,0,28) b.Position=UDim2.new(1,-14,0.5,0) b.AnchorPoint=Vector2.new(1,0.5)
	b.BackgroundColor3=C("bar") b.BorderSizePixel=0 b.Text=opts[idx] b.Font=Enum.Font.GothamBold b.TextSize=12 b.TextColor3=C("txt") b.ZIndex=15 b.Parent=f
	local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,8) bc.Parent=b
	reg(b,"BackgroundColor3","bar") reg(b,"TextColor3","txt")
	b.MouseButton1Click:Connect(function()
		idx=idx%#opts+1
		b.Text=opts[idx]
		cb(idx,opts[idx])
	end)
	return f,b
end
local function mkActRow(text,btn,col,cb)
	local f=mkSetRow(44)
	local l=Instance.new("TextLabel")
	l.Size=UDim2.new(1,-120,1,0) l.Position=UDim2.new(0,14,0,0) l.BackgroundTransparency=1
	l.Font=FONT l.TextSize=13 l.Text=text l.TextColor3=C("txt") l.TextXAlignment=Enum.TextXAlignment.Left l.ZIndex=15 l.Parent=f
	reg(l,"TextColor3","txt")
	local b=Instance.new("TextButton")
	b.Size=UDim2.new(0,100,0,28) b.Position=UDim2.new(1,-14,0.5,0) b.AnchorPoint=Vector2.new(1,0.5)
	b.BackgroundColor3=col b.BorderSizePixel=0 b.Text=btn b.Font=Enum.Font.GothamBold b.TextSize=12 b.TextColor3=Color3.fromRGB(255,255,255) b.ZIndex=15 b.Parent=f
	local bc=Instance.new("UICorner") bc.CornerRadius=UDim.new(0,8) bc.Parent=b
	b.MouseButton1Click:Connect(cb)
	return f,b
end
local lyricPage=Instance.new("Frame")
lyricPage.Size=UDim2.new(1,0,1,0) lyricPage.BackgroundColor3=C("bg") lyricPage.BorderSizePixel=0 lyricPage.Visible=false lyricPage.ZIndex=100 lyricPage.Parent=main
reg(lyricPage,"BackgroundColor3","bg")
local lyTop=Instance.new("Frame")
lyTop.Size=UDim2.new(1,0,0,46) lyTop.BackgroundColor3=C("top") lyTop.BorderSizePixel=0 lyTop.ZIndex=101 lyTop.Parent=lyricPage
reg(lyTop,"BackgroundColor3","top")
local lyTitle=Instance.new("TextLabel")
lyTitle.Size=UDim2.new(1,-90,1,0) lyTitle.Position=UDim2.new(0,16,0,0) lyTitle.BackgroundTransparency=1
lyTitle.Font=Enum.Font.GothamBold lyTitle.TextSize=15 lyTitle.Text="歌词" lyTitle.TextColor3=C("txt") lyTitle.TextXAlignment=Enum.TextXAlignment.Left lyTitle.ZIndex=102 lyTitle.Parent=lyTop
reg(lyTitle,"TextColor3","txt")
local lyEd=Instance.new("TextButton")
lyEd.Size=UDim2.new(0,56,0,28) lyEd.Position=UDim2.new(1,-78,0.5,0) lyEd.AnchorPoint=Vector2.new(1,0.5)
lyEd.BackgroundColor3=C("card") lyEd.BorderSizePixel=0 lyEd.Text="粘贴" lyEd.Font=Enum.Font.GothamBold lyEd.TextSize=12 lyEd.TextColor3=C("txt") lyEd.ZIndex=102 lyEd.Parent=lyTop
local lye=Instance.new("UICorner") lye.CornerRadius=UDim.new(0,8) lye.Parent=lyEd
reg(lyEd,"BackgroundColor3","card") reg(lyEd,"TextColor3","txt")
local lyClose=Instance.new("TextButton")
lyClose.Size=UDim2.new(0,56,0,28) lyClose.Position=UDim2.new(1,-14,0.5,0) lyClose.AnchorPoint=Vector2.new(1,0.5)
lyClose.BackgroundColor3=C("card") lyClose.BorderSizePixel=0 lyClose.Text="关闭" lyClose.Font=Enum.Font.GothamBold lyClose.TextSize=12 lyClose.TextColor3=C("txt") lyClose.ZIndex=102 lyClose.Parent=lyTop
local lyc=Instance.new("UICorner") lyc.CornerRadius=UDim.new(0,8) lyc.Parent=lyClose
reg(lyClose,"BackgroundColor3","card") reg(lyClose,"TextColor3","txt")
local lyScroll=Instance.new("ScrollingFrame")
lyScroll.Size=UDim2.new(1,-20,1,-70) lyScroll.Position=UDim2.new(0,10,0,56) lyScroll.BackgroundTransparency=1 lyScroll.BorderSizePixel=0
lyScroll.ScrollBarThickness=3 lyScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y lyScroll.CanvasSize=UDim2.new(0,0,0,0) lyScroll.ZIndex=101 lyScroll.Parent=lyricPage
local lyl=Instance.new("UIListLayout") lyl.Padding=UDim.new(0,14) lyl.SortOrder=Enum.SortOrder.LayoutOrder lyl.Parent=lyScroll
local lyp=Instance.new("UIPadding") lyp.PaddingTop=UDim.new(0,120) lyp.PaddingBottom=UDim.new(0,120) lyp.Parent=lyScroll
local lyricLines=nil
local queuePage=Instance.new("Frame")
queuePage.Size=UDim2.new(1,0,1,0) queuePage.BackgroundColor3=C("bg") queuePage.BorderSizePixel=0 queuePage.Visible=false queuePage.ZIndex=100 queuePage.Parent=main
reg(queuePage,"BackgroundColor3","bg")
local qTop=Instance.new("Frame")
qTop.Size=UDim2.new(1,0,0,46) qTop.BackgroundColor3=C("top") qTop.BorderSizePixel=0 qTop.ZIndex=101 qTop.Parent=queuePage
reg(qTop,"BackgroundColor3","top")
local qTitle=Instance.new("TextLabel")
qTitle.Size=UDim2.new(1,-160,1,0) qTitle.Position=UDim2.new(0,16,0,0) qTitle.BackgroundTransparency=1
qTitle.Font=Enum.Font.GothamBold qTitle.TextSize=15 qTitle.Text="播放队列" qTitle.TextColor3=C("txt") qTitle.TextXAlignment=Enum.TextXAlignment.Left qTitle.ZIndex=102 qTitle.Parent=qTop
reg(qTitle,"TextColor3","txt")
local qClear=Instance.new("TextButton")
qClear.Size=UDim2.new(0,86,0,28) qClear.Position=UDim2.new(1,-64,0.5,0) qClear.AnchorPoint=Vector2.new(1,0.5)
qClear.BackgroundColor3=Color3.fromRGB(150,50,60) qClear.BorderSizePixel=0 qClear.Text="清空队列" qClear.Font=Enum.Font.GothamBold qClear.TextSize=12 qClear.TextColor3=Color3.fromRGB(255,255,255) qClear.ZIndex=102 qClear.Parent=qTop
local qcc=Instance.new("UICorner") qcc.CornerRadius=UDim.new(0,8) qcc.Parent=qClear
local qClose=Instance.new("TextButton")
qClose.Size=UDim2.new(0,50,0,28) qClose.Position=UDim2.new(1,-8,0.5,0) qClose.AnchorPoint=Vector2.new(1,0.5)
qClose.BackgroundColor3=C("card") qClose.BorderSizePixel=0 qClose.Text="关闭" qClose.Font=Enum.Font.GothamBold qClose.TextSize=12 qClose.TextColor3=C("txt") qClose.ZIndex=102 qClose.Parent=qTop
local qc=Instance.new("UICorner") qc.CornerRadius=UDim.new(0,8) qc.Parent=qClose
reg(qClose,"BackgroundColor3","card") reg(qClose,"TextColor3","txt")
local qScroll=Instance.new("ScrollingFrame")
qScroll.Size=UDim2.new(1,0,1,-46) qScroll.Position=UDim2.new(0,0,0,46) qScroll.BackgroundTransparency=1 qScroll.BorderSizePixel=0
qScroll.ScrollBarThickness=3 qScroll.AutomaticCanvasSize=Enum.AutomaticSize.Y qScroll.CanvasSize=UDim2.new(0,0,0,0) qScroll.ZIndex=101 qScroll.Parent=queuePage
local ql=Instance.new("UIListLayout") ql.Padding=UDim.new(0,6) ql.SortOrder=Enum.SortOrder.LayoutOrder ql.Parent=qScroll
local qp=Instance.new("UIPadding") qp.PaddingTop=UDim.new(0,8) qp.PaddingBottom=UDim.new(0,12) qp.PaddingLeft=UDim.new(0,8) qp.PaddingRight=UDim.new(0,8) qp.Parent=qScroll
local mini=Instance.new("TextButton")
mini.Size=UDim2.new(0,58,0,58) mini.Position=UDim2.new(0,14,0.5,0)
mini.BackgroundColor3=Color3.fromRGB(26,24,40) mini.BorderSizePixel=0 mini.Text="♪" mini.Font=Enum.Font.GothamBold mini.TextSize=22
mini.TextColor3=Color3.fromRGB(180,150,255) mini.Visible=false mini.ZIndex=200 mini.Parent=gui
local mic=Instance.new("UICorner") mic.CornerRadius=UDim.new(0,18) mic.Parent=mini
local mis=Instance.new("UIStroke") mis.Color=C("acc") mis.Thickness=1.5 mis.Transparency=0.4 mis.Parent=mini
reg(mis,"Color","acc")
local function clampP(pos,sz)
	local x=math.clamp(pos.X.Offset,-sz.X.Offset*0.4,vw-sz.X.Offset*0.6)
	local y=math.clamp(pos.Y.Offset,-8,vh-sz.Y.Offset*0.6)
	return UDim2.new(0,x,0,y)
end
local function mkDrag(handle,target,onClick)
	local drag=false local si=nil local sp=nil local mv=false
	handle.InputBegan:Connect(function(i)
		if i.UserInputType==Enum.UserInputType.MouseButton1 or i.UserInputType==Enum.UserInputType.Touch then
			drag=true mv=false si=i.Position sp=target.Position
			local cn
			cn=i.Changed:Connect(function()
				if i.UserInputState==Enum.UserInputState.End then
					drag=false cn:Disconnect()
					if not mv and onClick then onClick() end
				end
			end)
		end
	end)
	UIS.InputChanged:Connect(function(i)
		if drag and (i.UserInputType==Enum.UserInputType.MouseMovement or i.UserInputType==Enum.UserInputType.Touch) then
			local d=i.Position-si
			if d.Magnitude>5 then mv=true end
			target.Position=clampP(UDim2.new(0,sp.X.Offset+d.X,0,sp.Y.Offset+d.Y),target.AbsoluteSize)
		end
	end)
end
mkDrag(top,main,nil)
mkDrag(mini,mini,function()
	mini.Visible=false main.Visible=true musc.Scale=0.9
	TweenService:Create(musc,TweenInfo.new(0.28,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
end)
local function findSong(id)
	for _,s in ipairs(DB.songs) do if s.id==tostring(id) then return s end end
	return nil
end
local function addSong(id,name)
	id=tostring(id)
	local ex=findSong(id)
	if ex then return ex end
	local s={id=id,name=name or ("音频 "..id),artist="未知作者",album="未知专辑",cover="",lyrics=nil,dur=0}
	table.insert(DB.songs,s)
	return s
end
local function fetchInfo(s)
	task.spawn(function()
		local ok,d=pcall(function() return MPS:GetProductInfo(tonumber(s.id),Enum.InfoType.Asset) end)
		if ok and d then
			if d.Name and d.Name~="" then s.name=d.Name end
			if d.Creator and d.Creator and d.Creator.Name then s.artist=d.Creator.Name end
			refreshAll()
			if cur==s then nmLbl.Text=s.name arLbl.Text=s.artist end
		end
	end)
end
local function pushHist(s)
	for i=#DB.hist,1,-1 do if DB.hist[i].id==s.id then table.remove(DB.hist,i) end end
	table.insert(DB.hist,1,{id=s.id,at=os.time()})
	if #DB.hist>100 then table.remove(DB.hist,#DB.hist) end
end
local function refreshFav()
	DB.fav={}
	for _,s in ipairs(DB.songs) do if s.liked then table.insert(DB.fav,s.id) end end
end
local function setPlayIcon()
	bPlay.Text=playing and "||" or ">"
	coverMask.Text=playing and "||" or ">"
end
local function updateNow()
	if not cur then
		nmLbl.Text="未在播放" arLbl.Text="从下方添加音乐 ID" tAll.Text="00:00" tCur.Text="00:00"
		coverImg.Image="" setPlayIcon() return
	end
	nmLbl.Text=cur.name
	arLbl.Text=cur.artist
	coverImg.Image=cur.cover~="" and "rbxassetid://"..cur.cover or ""
	chipFav.Text=cur.liked and "已收藏" or "收藏"
	setPlayIcon()
end
local function doPlay(s)
	if not s then return end
	cur=s
	updateNow()
	sound:Stop()
	sound.SoundId=sid(s.id)
	sound.Volume=muted and 0 or vol
	sound.PlaybackSpeed=SPEEDS[speedI]
	playing=true
	setPlayIcon()
	sound:Play()
	task.spawn(function()
		pcall(function()
			if not sound.IsLoaded then sound.Loaded:Wait(8) end
		end)
		if sound.TimeLength>0 then s.dur=sound.TimeLength tAll.Text=fmt(sound.TimeLength) end
	end)
	pushHist(s)
	fetchInfo(s)
	refreshAll()
end
local function toggle()
	if not cur then Toast("先添加一首音乐") return end
	if playing then
		sound:Pause()
		playing=false
	else
		sound.Volume=muted and 0 or vol
		sound:Resume()
		playing=true
	end
	setPlayIcon()
end
local function nextSong(auto)
	if #DB.songs==0 then return end
	if loopI==2 and auto and cur then doPlay(cur) return end
	local n
	if shuffle then n=math.random(1,#DB.songs) else n=(curIdx%#DB.songs)+1 end
	curIdx=n
	doPlay(DB.songs[n])
end
local function prevSong()
	if #DB.songs==0 then return end
	local n=shuffle and math.random(1,#DB.songs) or ((curIdx-2+#DB.songs)%#DB.songs)+1
	curIdx=n
	doPlay(DB.songs[n])
end
sound.Ended:Connect(function()
	if loopI==2 and cur then
		doPlay(cur)
	elseif loopI==3 and curIdx>=#DB.songs then
		playing=false setPlayIcon()
	else
		nextSong(true)
	end
end)
local function mkRow(parent,song,onSel,onMore,showIdx)
	local f=Instance.new("Frame")
	f.Size=UDim2.new(1,0,0,54) f.BackgroundColor3=C("card") f.BackgroundTransparency=0.35 f.BorderSizePixel=0 f.ZIndex=20 f.Parent=parent
	local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,10) c.Parent=f
	reg(f,"BackgroundColor3","card")
	local cv=Instance.new("ImageLabel")
	cv.Size=UDim2.new(0,42,0,42) cv.Position=UDim2.new(0,6,0.5,0) cv.AnchorPoint=Vector2.new(0,0.5)
	cv.BackgroundColor3=C("bar") cv.BorderSizePixel=0 cv.Image=song.cover~="" and "rbxassetid://"..song.cover or "" cv.ScaleType=Enum.ScaleType.Crop cv.ZIndex=21 cv.Parent=f
	local cvc=Instance.new("UICorner") cvc.CornerRadius=UDim.new(0,8) cvc.Parent=cv
	reg(cv,"BackgroundColor3","bar")
	local n=Instance.new("TextLabel")
	n.Size=UDim2.new(1,-120,0,18) n.Position=UDim2.new(0,56,0,9) n.BackgroundTransparency=1
	n.Font=Enum.Font.GothamBold n.TextSize=13 n.Text=song.name n.TextColor3=C("txt") n.TextXAlignment=Enum.TextXAlignment.Left n.TextTruncate=Enum.TextTruncate.AtEnd n.ZIndex=21 n.Parent=f
	reg(n,"TextColor3","txt")
	local a=Instance.new("TextLabel")
	a.Size=UDim2.new(1,-120,0,16) a.Position=UDim2.new(0,56,0,28) a.BackgroundTransparency=1
	a.Font=FONT a.TextSize=11 a.Text=(showIdx and ("#"..showIdx.." ") or "")..song.artist.." · ID "..song.id a.TextColor3=C("sub") a.TextXAlignment=Enum.TextXAlignment.Left a.TextTruncate=Enum.TextTruncate.AtEnd a.ZIndex=21 a.Parent=f
	reg(a,"TextColor3","sub")
	local h=Instance.new("TextLabel")
	h.Size=UDim2.new(0,26,0,26) h.Position=UDim2.new(1,-34,0.5,0) h.AnchorPoint=Vector2.new(1,0.5)
	h.BackgroundTransparency=1 h.Font=Enum.Font.GothamBold h.TextSize=14 h.Text=song.liked and "H" or "h" h.TextColor3=song.liked and Color3.fromRGB(255,110,140) or C("sub") h.ZIndex=21 h.Parent=f
	local pb=Instance.new("TextButton")
	pb.Size=UDim2.new(1,-60,1,0) pb.Position=UDim2.new(0,0,0,0) pb.BackgroundTransparency=1 pb.Text="" pb.ZIndex=22 pb.Parent=f
	pb.MouseButton1Click:Connect(function() onSel(song) end)
	local mb=Instance.new("TextButton")
	mb.Size=UDim2.new(0,34,1,0) mb.Position=UDim2.new(1,-34,0,0) mb.BackgroundTransparency=1 mb.Text="*" mb.Font=Enum.Font.GothamBold mb.TextSize=16 mb.TextColor3=C("sub") mb.ZIndex=22 mb.Parent=f
	reg(mb,"TextColor3","sub")
	mb.MouseButton1Click:Connect(function()
		local p=mb.AbsolutePosition
		onMore(song,math.max(4,p.X-140),p.Y+20)
	end)
	local fb=Instance.new("TextButton")
	fb.Size=UDim2.new(0,30,1,0) fb.Position=UDim2.new(1,-64,0,0) fb.BackgroundTransparency=1 fb.Text="" fb.ZIndex=22 fb.Parent=f
	fb.MouseButton1Click:Connect(function()
		song.liked=not song.liked
		h.Text=song.liked and "H" or "h"
		h.TextColor3=song.liked and Color3.fromRGB(255,110,140) or C("sub")
		refreshFav() updateNow()
	end)
	return f
end
local curSub=1
local openPl=nil
local function clearScroll(sc)
	for _,c in ipairs(sc:GetChildren()) do
		if c:IsA("Frame") or c:IsA("TextLabel") or c:IsA("TextButton") then c:Destroy() end
	end
end
local function songMenu(s,x,y)
	local items={
		{t="立即播放",f=function()
			for i,v in ipairs(DB.songs) do if v==s then curIdx=i break end end
			doPlay(s) Toast("开始播放")
		end},
		{t="下一首播放",f=function() table.insert(DB.queue,1,s.id) Toast("已加入下一首") end},
		{t="加到队列末尾",f=function() table.insert(DB.queue,s.id) Toast("已加入队列") end},
		{t="重命名",f=function()
			Modal("重命名歌曲","输入新名称",s.name,function(v,ok)
				if ok and v~="" then s.name=v refreshAll() updateNow() Toast("已重命名") end
			end)
		end},
		{t="改作者",f=function()
			Modal("修改作者","作者名",s.artist,function(v,ok)
				if ok and v~="" then s.artist=v refreshAll() updateNow() end
			end)
		end},
		{t="改专辑",f=function()
			Modal("修改专辑","专辑名",s.album,function(v,ok)
				if ok and v~="" then s.album=v refreshAll() end
			end)
		end},
		{t="改封面(图片ID)",f=function()
			Modal("修改封面","图片资产ID",s.cover,function(v,ok)
				if ok then s.cover=tostring(v):gsub("%s","") refreshAll() updateNow() end
			end)
		end},
		{t="复制 ID",f=function()
			pcall(function() setclipboard(s.id) end)
			Toast("ID: "..s.id)
		end},
		{t="收藏/取消",f=function()
			s.liked=not s.liked refreshFav() refreshAll() updateNow()
			Toast(s.liked and "已收藏" or "已取消")
		end},
		{t="添加到歌单",f=function()
			if #DB.pls==0 then Toast("先去歌单页新建") return end
			local sub={}
			for _,pl in ipairs(DB.pls) do
				table.insert(sub,{t="→ "..pl.name,f=function()
					local dup=false
					for _,i in ipairs(pl.ids) do if i==s.id then dup=true end end
					if not dup then table.insert(pl.ids,s.id) Toast("已加入") else Toast("已存在") end
				end})
			end
			Menu(x,y,sub)
		end},
		{t="查看详情",f=function()
			Modal("歌曲详情","","",function() end)
			modalTitle.Text="歌曲详情"
			modalInput.Text="名称："..s.name.."\n作者："..s.artist.."\n专辑："..s.album.."\nID："..s.id.."\n时长："..fmt(s.dur).."\n收藏："..(s.liked and "是" or "否")
			modalBox.Visible=true
		end},
		{t="从库中删除",danger=true,f=function()
			Confirm("删除《"..s.name.."》？",function()
				for i,v in ipairs(DB.songs) do if v==s then table.remove(DB.songs,i) break end end
				for _,pl in ipairs(DB.pls) do
					for i=#pl.ids,1,-1 do if pl.ids[i]==s.id then table.remove(pl.ids,i) end end
				end
				refreshFav() refreshAll() Toast("已删除")
			end)
		end},
	}
	Menu(x,y,items)
end
function refreshAll()
	clearScroll(listScroll)
	local q=searchBox.Text:lower()
	local pool={}
	if curSub==1 then
		for _,id in ipairs(DB.fav) do local s=findSong(id) if s then table.insert(pool,s) end end
	elseif curSub==2 then
		local add=Instance.new("TextButton")
		add.Size=UDim2.new(1,0,0,44) add.BackgroundColor3=C("acc") add.BackgroundTransparency=0.25 add.BorderSizePixel=0
		add.Text="+ 新建歌单文件夹" add.Font=Enum.Font.GothamBold add.TextSize=13 add.TextColor3=C("txt") add.ZIndex=20 add.Parent=listScroll
		local ac=Instance.new("UICorner") ac.CornerRadius=UDim.new(0,10) ac.Parent=add
		reg(add,"BackgroundColor3","acc") reg(add,"TextColor3","txt")
		add.MouseButton1Click:Connect(function()
			Modal("新建歌单","输入歌单名称","我的歌单",function(v,ok)
				if ok and v~="" then table.insert(DB.pls,{name=v,ids={}}) refreshAll() Toast("已创建") end
			end)
		end)
		for _,pl in ipairs(DB.pls) do
			local f=Instance.new("Frame")
			f.Size=UDim2.new(1,0,0,54) f.BackgroundColor3=C("card") f.BackgroundTransparency=0.35 f.BorderSizePixel=0 f.ZIndex=20 f.Parent=listScroll
			local c=Instance.new("UICorner") c.CornerRadius=UDim.new(0,10) c.Parent=f
			reg(f,"BackgroundColor3","card")
			local ic2=Instance.new("TextLabel")
			ic2.Size=UDim2.new(0,42,0,42) ic2.Position=UDim2.new(0,6,0.5,0) ic2.AnchorPoint=Vector2.new(0,0.5)
			ic2.BackgroundColor3=C("acc") ic2.BackgroundTransparency=0.4 ic2.BorderSizePixel=0 ic2.Text="F" ic2.Font=Enum.Font.GothamBold ic2.TextSize=18 ic2.TextColor3=Color3.fromRGB(255,255,255) ic2.ZIndex=21 ic2.Parent=f
			local icc=Instance.new("UICorner") icc.CornerRadius=UDim.new(0,8) icc.Parent=ic2
			reg(ic2,"BackgroundColor3","acc")
			local n=Instance.new("TextLabel")
			n.Size=UDim2.new(1,-120,0,18) n.Position=UDim2.new(0,56,0,9) n.BackgroundTransparency=1
			n.Font=Enum.Font.GothamBold n.TextSize=13 n.Text=pl.name n.TextColor3=C("txt") n.TextXAlignment=Enum.TextXAlignment.Left n.TextTruncate=Enum.TextTruncate.AtEnd n.ZIndex=21 n.Parent=f
			reg(n,"TextColor3","txt")
			local a=Instance.new("TextLabel")
			a.Size=UDim2.new(1,-120,0,16) a.Position=UDim2.new(0,56,0,28) a.BackgroundTransparency=1
			a.Font=FONT a.TextSize=11 a.Text=#pl.ids.." 首歌曲" a.TextColor3=C("sub") a.TextXAlignment=Enum.TextXAlignment.Left a.ZIndex=21 a.Parent=f
			reg(a,"TextColor3","sub")
			local ob=Instance.new("TextButton")
			ob.Size=UDim2.new(1,-60,1,0) ob.BackgroundTransparency=1 ob.Text="" ob.ZIndex=22 ob.Parent=f
			ob.MouseButton1Click:Connect(function()
				openPl=pl plName.Text=pl.name backRow.Visible=true listScroll.Visible=false plScroll.Visible=true refreshPl()
			end)
			local mb=Instance.new("TextButton")
			mb.Size=UDim2.new(0,34,1,0) mb.Position=UDim2.new(1,-34,0,0) mb.BackgroundTransparency=1 mb.Text="*" mb.Font=Enum.Font.GothamBold mb.TextSize=16 mb.TextColor3=C("sub") mb.ZIndex=22 mb.Parent=f
			mb.MouseButton1Click:Connect(function()
				local p=mb.AbsolutePosition
				Menu(math.max(4,p.X-140),p.Y+20,{
					{t="播放全部",f=function()
						if #pl.ids==0 then Toast("歌单是空的") return end
						for _,id in ipairs(pl.ids) do if not findSong(id) then addSong(id) end table.insert(DB.queue,id) end
						local s=findSong(pl.ids[1])
						curIdx=1 doPlay(s) Toast("播放歌单")
					end},
					{t="重命名歌单",f=function()
						Modal("重命名歌单","新名称",pl.name,function(v,ok)
							if ok and v~="" then pl.name=v refreshAll() end
						end)
					end},
					{t="复制全部 ID",f=function()
						pcall(function() setclipboard(table.concat(pl.ids,",")) end)
						Toast("已复制 "..#pl.ids.." 个")
					end},
					{t="删除歌单",danger=true,f=function()
						Confirm("删除《"..pl.name.."》？",function()
							for i,v in ipairs(DB.pls) do if v==pl then table.remove(DB.pls,i) break end end
							refreshAll() Toast("已删除")
						end)
					end},
				})
			end)
		end
		return
	elseif curSub==3 then
		for _,hh in ipairs(DB.hist) do local s=findSong(hh.id) if s then table.insert(pool,s) end end
		local cb=Instance.new("TextButton")
		cb.Size=UDim2.new(1,0,0,38) cb.BackgroundColor3=Color3.fromRGB(150,50,60) cb.BackgroundTransparency=0.2 cb.BorderSizePixel=0
		cb.Text="清空历史记录" cb.Font=Enum.Font.GothamBold cb.TextSize=12 cb.TextColor3=Color3.fromRGB(255,255,255) cb.ZIndex=20 cb.Parent=listScroll
		local cbc=Instance.new("UICorner") cbc.CornerRadius=UDim.new(0,9) cbc.Parent=cb
		cb.MouseButton1Click:Connect(function()
			Confirm("清空全部历史？",function() DB.hist={} refreshAll() Toast("已清空") end)
		end)
	else
		pool=DB.songs
	end
	local cnt=0
	for _,s in ipairs(pool) do
		if q=="" or tostring(s.name):lower():find(q,1,true) or tostring(s.artist):lower():find(q,1,true) or tostring(s.id):find(q,1,true) then
			cnt=cnt+1
			mkRow(listScroll,s,function(sg)
				for i,v in ipairs(DB.songs) do if v==sg then curIdx=i break end end
				doPlay(sg)
			end,songMenu,curSub==3 and cnt or nil)
		end
	end
	if cnt==0 then
		local e=Instance.new("TextLabel")
		e.Size=UDim2.new(1,0,0,60) e.BackgroundTransparency=1 e.Font=FONT e.TextSize=12
		e.Text="这里还没有内容\n在「正在播放」页输入音乐 ID 添加" e.TextColor3=C("sub") e.TextWrapped=true e.ZIndex=20 e.Parent=listScroll
		reg(e,"TextColor3","sub")
	end
	refreshFav()
end
function refreshPl()
	clearScroll(plScroll)
	if not openPl then return end
	if #openPl.ids==0 then
		local e=Instance.new("TextLabel")
		e.Size=UDim2.new(1,0,0,60) e.BackgroundTransparency=1 e.Font=FONT e.TextSize=12
		e.Text="空歌单\n用歌曲右侧 * → 添加到歌单" e.TextColor3=C("sub") e.TextWrapped=true e.ZIndex=20 e.Parent=plScroll
		reg(e,"TextColor3","sub")
		return
	end
	for i,id in ipairs(openPl.ids) do
		local s=findSong(id)
		if not s then s=addSong(id) end
		mkRow(plScroll,s,function(sg)
			for j,v in ipairs(DB.songs) do if v==sg then curIdx=j break end end
			doPlay(sg)
		end,function(sg,x,y)
			Menu(x,y,{
				{t="播放",f=function() doPlay(sg) end},
				{t="从此歌单移除",danger=true,f=function()
					for k,v in ipairs(openPl.ids) do if v==sg.id then table.remove(openPl.ids,k) break end end
					refreshPl() refreshAll() Toast("已移除")
				end},
				{t="重命名",f=function()
					Modal("重命名","新名称",sg.name,function(v,ok)
						if ok and v~="" then sg.name=v refreshPl() updateNow() end
					end)
				end},
				{t="收藏",f=function() sg.liked=not sg.liked refreshFav() refreshPl() updateNow() end},
			})
		end,i)
	end
end
function refreshQueue()
	clearScroll(qScroll)
	if #DB.queue==0 then
		local e=Instance.new("TextLabel")
		e.Size=UDim2.new(1,0,0,50) e.BackgroundTransparency=1 e.Font=FONT e.TextSize=12
		e.Text="队列为空\n歌曲 * → 加到队列" e.TextColor3=C("sub") e.TextWrapped=true e.ZIndex=101 e.Parent=qScroll
		reg(e,"TextColor3","sub")
		return
	end
	for i,id in ipairs(DB.queue) do
		local s=findSong(id)
		if not s then s=addSong(id) end
		mkRow(qScroll,s,function(sg)
			table.remove(DB.queue,i)
			doPlay(sg) refreshQueue()
		end,function(sg,x,y)
			Menu(x,y,{
				{t="立即播放",f=function() table.remove(DB.queue,i) doPlay(sg) refreshQueue() end},
				{t="上移",f=function()
					if i>1 then DB.queue[i],DB.queue[i-1]=DB.queue[i-1],DB.queue[i] refreshQueue() end
				end},
				{t="下移",f=function()
					if i<#DB.queue then DB.queue[i],DB.queue[i+1]=DB.queue[i+1],DB.queue[i] refreshQueue() end
				end},
				{t="移除",danger=true,f=function() table.remove(DB.queue,i) refreshQueue() Toast("已移除") end},
			})
		end,i)
	end
end
local function refreshLyric()
	clearScroll(lyScroll)
	local lines={}
	if cur and cur.lyrics and cur.lyrics~="" then
		for l in tostring(cur.lyrics):gmatch("[^\r\n]+") do if l~="" then table.insert(lines,l) end end
	end
	lyricLines=lines
	if #lines==0 then
		local e=Instance.new("TextLabel")
		e.Size=UDim2.new(1,0,0,80) e.BackgroundTransparency=1 e.Font=FONT e.TextSize=13
		e.Text="暂无歌词\n点右上角「粘贴」自己填\n一行一句" e.TextColor3=C("sub") e.TextWrapped=true e.ZIndex=102 e.Parent=lyScroll
		reg(e,"TextColor3","sub")
		return
	end
	for i,l in ipairs(lines) do
		local t=Instance.new("TextLabel")
		t.Name="L"..i
		t.Size=UDim2.new(1,0,0,26) t.BackgroundTransparency=1 t.Font=FONT t.TextSize=14
		t.Text=l t.TextColor3=C("sub") t.TextWrapped=true t.TextXAlignment=Enum.TextXAlignment.Left t.ZIndex=102 t.Parent=lyScroll
		reg(t,"TextColor3","sub")
	end
end
bPlay.MouseButton1Click:Connect(toggle)
coverMask.MouseButton1Click:Connect(toggle)
bPrev.MouseButton1Click:Connect(prevSong)
bNext.MouseButton1Click:Connect(function() nextSong(false) end)
chipLoop.MouseButton1Click:Connect(function()
	loopI=loopI%3+1 chipLoop.Text=LOOPMODE[loopI] Toast(LOOPMODE[loopI])
end)
chipShuf.MouseButton1Click:Connect(function()
	shuffle=not shuffle chipShuf.Text="随机 "..(shuffle and "开" or "关") Toast("随机 "..(shuffle and "开" or "关"))
end)
chipSpeed.MouseButton1Click:Connect(function()
	speedI=speedI%#SPEEDS+1
	chipSpeed.Text=SPEEDS[speedI].."x"
	sound.PlaybackSpeed=SPEEDS[speedI]
	Toast("倍速 "..SPEEDS[speedI].."x")
end)
chipTimer.MouseButton1Click:Connect(function()
	timerI=timerI%#TIMERS+1
	chipTimer.Text=TIMERS[timerI]==0 and "定时 关" or (TIMERS[timerI].."分钟")
	timerEnd=TIMERS[timerI]==0 and 0 or (os.time()+TIMERS[timerI]*60)
	Toast(TIMERS[timerI]==0 and "定时关闭" or (TIMERS[timerI].." 分钟后停止"))
end)
chipFav.MouseButton1Click:Connect(function()
	if not cur then Toast("还没播歌") return end
	cur.liked=not cur.liked refreshFav() updateNow() refreshAll()
	Toast(cur.liked and "已收藏" or "已取消")
end)
chipLyric.MouseButton1Click:Connect(function() refreshLyric() lyricPage.Visible=true end)
lyClose.MouseButton1Click:Connect(function() lyricPage.Visible=false end)
lyEd.MouseButton1Click:Connect(function()
	if not cur then Toast("先播一首歌") return end
	Modal("粘贴歌词","一行一句",cur.lyrics or "",function(v,ok)
		if ok then cur.lyrics=v refreshLyric() Toast("歌词已保存") end
	end)
end)
chipQueue.MouseButton1Click:Connect(function() refreshQueue() queuePage.Visible=true end)
qClose.MouseButton1Click:Connect(function() queuePage.Visible=false end)
qClear.MouseButton1Click:Connect(function()
	Confirm("清空播放队列？",function() DB.queue={} refreshQueue() Toast("已清空") end)
end)
chipInfo.MouseButton1Click:Connect(function()
	if not cur then Toast("还没播歌") return end
	Modal("歌曲详情","","",function() end)
	modalTitle.Text="歌曲详情"
	modalInput.Text="名称："..cur.name.."\n作者："..cur.artist.."\n专辑："..cur.album.."\nID："..cur.id.."\n时长："..fmt(cur.dur).."\n倍速："..SPEEDS[speedI].."x\n收藏："..(cur.liked and "是" or "否")
	modalBox.Visible=true
end)
vIconBtn.MouseButton1Click:Connect(function()
	muted=not muted
	sound.Volume=muted and 0 or vol
	vIcon.Text=muted and "M" or "V"
	Toast(muted and "已静音" or "取消静音")
end)
idAdd.MouseButton1Click:Connect(function()
	local raw=idInput.Text:gsub("%s","")
	if raw=="" then Toast("先输入 ID") return end
	local nm,id
	if raw:find(",") then
		local p=raw:split(",") nm=p[1] id=p[2]
	else
		id=raw
	end
	if not tonumber(id) then Toast("ID 必须是数字") return end
	local s=addSong(id,nm)
	for i,v in ipairs(DB.songs) do if v==s then curIdx=i break end end
	idInput.Text=""
	doPlay(s)
	Toast("已添加并开始播放")
end)
idInput.FocusLost:Connect(function(e) if e then idAdd:Activate() end end)
for i,b in ipairs(subBtns) do
	b.MouseButton1Click:Connect(function()
		curSub=i
		openPl=nil backRow.Visible=false listScroll.Visible=true plScroll.Visible=false
		for j,b2 in ipairs(subBtns) do b2.TextColor3=(j==i) and C("txt") or C("sub") end
		sline.Position=UDim2.new((i-1)*0.25,8,1,-2)
		refreshAll()
	end)
end
subBtns[1].TextColor3=C("txt")
bBack.MouseButton1Click:Connect(function()
	openPl=nil backRow.Visible=false listScroll.Visible=true plScroll.Visible=false refreshAll()
end)
bPlMenu.MouseButton1Click:Connect(function()
	if not openPl then return end
	local p=bPlMenu.AbsolutePosition
	Menu(math.max(4,p.X-140),p.Y+24,{
		{t="播放全部",f=function()
			if #openPl.ids==0 then Toast("空歌单") return end
			for _,id in ipairs(openPl.ids) do if not findSong(id) then addSong(id) end table.insert(DB.queue,id) end
			doPlay(findSong(openPl.ids[1])) Toast("已加入队列")
		end},
		{t="重命名",f=function()
			Modal("重命名歌单","新名称",openPl.name,function(v,ok)
				if ok and v~="" then openPl.name=v plName.Text=v refreshAll() end
			end)
		end},
		{t="删除歌单",danger=true,f=function()
			Confirm("删除《"..openPl.name.."》？",function()
				for i,v in ipairs(DB.pls) do if v==openPl then table.remove(DB.pls,i) break end end
				openPl=nil backRow.Visible=false listScroll.Visible=true plScroll.Visible=false refreshAll()
			end)
		end},
	})
end)
searchBox:GetPropertyChangedSignal("Text"):Connect(function() if curSub~=2 then refreshAll() end end)
sClear.MouseButton1Click:Connect(function() searchBox.Text="" refreshAll() end)
local function switchTab(i)
	pNow.Visible=(i==1) pLib.Visible=(i==2) pSet.Visible=(i==3)
	tabNow.TextColor3=(i==1) and C("txt") or C("sub")
	tabLib.TextColor3=(i==2) and C("txt") or C("sub")
	tabSet.TextColor3=(i==3) and C("txt") or C("sub")
	tline.Position=UDim2.new((i-1)/3,12,1,-3)
	if i==2 then refreshAll() end
end
tabNow.MouseButton1Click:Connect(function() switchTab(1) end)
tabLib.MouseButton1Click:Connect(function() switchTab(2) end)
tabSet.MouseButton1Click:Connect(function() switchTab(3) end)
tabNow.TextColor3=C("txt")
mkSwitch("淡入淡出",SET.fade,function(v) SET.fade=v end)
mkSwitch("频谱动画",SET.spec,function(v) SET.spec=v spec.Visible=v end)
mkSwitch("启用歌词页",SET.lyric,function(v) SET.lyric=v chipLyric.Visible=v end)
mkChoice("音质",{"流畅","标准","高清","无损"},2,function(i,v) SET.quality=v Toast("音质："..v) end)
mkChoice("封面动效",{"静止","旋转","呼吸"},1,function(i,v) SET.cover=v Toast("封面："..v) end)
mkChoice("主题配色",{"暗紫","纯黑","深海","森语"},1,function(i,v)
	TI=i applyTheme() Toast("主题："..v)
end)
mkActRow("新建歌单文件夹","+ 新建",C("acc"),function()
	Modal("新建歌单","输入名称","我的歌单",function(v,ok)
		if ok and v~="" then table.insert(DB.pls,{name=v,ids={}}) refreshAll() Toast("已创建") end
	end)
end)
mkActRow("批量导入 ID","导入",C("acc"),function()
	Modal("批量导入","多个ID用逗号或换行分隔","",function(v,ok)
		if not ok or v=="" then return end
		local n=0
		for id in tostring(v):gmatch("%d+") do addSong(id) n=n+1 end
		refreshAll() Toast("导入 "..n.." 首")
	end)
end)
mkActRow("导出数据(复制)","导出",C("acc"),function()
	local ok,js=pcall(function() return HS:JSONEncode({songs=DB.songs,pls=DB.pls}) end)
	Modal("复制下面的内容保存","","",function() end)
	modalTitle.Text="导出数据"
	modalInput.Text=ok and js or "导出失败"
	modalBox.Visible=true
end)
mkActRow("导入数据(粘贴)","导入",C("acc"),function()
	Modal("粘贴之前导出的 JSON","JSON","",function(v,ok)
		if not ok or v=="" then return end
		local ok2,d=pcall(function() return HS:JSONDecode(v) end)
		if ok2 and d then
			if d.songs then DB.songs=d.songs end
			if d.pls then DB.pls=d.pls end
			refreshFav() refreshAll() Toast("导入成功")
		else
			Toast("JSON 格式不对")
		end
	end)
end)
mkActRow("睡眠定时设置","设置",C("acc"),function() chipTimer:Activate() end)
mkActRow("清空全部歌曲","清空",Color3.fromRGB(150,50,60),function()
	Confirm("清空整个音乐库？",function()
		DB.songs={} DB.queue={} DB.hist={} DB.fav={}
		for _,pl in ipairs(DB.pls) do pl.ids={} end
		sound:Stop() cur=nil playing=false updateNow() refreshAll() Toast("已清空")
	end)
end)
mkActRow("快捷键说明","查看",C("card"),function()
	Modal("操作说明","","",function() end)
	modalTitle.Text="操作说明"
	modalInput.Text="空格：播放/暂停\n左右方向键：切歌\nM：静音  L：歌词  Q：队列\n- 最小化  X 关闭\n拖动顶栏移动窗口"
	modalBox.Visible=true
end)
mkActRow("关于","查看",C("card"),function()
	Modal("关于","","",function() end)
	modalTitle.Text="关于"
	modalInput.Text="G2R5x 音乐\n本地播放器 · 仅自己可听见\n支持收藏/歌单/历史/队列\n数据存内存，退出前记得导出"
	modalBox.Visible=true
end)
bSearch.MouseButton1Click:Connect(function()
	switchTab(2) curSub=4
	for j,b2 in ipairs(subBtns) do b2.TextColor3=(j==4) and C("txt") or C("sub") end
	sline.Position=UDim2.new(0.75,8,1,-2)
	refreshAll()
end)
bMenu.MouseButton1Click:Connect(function()
	local p=bMenu.AbsolutePosition
	Menu(math.max(4,p.X-150),p.Y+30,{
		{t="添加音乐 ID",f=function() switchTab(1) end},
		{t="新建歌单",f=function()
			Modal("新建歌单","名称","我的歌单",function(v,ok)
				if ok and v~="" then table.insert(DB.pls,{name=v,ids={}}) refreshAll() Toast("已创建") end
			end)
		end},
		{t="复制当前歌曲 ID",f=function()
			if cur then pcall(function() setclipboard(cur.id) end) Toast("ID: "..cur.id) else Toast("没在播放") end
		end},
		{t="切换主题",f=function() TI=TI%#THEMES+1 applyTheme() Toast("主题："..THEMES[TI].name) end},
		{t="导出数据",f=function()
			local ok,js=pcall(function() return HS:JSONEncode({songs=DB.songs,pls=DB.pls}) end)
			Modal("复制保存","","",function() end)
			modalTitle.Text="导出数据" modalInput.Text=ok and js or "失败" modalBox.Visible=true
		end},
		{t="关于",f=function()
			Modal("关于","","",function() end)
			modalTitle.Text="关于" modalInput.Text="G2R5x 音乐\n本地播放器" modalBox.Visible=true
		end},
		{t="关闭播放器",danger=true,f=function() gui:Destroy() end},
	})
end)
bMin.MouseButton1Click:Connect(function() main.Visible=false mini.Visible=true end)
bX.MouseButton1Click:Connect(function() gui:Destroy() end)
local acc=0
local specT=0
RS.RenderStepped:Connect(function(dt)
	acc=acc+dt
	if acc<0.1 then return end
	acc=0
	if cur and sound.TimeLength>0 then
		local r=sound.TimePosition/sound.TimeLength
		setProg(math.clamp(r,0,1))
		tCur.Text=fmt(sound.TimePosition)
		tAll.Text=fmt(sound.TimeLength)
	end
	if SET.spec then
		specT=specT+0.1
		for i,b in ipairs(bars) do
			local h=playing and (3+math.abs(math.sin(specT*3+i*0.7))*26) or 3
			b.Size=UDim2.new(0,10,0,h)
		end
	end
	if SET.cover~="静止" and playing then
		if SET.cover=="旋转" then
			coverBig.Rotation=(coverBig.Rotation+1.2)%360
		else
			local s=1+math.sin(os.clock()*3)*0.03
			coverBig.Size=UDim2.new(0,150*s,0,150*s)
		end
	else
		coverBig.Size=UDim2.new(0,150,0,150)
	end
	if timerEnd>0 and os.time()>timerEnd then
		timerEnd=0 timerI=1 chipTimer.Text="定时 关"
		sound:Stop() playing=false setPlayIcon() Toast("定时结束")
	end
	if lyricLines and lyricPage.Visible and cur and sound.TimeLength>0 and #lyricLines>0 then
		local idx=math.floor(sound.TimePosition/sound.TimeLength*#lyricLines)+1
		for i=1,#lyricLines do
			local t=lyScroll:FindFirstChild("L"..i)
			if t then
				if i==idx then t.TextColor3=C("acc") t.TextSize=16 else t.TextColor3=C("sub") t.TextSize=14 end
			end
		end
	end
end)
addSong("1848354535","示例曲目 1")
addSong("9125919308","示例曲目 2")
addSong("9046864754","示例曲目 3")
addSong("1839246711","示例曲目 4")
addSong("6606226548","示例曲目 5")
table.insert(DB.pls,{name="我喜欢的音乐",ids={}})
table.insert(DB.pls,{name="默认收藏夹",ids={}})
switchTab(1)
refreshAll()
setPlayIcon()
task.spawn(function()
	local full=APP
	for i=1,#full do
		it.Text=full:sub(1,i) ig.Text=full:sub(1,i)
		task.wait(0.13)
	end
	TweenService:Create(isub,TweenInfo.new(0.5),{TextTransparency=0.4}):Play()
	task.wait(0.8)
	TweenService:Create(it,TweenInfo.new(0.55),{TextTransparency=1}):Play()
	TweenService:Create(ig,TweenInfo.new(0.55),{TextTransparency=1}):Play()
	TweenService:Create(isub,TweenInfo.new(0.55),{TextTransparency=1}):Play()
	task.wait(0.5)
	TweenService:Create(intro,TweenInfo.new(0.45),{BackgroundTransparency=1}):Play()
	task.wait(0.45)
	intro:Destroy()
	main.Visible=true
	TweenService:Create(musc,TweenInfo.new(0.35,Enum.EasingStyle.Back,Enum.EasingDirection.Out),{Scale=1}):Play()
	task.wait(0.4)
	Toast("输入音乐 ID 即可播放")
end)
