["在场景中创建舞台并填充"] = 
{

    local iStage = self:CreateStage();
	self:SetCurStage(iStage);
	
	-- 一句创建 
	-- self:SetCurStage(self:CreateStage(1));

    local iPlayer1 = ActorMgr:CreateActor("Player","player1",{
        ['Transform'] = { x=100, y=100, w=64, h=64 };
        ["Color"] = { r = 1, g = 0, b = 1,a = 1 };
    });
    iStage:AddActor(iPlayer1);

    local iPlayer2 = ActorMgr:CreateActor("Player","player2",{
        ['Transform'] = { x=100, y=140, w=64, h=64 };
        ["Color"] = { r = 1, g = 1, b = 0,a = 1 };
    });
    iStage:AddActor(iPlayer2);

    local iPlayer3 = ActorMgr:CreateActor("Player","player3",{
        ['Transform'] = { x=100, y=150, w=64, h=64 };
        ["Color"] = { r = 1, g = 0, b = 0,a = 1 };
    });
    iStage:AddActor(iPlayer3);

    iStage:RegisterSystem(LayerSortSystem);
    iStage:RegisterSystem(RectangleRenderSystem);

    local backBtn = loveframes.Create("imagebutton");
    backBtn:SetImage(AssetsMgr:GetTexture("grass"));
    backBtn:SetText("");
    backBtn:SetPos(445,534);
    backBtn:SizeToImage();
    backBtn.OnClick = function ()
        SceneMgr:SwitchScene(GameStateType.nWelcome,SceneType.sWelcomScene,true);
    end
    self:GetCurStage():AddUI("backBtn",backBtn);
}

["进度条"] = 
{
    local progressbar = loveframes.Create("progressbar")
    progressbar:SetPos(5, 30)
    progressbar:SetWidth(490)
    progressbar:SetLerpRate(2)
    progressbar:SetLerp(true)
    progressbar:SetValue(0);
    progressbar.OnComplete = function(object)
        
    end
}

["HTTP"] = 
{
    	-- http://127.0.0.1:5000/start?sContent=你好啊

    -- local textinput = loveframes.Create("textinput")
	-- textinput:SetPos(5, 30)
    -- textinput:SetWidth(490)
    -- textinput:SetText("")
	-- textinput:SetFont(AssetsMgr:GetFont(142))
	-- textinput.OnEnter = function(object)
	-- 	if not textinput.multiline then
	-- 		object:Clear()
	-- 	end
	-- end

	local headers = {}
	
	local frame = loveframes.Create("frame")
	frame:SetName("RR聊天")
	frame:SetSize(500, 365)
	frame:CenterWithinArea(unpack({5, 40, 540, 555}))
	
	
	local resultpanel = loveframes.Create("panel", frame)
	resultpanel:SetPos(5, 30)
	resultpanel:SetSize(490, 25)
	

	
	local resulttext = loveframes.Create("text", resultpanel)
	resulttext:SetPos(5, 5)
	
	local resultinput = loveframes.Create("textinput", frame)
	resultinput:SetPos(5, 60)
	resultinput:SetWidth(490)
	resultinput:SetMultiline(true)
	resultinput:SetHeight(270)
	resultinput:SetEditable(false)
	resultinput:SetFont(AssetsMgr:GetFont(142))
	
	local urlinput = loveframes.Create("textinput", frame)
	urlinput:SetSize(387, 25)
	urlinput:SetPos(5, 335)
	urlinput:SetText("")
	urlinput:SetFont(AssetsMgr:GetFont(142))
	
	local httpbutton = loveframes.Create("button", frame)
	httpbutton:SetSize(100, 25)
	httpbutton:SetPos(frame:GetWidth() - 105, 335)
	httpbutton:SetText("发送")
	httpbutton.OnClick = function()
		local sContent = urlinput:GetValue()
		local response_body = {};
		local urls = string.format("http://127.0.0.1:5000/start?sContent=%s",sContent);
        local res, code, response_headers = http.request ({
            method = "GET",
            url = urls,
            sink = ltn12.sink.table(response_body)
		})
		resultinput:SetText(response_body[1]);
	end

	local aaabutton = loveframes.Create("button", resultpanel)
	aaabutton:SetPos(290, 0)
	aaabutton:SetSize(100, 25)
	aaabutton:SetText("同步")
	aaabutton:SetVisible(true)
	aaabutton.OnClick = function(object) 
		local response_body = {};
		local urls = string.format("http://127.0.0.1:5000/query");
        local res, code, response_headers = http.request ({
            method = "GET",
            url = urls,
            sink = ltn12.sink.table(response_body)
		})
		resultinput:SetText(response_body[1]);
	end

	local clearbutton = loveframes.Create("button", resultpanel)
	clearbutton:SetPos(390, 0)
	clearbutton:SetSize(100, 25)
	clearbutton:SetText("清空")
	clearbutton:SetVisible(true)
	clearbutton.OnClick = function(object)
		resultinput:SetText("");
	end

	local response_body = {};
	local urls = string.format("http://127.0.0.1:5000/query");
	local res, code, response_headers = http.request ({
		method = "GET",
		url = urls,
		sink = ltn12.sink.table(response_body)
	})
	resultinput:SetText(response_body[1]);

}
["创建Stage"] = {
	-- 直接创建并将场景显示为当前场景
	local iStage = self:SetCurStage(self:CreateStage(1));
	-- 切换创景，如不存在可设置是否新建与是否播放Fade,todo...fade模式还有点问题，建议第三个参数保持false，直到修改掉这个bug
	local iStage = self:SwitchStage(1,true,false);
}

