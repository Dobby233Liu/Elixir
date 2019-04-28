_G.GMTool = Scene:DeriveClass("GMTool");

function GMTool:StartHandler()

    local iStage = self:SetCurStage(self:CreateStage(1));

    local function GetAdd(hostname)
        local ip, resolved = socket.dns.toip(hostname)
        local ListTab = {}
        for k, v in ipairs(resolved.ip) do
            table.insert(ListTab, v)
        end
        return ListTab
    end

    local ip = unpack(GetAdd(socket.dns.gethostname()))

    local frame = loveframes.Create("frame");
    frame:SetName("GM");
    frame:SetSize(960,640);
    frame:SetScreenLocked(true);
    frame:ShowCloseButton(true);
    frame.OnClose = function ()
        love.event.quit();
    end

    local text_ip = loveframes.Create("text",frame)
	text_ip:SetLinksEnabled(true)
	text_ip:SetDetectLinks(true)
	text_ip:SetText("IP:")
    text_ip:SetShadowColor(.8, .8, .8, 1)
    text_ip:SetPos(15,34)
    text_ip:SetSize(100,50)
    text_ip:SetFont(AssetsMgr:GetFont(142))

    local textinput_ip = loveframes.Create("textinput", frame)
    textinput_ip:SetPos(55,30)
    textinput_ip:SetText(ip)
    textinput_ip:SetFont(AssetsMgr:GetFont(142))

    local text_port = loveframes.Create("text",frame)
	text_port:SetLinksEnabled(true)
	text_port:SetDetectLinks(true)
	text_port:SetText("端口:")
    text_port:SetShadowColor(.8, .8, .8, 1)
    text_port:SetPos(15,64)
    text_port:SetFont(AssetsMgr:GetFont(142))

    local textinput_port = loveframes.Create("textinput", frame)
    textinput_port:SetPos(55,60)
    textinput_port:SetText(26001)
    textinput_port:SetFont(AssetsMgr:GetFont(142))

end
 
--[[
    _G.GMTool = Scene:DeriveClass("GMTool");

function GMTool:StartHandler()

    local iStage = self:SetCurStage(self:CreateStage(1));
    iStage:AddActor(ActorMgr:CreateActor("Player","player1" ));

    local frame = loveframes.Create("frame");
    frame:SetName("GM");
    frame:SetSize(960,640);
    frame:SetScreenLocked(true);
    frame:ShowCloseButton(true);
    frame.OnClose = function ()
        love.event.quit();
    end
    self:GetCurStage():AddUI("frame",frame);

    local text_ip = loveframes.Create("text",frame)
	text_ip:SetLinksEnabled(true)
	text_ip:SetDetectLinks(true)
	text_ip:SetText("IP:")
    text_ip:SetShadowColor(.8, .8, .8, 1)
    text_ip:SetPos(15,34)
    text_ip:SetSize(100,50)
    text_ip:SetFont(AssetsMgr:GetFont(142))

    local textinput_ip = loveframes.Create("textinput", frame)
    textinput_ip:SetPos(55,30)
    textinput_ip:SetText("")
    textinput_ip:SetFont(AssetsMgr:GetFont(142))
    self:GetCurStage():AddUI("textinput_ip",textinput_ip);

    local getipBtn = loveframes.Create("button",frame);
	getipBtn:SetPos(270, 30);
	getipBtn:SetSize(70, 30);
	getipBtn:SetText("本机ip");
    getipBtn.OnClick = function() 
        local function GetAdd(hostname)
            local ip, resolved = socket.dns.toip(hostname)
            local ListTab = {}
            for k, v in ipairs(resolved.ip) do
                table.insert(ListTab, v)
            end
            return ListTab
        end
        
        self:Trace(1,unpack(GetAdd('localhost')))
        local allip = unpack(GetAdd(socket.dns.gethostname()))
        self:Trace(1,allip) 
        textinput_ip:SetText(allip)
    end

    local text_port = loveframes.Create("text",frame)
	text_port:SetLinksEnabled(true)
	text_port:SetDetectLinks(true)
	text_port:SetText("端口:")
    text_port:SetShadowColor(.8, .8, .8, 1)
    text_port:SetPos(15,64)
    text_port:SetFont(AssetsMgr:GetFont(142))

    local textinput_port = loveframes.Create("textinput", frame)
    textinput_port:SetPos(55,60)
    textinput_port:SetText("")
    textinput_port:SetFont(AssetsMgr:GetFont(142))
    self:GetCurStage():AddUI("textinput_port",textinput_port);
 
	local multichoice = loveframes.Create("multichoice", frame);
	multichoice:SetPos(350, 30);
    multichoice:SetText("选择工具");
    local tbTool = {
        { sName = "模拟充值",};
        { sName = "提升等级",};
        { sName = "完成任务",};
    }
    for i=1, #tbTool do
        local v = tbTool[i];
		multichoice:AddChoice(v.sName);
	end

end
 
]]