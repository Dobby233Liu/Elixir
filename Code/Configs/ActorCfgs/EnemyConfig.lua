local EnemyConfig = 
{
    ['Transform'] = {};
    ["Color"] = { r = 1, g = 1, b = 1,a = 1 };
    ['RenderLayer'] = { nLayerIndex = RenderLayerType.nPlayer };
    ["Render"] = {};
    ["Attribute"] = {};
    -- ['Rectangle'] = { sFillType = 'fill'};
    ["Animate"] = { sImg = "hero_ani_2", nQuadW = 100, nQuadH = 100, nTotalFrame= 4, nLoop = 1, nTotalPlayCount = 10,nTimeAfterPlay = 0.1 };
    -- ["Sprite"] = { sImg = "hero_1"};
}
return EnemyConfig