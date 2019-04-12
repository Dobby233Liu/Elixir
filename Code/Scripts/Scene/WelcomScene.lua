_G.WelcomScene = Scene:DeriveClass("WelcomScene");

function WelcomScene:Start()
    self.nCricleR = 1;
    self.bScalBig = true;
end

function WelcomScene:Update(dt)
	if self.bScalBig then 
		if self.nCricleR <= 0.1 then 
			self.bScalBig = false;
			return 
		end 
		self.nCricleR = self.nCricleR - 0.01;
	else 
		if self.nCricleR >= 1 then 
			self.bScalBig = true;
			return 
		end 
		self.nCricleR = self.nCricleR + 0.01;
	end
end

function WelcomScene:Render()
    love.graphics.setColor(1,1,1,1);
    love.graphics.setFont(AssetsMgr:GetFont(722));
    local nTitleX = (graphicsWidth*0.5) - AssetsMgr:GetFont(722):getWidth(Option.sTitle)*0.5;
    local nTitleY = graphicsHeight*0.35;
    love.graphics.print(Option.sTitle, nTitleX,nTitleY);
    love.graphics.setColor(1,1,1,self.nCricleR);
    love.graphics.setFont(AssetsMgr:GetFont(242));
    local nStartBtnX = (graphicsWidth*0.5) - AssetsMgr:GetFont(242):getWidth("TAP TO RESTART GAME")*0.5;
    local nStartBtnY = graphicsHeight*0.6;
    love.graphics.print("TAP TO RESTART GAME",nStartBtnX,nStartBtnY);
end

function WelcomScene:MouseDown(x, y, button, istouch, presses)
    SceneMgr:SwitchScene(GameStateType.nGame,SceneType.sGameScene,true);
end


