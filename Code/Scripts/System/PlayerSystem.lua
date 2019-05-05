_G.PlayerSystem = System:DeriveClass("PlayerSystem");

PlayerSystem:SetRegisterCompo{

};

PlayerSystem.nSpeed = 0.4; 

function PlayerSystem:MouseDown(x,y,button)
    if button == 1 then 
        local bOper = self:OperHandler();
        if bOper then 
            return
        end 
        self:MapMoveHandler();
    end 
end

function PlayerSystem:OperHandler()
     

    return false;
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
        TweenMoveSystem:SearchPathComplete(iPlayer,tbPath,function ()
            tbEndPoint.nWalkAble = 0;
            self.tbEndPoint = tbEndPoint;
            self:AddActiveActorHandler(function ()
                GlobalGameSystem:ChangeState("Enemy");
                self:Trace(2," Player Move Done! ");
            end);
        end,self.nSpeed,"linear");
    end)
end

function PlayerSystem:EvtChangeState(sState)
    if sState == "Player" then 
        self.bMoved = false;
        self.tbEndPoint.nWalkAble = 1;
    end
end

function PlayerSystem:AddActiveActorHandler(pfn)
    local iStage = self:GetCurScene():GetCurStage();
    local iPlayer = ActorMgr:GetActor("player1");
    local px = iPlayer:GetiCompo("Transform").x;
    local py = iPlayer:GetiCompo("Transform").y;
    local nDistance = iPlayer:GetiCompo("Attribute").nDistance;
    local tbActorList = iStage:GetActorList();
    for i,v in ipairs(tbActorList) do 
        if v.sTagType == "Enemy" then 
            local bx = v:GetiCompo("Transform").x;
            local by = v:GetiCompo("Transform").y;
            local dist = Dist(px + 50,py + 50,bx + 50,by + 50);
            if dist <= nDistance then 
                v:SetiCompo("Attribute", "bActive", true);
            else 
                v:SetiCompo("Attribute", "bActive", false);
            end
        elseif v.sTagType == "ExitTile" then 
            local bx = v:GetiCompo("Transform").x;
            local by = v:GetiCompo("Transform").y;
            local dist = Dist(px,py,bx,by);
            if dist <= 1 then 
                ExitTileSystem:NextStageHandler(); 
            end
        end
    end
    if pfn then 
        pfn();
    end
end