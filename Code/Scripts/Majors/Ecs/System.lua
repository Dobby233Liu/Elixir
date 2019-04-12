_G.System = Class:DeriveClass("System");

function System:DeriveClass(sClassName)
    local obj = {}; 
    obj.sClassName = sClassName;
    obj.tbListenerList = {};                -- 侦听列表
    obj.nUniqueID = 0;                      -- 唯一识别
    obj.sTagType = "System";                -- 标签类型
	setmetatable(obj,{__index = self});
	return obj;
end