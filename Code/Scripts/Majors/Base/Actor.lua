_G.Actor = Entity:DeriveClass("Actor");

function Actor:DeriveClass(sClassName)
    local obj = {}; 
    obj.sClassName = sClassName;
    obj.tbListenerList = {};    -- 侦听列表
    obj.tbiCompoList = {};      -- 组件列表
    obj.nUniqueID = 0;          -- 唯一识别
    obj.sTagType = "Actor";     -- 标签类型
    obj.sUseName = "Actor";     -- 标签类型
    obj.bVisible = true;        -- 是否可用
    obj.iParent = nil;          -- 父级容器
	setmetatable(obj,{__index = self});
	return obj;
end 

function Actor:AddiCompo(sClassName,tbParams)
    local iCompo = require("Code/Scripts/Compo/"..sClassName):New(tbParams); 
    self.tbiCompoList[sClassName] = iCompo;
end

function Actor:GetiCompo(sClassName)
    return self.tbiCompoList[sClassName];
end 

function Actor:SetiCompo(sClassName,sKey,nValue)
    self.tbiCompoList[sClassName][sKey] = nValue;
end 

function Actor:BindCompo(cfg) 
    local cfg = cfg;
    for i,v in pairs(cfg) do 
        self:AddiCompo(i,v);
    end    
end  

function Actor:Clear()
    if next(self.tbiCompoList) then
        self.tbiCompoList = {};
    end
end

function Actor:ChangeiCompoParam(tbProperty)
    local tbProperty = tbProperty or {};
    if next(tbProperty) then 
        for sComp,tbPro in pairs(tbProperty) do
            if not self:GetiCompo(sComp) then 
                self:AddiCompo(sComp,tbPro)
            end 
            for k,v in pairs(tbPro) do
                self:GetiCompo(sComp)[k] = v;
            end  
        end
    end
end

function Actor:SetParent(iActor)
    self.iParent = iActor;
end

function Actor:GetParent()
    return self.iParent;
end

function Actor:IsParent()
    if self.iParent == nil then 
        return false;
    end 
    return true;
end

function Actor:UpdatePosByParent(fx,fy)
    if not self:IsParent() then 
        return 
    end
    local iParent = self:GetParent();
    local iCompoTransform = iParent:GetiCompo("Transform");
    local x = iCompoTransform.x;
    local y = iCompoTransform.y;
    self:GetiCompo("Transform").x = x + fx;
    self:GetiCompo("Transform").y = y + fy;
end