-- Minimal in-game UI scaffold to open the Registry/Savegame editor

function draw()
	UiPush()
		UiAlign("right top")
		UiTranslate(UiWidth()-16, 16)
		UiFont("regular.ttf", 20)
		UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 1, 1, 0.7)
		if UiTextButton("Registry / Savegame Editor", 260, 36) then
			if ModManager and ModManager.OpenRegistryEditor then
				ModManager.OpenRegistryEditor()
			end
		end
	UiPop()

	-- Render popups/modals (reuses the exact same editor UI)
	if drawPopElements then
		drawPopElements()
	end
end
