_G.PlayerSystem = System:DeriveClass("PlayerSystem");

PlayerSystem:SetRegisterCompo{

};

function PlayerSystem:MouseDown(x,y,button)
    if button == 1 then 
        self:MapMoveHandler();
    end 
end

function PlayerSystem:MapMoveHandler()
    if self.bMoved then return end 
    self.bMoved = true;
    local function CheckCanWalk(nCol,nRow,tbRealMapInfo)
        for i,tbNode in ipairs(tbRealMapInfo) do 
            if nCol == tbNode.nCol and nRow == tbNode.nRow then 
                if tbNode.nWalkAble == 1 then 
                    return true 
                end 
            end
        end
        return false;
    end

    local function GetNodeFromRealMap(nCol,nRow,tbRealMapInfo)
        for i,tbNode in ipairs(tbRealMapInfo) do 
            if nCol == tbNode.nCol and nRow == tbNode.nRow then 
                return tbNode;
            end
        end
        return nil;
    end

    local iPlayer = ActorMgr:GetActor("player1");
    local iMap = ActorMgr:GetActor("map1");
    local iMapMakerCompo = iMap:GetiCompo("MapMaker");
    local nCellSize = iMapMakerCompo.nCellSize;
    local tbRealMapInfo = iMapMakerCompo.tbRealMapInfo;
    local px = iPlayer:GetiCompo("Transform").x;
    local py = iPlayer:GetiCompo("Transform").y;
    local nPCol,nPRow = math.floor(px/nCellSize),math.floor(py/nCellSize);
    local mx,my = CameraMgr:GetMousePosition();
    local nMCol,nMRow = math.floor(mx/nCellSize),math.floor(my/nCellSize);
    local bCanWalk = CheckCanWalk(nMCol,nMRow,tbRealMapInfo);
    if not bCanWalk then 
        self:Trace(1,"Can't Walk!");
        self.bMoved = false;
        return
    end
    local tbStartPoint = GetNodeFromRealMap(nPCol,nPRow,tbRealMapInfo);
    local tbEndPoint = GetNodeFromRealMap(nMCol,nMRow,tbRealMapInfo);
    if tbStartPoint == nil or tbEndPoint == nil then 
        self:Trace(2," Not Find Start or End Point ");
        self.bMoved = false;
        return 
    end
    FindPathSystem:SearchPath(tbStartPoint,tbEndPoint,function (nCode,tbPath)
        if nCode ~= 0 then 
            self:Trace(1,"Find Path Fail!");
            self.bMoved = false;
            return;
        end
        PlayerTweenMoveSystem:SearchPathComplete(tbPath,function ()
            self.bMoved = false;
            self:Trace(2," Player Move Done! ");
        end);
    end)
end