local ZGV = ZygorGuidesViewer	if not ZGV then return end
local Pointer = ZGV.Pointer	if not Pointer then return end

local arrowskindir,arrowskinlc,arrowskinname,arrowskinorder = "Stealth","stealth","Stealth","1"

local arrow = ZGV.Pointer:AddArrowSkin(arrowskinlc,arrowskinname,arrowskinorder)

local arrowframeproto = {}

arrow.features={colordist=true,smooth=false}

local sprite_angles_base = {[0]=0,0.5,1.1,2.6,4.5,6.9,9.7,13.0,16.7,20.8,25.3,30.1,35.3,40.7,46.4,52.4,58.7,65.2,71.9,78.8,85.9,93.1,100.5,108.1,115.7,123.5,131.4,139.4,147.4,155.5,163.6,168,173,180}
local sprite_angles={}

--DEBUGSPRITE1= sprite_angles_base
--DEBUGSPRITE2= sprite_angles
function arrow:CreateFrame()
	if not self.frame then
		self.frame = CreateFrame("BUTTON","ZygorGuidesViewerPointerArrow_".. arrowskindir,ZGV.Pointer.ArrowFrameCtrl,"ZygorGuidesViewerFrame_Arrow_template_".. arrowskinlc)
		self.frame.style = self.id

		for f,fu in pairs(arrowframeproto) do self.frame[f] = fu end

		self.frame:OnLoad()
	end
	return self.frame
end

------------ color
local ar,ag,ab = 1.0,0.0,0.0
local br,bg,bb = 0.8,0.7,0.0
local cr,cg,cb = 0.1,0.8,0.0

local msin,mcos,mabs,mfloor=math.sin,math.cos,math.abs,math.floor
local rad2deg = 180/math.pi

function arrowframeproto:OnLoad()
	local skindir = ZGV.DIR.."\\Arrows\\".. arrowskindir
	self.arrow.arr:SetTexture(true)
	self.arrow.arr:SetTexture(skindir.."\\arrow",false)
	self.arrow.arr:SetDrawLayer("ARTWORK",1)
	self.arrow.arrspecular:SetTexture(true)
	self.arrow.arrspecular:SetTexture(skindir.."\\arrow-specular",false)
	self.arrow.arrspecular:SetDrawLayer("ARTWORK",2)
	self.special:SetTexture(skindir.."\\specials",false)
	self.special:Hide()
	
	local spr_w,spr_h = 102,68
	local imgw,imgh = 1024,1024
	local w,h,inrow,total = spr_w/imgw,spr_h/imgh,floor(imgw/spr_w),floor(imgw/spr_w)*floor(imgh/spr_h)
	local step=360/total
	
	local TINY_TURNS = false

	self.arrow.SetAngle = function(self,angle)
		self.angle = angle
		angle=angle*rad2deg
		
		if TINY_TURNS then
			local frac_angle = angle%step
			
			if (angle<90 or angle>270) then
				if frac_angle>step*0.5 then frac_angle=frac_angle-step end
				local q=((angle<180) and angle or 360-angle)/180
				frac_angle=frac_angle*(1+q*0.7)
				
				frac_angle = frac_angle * (1+cos(angle*2))/2
			else
				frac_angle=0
			end
			
			self.turn.anim:SetRadians(frac_angle/rad2deg)  self.turn:Play()
		end
		
		--angle=(angle+(step/2))%360  -- shift step/2 forward
		local num = math.round(angle/step)%total
		local row,col = floor(num/inrow),num%inrow
		self.arr:SetTexCoord(col*w,(col+1)*w,row*h,(row+1)*h)
		self.arrspecular:SetTexCoord(col*w,(col+1)*w,row*h,(row+1)*h)

		self.arrspecular:SetAlpha(0.7)
	
		-- precision!
		if num==0 or num==1 or num==total-1 then
			if ZGV.db.profile.arrowcolordist then
				local r,g,b,a = self.arr:GetVertexColor()
				r = r + (1-r)*0.5
				g = g + (1-g)*0.5
				b = b + (1-b)*0.5
				self.arr:SetVertexColor(r,g,b,a)
			else
				self.arr:SetVertexColor(0.4,1.0,0.0,1.0)
				self.arrspecular:SetAlpha(1.0)
			end
		end

	end
	self:Hide()
	self.title:SetFont(ZGV.Font,9)

	self.arrow.warning = self.arrow:CreateAnimationGroup()
	local fade1 = ZGV.ChainCall(self.arrow.warning:CreateAnimation("Alpha")) :SetDuration(0.5) :SetToAlpha(1)  :SetOrder(1) .__END
	local fade2 = ZGV.ChainCall(self.arrow.warning:CreateAnimation("Alpha")) :SetDuration(0.5) :SetToAlpha(0) :SetOrder(2) .__END
