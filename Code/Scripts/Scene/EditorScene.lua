_G.EditorScene = Scene:DeriveClass("EditorScene");

function EditorScene:StartHandler()

    local iStage = self:CreateStage();
    self:SetCurStage(iStage);

end