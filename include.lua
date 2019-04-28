_G.Include = Class:DeriveClass("Include");

package.path = ""
package.cpath = (os.getenv ("LUA_CLIBRARY_PATH") or ".") .. "/libs/?.dll"

function Include:RequireHandler(strDir,sPath)
    self:Trace(1,"do file: [",strDir..sPath,"]");
    require(strDir..sPath);
end

function Include:Import(pfn)
    self:GlobalBase();
    self:GlobalConfig();
    self:ThirdPartyLibrary();
    self:GlobalManager();
    self:GlobalSystem();
    self:GlobalScene();
    self:Trace(1," *** Do File Complete! *** ");
    pfn(0,nil);
end

function Include:ThirdPartyLibrary()
    local strDir = "Library/";
    loader      	    = require(strDir..'love-loader');
    bump_debug      	= require(strDir..'bump_debug');
    bump      	        = require(strDir..'bump');
    json      	        = require(strDir..'json');
    splash      	    = require(strDir..'lovesplash');
    Timer               = require(strDir.."Timer")();
    Camera              = require(strDir.."Camera")();
    Blob                = require(strDir.."Blob");
    Utils               = require(strDir.."Utils");
    Katsudo             = require(strDir.."katsudo");
    Tween               = require(strDir.."tween/tween");
    utf8                = require("utf8");
    utf8_simple         = require(strDir.."utf8_simple");
    socket              = require("socket");
    http                = require("socket.http");
    loveframes          = require(strDir.."loveframes/loveframes");
end

function Include:GlobalBase()
    
    local strDir = "Code/Scripts/Majors/Ecs/";
    self:RequireHandler(strDir,"Compo");
    self:RequireHandler(strDir,"Entity");
    self:RequireHandler(strDir,"System");

    local strDir = "Code/Scripts/Majors/Base/";
    self:RequireHandler(strDir,"Scene");
    self:RequireHandler(strDir,"Actor");
    self:RequireHandler(strDir,"Stage");
    self:RequireHandler(strDir,"Chain");
    

end

function Include:GlobalConfig()

    local strDir = "Code/Configs/";

    local cfgDir = strDir.."Settings/";
    self:RequireHandler(cfgDir,"Option");

    cfgDir = strDir.."AssetsCfgs/";
    self:RequireHandler(cfgDir,"AssetsFontCfg");
    self:RequireHandler(cfgDir,"AssetsTextureCfg");
    -- self:RequireHandler(cfgDir,"AssetsVoiceCfg");
    
    cfgDir = strDir.."ManagerCfgs/";
    self:RequireHandler(cfgDir,"GameStateCfg");
    self:RequireHandler(cfgDir,"SceneMgrCfg");

    cfgDir = strDir.."SceneCfgs/";
    -- self:RequireHandler(cfgDir,"WelcomSceneCfg");
    -- self:RequireHandler(cfgDir,"HelpSceneCfg");
    -- self:RequireHandler(cfgDir,"GameSceneCfg");

end

function Include:GlobalManager()
    local strDir = "Code/Scripts/Manager/";
    self:RequireHandler(strDir,"ProjectMgr");
    self:RequireHandler(strDir,"GameMgr");
    self:RequireHandler(strDir,"AssetsMgr");
    self:RequireHandler(strDir,"GameStateMgr");
    self:RequireHandler(strDir,"SceneMgr");
    self:RequireHandler(strDir,"CameraMgr");
    self:RequireHandler(strDir,"ActorMgr");
end 

function Include:GlobalSystem()
    local strDir = "Code/Scripts/System/";
    self:RequireHandler(strDir,"LayerSortSystem");
    self:RequireHandler(strDir,"RectangleRenderSystem");
    self:RequireHandler(strDir,"GameChainSystem");
    self:RequireHandler(strDir,"MakeChildSystem");
    self:RequireHandler(strDir,"MapGeneratorSystem");
    self:RequireHandler(strDir,"SpriteRenderSystem");
    self:RequireHandler(strDir,"AnimationSystem");
    -- 寻路三剑客
    self:RequireHandler(strDir,"PlayerSystem");
    self:RequireHandler(strDir,"PlayerTweenMoveSystem");
    self:RequireHandler(strDir,"FindPathSystem");

end

function Include:GlobalScene()
    local strDir = "Code/Scripts/Scene/";
    self:RequireHandler(strDir,"LoaderScene");
    self:RequireHandler(strDir,"SplashScene");
    self:RequireHandler(strDir,"WelcomScene");
    self:RequireHandler(strDir,"GameScene");
    self:RequireHandler(strDir,"HelpWelcom");
    self:RequireHandler(strDir,"GMTool");
end