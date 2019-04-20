_G.WelcomScene = Scene:DeriveClass("WelcomScene");

function WelcomScene:StartHandler()

    local iStage = self:CreateStage();
    self:SetCurStage(iStage);

    local startBtn = loveframes.Create("button");
    startBtn:SetText("开始");
    startBtn:SetPos(445,384);
    startBtn:SetSize(70,40);
    startBtn.OnClick = function ()
        self:ClickStartHandler();
    end
    self:GetCurStage():AddUI("startBtn",startBtn);

    local helpBtn = loveframes.Create("imagebutton");
    helpBtn:SetImage(AssetsMgr:GetTexture("grass"));
    helpBtn:SetText("");
    helpBtn:SetPos(445,434);
    helpBtn:SizeToImage();
    helpBtn.OnClick = function ()
        self:ClickHelpHandler();
    end
    self:GetCurStage():AddUI("helpBtn",helpBtn);

end

function WelcomScene:RenderHandler()
    love.graphics.setColor(1,1,1,1);
    love.graphics.setFont(AssetsMgr:GetFont(722));
    local nTitleX = (graphicsWidth*0.5) - AssetsMgr:GetFont(722):getWidth(Option.sTitle)*0.5;
    local nTitleY = graphicsHeight*0.35;
    love.graphics.print(Option.sTitle, nTitleX,nTitleY);
end

function WelcomScene:ClickStartHandler()
    SceneMgr:SwitchScene(GameStateType.nGame,SceneType.sGameScene,true);
end 

function WelcomScene:ClickHelpHandler()
    SceneMgr:SwitchScene(GameStateType.nHelp,SceneType.sHelpWelcom,true);
end