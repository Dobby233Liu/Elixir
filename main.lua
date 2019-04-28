
require("Code/Scripts/Majors/Core/Class");
require("Code/Scripts/Majors/Core/Event");
require("Code/Scripts/Majors/Core/Origin");

require("include");

function love.load()
    -- 加载文件
    Include:Import(function(nCode)
        if nCode ~= 0 then 
            return error("Do File Failed!");
        end
        -- 全局设置
        ProjectMgr:Start(function ()
            GameMgr:StartUp();
        end);
    end)
end

function love.update(dt)
    if GameMgr then 
        love.window.setTitle(Option.sTitle.." ["..love.timer.getFPS().."]" );
        GameMgr:Update(dt);
    end
end

function love.draw()
    if AssetsMgr then 
        if Option.Debug then 
            love.graphics.setFont(AssetsMgr:GetFont(142));
            love.graphics.setColor(0.6, 0.39, 0.6, 1);
            local stats = love.graphics.getStats();
            love.graphics.print("GPU memory: "..(math.floor(stats.texturememory/1.024)/1000)..
            " Kb\nLua Memory: "..(math.floor(collectgarbage("count")/1.024)/1000).." Kb\nFonts: "..
            stats.fonts.."\nCanvas Switches: "..stats.canvasswitches.."\nCanvases: "..stats.canvases..
            "\nFPS: "..love.timer.getFPS(), 10, 10); 

            love.graphics.setFont(AssetsMgr:GetFont(142));
            -- love.graphics.setColor(1, 0, 0, 1);
            local version = string.format(" %s-[%s] ", Option.sEngineVersion,Option.sGameVersion)
            local nVersionWidth = graphicsWidth - AssetsMgr:GetFont(142):getWidth(version);
            local nVersionHeight = graphicsHeight - AssetsMgr:GetFont(142):getHeight(version) * 1.5 
            love.graphics.print(version, nVersionWidth,nVersionHeight);

            love.graphics.setFont(AssetsMgr:GetFont(142));
            -- love.graphics.setColor(1, 0, 0, 1);
            local gamestate = string.format(" %s ", GameStateValue[GameStateMgr:GetCurState()])
            local nVersionWidth = graphicsWidth - AssetsMgr:GetFont(142):getWidth(gamestate);
            local nVersionHeight = 10;
            love.graphics.print(gamestate, nVersionWidth,nVersionHeight);
        end
    end 
    if GameMgr then 
        GameMgr:Render();
    end
end

function love.mousepressed(x, y, button, istouch, presses)
    if GameMgr then 
        GameMgr:MouseDown(x, y, button, istouch, presses)
    end
end

function love.mousereleased(x, y, button)
	GameMgr:mousereleased(x, y, button)
end

function love.wheelmoved(x, y)
	GameMgr:wheelmoved(x, y)
end

function love.keypressed(key, isrepeat)
    if key == "escape" then 
        love.event.quit();
    end 
	GameMgr:keypressed(key, isrepeat)
end

function love.keyreleased(key)
	GameMgr:keyreleased(key)
end

function love.textinput(text)
	GameMgr:textinput(text)
end
