local addonName, addonTable = ... 
daftUITweaks = {}
daftUITweaks.addonName = addonName

---- HELPER FUNCTIONS ----

function daftUITweaks:FadeFramesIn(frames)
	for i, addon in next, frames do
		local thisFrame = _G[addon]
		
		if thisFrame:IsShown() then
			UIFrameFadeIn(thisFrame, .5, thisFrame:GetAlpha(), 1)
		end
	end
end


function daftUITweaks:FadeFramesOut(frames)
	for i, addon in next, frames do
		local thisFrame = _G[addon]
		
		if thisFrame:IsShown() then
			UIFrameFadeOut(thisFrame, .5, thisFrame:GetAlpha(), 0)
		end
	end
end


function daftUITweaks:FadeFrames(frames)
	
	for i, addon in next, frames do
		local thisFrame = _G[addon]
		
		thisFrame:HookScript("OnEnter", function()
			addon:FadeFramesIn(frames)
		end)

		WorldFrame:HookScript("OnEnter", function()
			addon:FadeFramesOut(frames)
		end)
	end
end