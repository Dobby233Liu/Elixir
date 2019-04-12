_G.ProjectMgr = Class:DeriveClass("ProjectMgr");

function ProjectMgr:Start(pfn)

    GameStateMgr:StartUp();
    

    Camera:setFollowLerp(Option.nCamera_Follow_Lerp);
    Camera:setFollowStyle(Option.nCamera_Follow_Style);

    local file = io.open('Project/Project.json', 'r')
    if not file then 
        self:Error("not find GameDataCfg.json")
        return
    end 

    local szContent = "";
    for line in file:lines() do
        szContent = szContent..line;
    end
    
    Option.cfgProject = json.decode(szContent);
    self:Trace(1,table.show(Option.cfgProject,"Option.cfgProject"));

    Option.sTitle = Option.cfgProject.gameinfo.sTitle;
    Option.sEngineVersion = Option.cfgProject.gameinfo.sEngineVersion;
    Option.sGameVersion = Option.cfgProject.gameinfo.sGameVersion;

    local sOSString = love.system.getOS( )

    local tbOSInfo = Option.cfgProject.os[sOSString]
    self:Trace(1,table.show(tbOSInfo,"tbOSInfo"));

    -- local tbplatformInfo = Option.cfgProject.platform[sOSString]
    -- self:Trace(1,table.show(tbplatformInfo,"tbplatformInfo"));

    GameStateMgr:SetCurState(GameStateType.nWelcome);
    if pfn then 
        pfn()
    end 

end

-- function ProjectMgr:Update(dt)
--     if GameStateMgr:GetCurState() == GameStateType.nLoader then 
--         AssetsMgr:Update(dt);
--     end
-- end 

-- function ProjectMgr:Render()
--     if GameStateMgr:GetCurState() == GameStateType.nLoader then 
--         AssetsMgr:Render();
--     end
-- end