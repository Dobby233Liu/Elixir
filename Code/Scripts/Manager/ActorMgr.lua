_G.ActorMgr = Class:DeriveClass("ActorMgr");  

function ActorMgr:CreateActor(sActorType,sUseName,tbProperty)
    local sActorPath = string.format("Code/Scripts/Actor/%s",sActorType);
    local sActorCfgPath = string.format("Code/Configs/ActorCfgs/%sConfig",sActorType);
    local sActorClassName = sActorType..Origin:SetUniqueID();
    local iActor = require(sActorPath):Create(sActorClassName);
    iActor.sTagType = sActorType;
    iActor.sUseName = sUseName or sActorClassName;
    local CfgActor =  require(sActorCfgPath);
    iActor:BindCompo(CfgActor);
    iActor:ChangeiCompoParam(tbProperty);
    return iActor
end

function ActorMgr:UpdateActor(iActor,tbProperty)
    iActor:ChangeiCompoParam(tbProperty);
end

function ActorMgr:GetActor(sUseName)
    local iScene = SceneMgr:GetCurScene();
    local iStage = iScene:GetCurStage();
    local iActor = iStage:GetActor(sUseName)
    return iActor;
end

function ActorMgr:RemoveActor(sClassName)
    local iScene = SceneMgr:GetCurScene();
    local iStage = iScene:GetCurStage();
    iStage:RemoveActor(sClassName);
end