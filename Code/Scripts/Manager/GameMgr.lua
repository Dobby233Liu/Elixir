_G.GameMgr = Class:DeriveClass("GameMgr");

function GameMgr:StartUp()
    self:Start();
end

function GameMgr:Start()
    SceneMgr:Start();
end

function GameMgr:Update(dt)
    CameraMgr:Update(dt); 
    SceneMgr:Update(dt);
    loveframes.update(dt);
end

function GameMgr:Render()
    loveframes.draw()
    SceneMgr:Render()
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
		demo.CreateToolbar()
		demo.CreateExamplesList()
		--demo.ToggleExamplesList()
	end
end

function GameMgr:keyreleased(key)
	loveframes.keyreleased(key)
end

function GameMgr:textinput(text)
	loveframes.textinput(text)
end
