local ExitTile = {};

function ExitTile:Create(sClassName)

   local obj = Actor:DeriveClass(sClassName);

   return obj;

end

return ExitTile;