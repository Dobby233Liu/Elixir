_G.RectangleRenderSystem = System:DeriveClass("RectangleRenderSystem");

RectangleRenderSystem:SetRegisterCompo{
   "Rectangle","Transform","Color"
}

function RectangleRenderSystem:Render()
   local iStage = self:GetCurScene():GetCurStage();
   for _,iActor in pairs(iStage:GetActorList()) do
      repeat
         if not self:GetRegisterCompo(iActor) then break end
         local iCompoTransform = iActor:GetiCompo("Transform");
         local iCompoRectangle = iActor:GetiCompo("Rectangle");
         local iCompoColor = iActor:GetiCompo("Color");
         local x = iCompoTransform.x;
         local y = iCompoTransform.y;
         local w = iCompoTransform.w;
         local h = iCompoTransform.h;
         local sFillType = iCompoRectangle.sFillType;
         love.graphics.setColor(iCompoColor.r,iCompoColor.g,iCompoColor.b,iCompoColor.a);
         love.graphics.rectangle(sFillType,x,y,w,h);
      until true
   end 
end