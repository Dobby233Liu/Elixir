_G.LayerSortSystem = System:DeriveClass("LayerSortSystem");

LayerSortSystem:SetRegisterCompo{
   "RenderLayer","Transform"
}

function LayerSortSystem:Update(dt)
    if Option.sGameType == GameType.Roguelike then 
        self:RogueLikeSortHandler();
    else -- 默认使用Rogue渲染层级
        self:RogueLikeSortHandler();
    end
end

function LayerSortSystem:RogueLikeSortHandler()
    local iStage = self:GetCurScene():GetCurStage();
    table.sort(iStage:GetActorList(), function(a,b)
        if a ~= nil and b ~= nil then 
            local ay = a:GetiCompo("Transform").y + a:GetiCompo("Transform").h;
            local by = b:GetiCompo("Transform").y + b:GetiCompo("Transform").h;
            if ay == by then 
                by = by - 1
            end
            return ay < by;
        end
    end) 
end