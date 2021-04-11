
local f, events = CreateFrame("Frame"), {};
f:RegisterEvent("TRANSMOGRIFY_OPEN")
--f:RegisterAllEvents();

f:SetScript("OnEvent", function(self,event, ...)
    if event == "TRANSMOGRIFY_OPEN" then
        -- print("Improving Transmog window...")
        ResizeTransmogrify();
    end  
end)

function ResizeTransmogrify()
    local frameWidth = GetScreenWidth() - 460;   -- 1462
    local frameHeight = GetScreenHeight() - 240; -- 841
    local modelSceneWidth = frameWidth - 662; -- 800
    local modelSceneHeight = frameHeight - 111; -- 730
    WardrobeFrame:SetWidth(frameWidth);
    WardrobeFrame:SetHeight(frameHeight);
    WardrobeTransmogFrame.ModelScene:SetWidth(modelSceneWidth);
    WardrobeTransmogFrame:SetWidth(modelSceneWidth);
    WardrobeTransmogFrame:SetHeight(modelSceneHeight);
    WardrobeTransmogFrame.ModelScene:SetHeight(modelSceneHeight);
    WardrobeTransmogFrame.Inset.BG:SetWidth(modelSceneWidth);
    WardrobeTransmogFrame.Inset.BG:SetHeight(modelSceneHeight);
    WardrobeTransmogFrame.ModelScene.HeadButton:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"LEFT", 0, 100);
    WardrobeTransmogFrame.ModelScene.HandsButton:SetPoint("TOPRIGHT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", -15, 0);
    WardrobeTransmogFrame.ModelScene.MainHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", -50, 15);
    WardrobeTransmogFrame.ModelScene.SecondaryHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 50, 15);
    WardrobeTransmogFrame.ModelScene.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
    WardrobeTransmogFrame.ModelScene.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
    WardrobeFrame:ClearAllPoints();
    WardrobeFrame:SetPoint("CENTER", UIParent ,"CENTER",0,0);
    -- WardrobeFrame:SetUserPlaced(true);
end

