_G.AssetsMgr = Class:DeriveClass("AssetsMgr");
 
AssetsMgr.tbMedia = {images = {}, sounds = {}, fonts = {}};

function AssetsMgr:GetTexture(sImage)
    return self.tbMedia.images[sImage];
end 

function AssetsMgr:GetFont(nFont)
    return self.tbMedia.fonts[nFont];
end 

function AssetsMgr:GetSound(sSound)
    return self.tbMedia.sounds[sSound];
end
