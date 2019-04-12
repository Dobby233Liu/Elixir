_G.SceneMgr = Class:DeriveClass("SceneMgr"); 

SceneMgr.iCurScene = nil;
SceneMgr.tbSceneList = nil;

function SceneMgr:Start()
	self.tbSceneList = {};
	local tbScenes = SceneMgrCfg.tbScenes;
	tbScenes = tbScenes or {};
	if not next(tbScenes) then 
		self:Error("SceneMgrCfg.tbScenes Not Find!");
		return;
	end
	for _,sSceneName in ipairs(tbScenes) do 
		local iScene = self:CreateScene(sSceneName);
		self.tbSceneList[sSceneName] = iScene;
		if sSceneName == SceneType.sLoaderScene then 
			self.iCurScene = iScene;
		end
	end

	SceneMgr:SwitchScene(GameStateType.nLoader,SceneType.sLoaderScene);
end

function SceneMgr:Init()
	self.iCurScene:Start();
end

function SceneMgr:Update(dt)
	if self.iCurScene then 
		self.iCurScene:Update(dt);
	end
end

function SceneMgr:Render()
	if self.iCurScene then 
		self.iCurScene:Render();
	end
end 

function SceneMgr:MouseDown(x, y, button, istouch, presses)
	if self.iCurScene then 
		if self.iCurScene.MouseDown then 
			self.iCurScene:MouseDown(x, y, button, istouch, presses)
		end
	end
end

function SceneMgr:CreateScene(sClassName)
	local iScene = _G[sClassName];
	return iScene;
end

function SceneMgr:GetScene(sClassName)
	return self.tbSceneList[sClassName];
end

function SceneMgr:GetCurScene()
	return self.iCurScene;
end

function SceneMgr:SetCurScene(sClassName)
	self.iCurScene = self:GetScene(sClassName);
end

function SceneMgr:SwitchScene(nState,sScene,bFade)
	self:Trace(1,nState,sScene) 
	if bFade then 
		CameraMgr:Fade(0.5, 0, 0, 0, 1,function()
			GameStateMgr:SetCurState(nState);
			self:SetCurScene(sScene); 
			self:GetCurScene():Start();
			CameraMgr:Fade(3.5, 0, 0, 0, 0);
		end)
	else 
		GameStateMgr:SetCurState(nState);
		self:SetCurScene(sScene);
		self:GetCurScene():Start();
	end
end