_G.GameMgr = Class:DeriveClass("GameMgr");

function GameMgr:StartUp()
    self:Start();
end

function GameMgr:Start()
    SceneMgr:Start();
end

function GameMgr:Update(dt)
	Timer:update(dt); 
	Tween.update(dt);
    CameraMgr:Update(dt); 
    SceneMgr:Update(dt);
	loveframes.update(dt);
end

function GameMgr:Render()
    SceneMgr:Render()
    loveframes.draw()
end

function GameMgr:MouseDown(x, y, button, istouch, presses)
    SceneMgr:MouseDown(x, y, button, istouch, presses)
    loveframes.mousepressed(x, y, button)
end


function GameMgr:mousereleased(x, y, button)
	loveframes.mousereleased(x, y, button)
end

function GameMgr:wheelmoved(x, y)
	loveframes.wheelmoved(x, y)
end

function GameMgr:keypressed(key, isrepeat)
	loveframes.keypressed(key, isrepeat)
	if key == "f1" then
		local debug = loveframes.config["DEBUG"]
		loveframes.config["DEBUG"] = not debug
	elseif key == "f2" then
		loveframes.RemoveAll()
	elseif key == "tab" then
		local debug = Option.Debug;
		Option.Debug = not debug;
	end
	SceneMgr:KeyDown(key, isrepeat)
end

function GameMgr:keyreleased(key)
	loveframes.keyreleased(key)
end

function GameMgr:textinput(text)
	loveframes.textinput(text)
end
