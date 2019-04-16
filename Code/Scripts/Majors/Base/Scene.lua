_G.Scene = Class:DeriveClass("Scene");

function Scene:DeriveClass(sClassName)
    local obj = {};
    obj.sClassName = sClassName;
    obj.tbListenerList = {};                -- 侦听列表 
    obj.tbStageList = {};                   -- 舞台列表
    obj.nUniqueID = 0;                      -- 唯一识别
    obj.sTagType = "Scene";                 -- 标签类型
    obj.nStageID = 1;                       -- 场景ID
    obj.iCurStage = nil;                    -- 场景ID
	setmetatable(obj,{__index = self});
	return obj;
end

function Scene:Start()
    local iStage = self:GetCurStage();
    if iStage then 
        self:GetCurStage():Start();
    end
    self:StartHandler()
end

function Scene:Update(dt)
    local iStage = self:GetCurStage();
    if iStage then 
        self:GetCurStage():Update(dt);
    end
    self:UpdateHandler(dt)
end

function Scene:Render()
    local iStage = self:GetCurStage();
    if iStage then 
        self:GetCurStage():Render();
    end
    self:RenderHandler()
end

function Scene:Destory() 
    local iStage = self:GetCurStage();
    if iStage then 
        self:GetCurStage():RemoveAllUI();
    end
    self:DestoryHandler()
end

-------------------------------------------------------------

function Scene:StartHandler()
    self:Trace(3,"Scene:StartHandler you must Implementation !!!")
end

function Scene:UpdateHandler(dt)
    -- self:Trace(3,"Scene:UpdateHandler you must Implementation !!!")
end

function Scene:RenderHandler()
    -- self:Trace(3,"Scene:RenderHandler you must Implementation !!!")
end

function Scene:DestoryHandler()
    self:Trace(3,"Scene:DestoryHandler you must Implementation !!!")
end



function Scene:CreateStage()
    local iStage = Stage:DeriveClass("Stage"..self.nStageID);
    table.insert(self.tbStageList,iStage);
    return iStage;
end

function Scene:SetCurStage(iStage)
    self.iCurStage = iStage;
end

function Scene:GetCurStage()
    return self.iCurStage;
end