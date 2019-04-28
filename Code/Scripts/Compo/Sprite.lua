-- 精灵
local Sprite = {};

function Sprite:New(tbParams) 
    local obj = Compo:DeriveClass("Sprite");
    obj.sImg = tbParams.sImg;
    return obj; 
end 

return Sprite;