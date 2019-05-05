_G.Stage = Entity:DeriveClass("Stage");

function Stage:DeriveClass(sClassName)
    local obj = {}; 
    obj.sClassName = sClassName;
    obj.tbListenerList = {};    -- 侦听列表
    obj.tbActorList = {};       -- 演员列表
    obj.tbRenderList = {};      -- 显示列表
    obj.tbSystemList = {};      -- 系统列表
    obj.tbUIList = {};          -- UI列表
    obj.nUniqueID = 0;          -- 唯一识别
    obj.nStageID = 0;           -- 场景ID
    obj.sTagType = "Stage";     -- 标签类型
    obj.sUseName = "Stage";     -- 标签类型
	setmetatable(obj,{__index = self});
	return obj;
end

function Stage:Start()
    self:Trace(1,"You need to start!")
end

function Stage:AddActor(iActor)
    table.insert(self.tbActorList,iActor);
    if not iActor:GetiCompo("RenderLayer") then return end;
    local nLayerIndex = iActor:GetiCompo("RenderLayer").nLayerIndex;
    self.tbRenderList = self.tbRenderList or {};
    self.tbRenderList[nLayerIndex] = self.tbRenderList[nLayerIndex] or {};
    table.insert(self.tbRenderList[nLayerIndex], iActor);
end

function Stage:RemoveActor(sClassName)
    for i,v in ipairs(self.tbActorList) do 
        if v.sClassName == sClassName then 
            table.remove(self.tbActorList,i);
            break;
        end 
    end
    if not iActor:GetiCompo("RenderLayer") then return end;
    local nLayerIndex = iActor:GetiCompo("RenderLayer").nLayerIndex;
    for i,v in ipairs(self.tbRenderList[nLayerIndex]) do 
        if v.sClassName == iActor.sClassName then 
            table.remove(self.tbRenderList[nLayerIndex],i);
            break;
        end
    end 
end

function Stage:RegisterSystem(iSystem)
    table.insert(self.tbSystemList,iSystem);
end

function Stage:GetActor(sUseName)
    for i,v in ipairs(self.tbActorList) do 
        if v.sUseName == sUseName then 
            return v;
        end 
    end
    return nil;
end

function Stage:GetActorByClassName(sClassName)
    for i,v in ipairs(self.tbActorList) do 
        if v.sClassName == sClassName then 
            return v;
        end 
    end 
    return nil;
end

function Stage:GetSystem(sClassName)
    for i,v in ipairs(self.tbSystemList) do 
        if v.sClassName == sClassName then 
            return v;
        end 
    end
    return nil;
end

function Stage:GetActorList()
    return self.tbActorList;
end

function Stage:GetRenderList()
    return self.tbRenderList;
end

function Stage:Render()
    for _,iSystem in ipairs(self.tbSystemList) do 
        if iSystem.Render then 
            iSystem:Render();
        end
    end
end

function Stage:Update(dt)
    for _,iSystem in ipairs(self.tbSystemList) do 
        if iSystem.Update then 
            iSystem:Update(dt);
        end
    end
end

function Stage:MouseDown(x, y, button, istouch, presses)
    for _,iSystem in ipairs(self.tbSystemList) do 
        if iSystem.MouseDown then 
            iSystem:MouseDown(x, y, button, istouch, presses)
        end
    end
end

function Stage:AddUI(sUseName,iUI)
    self.tbUIList[sUseName] = iUI;
end

function Stage:GetUI(sUseName)
    return self.tbUIList[sUseName];
end

function Stage:RemoveAllUI()
    for i,v in pairs(self.tbUIList) do 
        if v.Remove then 
            v:Remove();
        end
    end 
end

function Stage:RemoveAllTween()
    Tween:stopAll();
end

function Stage:GetTagTypeActorList(sTagType)
    local tbResult = {};
    local tbActorList = self:GetActorList();
    for i,v in ipairs(tbActorList) do 
        if v.sTagType == sTagType then 
            table.insert(tbResult,v);
        end
    end
    return tbResult
end