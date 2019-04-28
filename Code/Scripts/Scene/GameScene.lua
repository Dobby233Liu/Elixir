_G.GameScene = Scene:DeriveClass("GameScene");

function GameScene:StartHandler()
    self:NewStage();
end

function Scene:NewStage()

    -- 渲染层级有问题，现在是根据渲染系统注册的先后顺序决定的，并非理想排序
    -- 这个问题得改一下

    local iStage = self:SetCurStage(self:CreateStage());
    iStage:AddActor(ActorMgr:CreateActor("Player","player1"));
    iStage:AddActor(ActorMgr:CreateActor("Map","map1",{
        ["MapMaker"] = { nCellSize = 100, nCellCount = math.random(500,1000) };
    }));
    iStage:RegisterSystem(LayerSortSystem);
    iStage:RegisterSystem(MapGeneratorSystem);
    iStage:RegisterSystem(SpriteRenderSystem);
    iStage:RegisterSystem(AnimationSystem);
    iStage:RegisterSystem(RectangleRenderSystem);
    iStage:RegisterSystem(PlayerSystem);
    iStage:RegisterSystem(PlayerTweenMoveSystem);
    iStage:RegisterSystem(FindPathSystem);
    iStage:GetSystem("AnimationSystem"):Start();
    iStage:GetSystem("MapGeneratorSystem"):GeneratorHandler(ActorMgr:GetActor("map1"),function()
        local iMap = ActorMgr:GetActor("map1")
        local iMapCompo = iMap:GetiCompo("MapMaker");
        local tbNodex = {};
        for i = 1, #iMapCompo.tbRealMapInfo do
            local tbNode = iMapCompo.tbRealMapInfo[i];
            local iTile = ActorMgr:CreateActor("Tile","tile1")
            iStage:AddActor(iTile);
            iTile:SetiCompo("Transform", "x", tbNode.x);
            iTile:SetiCompo("Transform", "y", tbNode.y);
            tbNode.nWalkAble = 1;
            tbNode.nID = Origin:SetUniqueID();
            tbNode.addNeighbors(tbNode,iMapCompo.tbRealMapInfo);
            if i == 1 then 
                tbNodex = tbNode;
            end 
        end
        -- NextStageSystem:SetPlayerBornPos();
        ActorMgr:GetActor("player1"):SetiCompo("Transform", "x", tbNodex.x);
        ActorMgr:GetActor("player1"):SetiCompo("Transform", "y", tbNodex.y);
        CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
    end)
end