["想法"] = {
	["敌人移动规则"] = "将玩家范围分为3层，敌人靠近最外层后，会在中层或者最外层外的node中随机找一个，如果靠近中层，就在内层或者外层随机找一个"
}

["链式"] = {
	local iStage = self:SetCurStage(self:CreateStage(1));

    GameChainSystem:Start();

    GameChainSystem:CreateChain(1,function (pfn) 
        iStage:AddActor(ActorMgr:CreateActor("Player","player1",{
            ['Transform'] = { x=0, y=0, w=64, h=64 };
            ["Color"] = { r = 0, g = 1, b = 1,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
        if pfn then pfn() end
    end,function (pfn)
        iStage:AddActor(ActorMgr:CreateActor("Monster1","monster1_1",{
            ['Transform'] = { x=100, y=0, w=64, h=64 };
            ["Color"] = { r = 1, g = 0, b = 1,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
        if pfn then pfn() end
    end);

    GameChainSystem:CreateChain(1,function (pfn) 

    
        iStage:AddActor(ActorMgr:CreateActor("Monster1","monster1_2",{
            ['Transform'] = { x=200, y=0, w=64, h=64 };
            ["Color"] = { r = 1, g = 0, b = 1,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
    
        iStage:AddActor(ActorMgr:CreateActor("Monster1","monster1_3",{
            ['Transform'] = { x=300, y=0, w=64, h=64 };
            ["Color"] = { r = 1, g = 0, b = 1,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
        if pfn then pfn() end
    end,function (pfn)
        iStage:AddActor(ActorMgr:CreateActor("Monster2","monster2_1",{
            ['Transform'] = { x=400, y=0, w=64, h=64 };
            ["Color"] = { r = 1, g = 1, b = 0,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
        if pfn then pfn() end
    end);
    
    GameChainSystem:CreateChain(1,function (pfn) 

        iStage:AddActor(ActorMgr:CreateActor("Monster2","monster2_2",{
            ['Transform'] = { x=500, y=0, w=64, h=64 };
            ["Color"] = { r = 1, g = 1, b = 0,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
        
        iStage:AddActor(ActorMgr:CreateActor("Monster2","monster2_3",{
            ['Transform'] = { x=600, y=0, w=64, h=64 };
            ["Color"] = { r = 1, g = 1, b = 0,a = 1 };
            ['Rectangle'] = { sFillType = 'fill'};
            ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        }));
        if pfn then pfn() end
    end,function (pfn)
        if pfn then pfn() end
    end);

    iStage:RegisterSystem(LayerSortSystem);
    iStage:RegisterSystem(RectangleRenderSystem);

    GameChainSystem:ExecuteChain(true,function ()
        GameChainSystem:Destory()
    end);
}
["添加子集的配置"] = 
{
    local PlayerConfig = 
    {
        ['Transform'] = { x=0, y=200, w=64, h=64 };
        ["Color"] = { r = 1, g = 1, b = 1,a = 1 };
        ['Rectangle'] = { sFillType = 'fill'};
        ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
        
        ------------------------------------------------

        ["Children"] = { tbChildren = {
            { sActorType = "Head", sUseName = "head_1", tbProperty = {
                ['Transform'] = { x=0, y= 100, w=32, h=32 };
                ["Color"] = { r = 1, g = 0, b = 1,a = 1 };
                ['Rectangle'] = { sFillType = 'fill'};
                ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
            }};
        }};

        
    }
    return PlayerConfig
}
["获取内网本机IP地址"] = {
    local function GetAdd(hostname)
        local ip, resolved = socket.dns.toip(hostname)
        local ListTab = {}
        for k, v in ipairs(resolved.ip) do
            table.insert(ListTab, v)
        end
        return ListTab
    end
    
    self:Trace(1,unpack(GetAdd('localhost'))) -- 127.0.0.1
    self:Trace(1,unpack(GetAdd(socket.dns.gethostname()))) -- 192.168.1.21
}
["完整的场景"] = 
{
    _G.GameScene = Scene:DeriveClass("GameScene");


GameScene.nStageID = 1

function GameScene:StartHandler()
    local iStage = self:SetCurStage(self:CreateStage(nStage));

    self.iPlayer = ActorMgr:CreateActor("Player","player1")

    self:NewStage(iStage);


    -- local tbTweenType = {
    --     "linear",
    --     "inQuad",    "outQuad",    "inOutQuad",    "outInQuad",
    --     "inCubic",   "outCubic",   "inOutCubic",   "outInCubic",
    --     "inQuart",   "outQuart",   "inOutQuart",   "outInQuart",
    --     "inQuint",   "outQuint",   "inOutQuint",   "outInQuint",
    --     "inSine",    "outSine",    "inOutSine",    "outInSine",
    --     "inExpo",    "outExpo",    "inOutExpo",    "outInExpo",
    --     "inCirc",    "outCirc",    "inOutCirc",    "outInCirc",
    --     "inElastic", "outElastic", "inOutElastic", "outInElastic",
    --     "inBack",    "outBack",    "inOutBack",    "outInBack",
    --     "inBounce",  "outBounce",  "inOutBounce",  "outInBounce",
    -- }

    -- local nIndex = 1;
    -- local nextBtn = loveframes.Create("button");
	-- nextBtn:SetPos(100, 100);
	-- nextBtn:SetSize(100, 40);
	-- nextBtn:SetText("linear");
    -- nextBtn.OnClick = function()
    --     nIndex = nIndex + 1
    --     if nIndex >= #tbTweenType then 
    --         nIndex = 1
    --     end 
    --     local sType = tbTweenType[nIndex]
    --     iStage:GetSystem("PlayerTweenMoveSystem").tweenType = sType;
    --     nextBtn:SetText(sType);
    -- end
    
    -- local nextBtn = loveframes.Create("button");
	-- nextBtn:SetPos(100, 100);
	-- nextBtn:SetSize(100, 40);
	-- nextBtn:SetText("下一个");
	-- nextBtn.OnClick = function()
    --     CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
    --         self:ChangeStage("+",function (iStage,bNewStage)
    --             if bNewStage then 
    --                 self:NewStage(iStage);
    --             end
    --             local iMap = ActorMgr:GetActor("map1")
    --             local iMapCompo = iMap:GetiCompo("MapMaker");
    --             local tbNode = iMapCompo.tbRealMapInfo[1];
    --             self.iPlayer:SetiCompo("Transform", "x", tbNode.x);
    --             self.iPlayer:SetiCompo("Transform", "y", tbNode.y);
    --             CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
    --             CameraMgr:Fade(2.5, 0, 0, 0, 0 );
    --         end)
    --     end) 
	-- end

    -- local lastBtn = loveframes.Create("button");
	-- lastBtn:SetPos(210, 100);
	-- lastBtn:SetSize(100, 40);
	-- lastBtn:SetText("上一个");
	-- lastBtn.OnClick = function()
    --     CameraMgr:Fade(1.5, 0, 0, 0, 1,function()
    --         self:ChangeStage("-");
    --         CameraMgr:SetFollowActor(ActorMgr:GetActor("player1"));
    --         local iMap = ActorMgr:GetActor("map1");
    --         local iMapCompo = iMap:GetiCompo("MapMaker");
    --         local tbNode = iMapCompo.tbRealMapInfo[1];
    --         self.iPlayer:SetiCompo("Transform", "x", tbNode.x);
    --         self.iPlayer:SetiCompo("Transform", "y", tbNode.y);
    --         CameraMgr:Fade(2.5, 0, 0, 0, 0 );
    --     end)
	-- end

end

function GameScene:NewStage(iStage)

    iStage:AddActor(self.iPlayer);

    CameraMgr:SetFollowActor(self.iPlayer);

    iStage:AddActor(ActorMgr:CreateActor("Map","map1",{
        ["MapMaker"] = { nCellSize = 100, nCellCount = 1000 };
    }));

    iStage:RegisterSystem(MapGeneratorSystem);
    iStage:RegisterSystem(LayerSortSystem);
    iStage:RegisterSystem(RectangleRenderSystem);
    iStage:RegisterSystem(AnimationSystem);
    iStage:RegisterSystem(SpriteRenderSystem);
    iStage:RegisterSystem(PlayerSystem);
    iStage:RegisterSystem(PlayerTweenMoveSystem);
    iStage:RegisterSystem(FindPathSystem);

    iStage:GetSystem("AnimationSystem"):Start();
    iStage:GetSystem("MapGeneratorSystem"):GeneratorHandler(ActorMgr:GetActor("map1"),function()
        local iMap = ActorMgr:GetActor("map1")
        local iMapCompo = iMap:GetiCompo("MapMaker");
        local tbNodex = {};
        for i = 1, #iMapCompo.tbRealMapInfo do
            local tbNode = iMapCompo.tbRealMapInfo[i];
            local iTile = ActorMgr:CreateActor("Tile","tile1")
            iStage:AddActor(iTile);
            iTile:SetiCompo("Transform", "x", tbNode.x);
            iTile:SetiCompo("Transform", "y", tbNode.y);
            tbNode.nWalkAble = 1;
            tbNode.nID = Origin:SetUniqueID();
            tbNode.addNeighbors(tbNode,iMapCompo.tbRealMapInfo);
            if i == 1 then 
                tbNodex = tbNode
            end 
        end

        self.iPlayer:SetiCompo("Transform", "x", tbNodex.x);
        self.iPlayer:SetiCompo("Transform", "y", tbNodex.y);
    end)
end
}