_G.GameMgr = Class:DeriveClass("GameMgr");

function GameMgr:StartUp()
    self:Start();
end

function GameMgr:Start()
    SceneMgr:Start();
end

function GameMgr:Update(dt)
    CameraMgr:Update(dt); 
    SceneMgr:Update(dt) 
end

function GameMgr:Render()
    SceneMgr:Render()
end

function GameMgr:MouseDown(x, y, button, istouch, presses)
	SceneMgr:MouseDown(x, y, button, istouch, presses)
end