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
    -- self:GlobalSystem();
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
    socket              = require("socket");
    http                = require("socket.http")
end

function Include:GlobalBase()
    local strDir = "Code/Scripts/Majors/Base/";
    self:RequireHandler(strDir,"Scene");
    
    local strDir = "Code/Scripts/Majors/Ecs/";
    self:RequireHandler(strDir,"Compo");
    self:RequireHandler(strDir,"Entity");
    self:RequireHandler(strDir,"System");

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

end

function Include:GlobalManager()
    local strDir = "Code/Scripts/Manager/";
    self:RequireHandler(strDir,"ProjectMgr");
    self:RequireHandler(strDir,"GameMgr");
    self:RequireHandler(strDir,"AssetsMgr");
    self:RequireHandler(strDir,"GameStateMgr");
    self:RequireHandler(strDir,"SceneMgr");
    self:RequireHandler(strDir,"CameraMgr");
end 

function Include:GlobalSystem()
    local strDir = "Code/Scripts/System/";
end

function Include:GlobalScene()
    local strDir = "Code/Scripts/Scene/";
    self:RequireHandler(strDir,"LoaderScene");
    self:RequireHandler(strDir,"SplashScene");
    self:RequireHandler(strDir,"WelcomScene");
    self:RequireHandler(strDir,"GameScene");
end