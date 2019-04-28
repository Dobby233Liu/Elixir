_G.AnimationSystem = System:DeriveClass("AnimationSystem");

AnimationSystem:SetRegisterCompo{
   "Animate","Transform",
}

function AnimationSystem:Start()
	local iStage = self:GetCurScene():GetCurStage();
	for _,tbLayer in pairs(iStage:GetRenderList()) do
	   for _,iActor in ipairs(tbLayer) do  
         repeat
            if not self:GetRegisterCompo(iActor) then break end
            self:ReSetFrame(iActor);
            self:Play(iActor);
         until true
      end
   end
end

function AnimationSystem:ReSetFrame(iActor)
	local iCompoAnimate = iActor:GetiCompo("Animate");
	local sImg = iCompoAnimate.sImg;
	local iImage = AssetsMgr:GetTexture(sImg);
	iCompoAnimate.iImage = iImage;
	local nQuadW = iCompoAnimate.nQuadW;
	local nQuadH = iCompoAnimate.nQuadH;
	local nOffset = iCompoAnimate.nOffset;
	local nStartFrame = iCompoAnimate.nStartFrame;
	local nImgW,nImgH = iImage:getWidth(), iImage:getHeight();
	local nCol = math.floor(nImgW/nQuadW);
	local nRow = math.floor(nImgH/nQuadH);
	iCompoAnimate.tbQuad = {};
	local nFrame = 1;
	iCompoAnimate.nCurFrame = nFrame;
	for i = 0, nRow-1 do
		for j = 0, nCol-1 do
			iCompoAnimate.tbQuad[nFrame] = love.graphics.newQuad(j*nQuadW, i*nQuadH, nQuadW, nQuadH, nImgW, nImgH);
			nFrame = nFrame + 1;
		end
	end
	-- 根据偏移量裁剪序列帧,有点问题暂不可用
	-- for i = 1, nOffset do 
	--    table.remove(iCompoAnimate.tbQuad,i);
	-- end

	iCompoAnimate.nLastTime = 0;
	iCompoAnimate.nCurPlayCount = 0;
	iCompoAnimate.nTotalPlayCount = iCompoAnimate.nTotalPlayCount - nOffset;
	iCompoAnimate.iCurQuad = iCompoAnimate.tbQuad[nStartFrame or iCompoAnimate.nCurFrame];
end

function AnimationSystem:Update(dt)
	local iStage = self:GetCurScene():GetCurStage();
	for _,tbLayer in pairs(iStage:GetRenderList()) do
	   for _,iActor in ipairs(tbLayer) do  
			repeat
				if not self:GetRegisterCompo(iActor) then break end
				if not iActor.bVisible then break end
				local iCompoAnimate = iActor:GetiCompo("Animate");
				if not iCompoAnimate.bRunning then 
					break;
				end 
				local nTimeAfterPlay = iCompoAnimate.nTimeAfterPlay;
				local nLastTime = iCompoAnimate.nLastTime;
				local nTotalFrame = iCompoAnimate.nTotalFrame;
				local nCurPlayCount = iCompoAnimate.nCurPlayCount;
				local nTotalPlayCount = iCompoAnimate.nTotalPlayCount;
				local nLoop = iCompoAnimate.nLoop;
				local nNowTime = GetTime();
				if nNowTime - nLastTime > nTimeAfterPlay then 
					iCompoAnimate.nLastTime = nNowTime;
					iCompoAnimate.nCurFrame = iCompoAnimate.nCurFrame + 1;
					if iCompoAnimate.nCurFrame > nTotalFrame then 
						if nLoop == 0 then 
							iCompoAnimate.nCurPlayCount = iCompoAnimate.nCurPlayCount + 1;
							if iCompoAnimate.nCurPlayCount >= nTotalPlayCount then 
								iCompoAnimate.iCurQuad = nil;
								iCompoAnimate.bRunning = false;
								if self.fComplete then 
									self.fComplete();
								end 
								break;
							else 
								iCompoAnimate.nCurFrame = 1;
								iCompoAnimate.iCurQuad = iCompoAnimate.tbQuad[iCompoAnimate.nCurFrame];
								break;
							end
						elseif nLoop == 1 then  
							iCompoAnimate.nCurFrame = 1;
							iCompoAnimate.iCurQuad = iCompoAnimate.tbQuad[iCompoAnimate.nCurFrame];
						end
					else 
						iCompoAnimate.iCurQuad = iCompoAnimate.tbQuad[iCompoAnimate.nCurFrame];
					end
				end 
			until true
		end
	end 
