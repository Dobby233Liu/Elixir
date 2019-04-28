_G.ProjectMgr = Class:DeriveClass("ProjectMgr");

function ProjectMgr:Start(pfn)

    -- 设置Love环境
    love.graphics.present();
    love.graphics.setDefaultFilter('nearest', 'nearest', 1);
    love.graphics.setLineStyle('smooth');
    -- love.graphics.setBackgroundColor(0.21,0.27,0.30);
    love.graphics.setBackgroundColor(69/255,69/255,69/255);
    
    -- 获取分辨率
    _G.graphicsWidth  = love.graphics.getWidth();
    _G.graphicsHeight = love.graphics.getHeight();
    _G.screenWidth, _G.screenHeight = love.window.getDesktopDimensions();

    _G.logFileName = "gc"..os.time()..".log"

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
    Option.sGameType = Option.cfgProject.gameinfo.sGameType;
    Option.Debug = Option.cfgProject.gameinfo.Debug;
    Option.Log = Option.cfgProject.gameinfo.Log;
    Option.bFollow = Option.cfgProject.gameinfo.bFollow;

    self:Trace(1,"---------StartUp!---------");
    self:Trace(1,string.format("graphicsWidth:%s,graphicsHeight:%s",graphicsWidth,graphicsHeight));
    self:Trace(1,string.format("screenWidth:%s,screenHeight:%s",screenWidth,screenHeight));
    self:Trace(1,"Do File Load Start!");

    local sOSString = love.system.getOS( )

    local tbOSInfo = Option.cfgProject.os[sOSString]
    -- self:Trace(1,table.show(tbOSInfo,"tbOSInfo"));

    -- local tbplatformInfo = Option.cfgProject.platform[sOSString]
    -- self:Trace(1,table.show(tbplatformInfo,"tbplatformInfo"));

    GameStateMgr:SetCurState(GameStateType.nWelcome);

    if pfn then 
        pfn()
    end 

end