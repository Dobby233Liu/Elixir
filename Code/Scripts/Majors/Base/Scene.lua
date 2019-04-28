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

function Scene:MouseDown(x, y, button, istouch, presses)
    local iStage = self:GetCurStage();
    if iStage then 
        self:GetCurStage():MouseDown(x, y, button, istouch, presses);
    end
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



function Scene:CreateStage(nStageID)
    self.nStageID = nStageID or self.nStageID;
    local iStage = Stage:DeriveClass("Stage"..self.nStageID);
    iStage.nStageID = self.nStageID;
    table.insert(self.tbStageList,iStage);
    return iStage;
end

function Scene:GetStageByStageID(nStageID)
    for _,iStage in ipairs(self.tbStageList) do 
        if iStage.nStageID == nStageID then 
            return iStage;
        end 
    end
    return nil;
end

function Scene:SetCurStage(iStage)
    self.iCurStage = iStage;
    self:SetCurStageID(self.iCurStage.nStageID)
    return self.iCurStage;
end

function Scene:GetCurStage()
    return self.iCurStage;
end

function Scene:GetCurStageID()
    return self.nStageID;
end

function Scene:SetCurStageID(nStageID)
    self.nStageID = nStageID;
end

-- 此方法只适合一次性创建完成的多个Stage，慎用！
function Scene:SwitchStage(nStageID,bCreate,bFade,pfn)
    local iStage = self:GetStageByStageID(nStageID);
    if bFade then 
        CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
            if iStage == nil then 
                if bCreate then 
                    self:Destory()
                    iStage = self:CreateStage(nStageID);
                    iStage = self:SetCurStage(iStage);
                    iStage:Start();
                end 
            end
            if pfn then 
                pfn(iStage)
            end 
            CameraMgr:Fade(2.5, 0, 0, 0, 0 );
            return iStage
        end)
    else 
        if iStage == nil then 
            if bCreate then 
                self:Destory()
                iStage = self:CreateStage(nStageID);
                iStage = self:SetCurStage(iStage);
                iStage:Start();
            end 
        end
        if pfn then 
            pfn(iStage)
        end 
        return iStage
    end
end

-- 切换Stage，如果没有则新建
function Scene:ChangeStage(sType,pfn)
    local bNewStage = false;
    if sType == "+" then
        local nCurStageID = self:GetCurStageID();
        nCurStageID = nCurStageID + 1;
        self:Trace(1,nCurStageID);
        if nCurStageID == 0 then 
            self:Trace(2,"nStageID is 0")
            return 
        end 
        local iStage = self:GetStageByStageID(nCurStageID);
        if iStage == nil then 
            iStage = self:SetCurStage(self:CreateStage(nCurStageID));
            bNewStage = true;
            self:Trace(1,"New Stage has been Created!",nCurStageID)
            if pfn then 
                pfn(iStage,bNewStage)
            end 
            return;
        end
        bNewStage = false;
        iStage:RemoveAllTween();
        iStage = self:SetCurStage(iStage);
        if pfn then 
            pfn(iStage,bNewStage)
        end 
        return iStage;
    elseif sType == "-" then 
        local nCurStageID = self:GetCurStageID();
        nCurStageID = nCurStageID - 1;
        self:Trace(1,nCurStageID);
        if nCurStageID == 0 then 
            self:Trace(2,"nStageID is 0")
            return 
        end 
        local iStage = self:GetStageByStageID(nCurStageID);
        if iStage == nil then 
            self:Trace(2,"Scene is nil")
            return;
        end
        iStage:RemoveAllTween();
        iStage = self:SetCurStage(iStage);
        return iStage
    end 
end