end

local fadespeed=99
local THROTTLE=1/30  --NOTE: this is the crossfading speed, NOT the rotation update interval.
local elapsed_sum=0

local xfade=1 -- "-1" is special, "0" is none, "1" is arrow.
function arrowframeproto:OnUpdate (elapsed)
	do return end -- no more fading
	elapsed_sum=elapsed_sum+elapsed
	if elapsed_sum<THROTTLE then return end
	elapsed=elapsed_sum
	elapsed_sum=0

	local target=self.targetdisplay
	local xfade_target
	if target=="none" then xfade_target=0
	elseif target=="arrow" then xfade_target=1
	else xfade_target=-1 --special
	end
	
	if xfade~=xfade_target then xfade=xfade+(xfade_target>xfade and 1 or -1)*fadespeed*elapsed end
	if xfade<-1 then xfade=-1 end  if xfade>1 then xfade=1 end  if xfade>-0.05 and xfade<0.05 and xfade_target==0 then xfade=0 end

	if xfade>0 then self.special:SetAlpha(0) self.arrow:SetAlpha(xfade) return end
	if xfade<0 then self.special:SetAlpha(-xfade) self.arrow:SetAlpha(0) return end
	self.special:SetAlpha(0) self.arrow:SetAlpha(0)
end

function arrowframeproto:ShowArrived()
	self:ShowSpecial("here")
	--self.back:SetTexCoord(0,0,0,1,1,0,1,1)
end

local precision_range = 0.02
local precision_mult = 1/precision_range

function arrowframeproto:ShowTraveling (elapsed,angle,dist)
	self.arrow:Show() self.special:Hide()
	self.title:Show()
	
	self.arrow.warning:Stop()

	local profile=ZGV.db.profile

	local distperc,angleperc,tier

	local spangood,spanperf=0.50,0.25
	--if dist<500 then local mul=1-(dist/500)  mul=mul*mul*mul*mul*mul  spangood,spanperf = spangood+spangood*mul,spanperf+spanperf*mul  end

	Pointer.initialdist = Pointer.initialdist or dist

	if profile.arrowcolordist then
		distperc=max(0,1-(dist/min(max(100,Pointer.initialdist or 0),500)))
	else
		angleperc = mabs(1-angle*0.3183)  -- 1/pi  ;  0=target backwards, 1=target ahead
		--perc,tier = Pointer.CalculateDirectionTiers(perc,0,1-spangood,1-spangood,0.95)
	end
	local r,g,b = ZGV.gradient3(distperc or angleperc and min(angleperc*1.1,1), ar,ag,ab, br,bg,bb, cr,cg,cb, 0.5)
	self.arrow.arr:SetVertexColor(r,g,b)
	
	------------ rotation of elements

	self.arrow:SetAngle(angle)

	--[[
	if self.precise.turn and angleperc>=1-precision_range then
		-- precision dot
		local precangle = angle
		if precangle>3.141592 then precangle=precangle-6.283185 end
		precangle = precangle * 8  -- precision!
		while precangle>6.283185 do precangle=precangle-6.283185 end
		while precangle<0 do precangle=precangle+6.283185 end

		self.precise:SetAlpha((angleperc-1+precision_range)*precision_mult)
		self.precise.turn.anim:SetRadians(precangle)
		self.precise.turn:Play()
	else
		self.precise:SetAlpha(0)
	end
	--]]


	--[[
	local msin,mcos,mabs=msin,mcos,mabs

	local sin,cos = msin(angle + 2.356194)*0.85, mcos(angle + 2.356194)*0.85
	self.arrow:SetTexCoord(0.5-sin, 0.5+cos, 0.5+cos, 0.5+sin, 0.5-cos, 0.5-sin, 0.5+sin, 0.5-cos)
	--]]

