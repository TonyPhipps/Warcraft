local UNDERCUT = .97
local DURATION = 3 -- 1, 2, 3 for 12h, 24h, 48h
local PRICEBY = "QUALITY" -- QUALITY or VENDOR

-- PRICE BY QUALITY
-- where 1000 = 1 gold
local POOR_PRICE = 100000
local COMMON_PRICE = 200000
local UNCOMMON_PRICE = 2000000
local RARE_PRICE = 5000000
local EPIC_PRICE = 10000000

-- PRICE BY VENDOR
-- where formula is vendor price * number
local POOR_MULTIPLIER = 20
local COMMON_MULTIPLIER = 30
local UNCOMMMON_MULTIPLIER = 40
local RARE_MULTIPLIER = 50
local EPIC_MULTIPLIER = 60

local STARTING_MULTIPLIER = 0.9

---------END CONFIG---------

local daftAuction = CreateFrame("Frame", "daftAuction", UIParent)

daftAuction:RegisterEvent("AUCTION_HOUSE_SHOW")
daftAuction:RegisterEvent("AUCTION_ITEM_LIST_UPDATE")

local selectedItem
local selectedItemVendorPrice
local selectedItemQuality
local currentPage = 0
local myBuyoutPrice, myStartPrice
local myName = UnitName("player")

daftAuction:SetScript("OnEvent", function(self, event)
	
	if event == "AUCTION_HOUSE_SHOW" then
			
		AuctionsItemButton:HookScript("OnEvent", function(self, event)
			
			if event=="NEW_AUCTION_UPDATE" then -- user placed an item into auction item box
				self:SetScript("OnUpdate", nil)
				myBuyoutPrice = nil
				myStartPrice = nil
				currentPage = 0
				selectedItem = nil
				selectedItem, texture, count, quality, canUse, price, _, stackCount, totalCount, selectedItemID = GetAuctionSellItemInfo();
				local canQuery = CanSendAuctionQuery()
				
				if canQuery and selectedItem then -- query auction house based on item name
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
							
				if PRICEBY == "QUALITY" then
				
					if selectedItemQuality == 0 then myBuyoutPrice = POOR_PRICE end
					if selectedItemQuality == 1 then myBuyoutPrice = COMMON_PRICE end
					if selectedItemQuality == 2 then myBuyoutPrice = UNCOMMON_PRICE end
					if selectedItemQuality == 3 then myBuyoutPrice = RARE_PRICE end
					if selectedItemQuality == 4 then myBuyoutPrice = EPIC_PRICE end
				
				elseif PRICEBY == "VENDOR" then
				
					if selectedItemQuality == 0 then myBuyoutPrice = selectedItemVendorPrice * POOR_MULTIPLIER end
					if selectedItemQuality == 1 then myBuyoutPrice = selectedItemVendorPrice * COMMON_MULTIPLIER end
					if selectedItemQuality == 2 then myBuyoutPrice = selectedItemVendorPrice * UNCOMMMON_MULTIPLIER end
					if selectedItemQuality == 3 then myBuyoutPrice = selectedItemVendorPrice * RARE_MULTIPLIER end
					if selectedItemQuality == 4 then myBuyoutPrice = selectedItemVendorPrice * EPIC_MULTIPLIER end
				end
				
				myStartPrice = myBuyoutPrice * STARTING_MULTIPLIER
			end
			
			local currentPageCount = floor(totalAuctions/50)
			
			for i=1, batch do -- SCAN CURRENT PAGE
				local postedItem, _, count, _, _, _, _, minBid, _, buyoutPrice, _, _, _, owner = GetAuctionItemInfo("list",i)
				
				if postedItem == selectedItem and owner ~= myName then -- selected item matches the one found on auction list
					
					if myBuyoutPrice == nil and myStartPrice == nil then
						myBuyoutPrice = (buyoutPrice/count) * UNDERCUT
						myStartPrice = (minBid/count) * UNDERCUT
						
					elseif myBuyoutPrice > (buyoutPrice/count) then
						myBuyoutPrice = (buyoutPrice/count) * UNDERCUT
						myStartPrice = (minBid/count) * UNDERCUT
					end
				end
			end
			
			if currentPage < currentPageCount then -- GO TO NEXT PAGES
				
				self:SetScript("OnUpdate", function(self, elapsed)
					
					if not self.timeSinceLastUpdate then 
						self.timeSinceLastUpdate = 0 
					end
					self.timeSinceLastUpdate = self.timeSinceLastUpdate + elapsed
					
					if self.timeSinceLastUpdate > .1 then -- a cycle has passed, run this
						selectedItem = GetAuctionSellItemInfo()
						local canQuery = CanSendAuctionQuery()
						
						if canQuery then -- check the next page of auctions
							currentPage = currentPage + 1
							QueryAuctionItems(selectedItem, nil, nil, currentPage)
							self:SetScript("OnUpdate", nil)
						end
						self.timeSinceLastUpdate = 0
					end
				end)
			
			else -- ALL PAGES SCANNED
				self:SetScript("OnUpdate", nil)
				local stackSize = AuctionsStackSizeEntry:GetNumber()
					
				if myStartPrice ~= nil then
						
					if stackSize > 1 then -- this is a stack of items
							
						if UIDropDownMenu_GetSelectedValue(PriceDropDown) == PRICE_TYPE_UNIT then -- input price per item
							MoneyInputFrame_SetCopper(StartPrice, myStartPrice)
							MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice)
							
						else -- input price for entire stack
							MoneyInputFrame_SetCopper(StartPrice, myStartPrice*stackSize)
							MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice*stackSize)
						end
						
					else -- this is not a stack
						MoneyInputFrame_SetCopper(StartPrice, myStartPrice) 
						MoneyInputFrame_SetCopper(BuyoutPrice, myBuyoutPrice)
					end
					
					UIDropDownMenu_SetSelectedValue(DurationDropDown, 3);
				end
					
				myBuyoutPrice = nil
				myStartPrice = nil
				currentPage = 0
				selectedItem = nil
			end
		end
	end
end)





