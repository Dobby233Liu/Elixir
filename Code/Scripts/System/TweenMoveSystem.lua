_G.TweenMoveSystem = System:DeriveClass("TweenMoveSystem");

TweenMoveSystem.tbDataPlayer = {x = 0,y = 0};
TweenMoveSystem.tbPath = nil;

TweenMoveSystem.tweenType = "outQuad";

TweenMoveSystem:SetRegisterCompo{

};

function TweenMoveSystem:SearchPathComplete(iActor,tbPath,pfn,nSpeed,tweenType)
    self.tbPath = tbPath;
    self.pfn = pfn;
    self.iActor = iActor;
    self.nSpeed = nSpeed or 0.4;
    self.tweenType = tweenType or "outQuad";
    table.remove(self.tbPath,#self.tbPath);
    self:MoveHandler(self:GetNextNode());
end

function TweenMoveSystem:MoveHandler(iTargetNode)
    if iTargetNode == nil then 
        if self.pfn then 
            self.pfn();
            return;
        end 
        return;
    end 
    if self.iActor == nil then 
        if self.pfn then 
            self.pfn();
            return;
        end 
        return;
    end 
    local iActor = self.iActor;
    local pw = iActor:GetiCompo("Transform").w;
    local ph = iActor:GetiCompo("Transform").h;
    local px = iActor:GetiCompo("Transform").x;
    local py = iActor:GetiCompo("Transform").y;
    local nx,ny = iTargetNode.x,iTargetNode.y;
    local nCellSize = iTargetNode.nCellSize;
    local nNCol,nNRow = math.floor(nx/nCellSize),math.floor(ny/nCellSize);
    local ox,oy = nNCol * nCellSize,nNRow * nCellSize;
    local tbPos = { x = ox, y = oy };
    -- Tween.start(self.nSpeed,iActor:GetiCompo("Transform"),{ x = ox,y = oy },self.tweenType,function ()
    Tween(self.nSpeed,iActor:GetiCompo("Transform"),{ x = ox,y = oy },self.tweenType,function ()
        self:MoveHandler(self:GetNextNode());
    end)
end 

function TweenMoveSystem:GetNextNode()
    local nNextNode = self.tbPath[#self.tbPath];
    table.remove(self.tbPath,#self.tbPath);
    return nNextNode;
end