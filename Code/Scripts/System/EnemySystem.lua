_G.EnemySystem = System:DeriveClass("EnemySystem");

EnemySystem:SetRegisterCompo{

};

EnemySystem.nSpeed = 0.2;
EnemySystem.tbEnemyList = {};
EnemySystem.tbEndPointNode = {};

function EnemySystem:Start()
    self.nSpeed = 0.2;
    self.tbEndPointNode = self.tbEndPointNode or {};
    self.tbEnemyList = {};
end

function EnemySystem:PlayerMoveComplete()
    self:Trace(1," ~~~~~~EnemySystem:PlayerMoveComplete~~~~~~ ") 
    -- todo...获取Player附近的Enemy，并将其添加进仇恨列表
    -- todo...主意检查是否和其它Stage的Enemy串了
    local iStage = self:GetCurScene():GetCurStage();
    self.tbEnemyList = iStage:GetTagTypeActorList("Enemy");
    self.tbEnemyList = self:GetActiveActorList(true,self.tbEnemyList);
    if not next(self.tbEnemyList) then 
        GlobalGameSystem:ChangeState("Player");
        self:Trace(2,"There has no actor Find!!!");
        return 
    end
    self:MapMoveHandler(1);
end

function EnemySystem:MapMoveHandler(nIndex)
    local function CheckCanWalk(nCol,nRow,tbRealMapInfo)
        for i,tbNode in ipairs(tbRealMapInfo) do 
            if nCol == tbNode.nCol and nRow == tbNode.nRow then 
                if tbNode.nWalkAble == 1 then 
                    return true;
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
    local iActor = self.tbEnemyList[nIndex];
    -- 在这里区分是否进行其它操作，比如攻击Player
    local iMap = ActorMgr:GetActor("map1");
    local iMapMakerCompo = iMap:GetiCompo("MapMaker");
    local nCellSize = iMapMakerCompo.nCellSize;
    local tbRealMapInfo = iMapMakerCompo.tbRealMapInfo;
    local px = iActor:GetiCompo("Transform").x;
    local py = iActor:GetiCompo("Transform").y;
    local nPCol,nPRow = math.floor(px/nCellSize),math.floor(py/nCellSize); 
    local nMCol,nMRow = self:GetGoleNodeHanlder();
    local bCanWalk = CheckCanWalk(nMCol,nMRow,tbRealMapInfo);
    if not bCanWalk then 
        self:Trace(1,"Can't Walk!");
        self.bMoved = false;
        nIndex = nIndex + 1;
        if nIndex > #self.tbEnemyList then 
            GlobalGameSystem:ChangeState("Player");
            return 
        end
        self:MapMoveHandler(nIndex);
        return
    end
    local tbStartPoint = GetNodeFromRealMap(nPCol,nPRow,tbRealMapInfo);
    local tbEndPoint = GetNodeFromRealMap(nMCol,nMRow,tbRealMapInfo);
    if tbStartPoint == nil or tbEndPoint == nil then 
        self:Trace(2," Not Find Start or End Point ");
        self.bMoved = false;
        nIndex = nIndex + 1;
        if nIndex > #self.tbEnemyList then 
            GlobalGameSystem:ChangeState("Player");
            return 
        end
        self:MapMoveHandler(nIndex);
        return 
    end

    FindPathSystem:SearchPath(tbStartPoint,tbEndPoint,function (nCode,tbPath)
        if nCode ~= 0 then 
            self:Trace(1,"Find Path Fail!");
            self.bMoved = false;
            nIndex = nIndex + 1;
            if nIndex > #self.tbEnemyList then 
                GlobalGameSystem:ChangeState("Player");
                return 
            end
            self:MapMoveHandler(nIndex);
            return;
        end
        self.tbEndPointNode = self.tbEndPointNode or {};
        if self.tbEndPointNode[iActor.sClassName] then 
            self.tbEndPointNode[iActor.sClassName].nWalkAble = 1;
        end
        TweenMoveSystem:SearchPathComplete(iActor,tbPath,function ()
            self.bMoved = false;
            tbEndPoint.nWalkAble = 0;
            self.tbEndPointNode[iActor.sClassName] = tbEndPoint;
            nIndex = nIndex + 1;
            if nIndex > #self.tbEnemyList then 
                GlobalGameSystem:ChangeState("Player");
                return 
            end
            self:MapMoveHandler(nIndex);
            self:Trace(2," Enemy Move Done! ");
        end,self.nSpeed,"linear");
    end)
end

function EnemySystem:GetGoleNodeHanlder()
    local iStage = self:GetCurScene():GetCurStage();
    local iPlayer = ActorMgr:GetActor("player1");
    local px = iPlayer:GetiCompo("Transform").x;
    local py = iPlayer:GetiCompo("Transform").y;
    local tbTileList = iStage:GetTagTypeActorList("Tile");
    local iMap = ActorMgr:GetActor("map1");
    local iMapMakerCompo = iMap:GetiCompo("MapMaker");
    local nCellSize = iMapMakerCompo.nCellSize;
    local nRandomIndex = math.random(1,#tbTileList);
    for i,v in ipairs(tbTileList) do 
        if i == nRandomIndex then 
            local ax = v:GetiCompo("Transform").x;
            local ay = v:GetiCompo("Transform").y;
            local bx = px;
            local by = py;
            local nMCol,nMRow = math.floor(ax/nCellSize),math.floor(ay/nCellSize);
            return nMCol,nMRow
        end
    end
end

function EnemySystem:EvtChangeState(sState)
    if sState == "Enemy" then 
        self:PlayerMoveComplete();
    end
end

function EnemySystem:GetActiveActorList(bActive,tbEnemyList)
    local tbList = {};
    for i,v in ipairs(tbEnemyList) do 
        if v:GetiCompo("Attribute").bActive == bActive then 
            table.insert(tbList,v);
        end
    end
    return tbList;
end