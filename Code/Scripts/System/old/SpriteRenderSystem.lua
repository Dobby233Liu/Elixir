_G.SpriteRenderSystem = System:DeriveClass("SpriteRenderSystem");

SpriteRenderSystem:SetRegisterCompo{
    "Sprite","Transform","Color"
}

-- function SpriteRenderSystem:Render()
--     local iStage = self:GetCurScene():GetCurStage();
--     for _,tbLayer in ipairs(iStage:GetRenderList()) do
--        for i,iActor in ipairs(tbLayer) do  
--          repeat
--             if not self:GetRegisterCompo(iActor) then break end
--             if not iActor.bVisible then break end
--             local iCompoTransform = iActor:GetiCompo("Transform");
--             local iCompoSprite = iActor:GetiCompo("Sprite");
--             local iCompoColor = iActor:GetiCompo("Color");
--             local sImg = iCompoSprite.sImg;
--             local x = iCompoTransform.x;
--             local y = iCompoTransform.y;
--             local w = iCompoTransform.w;
--             local h = iCompoTransform.h;
--             local r = iCompoTransform.r;
--             local sx = iCompoTransform.sx;
--             local sy = iCompoTransform.sy;
--             local ox = iCompoTransform.ox;
--             local oy = iCompoTransform.oy;
--             local kx = iCompoTransform.kx;
--             local ky = iCompoTransform.ky;
--             local image = AssetsMgr:GetTexture(sImg);
--             local nImageW = image:getWidth();
--             local nImageH = image:getHeight();
--             local nImageX = x - (nImageW * 0.5 - w * 0.5);
--             local nImageY = y - (nImageH - h);
--             love.graphics.setColor(iCompoColor.r,iCompoColor.g,iCompoColor.b,iCompoColor.a);
--             -- love.graphics.draw( image,nImageX, nImageY, r, sx, sy, nImageW/2, nImageH/2, kx,ky )
--             love.graphics.draw( image,nImageX, nImageY, r, sx, sy, ox, oy, kx,ky );
--             if Option.Debug then 
--                 -- 贴图轮廓
--                 love.graphics.setColor(100,100,250,100);
--                 love.graphics.rectangle("line", nImageX, nImageY, nImageW, nImageH); 
--                 -- 底部点
--                 love.graphics.setColor(250,0,0,250); 
--                 love.graphics.circle( "fill",nImageX + nImageW / 2, nImageY + nImageH, 7 ) 
--             end
--          until true
--        end
--     end 
--  end