_G.Stage = Entity:DeriveClass("Stage");

function Stage:DeriveClass(sClassName)
    local obj = {}; 
    obj.sClassName = sClassName;
    obj.tbListenerList = {};    -- 侦听列表 
    obj.tbActorList = {};       -- 演员列表
    obj.tbSystemList = {};      -- 系统列表
    obj.tbUIList = {};          -- UI列表
    obj.nUniqueID = 0;          -- 唯一识别
    obj.sTagType = "Stage";     -- 标签类型
    obj.sUseName = "Stage";     -- 标签类型
	setmetatable(obj,{__index = self});
	return obj;
end

function Stage:Start()

end

function Stage:AddActor(iActor)
    table.insert(self.tbActorList,iActor);
end

function Stage:RemoveActor()
    for i,v in ipairs(self.tbActorList) do 
        if v.sClassName == iActor.sClassName then 
            table.remove(self.tbActorList,i);
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

function Stage:GetSystem(sUseName)
    for i,v in ipairs(self.tbSystemList) do 
        if v.sUseName == sUseName then 
            return v;
        end 
    end
    return nil;
end

function Stage:GetActorList()
    return self.tbActorList;
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