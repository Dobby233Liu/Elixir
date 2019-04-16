-- 位置
local Transform = {};

function Transform:New(tbParams) 
    local obj = Compo:DeriveClass("Transform"); 
    obj.x = tbParams.x or 0;
    obj.y = tbParams.y or 0; 
    obj.w = tbParams.w or 0;
    obj.h = tbParams.h or 0; 
    obj.sx = tbParams.sx or 1;
    obj.sy = tbParams.sy or 1; 
    obj.ox = tbParams.ox or 0;
    obj.oy = tbParams.oy or 0; 
    obj.kx = tbParams.kx or 0;
    obj.ky = tbParams.ky or 0;
    obj.r = tbParams.r or 0; 
    obj.dir = tbParams.dir or 1; -- (右：1左：2上：3下：4)
    return obj; 
end 

return Transform;