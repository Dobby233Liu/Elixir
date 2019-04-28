-- 组成子集
local Children = {};

function Children:New(tbParams) 
    local obj = Compo:DeriveClass("Children");
    obj.tbChildren = tbParams.tbChildren;
    return obj; 
end 

return Children;