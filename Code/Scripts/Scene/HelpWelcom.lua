_G.HelpWelcom = Scene:DeriveClass("HelpWelcom");

function HelpWelcom:StartHandler()

    local iStage = self:CreateStage();
    self:SetCurStage(iStage);

    local backBtn = loveframes.Create("button");
    backBtn:SetText("Back");
    backBtn:SetPos(445,434);
    backBtn:SetSize(70,40);
    backBtn.OnClick = function ()
        SceneMgr:SwitchScene(GameStateType.nWelcome,SceneType.sWelcomScene,true);
    end
    self:GetCurStage():AddUI("backBtn",backBtn);
    
end
