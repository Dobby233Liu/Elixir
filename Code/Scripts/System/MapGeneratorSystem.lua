_G.MapGeneratorSystem = System:DeriveClass("MapGeneratorSystem");

MapGeneratorSystem:SetRegisterCompo{
    "MapMaker","AStar"
};

function MapGeneratorSystem:GeneratorHandler(iMap,pfn)
    local iScene = self:GetCurScene();
    local iMap = iMap;
    if not self:GetRegisterCompo(iMap) then return end
    local iMapCompo = iMap:GetiCompo("MapMaker");
    local iAstarCompo = iMap:GetiCompo("AStar");
    local tbMapInfo = {};
    math.randomseed(os.time());
    self.nCount = 0;
    iAstarCompo.tbNode.nCellSize = iMapCompo.nCellSize;
    iMapCompo.tbDataMapInfo = {iAstarCompo.tbNode};
    iMapCompo.tbRealMapInfo = {iAstarCompo.tbNode};
    while self.nCount < iMapCompo.nCellCount do
        local tbNode = clone( iMapCompo.tbDataMapInfo[#iMapCompo.tbDataMapInfo] );
        local nDir = math.random(1,4);
        if nDir == 1 then 
            tbNode.x = tbNode.x + iMapCompo.nCellSize;
        elseif nDir == 2 then  
            tbNode.x = tbNode.x - iMapCompo.nCellSize;
        elseif nDir == 3 then  
            tbNode.y = tbNode.y + iMapCompo.nCellSize;
        elseif nDir == 4 then  
            tbNode.y = tbNode.y - iMapCompo.nCellSize;
        end
        tbNode.nWalkAble = 1;
        tbNode.nCellSize = iMapCompo.nCellSize;
        local nTCol,nTRow = math.floor(tbNode.x/iMapCompo.nCellSize),math.floor(tbNode.y/iMapCompo.nCellSize);
        tbNode.nCol = nTCol;
        tbNode.nRow = nTRow;
        if not self:GetSameItem(iMapCompo.tbDataMapInfo,tbNode) then 
            table.insert(iMapCompo.tbRealMapInfo,tbNode);
        end
        table.insert(iMapCompo.tbDataMapInfo,tbNode);
        self.nCount = self.nCount + 1;
    end 

    if pfn then 
        pfn()  
    end
end

function MapGeneratorSystem:GetSameItem(tbDataMapInfo,tbNode)
    for i = 1,#tbDataMapInfo do 
        local item = tbDataMapInfo[i];
        if item.x == tbNode.x and item.y == tbNode.y then 
            return true;
        end 
    end
    return false;
end

function MapGeneratorSystem:GetPlayerBornPoint(nIndex)
    local iMap = ActorMgr:GetActor("map1")
    local iMapCompo = iMap:GetiCompo("MapMaker");
    local tbRealMapInfo = iMapCompo.tbRealMapInfo;
    local nIndex = nIndex or math.random(1,4);
    local tmp_item = { x = 0, y = 0 };
    for i = 1,#tbRealMapInfo do 
        local item = tbRealMapInfo[i];
        if item.nWalkAble == 1 then 
            if nIndex == 1 then 
                if item.x >= tmp_item.x then 
                    tmp_item = item;
                end
            elseif nIndex == 2 then  
                if item.x < tmp_item.x then 
                    tmp_item = item;
                end
            elseif nIndex == 3 then  
                if item.y < tmp_item.y then 
                    tmp_item = item;
                end
            elseif nIndex == 4 then  
                if item.y >= tmp_item.y then 
                    tmp_item = item;
                end
            end
        end
    end
    self:Trace(1,tmp_item.nWalkAble)
    return tmp_item,nIndex;
end

function MapGeneratorSystem:GetRandomBornPoint(nPointCount)
    local iMap = ActorMgr:GetActor("map1")
    local iMapCompo = iMap:GetiCompo("MapMaker");
    local tbRealMapInfo = iMapCompo.tbRealMapInfo;
    local tbIndex = {}
    for i = 1, #tbRealMapInfo do 
        local iNode = tbRealMapInfo[i];
        table.insert(tbIndex,{ x = iNode.x, y = iNode.y});
    end
    local tbList = random_table(tbIndex, nPointCount)
    return tbList;
end