end

function AnimationSystem:Render()
	local iStage = self:GetCurScene():GetCurStage();
	for _,tbLayer in pairs(iStage:GetRenderList()) do
	   for _,iActor in ipairs(tbLayer) do 
			repeat
				if not self:GetRegisterCompo(iActor) then break end
				if not iActor.bVisible then break end
				local iCompoAnimate = iActor:GetiCompo("Animate");
				local iCompoTransform = iActor:GetiCompo("Transform");
				local iCompoColor = iActor:GetiCompo("Color");
				if not iCompoAnimate.bRunning then 
					break;
				end 
				local x = iCompoTransform.x;
				local y = iCompoTransform.y;
				local iImage = iCompoAnimate.iImage;
				if iImage == nil then 
					self:Trace(1,"there is no image")
					break;
				end 
				local iCurQuad = iCompoAnimate.iCurQuad;
				if iCurQuad == nil then 
					self:Trace(1,"there is no quad")
					break;
				end 
				local nQuadW = iCompoAnimate.nQuadW;
				local nQuadH = iCompoAnimate.nQuadH;
				local w = iCompoTransform.w;
				local h = iCompoTransform.h;
				local r = iCompoTransform.r;
				local ox = iCompoTransform.ox;
				local oy = iCompoTransform.oy;
				local sx = iCompoTransform.sx;
				local sy = iCompoTransform.sy;
				local dx = iCompoTransform.dx;
				local dy = iCompoTransform.dy;
				local nImageX = x - (nQuadW * 0.5 - w * 0.5);
				local nImageY = y - (nQuadH - h);
				love.graphics.setColor(iCompoColor.r,iCompoColor.g,iCompoColor.b,iCompoColor.a); 
				love.graphics.draw(iImage, iCurQuad, nImageX, nImageY,r,sx * dx,sy * dy,ox,oy, kx,ky )
				if Option.Debug then 
					-- 贴图轮廓
					love.graphics.setColor(100,100,250,100);
					love.graphics.rectangle("line", nImageX, nImageY, nQuadW, nQuadH);
					-- 底部点
					love.graphics.setColor(250,0,0,250); 
					love.graphics.circle( "fill",nImageX + nQuadW / 2, nImageY + nQuadH, 7 ) 
					-- 帧序号
					love.graphics.setColor(255,0,0,250); 
					local nCurFrame = iCompoAnimate.nCurFrame;
					love.graphics.print(string.format("Frame:%d",nCurFrame or 0),nImageX + nQuadW / 2, nImageY + nQuadH + 10);
				end
			until true
		end
	end 
end

function AnimationSystem:Play(iActor,pfn)
	if not iActor then 
		return;
	end
	self.fComplete = pfn;
	iActor:GetiCompo("Animate").bRunning = true;
end

function AnimationSystem:Destory(iActor)
	if not iActor then 
		return;
	end
	if iActor:GetiCompo("Animate").bRunning then 
		iActor:GetiCompo("Animate").bRunning = false;
	end
end

function AnimationSystem:Pause(iActor)
	if not iActor then 
		return;
	end
	if iActor:GetiCompo("Animate").bRunning then 
		iActor:GetiCompo("Animate").bRunning = false;
	end
end

function AnimationSystem:Resume(iActor)
	if not iActor then 
		return;
	end
	if not iActor:GetiCompo("Animate").bRunning then 
		iActor:GetiCompo("Animate").bRunning = true;
	end
end