local addonName, addonTable = ... 
daftUITweaks = {}
daftUITweaks.addonName = addonName

---- HELPER FUNCTIONS ----

function daftUITweaks:FadeFramesIn(frames)
	for i, frame in next, frames do
		local thisFrame = _G[frame]
		
		if thisFrame:IsShown() then
			UIFrameFadeIn(thisFrame, .5, thisFrame:GetAlpha(), 1)
		end
	end
end


function daftUITweaks:FadeFramesOut(frames)
	for i, frame in next, frames do
		local thisFrame = _G[frame]
		
		if thisFrame:IsShown() then
			UIFrameFadeOut(thisFrame, .5, thisFrame:GetAlpha(), 0)
		end
	end
end


function daftUITweaks:FadeFrames(frames)
	
	for i, frame in next, frames do
		local thisFrame = _G[frame]
		
		thisFrame:HookScript("OnEnter", function()
			frame:FadeFramesIn(frames)
		end)

		WorldFrame:HookScript("OnEnter", function()
			frame:FadeFramesOut(frames)
		end)
	end
end