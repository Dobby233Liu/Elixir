_G.GameScene = Scene:DeriveClass("GameScene");
GameScene.nEnemyCount = 1;
function GameScene:StartHandler()

    self:NewStage();
end

function GameScene:NewStage(iStage)
    local iStage = iStage or self:SetCurStage(self:CreateStage());
    iStage:AddActor(ActorMgr:CreateActor("Player","player1",{
        -- ["Color"] = { r = 0.7, g = 0.3, b = 0.3, a = 1}
    }));
    self.nEnemyCount = self.nEnemyCount + 1;
    for i = 1, self.nEnemyCount do 
        iStage:AddActor(ActorMgr:CreateActor("Enemy","enemy"..i ));
    end
    iStage:AddActor(ActorMgr:CreateActor("Map","map1"));

    iStage:RegisterSystem(MapGeneratorSystem);
    iStage:RegisterSystem(AnimationSystem);
    iStage:RegisterSystem(PlayerSystem);
    iStage:RegisterSystem(TweenMoveSystem);
    iStage:RegisterSystem(FindPathSystem);
    iStage:RegisterSystem(RenderSystem);
    iStage:RegisterSystem(EnemySystem);
    iStage:RegisterSystem(GlobalGameSystem);
    iStage:RegisterSystem(ExitTileSystem);

    Event:AddEvent(iStage:GetSystem("GlobalGameSystem"),iStage:GetSystem("PlayerSystem"));
    Event:AddEvent(iStage:GetSystem("GlobalGameSystem"),iStage:GetSystem("EnemySystem"));

    iStage:GetSystem("EnemySystem"):Start();
    iStage:GetSystem("AnimationSystem"):Start();
    iStage:GetSystem("MapGeneratorSystem"):GeneratorHandler(ActorMgr:GetActor("map1"),function()
        local iMap = ActorMgr:GetActor("map1")
        local iMapMakerCompo = iMap:GetiCompo("MapMaker");
        local nCellSize = iMapMakerCompo.nCellSize;
        local tbRealMapInfo = iMapMakerCompo.tbRealMapInfo;
        for i = 1, #tbRealMapInfo do
            local tbNode = tbRealMapInfo[i];
            local iTile = ActorMgr:CreateActor("Tile","tile"..i);
            iStage:AddActor(iTile);
            iTile:SetiCompo("Transform", "x", tbNode.x);
            iTile:SetiCompo("Transform", "y", tbNode.y);
            tbNode.nWalkAble = 1;
            tbNode.nID = Origin:SetUniqueID();
            tbNode.addNeighbors(tbNode,tbRealMapInfo);
        end
        local function GetNodeFromRealMap(nCol,nRow,tbRealMapInfo)
            for i,tbNode in ipairs(tbRealMapInfo) do 
                if nCol == tbNode.nCol and nRow == tbNode.nRow then 
                    return tbNode;
                end
            end
            return nil;
        end
        local tbEnemyList = iStage:GetTagTypeActorList("Enemy");
        local tbNodeE = MapGeneratorSystem:GetRandomBornPoint(#tbEnemyList);
        for i,iEnemy in ipairs(tbEnemyList) do 
            iEnemy:SetiCompo("Transform", "x", tbNodeE[i].x);
            iEnemy:SetiCompo("Transform", "y", tbNodeE[i].y);
            local nPCol,nPRow = math.floor(tbNodeE[i].x/nCellSize),math.floor(tbNodeE[i].y/nCellSize); 
            local iNode = GetNodeFromRealMap(nPCol,nPRow,tbRealMapInfo);
            iNode.nWalkAble = 0;
            EnemySystem.tbEndPointNode[iEnemy.sClassName] = iNode;
        end

        local tbNodeP,nIndex = MapGeneratorSystem:GetPlayerBornPoint(3);
        ActorMgr:GetActor("player1"):SetiCompo("Transform", "x", tbNodeP.x);
        ActorMgr:GetActor("player1"):SetiCompo("Transform", "y", tbNodeP.y);
        CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
        self:Trace(1,"nIndex",nIndex)
        if nIndex == 1 then 
            nIndex = 2 
        elseif nIndex == 2 then 
            nIndex = 1 
        elseif nIndex == 3 then 
            nIndex = 4 
        elseif nIndex == 4 then 
            nIndex = 3 
        end
        local tbNodeEp = MapGeneratorSystem:GetPlayerBornPoint(nIndex);
        local iExitTile = ActorMgr:CreateActor("ExitTile","exitTile1");
        iStage:AddActor(iExitTile);
        iExitTile:SetiCompo("Transform", "x", tbNodeEp.x);
        iExitTile:SetiCompo("Transform", "y", tbNodeEp.y);
    end)
end 

function GameScene:KeyDown(key)
    if key == "n" then 
        CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
            self:ChangeStage("+",function (iStage,bNewStage)
                if bNewStage then 
                    self:NewStage(iStage);
                end
                local tbNode = MapGeneratorSystem:GetPlayerBornPoint();
                ActorMgr:GetActor("player1"):SetiCompo("Transform", "x", tbNode.x);
                ActorMgr:GetActor("player1"):SetiCompo("Transform", "y", tbNode.y);
                CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
                iStage:GetSystem("EnemySystem"):Start();
                iStage:GetSystem("AnimationSystem"):Start();
                CameraMgr:Fade(2.5, 0, 0, 0, 0 );
            end)
        end) 
    end 

    if key == "m" then 
        CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
            self:ChangeStage("-");
            CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
            local tbNode = MapGeneratorSystem:GetPlayerBornPoint();
            ActorMgr:GetActor("player1"):SetiCompo("Transform", "x", tbNode.x);
            ActorMgr:GetActor("player1"):SetiCompo("Transform", "y", tbNode.y);
            self:GetCurStage():GetSystem("EnemySystem"):Start();
            self:GetCurStage():GetSystem("AnimationSystem"):Start();
            CameraMgr:Fade(2.5, 0, 0, 0, 0 );
        end)
    end
end