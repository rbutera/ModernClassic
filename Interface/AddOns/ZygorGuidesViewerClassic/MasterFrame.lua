local ZGV=ZygorGuidesViewer
if not ZGV then return end

function ZygorGuidesViewerFrameMaster_OnUpdate(self,elapsed)
	if ZGV.loading and ZGV.db and ZGV.db.char.maint_dostartup then
		ZGV:StartupStep()
		ZGV:UpdateFrame(true)
	end
end
