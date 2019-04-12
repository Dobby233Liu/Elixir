_G.GameScene = Scene:DeriveClass("GameScene");

local tba = {x = 0,y = 0}

function GameScene:Start()

end

function GameScene:Update(dt)
    local mx,my = CameraMgr:GetMousePosition();
    
    tba.x = mx;
    tba.y = my;
    
    -- self:Trace(1,mx,my)

end

function GameScene:Render()
    CameraMgr:RenderAttach(function ()
        love.graphics.setColor(1,1,1,1);
        love.graphics.rectangle("fill",tba.x,tba.y,100,100)
	end)
end

