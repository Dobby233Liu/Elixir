["在场景中创建舞台并填充"] = 
{
    local iStage = self:CreateStage();
    self:SetCurStage(iStage);

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