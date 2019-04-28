local Tile = {};

function Tile:Create(sClassName)

   local obj = Actor:DeriveClass(sClassName);

   return obj;

end

return Tile;