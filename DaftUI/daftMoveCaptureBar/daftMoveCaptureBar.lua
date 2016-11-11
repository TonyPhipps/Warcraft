local addonName, addonTable = ... ;

hooksecurefunc('WorldStateAlwaysUpFrame_OnLoad', function()
	WorldStateCaptureBar1:SetScript("OnShow", function(self, event, ...)
		WorldStateCaptureBar1:ClearAllPoints();
		WorldStateCaptureBar1:SetPoint("TOP", UIParent, "TOP");
		WorldStateCaptureBar1.SetPoint = function() end;
	end);
end);