_G.GameStateMgr = Class:DeriveClass("GameStateMgr");

function GameStateMgr:StartUp()
    self.nValue = GameStateType.nLoader;
end 

function GameStateMgr:GetCurState()
    return self.nValue
end

function GameStateMgr:SetCurState(nValue)
    self.nValue = nValue;
end
