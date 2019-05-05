_G.ExitTileSystem = System:DeriveClass("ExitTileSystem");

ExitTileSystem:SetRegisterCompo{

};

function ExitTileSystem:NextStageHandler()
    CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
        GameScene:ChangeStage("+",function (iStage,bNewStage)
            if bNewStage then 
                GameScene:NewStage(iStage);
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

function ExitTileSystem:LastStageHandler()
    CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
        GameScene:ChangeStage("-");
        CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
        local tbNode = MapGeneratorSystem:GetPlayerBornPoint();
        ActorMgr:GetActor("player1"):SetiCompo("Transform", "x", tbNode.x);
        ActorMgr:GetActor("player1"):SetiCompo("Transform", "y", tbNode.y);
        GameScene:GetCurStage():GetSystem("EnemySystem"):Start();
        GameScene:GetCurStage():GetSystem("AnimationSystem"):Start();
        CameraMgr:Fade(2.5, 0, 0, 0, 0 );
    end)
end