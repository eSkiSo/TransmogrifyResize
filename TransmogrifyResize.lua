
local f, events = CreateFrame("Frame"), {};

-- Use TRANSMOG_COLLECTION_UPDATED event to be sure WardrobeFrame is not nil, as can still be nil on TRANSMOGRIFY_OPEN!
f:RegisterEvent("TRANSMOG_COLLECTION_UPDATED") -- *NOT 'TRANSMOGRIFY_OPEN'!*  https://warcraft.wiki.gg/wiki/Events#Transmogrify

f:SetScript("OnEvent", function(self, event, ...)
    -- No need to check for which event before calling resize function;
    -- just only listening for the one we want.
    TransmogResize_ResizeTransmogrify(TransmogResize_FrameWidth, TransmogResize_FrameHeight)
end)

SLASH_TRANSMOGRESIZE1 = "/tmr"
SLASH_TRANSMOGRESIZE2 = "/transmogresize"
SLASH_TRANSMOGRESIZE3 = "/transmogrifyresize"
SLASH_TRANSMOGRESIZE4 = "/transmogrifierresize"
function SlashCmdList.TRANSMOGRESIZE(msg)
    if ( (msg == "help") or (not msg) or (msg:gsub("%s+", "") == "") ) then
        print("\n")
        print("Transmogrify Resize")
        print("  Type '/tmr reset' to reset the size of the Transmogrifier window.")
        print("  Type '/tmr help' (or just '/tmr') for this help information.")
        print("\n")
    elseif msg == "reset" then
        TransmogResize_FrameWidth = nil
        TransmogResize_FrameHeight = nil
        TransmogResize_ResizeTransmogrify(TransmogResize_FrameWidth, TransmogResize_FrameHeight)
        print("Transmogrify Resize - Transmogrifier's window size has been reset!")
    end
end

local isAddedResize = false

function TransmogResize_ResizeTransmogrify(frameWidth, frameHeight)

    -- Doing this check as event TRANSMOG_COLLECTION_UPDATED gets called
    -- when char loads into World, before being at transmog npc window.
    if not C_Transmog.IsAtTransmogNPC() then return end

    if not frameWidth then
        frameWidth = GetScreenWidth() - 460;   -- 1462
    end
    TransmogResize_FrameWidth = frameWidth

    if not frameHeight then
        frameHeight = GetScreenHeight() - 240; -- 841
    end
    TransmogResize_FrameHeight = frameHeight

    local modelSceneWidth = TransmogResize_FrameWidth - 662; -- 800
    local modelSceneHeight = TransmogResize_FrameHeight - 111; -- 730

    WardrobeFrame:SetWidth(TransmogResize_FrameWidth);
    WardrobeFrame:SetHeight(TransmogResize_FrameHeight);
    WardrobeTransmogFrame.ModelScene:SetWidth(modelSceneWidth);
    WardrobeTransmogFrame:SetWidth(modelSceneWidth);
    WardrobeTransmogFrame:SetHeight(modelSceneHeight);
    WardrobeTransmogFrame.ModelScene:SetHeight(modelSceneHeight);
    WardrobeTransmogFrame.Inset.BG:SetWidth(modelSceneWidth);
    WardrobeTransmogFrame.Inset.BG:SetHeight(modelSceneHeight);
    WardrobeTransmogFrame.HeadButton:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"LEFT", 15, 100);
    WardrobeTransmogFrame.HandsButton:SetPoint("TOPRIGHT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", -15, 0);
    WardrobeTransmogFrame.MainHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", -50, 15);
    WardrobeTransmogFrame.SecondaryHandButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 50, 15);
    WardrobeTransmogFrame.MainHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
    WardrobeTransmogFrame.SecondaryHandEnchantButton:SetPoint("BOTTOM", WardrobeTransmogFrame.ModelScene,"BOTTOM", 100, 20);
    WardrobeTransmogFrame.ToggleSecondaryAppearanceCheckbox:SetPoint("LEFT", WardrobeTransmogFrame.ModelScene,"TOPRIGHT", 50, -200);
    WardrobeFrame:ClearAllPoints();
    WardrobeFrame:SetPoint("CENTER", UIParent ,"CENTER",0,0);

    if not isAddedResize then
        local resizeButton = CreateFrame("Button", nil, WardrobeFrame)
        resizeButton:SetSize(16, 16)
        resizeButton:SetPoint("BOTTOMRIGHT")
        resizeButton:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Up")
        resizeButton:SetHighlightTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Highlight")
        resizeButton:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIM-SizeGrabber-Down")

        resizeButton:SetScript("OnMouseDown", function(self, button)
        WardrobeFrame:SetResizable(true)
        WardrobeFrame:StartSizing("BOTTOMRIGHT")
        WardrobeFrame:SetUserPlaced(true)

        end)

        resizeButton:SetScript("OnMouseUp", function(self, button)
        WardrobeFrame:StopMovingOrSizing()
        local newWidth = WardrobeFrame:GetWidth()
        local newHeight = WardrobeFrame:GetHeight()
        TransmogResize_ResizeTransmogrify(newWidth, newHeight);
        end)

        isAddedResize = true
    end

    -- WardrobeFrame:SetUserPlaced(true);
end
