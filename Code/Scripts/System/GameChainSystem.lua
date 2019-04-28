-- 游戏链系统
_G.GameChainSystem = System:DeriveClass("GameChainSystem");

function GameChainSystem:Start()
    self.tbChainList = {};
    self.iChain = nil;
    self.nCurIndex = 0;
    self:StartHandler();
end 

function GameChainSystem:NextProcess(pfn)
    self.tbChainList = {};
    self.iChain = nil;
    self.nCurIndex = 0;
    if pfn then pfn() end;
end

function GameChainSystem:StartHandler()
    self:Trace(3,"GameChainSystem StartHandler you must Implementation !!!")
end

function GameChainSystem:DestoryHandler()
    self:Trace(3,"GameChainSystem DestoryHandler you must Implementation !!!")
end

function GameChainSystem:ExecuteChain(bExecute,onComplete)
    self.nCurIndex = self.nCurIndex + 1;
    if self.nCurIndex > #self.tbChainList then 
        if onComplete then 
            self.nCurIndex = 0;
            self.tbChainList = {};
            self.iChain = nil;
            self.nCurIndex = 0;
            onComplete();
        end
        return;
    end 
    self.iChain = self.tbChainList[self.nCurIndex];
    if self.iChain then 
        self.iChain:Execute(function ()
            if self.iChain then 
                if self.iChain.Complete then 
                    self.iChain:Complete(function()
                        if bExecute then 
                            self:ExecuteChain(bExecute,onComplete)
                        end 
                    end);
                else 
                    if bExecute then 
                        self:ExecuteChain(bExecute,onComplete)
                    end 
                end
            end
        end);
    end
end

function GameChainSystem:CreateChain(nExecuteTime,onExecute,onComplete)
    local sClassName = "Chain"..Origin:SetUniqueID();
    local iChain = Chain:DeriveClass(sClassName, nExecuteTime, onExecute, onComplete);
    table.insert(self.tbChainList,iChain);
end

function GameChainSystem:Destory()
    self.tbChainList = {};
    self.iChain = nil;
    self.nCurIndex = 0;
    Tween:stopAll(); 
    if self.DestoryHandler then 
        self:DestoryHandler();
    end 
end

