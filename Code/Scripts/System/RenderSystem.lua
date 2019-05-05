_G.RenderSystem = System:DeriveClass("RenderSystem");

RenderSystem:SetRegisterCompo{
    "Render","Transform","Color","RenderLayer"
};

function RenderSystem:Update(dt)
    if Option.sGameType == GameType.Roguelike then 
        self:RogueLikeSortHandler();
    else -- 默认使用Rogue渲染层级
        self:RogueLikeSortHandler();
    end
end

function RenderSystem:RogueLikeSortHandler()
    local iStage = self:GetCurScene():GetCurStage();
    for nLayer,tbLayer in pairs(iStage:GetRenderList()) do
        if nLayer == RenderLayerType.nPlayer then 
            table.sort(tbLayer, function(a,b)
                if a ~= nil and b ~= nil then 
                    local ay = a:GetiCompo("Transform").y + a:GetiCompo("Transform").h;
                    local by = b:GetiCompo("Transform").y + b:GetiCompo("Transform").h;
                    -- if ay == by then 
                    --     return ay < (by - 1);
                    -- end
                    return ay < by; 
                end
            end)
        end
    end 
end

function RenderSystem:Render()
	local iStage = self:GetCurScene():GetCurStage();
	for _,tbLayer in pairs(iStage:GetRenderList()) do
	   for _,iActor in ipairs(tbLayer) do 
			repeat
                if not self:GetRegisterCompo(iActor) then break end

                local iCompoRender = iActor:GetiCompo("Render");
                local iCompoAnimate = iActor:GetiCompo("Animate");
                local iCompoSprite = iActor:GetiCompo("Sprite");
				local iCompoTransform = iActor:GetiCompo("Transform");
                local iCompoColor = iActor:GetiCompo("Color");
                local iCompoRectangle = iActor:GetiCompo("Rectangle");
                local iCompoAttribute = iActor:GetiCompo("Attribute");

                local x = iCompoTransform.x;
                local y = iCompoTransform.y;
                local w = iCompoTransform.w;
                local h = iCompoTransform.h;
                local r = iCompoTransform.r;
                local sx = iCompoTransform.sx;
                local sy = iCompoTransform.sy;
                local ox = iCompoTransform.ox;
                local oy = iCompoTransform.oy;
                local kx = iCompoTransform.kx;
                local ky = iCompoTransform.ky;
                local bActive = iCompoAttribute.bActive;

                if iCompoAttribute ~= nil then 
                    if bActive then 
                        love.graphics.setColor(1,0,0,1);
                    else 
                        love.graphics.setColor(iCompoColor.r,iCompoColor.g,iCompoColor.b,iCompoColor.a);
                    end
                else 
                    love.graphics.setColor(iCompoColor.r,iCompoColor.g,iCompoColor.b,iCompoColor.a);
                end

                -- Rectangle 
                if iCompoRectangle ~= nil then 
                    local sFillType = iCompoRectangle.sFillType;
                    love.graphics.rectangle(sFillType,x,y,w,h);
                    if Option.Debug then 
                        love.graphics.setColor(0,0,0,1)
                        love.graphics.print(iActor.sClassName,x,y)
                    end
                end

                -- Sprite
                if iCompoSprite ~= nil then 
                    local sImg = iCompoSprite.sImg;
                    local iImage = AssetsMgr:GetTexture(sImg);
                    local nImageW = iImage:getWidth();
                    local nImageH = iImage:getHeight();
                    local nImageX = x - (nImageW * 0.5 - w * 0.5);
                    local nImageY = y - (nImageH - h);
                    love.graphics.draw( iImage,nImageX, nImageY, r, sx, sy, ox, oy, kx,ky )
                    if Option.Debug then 
                        -- 贴图轮廓
                        love.graphics.setColor(100/255,100/255,250/255,100/255);
                        love.graphics.rectangle("line", nImageX, nImageY, nImageW, nImageH); 
                        -- 底部点
                        love.graphics.setColor(250/255,0/255,0/255,250/255); 
                        love.graphics.circle( "fill",nImageX + nImageW / 2, nImageY + nImageH, 7 ) 
                    end
                end

                -- 动画
                if iCompoAnimate ~= nil then 
                    if not iCompoAnimate.bRunning then 
                        break;
                    end 
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
                    local nImageX = x - (nQuadW * 0.5 - w * 0.5);
                    local nImageY = y - (nQuadH - h);
                    love.graphics.draw(iImage, iCurQuad, nImageX, nImageY,r,sx,sy,ox,oy, kx,ky )
    				if Option.Debug then 
    					-- 贴图轮廓
    					love.graphics.setColor(100/255,100/255,250/255,100/255);
    					love.graphics.rectangle("line", nImageX, nImageY, nQuadW, nQuadH);
    					-- 底部点
    					love.graphics.setColor(250/255,0/255,0/255,250/255); 
    					love.graphics.circle( "fill",nImageX + nQuadW / 2, nImageY + nQuadH, 7 ) 
    					-- 帧序号
    					love.graphics.setColor(255/255,0/255,0/255,250/255); 
    					local nCurFrame = iCompoAnimate.nCurFrame;
    					love.graphics.print(string.format("Frame:%d",nCurFrame or 0),nImageX + nQuadW / 2, nImageY + nQuadH + 10);
    				end
                end

                love.graphics.setColor(1,1,1,1);
			until true
		end
    end 
    
    if Option.Debug then
        self:Render_Node_1();
        self:Render_Node_2();
        self:Render_Node_3();
    end
end

function RenderSystem:Render_Node_1()
    local iPlayer = ActorMgr:GetActor("player1");
    local iMap = ActorMgr:GetActor("map1");
    local iMapMakerCompo = iMap:GetiCompo("MapMaker");
    local nCellSize = iMapMakerCompo.nCellSize;
    local tbRealMapInfo = iMapMakerCompo.tbRealMapInfo;
    for i,tbNode in ipairs(tbRealMapInfo) do 
        if tbNode.nWalkAble == 0 then 
            love.graphics.setColor(1,1,0,0.51);
            love.graphics.rectangle("fill",tbNode.x,tbNode.y,nCellSize,nCellSize)
        end 
    end
end

function RenderSystem:Render_Node_2()
    local iPlayer = ActorMgr:GetActor("player1");
    local px = iPlayer:GetiCompo("Transform").x;
    local py = iPlayer:GetiCompo("Transform").y;
    local iAttributeCompo = iPlayer:GetiCompo("Attribute");
    love.graphics.setColor(0.5,0.2,1,0.31);
    love.graphics.circle("fill",px + 50,py + 50,200);
end

function RenderSystem:Render_Node_3()
    local iMap = ActorMgr:GetActor("map1");
    local iMapMakerCompo = iMap:GetiCompo("MapMaker");
    local nCellSize = iMapMakerCompo.nCellSize;
    local tbRealMapInfo = iMapMakerCompo.tbRealMapInfo;
    for i,tbNode in ipairs(tbRealMapInfo) do 
        love.graphics.setColor(0.9,0.9,0,0.71);
        love.graphics.rectangle("line",tbNode.x,tbNode.y,nCellSize,nCellSize)
        if tbNode.nWalkAble == 1 then 
            love.graphics.setColor(0.9,0.2,0.8,0.71);
            love.graphics.rectangle("line",tbNode.x + 10,tbNode.y + 10 ,nCellSize - 20,nCellSize - 20)
        end
    end
end