end

local specials={"here","waiting","upstairs","downstairs","error","instance","instancehide"}
function arrowframeproto:ShowSpecial(spec)
	if spec==nil or not self.special[spec] then self.arrow:Hide() self.special:Hide() return end
	self.arrow:Hide() self.special:Show()
	for k,v in ipairs(specials) do if v~=spec then self.special[v]:Stop() end end
	self.special[spec]:Play()
end

function arrowframeproto:ShowStairs(up)
	self:ShowSpecial(up and "upstairs" or "downstairs")
end

function arrowframeproto:ShowWaiting(phase)
	--self.arrow:SetAngle(phase*6.28)
	self:ShowSpecial("waiting")
end

function arrowframeproto:ShowNothing()
	self:ShowSpecial(nil)
end

function arrowframeproto:ShowError()
	self:ShowSpecial("error")
end

function arrowframeproto:ShowInstance()
	self:ShowSpecial("instance")
end

function arrowframeproto:HideInstance()
	self:ShowSpecial("instancehide")
end

function arrowframeproto:ShowWarning()
	self.arrow.warning:Play()
end

function arrowframeproto:SetNotice (text)
	self.notice = text
end

function arrowframeproto:ShowText (title,dist,eta,status)
	self.stairs=false

	--Pointer.ArrowFrame_Proto_ShowText(self)
	local disttxt = Pointer.ArrowFrame_Proto_GetDistTxt(self,dist)
	local etatxt = Pointer.ArrowFrame_Proto_GetETATxt(self,eta)

	local distcolor
	if type(dist)=="number" then
		local perc=max(0,1-(dist/min(max(100,Pointer.initialdist or 0),500)))
		local r,g,b = ZGV.gradient3(perc, 1.0,0.5,0.4, 1.0,0.9,0.5, 0.7,1.0,0.6, 0.7)
		distcolor = ("|cff%02x%02x%02x"):format(r*255,g*255,b*255)
	else
		distcolor = "|cffffff00"
	end

	self.title:SetText(
		(title and "|cffffffff"..title.."|r\n" or "") ..
		(disttxt and distcolor..disttxt.."|r" or "") ..  (etatxt or "") ..
		(status and "|n"..status or "") ..
		(self.notice and "|n".. self.notice or "")
	)
end

function arrowframeproto:OnMouseWheel(delta)
	if IsControlKeyDown() then
		if delta>0 then delta=0.2 else delta=-0.2 end
		ZGV.db.profile.arrowscale = ZGV.db.profile.arrowscale + delta
		if ZGV.db.profile.arrowscale<0.8 then ZGV.db.profile.arrowscale=0.8 end
		if ZGV.db.profile.arrowscale>1.6 then ZGV.db.profile.arrowscale=1.6 end
		self:SetScale(ZGV.db.profile.arrowscale)
	end
end

function arrowframeproto:SetOption(opt,val)
	if opt=="metal" then
		local skindir = ZGV.DIR.."\\Arrows\\".. arrowskindir
		self.arrow.arr:SetTexture(skindir.."\\arrow"..(val and "-specular" or "") ,false)
	end
end
