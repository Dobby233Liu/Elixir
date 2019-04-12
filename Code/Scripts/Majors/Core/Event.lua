
_G.Event = {}; 

function Event:AddEvent(tbDistributor,tbListener)
    tbDistributor.tbListenerList[tbListener.sClassName] = tbListener;
end 

function Event:RemoveEvent(tbListener,tbDistributor)
    tbDistributor.tbListenerList[tbListener.sClassName] = nil;
end  

function Event:DoEvent(tbDistributor,sFuncName,...)
    local args = {...}; 
    for _,tbListener in pairs(tbDistributor.tbListenerList) do 
        local funcEvent = tbListener[sFuncName];
        if funcEvent ~= nil then 
            local r,_ = pcall(funcEvent,tbListener,unpack(args));
            if r == false then
                return error(string.format("%s DoEvent Failed %s",r));
            end
        end 
    end 
end 

function Event:QueryEvent(tbDistributor,sClassName) 
    return tbDistributor.tbListenerList[sClassName] ~= nil ;
end 