_G.GlobalGameSystem = System:DeriveClass("GlobalGameSystem");

GlobalGameSystem:SetRegisterCompo{

};

function GlobalGameSystem:Start()
    self.tbState = { "Player", "Enemy" };
    self.sCurState = "Player";
end

function GlobalGameSystem:ChangeState(sCurState,...)
    self.sCurState = sCurState;
    Event:DoEvent(self,"EvtChangeState",self.sCurState,...)
end