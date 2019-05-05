-- 属性
local Attribute = {};

function Attribute:New(tbParams) 
    local obj = Compo:DeriveClass("Attribute");
    obj.bActive = tbParams.bActive or false; -- 是否处于石像状态，false 处于石像状态，未激活
    obj.nDistance = tbParams.nDistance or 200; -- 激活石像所用的距离，靠近即可激活石像
    return obj; 
end 

return Attribute;