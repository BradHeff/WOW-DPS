local ZygorGuidesViewer=ZygorGuidesViewer
if not ZygorGuidesViewer then return end
ZygorGuidesViewer.Gold.guides_loaded=true
if ZGV:DoMutex("GoldFarmC") then return end
ZygorGuidesViewer.GuideMenuTier = "TRI"
ZygorGuidesViewer:RegisterGuidePlaceholder("GOLD\\Farming\\Linen Cloth")
