local Enemy = {};

function Enemy:Create(sClassName)

   local obj = Actor:DeriveClass(sClassName);

   return obj;

end

return Enemy;