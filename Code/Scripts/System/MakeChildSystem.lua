-- 生成子集系统
_G.MakeChildSystem = System:DeriveClass("MakeChildSystem");

MakeChildSystem:SetRegisterCompo{
    "Children"
};

function MakeChildSystem:MakeHandler()
    local iStage = self:GetCurScene():GetCurStage();
    for _,iActor in pairs(iStage:GetActorList()) do
        repeat
            if not self:GetRegisterCompo(iActor) then break end
            local iCompoChildren = iActor:GetiCompo("Children");
            for i,v in ipairs(iCompoChildren.tbChildren) do
                local sActorType = v.sActorType;
                local sUseName = v.sUseName;
                local tbProperty = v.tbProperty;
                local iActorChild = ActorMgr:CreateActor(sActorType,sUseName,tbProperty);
                iActorChild:SetParent(iActor);
                iStage:AddActor(iActorChild);
            end
        until true
    end 
end


