["在场景中创建舞台并填充"] = 
{
    local iStage = self:CreateStage();
    self:SetCurStage(iStage);

    local iPlayer1 = ActorMgr:CreateActor("Player","player1",{
        ['Transform'] = { x=100, y=100, w=64, h=64 };
        ["Color"] = { r = 1, g = 0, b = 1,a = 1 };
    });
    iStage:AddActor(iPlayer1);

    local iPlayer2 = ActorMgr:CreateActor("Player","player2",{
        ['Transform'] = { x=100, y=140, w=64, h=64 };
        ["Color"] = { r = 1, g = 1, b = 0,a = 1 };
    });
    iStage:AddActor(iPlayer2);

    local iPlayer3 = ActorMgr:CreateActor("Player","player3",{
        ['Transform'] = { x=100, y=150, w=64, h=64 };
        ["Color"] = { r = 1, g = 0, b = 0,a = 1 };
    });
    iStage:AddActor(iPlayer3);

    iStage:RegisterSystem(LayerSortSystem);
    iStage:RegisterSystem(RectangleRenderSystem);

    local backBtn = loveframes.Create("imagebutton");
    backBtn:SetImage(AssetsMgr:GetTexture("grass"));
    backBtn:SetText("");
    backBtn:SetPos(445,534);
    backBtn:SizeToImage();
    backBtn.OnClick = function ()
        SceneMgr:SwitchScene(GameStateType.nWelcome,SceneType.sWelcomScene,true);
    end
    self:GetCurStage():AddUI("backBtn",backBtn);
}

["进度条"] = 
{
    local progressbar = loveframes.Create("progressbar")
    progressbar:SetPos(5, 30)
    progressbar:SetWidth(490)
    progressbar:SetLerpRate(2)
    progressbar:SetLerp(true)
    progressbar:SetValue(0);
    progressbar.OnComplete = function(object)
        
    end
}