local daftSellGreys = CreateFrame("Frame")

daftSellGreys:RegisterEvent("MERCHANT_SHOW")
	
daftSellGreys:SetScript("OnEvent", function()
	for bag = 0, 4 do
		
		for slot = 1, GetContainerNumSlots(bag) do
			local _, _, locked, _, _, _, link = GetContainerItemInfo(bag, slot)
			
			if link ~= nil then
				local _, _, Quality = GetItemInfo(link)
				
				if Quality == 0 and not locked then
					UseContainerItem(bag, slot)
				end
			end
		end
	end
end)