
local AStar = {};

function AStar:New(tbParams) 
    local obj = Compo:DeriveClass("AStar");
    obj.tbNode = {
        x = 0,
        y = 0,
        g = 0,
        h = 0,
        f = 0,
        nID = 0,
        nCol = 0,
        nRow = 0,
        nCellSize = 0,
        tbNeighors = {},
        nWalkAble = 0,
        iActor = nil, -- 在这个Node上的Actor，如果没有设置为nil
        previous = nil,

        getNeighbors = function (iNode)
            return iNode.tbNeighors;
        end;
        
        addNeighbors = function (iNode,tbRealMapInfo)
            local x = iNode.x ;
            local y = iNode.y ;
            local nCellSize = iNode.nCellSize;
            local GetNeighor = function (x,y)
                for i,v in ipairs(tbRealMapInfo) do 
                    local tbNode = v;
                    if tbNode.x == x and tbNode.y == y then 
                        return tbNode;
                    end
                end 
                return nil;
            end 

            local tbNeighorPos = {
                {x, y - nCellSize}, -- u
                {x, y + nCellSize}, -- d
                {x - nCellSize, y}, -- l
                {x + nCellSize, y}, -- r
                {x - nCellSize, y - nCellSize}, -- ul
                {x - nCellSize, y + nCellSize}, -- dl
                {x + nCellSize, y - nCellSize}, -- ur
                {x + nCellSize, y + nCellSize}, -- dr
            }

            for i,v in ipairs(tbNeighorPos) do 
                local x = v[1];
                local y = v[2];
                local iNeighorNode = GetNeighor(x,y);
                if iNeighorNode ~= nil then 
                    table.insert(iNode.tbNeighors,iNeighorNode);
                end 
            end
        end,
    }
    return obj; 
end 

return AStar;