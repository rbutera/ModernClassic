--ZYGORGUIDESVIEWERFRAME_TITLE = "Zygor Guides Viewer";
ZYGORGUIDESVIEWERFRAME_TITLE = " ";

local ZGV = ZygorGuidesViewer

function ZygorGuidesViewerFrame_OnLoad()
end

function ZygorGuidesViewerFrame_OnHide()
	ZGV:Frame_OnHide();
end

function ZygorGuidesViewerFrame_OnLoad()
	--
end

function ZygorGuidesViewerFrame_OnShow()
	ZGV:Frame_OnShow();
end

function ZygorGuidesViewerFrame_Update()
	if ZGV then ZGV:UpdateMainFrame() end
end

function ZygorGuidesViewerFrame_HighlightCurrentStep()
	if ZygorGuidesViewer.CurrentStep then ZygorGuidesViewer:HighlightCurrentStep() end
end