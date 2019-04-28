-- 地图
local MapMaker = {};

function MapMaker:New(tbParams) 
    local obj = Compo:DeriveClass("MapMaker");
    obj.tbDataMapInfo = {};
    obj.tbRealMapInfo = {};
    obj.tbMapElement = tbParams.tbMapElement or {};
    obj.nCellSize = tbParams.nCellSize or 100;
    obj.nCellCount = tbParams.nCellCount or 30;
    return obj;
end 
return MapMaker;