_G.PlayerTweenMoveSystem = System:DeriveClass("PlayerTweenMoveSystem");

PlayerTweenMoveSystem.tbDataPlayer = {x = 0,y = 0};
PlayerTweenMoveSystem.tbPath = nil;

PlayerTweenMoveSystem.tweenType = "outQuad";

PlayerTweenMoveSystem:SetRegisterCompo{

};

function PlayerTweenMoveSystem:SearchPathComplete(tbPath,pfn)
    self.tbPath = tbPath;
    self.pfn = pfn;
    table.remove(self.tbPath,#self.tbPath);
    self:MoveHandler(self:GetNextNode());
end

function PlayerTweenMoveSystem:MoveHandler(iTargetNode)
    if iTargetNode == nil then 
        if self.pfn then 
            self.pfn();
            return;
        end 
        return;
    end 
    local iPlayer = ActorMgr:GetActor("player1");
    local pw = iPlayer:GetiCompo("Transform").w;
    local ph = iPlayer:GetiCompo("Transform").h;
    local px = iPlayer:GetiCompo("Transform").x;
    local py = iPlayer:GetiCompo("Transform").y;
    local nx,ny = iTargetNode.x,iTargetNode.y;
    local nCellSize = iTargetNode.nCellSize;
    local nNCol,nNRow = math.floor(nx/nCellSize),math.floor(ny/nCellSize);
    local ox,oy = nNCol * nCellSize,nNRow * nCellSize ;
    local tbPos = { x = ox, y = oy }
    Tween.start(0.4,iPlayer:GetiCompo("Transform"),{ x = ox,y = oy },self.tweenType,function ()
        self:MoveHandler(self:GetNextNode());
    end)
end 

function PlayerTweenMoveSystem:GetNextNode()
    local nNextNode = self.tbPath[#self.tbPath];
    table.remove(self.tbPath,#self.tbPath);
    return nNextNode;
end

function PlayerTweenMoveSystem:InterruptMove()

end