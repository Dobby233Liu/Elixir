_G.Scene = Class:DeriveClass("Scene");

function Scene:DeriveClass(sClassName)
    local obj = {};
    obj.sClassName = sClassName;
    obj.tbListenerList = {};                -- 侦听列表 
    obj.tbActorList = {};                   -- 演员列表
    obj.tbSystemList = {};                  -- 系统列表
    obj.nUniqueID = 0;                      -- 唯一识别
    obj.sTagType = "Scene";                 -- 标签类型
    obj.nSceneID = 0;                       -- 场景ID
	setmetatable(obj,{__index = self});
	return obj;
end

function Scene:Start()
    self:Trace(3,"Scene:Start you must Implementation !!!")
end 

function Scene:Update(dt)
    self:Trace(3,"Scene:Update you must Implementation !!!")
end

function Scene:Render()
    self:Trace(3,"Scene:Render you must Implementation !!!")
end