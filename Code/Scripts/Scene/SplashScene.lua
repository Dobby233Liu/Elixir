_G.SplashScene = Scene:DeriveClass("SplashScene");
SplashScene.speed = 100;
SplashScene.nCricleR = 1; 
function SplashScene:Start()
    self.speed = speed or 0.5;  
    local tbSplash = 
    {
        -- {		
        --     image = love.graphics.newImage("Assets/Textures/images/trees.png"),
        --     -- footer = "Look, some trees!",
        --     footer = "",
        --     speed = self.speed,
        --     duration = 2,
        -- },
        -- {		
        --     image = love.graphics.newImage("Assets/Textures/images/rabbit.png"),
        --     -- footer = "There is a rabbit nearby...",
        --     footer = "",
        --     speed = self.speed,
        --     duration = 2,
        -- },
        -- {		
        --     image = love.graphics.newImage("Assets/Textures/images/mushroom.png"),
        --     -- footer = "Who likes eating mushrooms!",
        --     footer = "",
        --     speed = self.speed,
        --     duration = 2,
        -- },
        {		
            image = love.graphics.newImage("Assets/Textures/images/love-app-icon.png"),
            -- footer = "Who likes eating mushrooms!",
            footer = "",
            speed = self.speed,
            duration = 2,
        },
    }
	splash.populate(tbSplash);
    splash.callback = function ()
        SceneMgr:SwitchScene(GameStateType.nWelcome,SceneType.sWelcomScene);
    end;
end

function SplashScene:Update(dt)
    splash.update(dt)
	if splash.active() then 
		return 
	end
end

function SplashScene:Render()
    splash.draw()
    if splash.active() then 
        return 
    end 
end