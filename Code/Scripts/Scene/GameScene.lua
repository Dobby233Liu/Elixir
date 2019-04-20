_G.GameScene = Scene:DeriveClass("GameScene");

function GameScene:StartHandler()

    local iStage = self:CreateStage();
    self:SetCurStage(iStage);

end