local Map = {};

function Map:Create(sClassName)

   local obj = Actor:DeriveClass(sClassName);

   return obj;

end

return Map;