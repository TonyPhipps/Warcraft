local addonName, addonTable = ... 
local addon = CreateFrame("Frame")

addon:RegisterEvent("AUCTION_HOUSE_SHOW")
addon:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_UPDATED")
addon:RegisterEvent("AUCTION_HOUSE_BROWSE_RESULTS_ADDED")
addon:RegisterEvent("AUCTION_HOUSE_NEW_RESULTS_RECEIVED")

local selectedItem
local selectedItemVendorPrice
local selectedItemQuality
local currentPage = 0
local myBuyoutPrice, myStartPrice
local myName = UnitName("player")

addon:SetScript("OnEvent", function(self, event)
	
	if event == "AUCTION_HOUSE_SHOW" then
	print("AUCTION_HOUSE_SHOW")
			
		C_AuctionHouse.AuctionsItemButton:HookScript("OnEvent", function(self, event)
			
			if event=="NEW_AUCTION_UPDATE" then
				
				self:SetScript("OnUpdate", nil)
				
				myBuyoutPrice = nil
				myStartPrice = nil
				currentPage = 0
				selectedItem = nil
				selectedItem, texture, count, quality, canUse, price, _, stackCount, totalCount, selectedItemID = GetAuctionSellItemInfo()
				
				local canQuery = CanSendAuctionQuery()
				
				if canQuery and selectedItem then -- run a new search
					
					ResetCursor()
					QueryAuctionItems(selectedItem)
				end
			end
		end)

	elseif event == "AUCTION_ITEM_LIST_UPDATE" then -- the auction list was updated or sorted
		
		if (selectedItem ~= nil) then -- an item was placed in the auction item box
			
			local batch, totalAuctions = GetNumAuctionItems("list")
			
			if totalAuctions == 0 then -- No matches
				
				_, _, selectedItemQuality, selectedItemLevel, _, _, _, _, _, _, selectedItemVendorPrice = GetItemInfo(selectedItem)
									
				if selectedItemQuality == 0 then myBuyoutPrice = selectedItemVendorPrice * addonTable.POOR_MULTIPLIER end
				if selectedItemQuality == 1 then myBuyoutPrice = selectedItemVendorPrice * addonTable.COMMON_MULTIPLIER end
				if selectedItemQuality == 2 then myBuyoutPrice = selectedItemVendorPrice * addonTable.UNCOMMMON_MULTIPLIER end
				if selectedItemQuality == 3 then myBuyoutPrice = selectedItemVendorPrice * addonTable.RARE_MULTIPLIER end
				if selectedItemQuality == 4 then myBuyoutPrice = selectedItemVendorPrice * addonTable.EPIC_MULTIPLIER end
				
				myStartPrice = myBuyoutPrice
			end
			
			local PageCount = floor(totalAuctions/50)
			
			for i=1, batch do -- Scan current page of items
				
				local postedItem, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, owner = GetAuctionItemInfo("list",i)
				
				if postedItem == selectedItem and owner ~= myName and buyoutPrice ~= nil then -- calculate lowest price
					
					if myBuyoutPrice == nil and myStartPrice == nil then
						
						myBuyoutPrice = (buyoutPrice/count) * addonTable.UNDERCUT
						myStartPrice = (minBid/count) * addonTable.UNDERCUT
					
					elseif myBuyoutPrice > (buyoutPrice/count) then
						
						myBuyoutPrice = (buyoutPrice/count) * addonTable.UNDERCUT
						myStartPrice = (minBid/count) * addonTable.UNDERCUT
					end
				end
			end
			
			if currentPage < PageCount then -- some pages remain
				
				self:SetScript("OnUpdate", function(self, elapsed) -- Crude while loop based on elapsed

					if not self.timeSinceLastUpdate then 
						
						self.timeSinceLastUpdate = 0 
					end

					self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed -- increment timer
					
					if self.timeSinceLastUpdate > .1 then -- .1sec, probably safe to query again
						
						selectedItem = GetAuctionSellItemInfo()
						local canQuery = CanSendAuctionQuery()
						
						if canQuery then -- can query next page
							
							currentPage = currentPage + 1
							QueryAuctionItems(selectedItem, nil, nil, currentPage)

							self:SetScript("OnUpdate", nil) -- end of crude while loop
						end
						
						self.timeSinceLastUpdate = 0
					end
				end)
			
			else -- ALL PAGES SCANNED
				
				self:SetScript("OnUpdate", nil) -- cleanup of crude while loop

				local stackSize = AuctionsStackSizeEntry:GetNumber()
					
				if myStartPrice ~= nil then -- we have enough to start an auction
						
					if stackSize > 1 then -- this is a stack of items
							
						if UIDropDownMenu_GetSelectedValue(PriceDropDown) == 1 then -- input price per item
							MoneyInputFrame_SetCopper(StartPrice, myStartPrice)
							MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice)
							
						else -- input price for entire stack
							MoneyInputFrame_SetCopper(StartPrice, myStartPrice * stackSize)
							MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice * stackSize)
						end
						
					else -- this is not a stack
						
						MoneyInputFrame_SetCopper(StartPrice, myStartPrice)
						MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice)
					end
					
					if UIDropDownMenu_GetSelectedValue(DurationDropDown) ~= 3 then 
						
						UIDropDownMenu_SetSelectedValue(DurationDropDown, 3) -- set duration to 3 (48h)
						DurationDropDownText:SetText("48 Hours") -- set duration text since it keeps bugging to "Custom"
					end
				end
					
				myBuyoutPrice = nil
				myStartPrice = nil
				currentPage = 0
				selectedItem = nil
				stackSize = nil
			end
		end
	end
end)





