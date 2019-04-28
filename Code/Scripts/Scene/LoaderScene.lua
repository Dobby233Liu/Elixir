_G.LoaderScene = Scene:DeriveClass("LoaderScene");

function LoaderScene:Start(callback) 
    self:Trace(1,"[started loading]"); 
    local pfn = function ()
        self:Trace(1,"[End loading]");
        -- SceneMgr:SwitchScene(GameStateType.nSplash,SceneType.sSplashScene);
        -- SceneMgr:SwitchScene(GameStateType.nWelcome,SceneType.sWelcomScene,true);
        SceneMgr:SwitchScene(GameStateType.nGame,SceneType.sGameScene,true);
        -- SceneMgr:SwitchScene(GameStateType.nGMTool,SceneType.sGMTool,true);
        if callback then 
            callback();
        end
    end

    local sSceneName = "Currency";

    local tbImage = AssetsTextureCfg[sSceneName];

    -- local tbSound = AssetsVoiceCfg[sSceneName];

    -- 字体资源
    local tbFont  = AssetsFontCfg[sSceneName];
    if not next(tbFont) then 
        self:Trace(1,"Not Find Font");
    else
        local iFont = {};
        if tbFont ~= nil then 
            for a = 1, #tbFont do 
                for i = 1, 72 do 
                    if i%2==0 then 
                        iFont.sName = i..tbFont[a].sName;
                        iFont.sPath = tbFont[a].sPath;
                        iFont.nSize = i;
                        AssetsMgr.tbMedia.fonts[tonumber(iFont.sName)] = love.graphics.newFont(iFont.sPath,iFont.nSize);
                    end
                end
            end
        end 
    end
    
    -- 贴图资源
    local tbImage = AssetsTextureCfg[sSceneName];
    if not next(tbImage) then 
        self:Trace(1,"Not Find Image");
        pfn();
        return;
    else
        if tbImage ~= nil then 
            for _,iTexture in ipairs(tbImage) do 
                self:Trace(1,"Loading Image ",iTexture.sName);
                loader.newImage(AssetsMgr.tbMedia.images,iTexture.sName,iTexture.sPath);
            end
        end 
    end 
    loader.start(pfn, nil); 
end

function LoaderScene:Update(dt)
    loader.update();
end

function LoaderScene:Render()
    self:DrawLoadingBar();
end

function LoaderScene:DrawLoadingBar()
	local separation = 30;
	local w = graphicsWidth - 2 * separation;
	local h = 15;
	local x,y = separation, graphicsHeight - separation - h;

	x, y = x + 3, y + 3;
	w, h = w - 6, h - 7;

	love.graphics.setColor(0.23,0.23,0.23,1);
	love.graphics.rectangle("fill", x, y, w, h);

	if loader.loadedCount > 0 then
		w = w * (loader.loadedCount / loader.resourceCount);
        love.graphics.setColor(1,1,1,1);
		love.graphics.rectangle("fill", x, y, w, h);
		love.graphics.setColor(1,1,1,0.19);
		love.graphics.rectangle("fill", x, y, graphicsWidth - 2 * separation - 6, h);
		love.graphics.setColor(1,1,1,1);
	end
end