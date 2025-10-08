#include "ui_extensions.lua"
#include "ui_helpers.lua"
#include "buttons.lua"
#include "game.lua"

#include "mod_manager_locLang.lua"


function locLangReset()
	locLang = locLang or {}
	locLang.INDEX =						0
	locLang.new = 						"New"
	-- Additional dynamic strings (English fallback) for added features
	locLang.hasPreview =              "Has Preview"
	locLang.hideInactive =            "Hide Inactive"
	locLang.orphaned =                "Orphaned"
	locLang.sizeFilter =              ">= Size"
	locLang.integrityScan =           "Integrity Scan"
	locLang.conflictScan =            "Conflict Scan"
	locLang.backup =                  "Backup"
	locLang.restore =                 "Restore"
	locLang.exportMeta =              "Export Meta"
	locLang.savedSearches =           "Saved Searches"
	locLang.addSavedSearch =          "Save Current"
	locLang.deleteSavedSearch =       "Delete"
	locLang.applySavedSearch =        "Apply"
	locLang.searchAdvancedHint =      "Advanced: tag:foo author:bar -active size:>100KB updated:<7d"
	locLang.renameMod =               "Rename Mod"
	locLang.renameApply =             "Apply Rename"
	locLang.editTags =                "Edit Tags"
	locLang.saveTags =                "Save Tags"
	locLang.scanResults =             "Scan Results"
	locLang.noIssuesFound =           "No issues found"
	locLang.previewMissing =          "Missing preview"
	locLang.descMissing =             "Missing description"
	locLang.duplicateName =           "Duplicate name"
	locLang.backupDone =              "Backup created"
	locLang.restoreDone =             "Restore completed"
	locLang.metaCopied =              "Metadata exported (copy manually)"
	locLang.savegameBrowser =         "Savegame Data"
	locLang.close =                   "Close"
	locLang.sizeUnit =                "KB"
	locLang.filterApplied =           "Filter Applied"
	locLang.rename = 					"Rename"
	locLang.duplicate = 				"Duplicate"
	locLang.delete = 					"Delete"
	locLang.enableAll = 				"Enable all"
	locLang.disableAll = 				"Disable all"
	locLang.modsRefreshed = 			"Mods Refreshed"
	locLang.renameCol = 				"[rename]"
	locLang.searchMod = 				"[search mod]"
	locLang.newCol = 					"[new collection]"
	locLang.collection = 				"Collection"
	locLang.delColConfirm = 			"Are you sure you want to delete this collection?"
	locLang.disableModsColAsk = 		"Do you want to disable all unlisted mods at the same time?"
	locLang.applyCol = 					"Apply collection"
	locLang.disuseCol = 				"Disuse collection"
	locLang.errorColShort = 			"Name too short, min 3 charactors"
	locLang.errorColLong = 				"Name too long, max 20 charactors"
	locLang.settings = 					"Settings"
	locLang.setting1 = 					"Built-in mod path"
	locLang.setting2 = 					"Workshop mod path"
	locLang.setting3 = 					"Initial category"
	locLang.setting4 = 					"Remember last selected mod"
	locLang.setting4ex = 				"overwrite previous"
	locLang.setting5 =					"Reset filter when changing mod category"
	locLang.setting6 =					"Fold author list by default"

					-- Extra filters & maintenance row
					UiTranslate(0, 10)
					UiFont("bold.ttf", 24)
					UiColor(1,1,1)
					UiText("Advanced Filters & Tools")
					UiTranslate(0, 34)
					UiFont("regular.ttf", 20)
					local btnW, btnH, btnGap = 170, 30, 12
					UiButtonImageBox("ui/common/box-outline-4.png",4,4,1,1,1,0.7)
					local function toggleButton(label, state)
						UiPush()
							if state then UiColor(0.7,1,0.7) else UiColor(0.85,0.85,0.85) end
							if UiTextButton(label, btnW, btnH) then return not state end
						UiPop()
						UiTranslate(btnW+btnGap,0)
						return state
					end
					gExtraFilters.hasPreview = toggleButton(locLang.hasPreview, gExtraFilters.hasPreview)
					gExtraFilters.hideInactive = toggleButton(locLang.hideInactive, gExtraFilters.hideInactive)
					gExtraFilters.orphanedOnly = toggleButton(locLang.orphaned, gExtraFilters.orphanedOnly)
					UiPush()
						UiColor(0.85,0.85,0.85)
						UiAlign("left middle")
						UiTranslate(0, btnH+12)
						UiText(locLang.sizeFilter..": ")
						UiTranslate(120, -btnH/2)
						UiFont("regular.ttf", 18)
						local sizeStr = tostring(math.floor(gExtraFilters.sizeThreshold/1024))
						local newSize, typing = UiTextInput(sizeStr, 100, btnH, true)
						if newSize ~= sizeStr then
							local num = tonumber(newSize) or 0
							gExtraFilters.sizeThreshold = num*1024
							if gSearchText ~= "" then updateSearch() end
						end
					UiPop()
					UiTranslate(0, btnH+60)
					UiFont("bold.ttf", 24)
					UiText("Maintenance")
					UiTranslate(0, 34)
					UiFont("regular.ttf", 20)
					local function actionButton(label, fn)
						UiPush()
							UiColor(0.9,0.9,0.9)
							if UiTextButton(label, btnW, btnH) then fn() end
						UiPop()
						UiTranslate(btnW+btnGap,0)
					end
					actionButton(locLang.integrityScan, runIntegrityScan)
					actionButton(locLang.conflictScan, runConflictScan)
					actionButton(locLang.backup, createBackup)
					UiTranslate(-(btnW+btnGap)*3, btnH+12)
					actionButton(locLang.restore, restoreBackup)
					actionButton(locLang.exportMeta, exportMetadata)
					UiTranslate(-(btnW+btnGap)*2, btnH+20)
					UiFont("regular.ttf", 18)
					UiColor(0.8,0.8,0.8)
					UiWordWrap(600)
					UiText(locLang.searchAdvancedHint)
	locLang.cateLocalShort =			"Local"
	locLang.cateWorkshopShort =			"Workshop"
	locLang.cateBuiltInShort =			"Built-in"
	locLang.filterModeAlphabet =		"Alphabetical"
	locLang.filterModeUpdate =			"Updated"
	locLang.filterModeSubscribe =		"Subscribed"
	locLang.modSavegameSpace =			"Savegame Space: "
	locLang.clearModData =				"This mod occupied %d B in savegame file. Do you want to clear it?"
	locLang.clearUnknownData =			"Unknown mods (e.g.: deleted) occupied %d B in savegame file in total. Do you want to clear them?"
	locLang.tooltipClearUnknownData =	"Clean-up unknown savegame data"
	locLang.tooltipChooseRandomMod =	"Select a random mod from \"%s\" list"
	locLang.tooltipRefresh =			"Refresh"
	locLang.collectEnabledToColAsk =	"Do you want to remove all disabled/other mods from collection at the same time?"
	locLang.collectEnabled =			"Collect all enabled"
	locLang.unitBytes =					"B"
	locLang.unitKiloBytes =				"KB"
	locLang.unitMegaBytes =				"MB"
	locLang.unitGigaBytes =				"GB"
	locLang.characterEnableHint =		"View in [[game://characters/;label=loc@UI_BUTTON_CHATACTER;id=game;]] menu"
end

function updateLocLangStr()
	UiPush()
		locLangReset()

		local pouncStr = GetTranslatedStringByKey("UI_TEXT_TAGS")
		local pouncStrLen = UiGetSymbolsCount(pouncStr)
		locLangStrAuthor = GetTranslatedStringByKey("UI_TEXT_AUTHOR")..UiTextSymbolsSub(pouncStr, pouncStrLen, pouncStrLen)
		locLangStrUpdateAt = GetTranslatedStringByKey("UI_TEXT_UPDATED").." "
		locLangStrWorkshopID = GetTranslatedStringByKey("UI_TEXT_WORKSHOP_ID").." "
		locLangStrByAuthor = GetTranslatedStringByKey("UI_TEXT_BY")..UiTextSymbolsSub(pouncStr, pouncStrLen, pouncStrLen).." "
		locLangStrModTags = pouncStr.." "

		local langIndex = UiGetLanguage()+1
		for locStrKey, locStrVal in pairs(locLangLookup) do
			repeat
				if not locLang[locStrKey] then break end
				if not locStrVal then break end
				if not locStrVal[langIndex] then break end
				locLang[locStrKey] = locStrVal[langIndex]
			until true
		end

		errorData = {
			Code = 0,
			Show = false,
			Fade = 1,
			List = {
				nil,
				locLang.errorColShort,
				locLang.errorColLong
			}
		}
		categoryTextLookup = {
			locLang.cateBuiltInShort,
			locLang.cateWorkshopShort,
			locLang.cateLocalShort
		}
		optionSettings = {
			{title = locLang.setting2,	key = "showpath.2", 	type = "bool"},
			{title = locLang.setting3,	key = "startcategory",	type = "drop", 	dropdown = categoryTextLookup},
			{title = locLang.setting4,	key = "rememberlast",	type = "bool",	note = locLang.setting4ex},
			{title = locLang.setting5,	key = "resetfilter",	type = "bool"},
			{title = locLang.setting6,	key = "foldauthor",		type = "bool"}
		}
		gMods = gMods or {}
		for i=1, 3 do gMods[i]= gMods[i] or {} end
		gMods[1].title = locLang.cateBuiltInShort
		gMods[2].title = locLang.cateWorkshopShort
		gMods[3].title = locLang.cateLocalShort
		filterCategoryText = {
			"loc@UI_BUTTON_ALL",
			locLang.new,
			"loc@UI_BUTTON_GLOBAL",
			"loc@UI_BUTTON_CONTENT",
			"loc@UI_BUTTON_ENABLED"
		}
		filterSortText = {
			locLang.filterModeAlphabet,
			"loc@UI_TEXT_AUTHOR",
			locLang.filterModeUpdate,
			locLang.filterModeSubscribe
		}
		byteUnitSuffix = {
			[0] = locLang.unitBytes,
			[1] = locLang.unitKiloBytes,
			[2] = locLang.unitMegaBytes,
			[3] = locLang.unitGigaBytes,
		}
		byteUnitFormat = {
			[0] = "%d %s",
			[1] = "%.2f %s",
			[2] = "%.2f %s",
			[3] = "%.2f %s"
		}

		UiFont("regular.ttf", 22)
		contextMenu.MenuWidth = {
			-- collection listing
			collectionW = UiMeasureText(0, locLang.rename, locLang.duplicate, locLang.delete, locLang.applyCol, locLang.disuseCol, locLang.collectEnabled) + 24,
			-- collected mods
			colModsW = UiMeasureText(0, locLang.enableAll, locLang.disableAll, locLang.collectEnabled) + 24,
			-- common listing
			listCommonW = UiMeasureText(0, "loc@UI_TEXT_DISABLE_ALL") + 24,
			-- workshop listing
			listWorkshopW = UiMeasureText(0, "loc@UI_TEXT_UNSUBSCRIBE", "loc@UI_TEXT_DISABLE_ALL") + 24,
			-- local listing
			listLocalW = UiMeasureText(0, "loc@UI_TEXT_NEW_GLOBAL", "loc@UI_TEXT_NEW_CONTENT", "loc@UI_TEXT_DISABLE_ALL") + 24,
			-- local selected listing
			listLocalSelW = UiMeasureText(0, "loc@UI_TEXT_NEW_GLOBAL", "loc@UI_TEXT_NEW_CONTENT", "loc@UI_TEXT_DUPLICATE_MOD", "loc@UI_TEXT_DELETE_MOD", "loc@UI_TEXT_DISABLE_ALL") + 24,
			-- search listing
			listSearchW1 = UiMeasureText(0, "loc@UI_TEXT_UNSUBSCRIBE", "loc@UI_TEXT_NEW_GLOBAL", "loc@UI_TEXT_NEW_CONTENT", "loc@UI_BUTTON_MAKE_LOCAL", "loc@UI_TEXT_DELETE_MOD") + 24,
			listSearchW2 = UiMeasureText(0, "loc@UI_TEXT_UNSUBSCRIBE", "loc@UI_TEXT_NEW_GLOBAL", "loc@UI_TEXT_NEW_CONTENT", "loc@UI_TEXT_DUPLICATE_MOD", "loc@UI_TEXT_DELETE_MOD") + 24
		}

		gPublishLangIndex = locLang.INDEX
	UiPop()
end

contextMenu = {
	Show = false,
	Type = 1,
	IsCollection = false,
	PosX = 0,
	PosY = 0,
	Scale = 0,
	Item = nil,
	GetMousePos = false
}

contextMenu.Collection = function(sel_collect)
	if sel_collect == "" then return false end
	gSearchClick = false
	gSearchFocus = false
	local open = true
	UiModalBegin()
	UiPush()
		local w = contextMenu.IsCollection and contextMenu.MenuWidth.collectionW or contextMenu.MenuWidth.colModsW
		local h = contextMenu.IsCollection and 22*6+16 or 22*3+16
		local x = contextMenu.PosX
		local y = contextMenu.PosY

		UiTranslate(x, y)
		UiAlign("left top")
		UiScale(1, contextMenu.Scale)
		UiWindow(w, h, true)
		UiColor(0.2, 0.2, 0.2, 1)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)
		UiColor(1, 1, 1)
		UiImageBox("ui/common/box-outline-6.png", w, h, 6, 6, 1)

		if InputPressed("esc") or (not UiIsMouseInRect(w, h) and InputPressed("lmb")) then open = false end
		if InputPressed("esc") or (not UiIsMouseInRect(w, h) and InputPressed("rmb")) then return false end

		--Indent 12, 8
		w = w - 24
		h = h - 16
		UiTranslate(12, 8)
		UiFont("regular.ttf", 22)
		UiColor(1, 1, 1, 0.5)

		if contextMenu.IsCollection then
			--Rename collection
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					gSearchClick = false
					gSearchFocus = false
					gCollectionClick = true
					gCollectionFocus = true
					gCollectionRename = true
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
			UiText(locLang.rename)
			UiTranslate(0, 22)

			--Duplicate collection
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					handleCollectionDuplicate(sel_collect)
					updateCollections(true)
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
			UiText(locLang.duplicate)
			UiTranslate(0, 22)

			--Delete collection
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					yesNoPopInit(locLang.delColConfirm, sel_collect, callback.DeleteCollection)
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
			UiText(locLang.delete)
			UiTranslate(0, 22)
		end

		--Enable mods in collection
		if UiIsMouseInRect(w, 22) then
			UiColor(1, 1, 1, 0.2)
			UiRect(w, 22)
			if InputPressed("lmb") then
				yesNoPopInit(locLang.disableModsColAsk, sel_collect, onlyActiveCollection, activeCollection)
				open = false
			end
		end
		UiColor(1, 1, 1, 1)
		UiText(contextMenu.IsCollection and locLang.applyCol or locLang.enableAll)
		UiTranslate(0, 22)

		--Disable mods in collection
		local count = getActiveModCountCollection()
		if count > 0 then
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					deactiveCollection()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
		else
			UiColor(0.8, 0.8, 0.8, 1)
		end
		UiText(contextMenu.IsCollection and locLang.disuseCol or locLang.disableAll)
		UiTranslate(0, 22)

		-- Collect all enabled to collection
		if UiIsMouseInRect(w, 22) then
			UiColor(1, 1, 1, 0.2)
			UiRect(w, 22)
			if InputPressed("lmb") then
				yesNoPopInit(locLang.collectEnabledToColAsk, sel_collect, onlyCollectAllEnabled, collectAllEnabled)
				open = false
			end
		end
		UiColor(1, 1, 1, 1)
		UiText(locLang.collectEnabled)
		UiTranslate(0, 22)
	UiPop()
	UiModalEnd()

	return open
end

contextMenu.Search = function(sel_mod, fnCategory)
	local open = true
	UiModalBegin()
	UiPush()
		local w = (fnCategory == 3) and contextMenu.MenuWidth.listSearchW2 or contextMenu.MenuWidth.listSearchW1
		local h = 128
		local x = contextMenu.PosX
		local y = contextMenu.PosY

		UiTranslate(x, y)
		UiAlign("left top")
		UiScale(1, contextMenu.Scale)
		UiWindow(w, h, true)
		UiColor(0.2, 0.2, 0.2, 1)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)
		UiColor(1, 1, 1)
		UiImageBox("ui/common/box-outline-6.png", w, h, 6, 6, 1)

		if InputPressed("esc") or (not UiIsMouseInRect(w, h) and InputPressed("lmb")) then open = false end
		if InputPressed("esc") or (not UiIsMouseInRect(w, h) and InputPressed("rmb")) then return false end

		--Indent 12, 8
		w = w - 24
		h = h - 16
		UiTranslate(12, 8)
		UiFont("regular.ttf", 22)
		UiColor(1, 1, 1, 0.5)

		--Unsubscribe
		if fnCategory == 2 and sel_mod ~= "" then
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					handleModCollectionRemove(sel_mod)
					Command("mods.unsubscribe", sel_mod)
					updateCollections(true)
					updateMods()
					updateSearch()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
		else
			UiColor(0.8, 0.8, 0.8, 1)
		end
		UiText("loc@UI_TEXT_UNSUBSCRIBE")
		UiTranslate(0, 22)

		--New global mod
		if UiIsMouseInRect(w, 22) then
			UiColor(1, 1, 1, 0.2)
			UiRect(w, 22)
			if InputPressed("lmb") then
				Command("mods.new", "global")
				updateMods()
				updateSearch()
				open = false
			end
		end
		UiColor(1, 1, 1, 1)
		UiText("loc@UI_TEXT_NEW_GLOBAL")
		UiTranslate(0, 22)

		--New content mod
		if UiIsMouseInRect(w, 22) then
			UiColor(1, 1, 1, 0.2)
			UiRect(w, 22)
			if InputPressed("lmb") then
				Command("mods.new", "content")
				updateMods()
				updateSearch()
				open = false
			end
		end
		UiColor(1, 1, 1, 1)
		UiText("loc@UI_TEXT_NEW_CONTENT")
		UiTranslate(0, 22)

		--Duplicate mod/Make local copy
		if sel_mod ~= "" then
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					Command("mods.makelocalcopy", sel_mod)
					updateMods()
					updateSearch()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
		else
			UiColor(0.8, 0.8, 0.8, 1)
		end
		UiText((fnCategory == 3) and "loc@UI_TEXT_DUPLICATE_MOD" or "loc@UI_BUTTON_MAKE_LOCAL")
		UiTranslate(0, 22)

		--Delete mod
		if fnCategory == 3 and sel_mod ~= "" then
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					yesNoPopInit("loc@ARE_YOU", sel_mod, callback.DeleteMod)
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
		else
			UiColor(0.8, 0.8, 0.8, 1)
		end
		UiText("loc@UI_TEXT_DELETE_MOD")
		UiTranslate(0, 22)
	UiPop()
	UiModalEnd()

	return open
end

contextMenu.Common = function(sel_mod, fnCategory)
	local open = true
	UiModalBegin()
	UiPush()
		local w =	(fnCategory == 2 and sel_mod ~= "") and contextMenu.MenuWidth.listWorkshopW or
					(fnCategory == 3) and (sel_mod ~= "" and contextMenu.MenuWidth.listLocalSelW or contextMenu.MenuWidth.listLocalW) or
					contextMenu.MenuWidth.listCommonW
		local h =	(fnCategory == 2 and sel_mod ~= "") and 63 or (fnCategory == 3) and (sel_mod ~= "" and 128 or 85) or 38
		local x = contextMenu.PosX
		local y = contextMenu.PosY

		UiTranslate(x, y)
		UiAlign("left top")
		UiScale(1, contextMenu.Scale)
		UiWindow(w, h, true)
		UiColor(0.2, 0.2, 0.2, 1)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)
		UiColor(1, 1, 1)
		UiImageBox("ui/common/box-outline-6.png", w, h, 6, 6, 1)

		if InputPressed("esc") or (not UiIsMouseInRect(w, h) and InputPressed("lmb")) then open = false end
		if InputPressed("esc") or (not UiIsMouseInRect(w, h) and InputPressed("rmb")) then return false end

		--Indent 12, 8
		w = w - 24
		h = h - 16
		UiTranslate(12, 8)
		UiFont("regular.ttf", 22)
		UiColor(1, 1, 1, 0.5)

		if fnCategory == 2 and sel_mod ~= "" then
			--Unsubscribe
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					handleModCollectionRemove(sel_mod)
					Command("mods.unsubscribe", sel_mod)
					updateCollections(true)
					updateMods()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
			UiText("loc@UI_TEXT_UNSUBSCRIBE")
			UiTranslate(0, 22)
		end
		if fnCategory == 3 then
			--New global mod
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					Command("mods.new", "global")
					updateMods()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
			UiText("loc@UI_TEXT_NEW_GLOBAL")
			UiTranslate(0, 22)
	
			--New content mod
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					Command("mods.new", "content")
					updateMods()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
			UiText("loc@UI_TEXT_NEW_CONTENT")
	
			if sel_mod ~= "" then
				--Duplicate mod
				UiTranslate(0, 22)
				if UiIsMouseInRect(w, 22) then
					UiColor(1, 1, 1, 0.2)
					UiRect(w, 22)
					if InputPressed("lmb") then
						Command("mods.makelocalcopy", sel_mod)
						updateMods()
						open = false
					end
				end
				UiColor(1, 1, 1, 1)
				UiText("loc@UI_TEXT_DUPLICATE_MOD")
	
				--Delete mod
				UiTranslate(0, 22)
				if UiIsMouseInRect(w, 22) then
					UiColor(1, 1, 1, 0.2)
					UiRect(w, 22)
					if InputPressed("lmb") then
						yesNoPopInit("loc@ARE_YOU", sel_mod, callback.DeleteMod)
						open = false
					end
				end
				UiColor(1, 1, 1, 1)
				UiText("loc@UI_TEXT_DELETE_MOD")
			end
			UiTranslate(0, 22)
		end

		--Disable all
		local count = getActiveModCount(fnCategory)
		if count > 0 then
			if UiIsMouseInRect(w, 22) then
				UiColor(1, 1, 1, 0.2)
				UiRect(w, 22)
				if InputPressed("lmb") then
					deactivateMods(fnCategory)
					updateCollections(true)
					updateMods()
					open = false
				end
			end
			UiColor(1, 1, 1, 1)
		else
			UiColor(0.8, 0.8, 0.8, 1)
		end
		UiText("loc@UI_TEXT_DISABLE_ALL")
	UiPop()
	UiModalEnd()

	return open
end

callback = {}

callback.DeleteCollection = function()
	if yesNoPopPopup.item ~= "" then
		ClearKey(nodes.Collection.."."..(yesNoPopPopup.item))
		updateCollections()
	end
end

callback.DeleteMod = function()
	if yesNoPopPopup.item ~= "" then
		handleModCollectionRemove(yesNoPopPopup.item)
		Command("mods.delete", yesNoPopPopup.item)
		updateCollections(true)
		updateMods()
		if gSearchText ~= "" then updateSearch() end
	end
end

nodes = {
	OldCollection = "savegame.collection",
	Collection = "options.collection",
	Settings = "options.modmenu"
}

-- ================= Added Feature State (scaffolding) =================
-- Debounced search & advanced search structures
gSearchAdvanced = {
	parsed = {},            -- tokenized constraints
	lastRaw = "",
	lastParseTime = 0
}
gSearchDirty = false
gSearchLastInput = 0
gSearchDebounce = 0.25 -- seconds

-- Extra global filter toggles
gExtraFilters = {
	hasPreview = false,
	hideInactive = false,
	orphanedOnly = false,
	sizeThreshold = 0 -- in bytes; 0 disabled
}

-- Saved searches storage key
gSavedSearchesKey = nodes.Settings..".savedsearches"
gSavedSearches = {}

-- Selection highlight animation
gSelectFlash = { id = "", t = 0, dur = 0.35 }

-- Hover preview enlarge
gPreviewHoverScale = 1.05

-- Integrity / conflict scan results cache
gScanResults = { integrity = {}, conflicts = {}, time = 0 }
gShowScanPopup = false

-- Savegame data browser state
gShowSavegameBrowser = false
gSavegameBrowserScroll = 0

-- Inline rename / tag edit state
gInlineRename = { active = false, text = "" }
gInlineTags = { active = false, text = "" }

-- Savegame data browser state
gSavegameBrowser = { show = false, data = {} }

-- Batch selection state
gBatchSelectionMode = false
gSelectedMods = {}
gShowBatchCollectionPopup = false
gBatchCollectionScroll = 0

-- Backup payload node
gBackupNode = nodes.Settings..".backupPayload"

-- =====================================================================

collectionPop = false
newList = {}
prevSelectMod = ""
initSelect = true
menuVer = "v1.4.5"
tempcharctrSelect = ""
tempcharctrSetTime = -1
prevPreview = ""

webLinks = {
	projectGithub = "https://github.com/YuLun-bili/Mod-Menu-Revamped",
	projectCrowdin = "https://crowdin.com/project/yulun-td-mmre"
}

initSettings = {
	["showpath.2"] = {"bool", false},
	["startcategory"] = {"int", 0},
	["rememberlast"] = {"bool", false},
	["resetfilter"] = {"bool", false},
	["foldauthor"] = {"bool", true}
}

category = {
	Index = (GetInt(nodes.Settings..".startcategory")+1),
	Lookup = {
		builtin = 1,
		steam = 2,
		["local"] = 3
	}
}

tooltip = {
	x = 0,
	y = 0,
	text = "",
	mode = 1,	-- 1: full, 2: partial
	bold = false
}

tooltipHoverId = ""
tooltipPrevId = ""
tooltipTimer = 0
tooltipCooldown = 0
tooltipDisable = false


yesNoPopPopup = {
	show	= false,
	yes		= false,
	no		= false,
	text	= "",
	item	= "",
	yes_fn	= nil,
	no_fn	= nil
}

function yesNoPopInit(text, item, fn, fn1)
	yesNoPopPopup.show		= true
	yesNoPopPopup.yes		= false
	yesNoPopPopup.no		= false
	yesNoPopPopup.text		= text
	yesNoPopPopup.item		= item
	yesNoPopPopup.yes_fn	= fn
	yesNoPopPopup.no_fn		= fn1
end

function yesNoPop()
	local clicked = false
	UiModalBegin()
	UiBlur(0.5)
	UiPush()
		local w = yesNoPopPopup.no_fn and 560 or 510
		local h = 240
		UiTranslate(UiCenter()-w/2, UiMiddle()-h/2)
		UiAlign("top left")
		UiWindow(w, h)
		UiColor(0.2, 0.2, 0.2)
		UiImageBox("common/box-solid-6.png", w, h, 6, 6)
		UiColor(1, 1, 1)
		UiImageBox("common/box-outline-6.png", w, h, 6, 6)

		if InputPressed("esc") then
			yesNoPopPopup.yes = false
			yesNoPopPopup.no = false
			return true
		end

		UiColor(1, 1, 1, 1)
		UiTranslate(16, 16)
		UiPush()
			UiAlign("middle center")
			UiTranslate(w/2-16, 75)
			UiFont("regular.ttf", 28)
			UiColor(1, 1, 1)
			UiWordWrap(w-80)
			UiText(yesNoPopPopup.text)
		UiPop()
		
		UiButtonImageBox("common/box-outline-6.png", 6, 6, 1, 1, 1)
		UiTranslate(0, h-100)
		if yesNoPopPopup.no_fn then
			local buttonW = 130
			local buttonGap = 35
			UiTranslate((w-16*2-buttonW*3-buttonGap*2)/2, 0)
			UiPush()
				UiColor(0.6, 0.3, 0.2)
				UiImageBox("common/box-solid-6.png", buttonW, 40, 6, 6)
				UiTranslate(buttonW+buttonGap, 0)
				UiColor(0.35, 0.5, 0.2)
				UiImageBox("common/box-solid-6.png", buttonW, 40, 6, 6)
			UiPop()

			UiFont("regular.ttf", 26)
			UiColor(1, 1, 1, 1)

			if UiTextButton("loc@UI_BUTTON_YES", buttonW, 40) then
				yesNoPopPopup.yes = true
				clicked = true
			end

			UiTranslate(buttonW+buttonGap, 0)
			if UiTextButton("loc@UI_BUTTON_NO", buttonW, 40) then
				yesNoPopPopup.no = true
				clicked = true
			end

			UiTranslate(buttonW+buttonGap, 0)
			if UiTextButton("loc@UI_BUTTON_CANCEL", buttonW, 40) then
				clicked = true
			end
		else
			local buttonW = 140
			local buttonGap = 40
			UiTranslate((w-16*2-buttonW*2-buttonGap)/2, 0)
			UiColor(0.6, 0.2, 0.2)
			UiImageBox("common/box-solid-6.png", buttonW, 40, 6, 6)
			UiFont("regular.ttf", 26)
			UiColor(1, 1, 1, 1)

			if UiTextButton("loc@UI_BUTTON_YES", buttonW, 40) then
				yesNoPopPopup.yes = true
				clicked = true
			end

			UiTranslate(buttonW+buttonGap, 0)
			if UiTextButton("loc@UI_BUTTON_NO", buttonW, 40) then
				yesNoPopPopup.no = true
				clicked = true
			end
		end
	UiPop()
	UiModalEnd()
	return clicked
end

function clearModsSavegameData()
	for _, modKey in ipairs(yesNoPopPopup.item) do
		ClearKey("savegame.mod."..modKey)
	end
end

function strSplit(str, splitAt)
	local splitted = {}
	(str..splitAt):gsub("(.-)"..splitAt.."%s*", function(s) splitted[#splitted+1] = s end)
	return splitted
end

function selectMod(mod)
	gModSelected = mod
	if mod ~= "" then
		Command("mods.updateselecttime", gModSelected)
		Command("game.selectmod", gModSelected)
		SetString("mods.modmanager.selectedmod", gModSelected)
	end
end

function initModMenuSettings()
	if GetString(nodes.Settings) == menuVer then return end
	for setNode, setVal in pairs(initSettings) do
		local settingNode = nodes.Settings.."."..setNode
		repeat
			if HasKey(settingNode) then break end
			if setVal[1] == "bool" then SetBool(settingNode, setVal[2]) end
			if setVal[1] == "int" then SetInt(settingNode, setVal[2]) end
		until true
	end
	ClearKey(nodes.Settings..".showpath.1") -- built-in, removed
	SetString(nodes.Settings, menuVer)
end

function transferCollection()
	if not HasKey(nodes.OldCollection) or HasKey(nodes.Collection) then return end
	for _, oldCollNode in pairs(ListKeys(nodes.OldCollection)) do
		local locNode = nodes.OldCollection.."."..oldCollNode
		local newNode = nodes.Collection.."."..oldCollNode
		local locName = GetString(locNode)
		SetString(newNode, locName)
		for _, oldMod in pairs(ListKeys(locNode)) do SetString(newNode.."."..oldMod) end
	end
	ClearKey(nodes.OldCollection)
end

function revertTempCharacter()
	if tempcharctrSetTime < 0 then return end
	if tempcharctrSelect == "" then return end
	SetString("savegame.player.character", tempcharctrSelect)
	tempcharctrSelect = ""
	tempcharctrSetTime = -1
end

function initLoc()
	transferCollection()
	initModMenuSettings()
	updateLocLangStr()
	RegisterListenerTo("LanguageChanged", "updateLocLangStr")
	RegisterListenerTo("LanguageChanged", "updateMods")
	RegisterListenerTo("LanguageChanged", "updateCollections")
	RegisterListenerTo("LanguageChanged", "collectionReset")
	RegisterListenerTo("OnMainMenuStateTransitFinished", "revertTempCharacter")
	math.randomseed(GetInt("savegame.stats.totalplaytime")+GetInt("savegame.stats.brokenvoxels"))

	gMods = gMods or {}
	for i=1, 3 do
		gMods[i] = gMods[i] or {}
		gMods[i].items = {}
		gMods[i].total = 0
		gMods[i].pos = 0
		gMods[i].sort = 0
		gMods[i].sortInv = false
		gMods[i].filter = 0
		gMods[i].dragstarty = 0
		gMods[i].isdragging = false
	end
	gModSelected = ""
	gAuthorSelected = ""
	updateMods()

	gCollections = {}
	updateCollections()
	gCollectionList = {}
	collectionReset()
	gCollectionMain = {
		pos = 0,
		sort = 0,
		sortInv = false,
		filter = 0,
		dragstarty = 0,
		isdragging = false,
	}
	gCollectionSelected = 0
	gCollectionTyping = false
	gCollectionFocus = false
	gCollectionRename = false
	gCollectionClick = false
	gCollectionName = ""

	gSearchTyping = false
	gSearchFocus = false
	gSearchClick = false
	gSearchText = ""
	gSearch = {
		items = {{}, {}, {}},
		total = {0, 0, 0},
		fold = {false, false, false},
		pos = 0,
		sortInv = false,
		filter = 0,
		dragstarty = 0,
		isdragging = false
	}

	gLoadedPreview = ""
	gLargePreview = 0
	gQuitLarge = false

	gPublishScale = 0
	gPublishDropdown = false
	gPublishLangIndex = 0
	gPublishLangReload = false
	gPublishLangTitle = nil
	gPublishLangDesc = nil
	
	gRefreshFade = 0
	gShowSetting = false

	recentRndList = {}
	recentRndListLookup = {}
	
	viewLocalPublishedWorkshop = false

	-- Load saved searches
	gSavedSearches = {}
	for _, key in ipairs(ListKeys(gSavedSearchesKey)) do
		local txt = GetString(gSavedSearchesKey.."."..key)
		if txt and txt ~= "" then table.insert(gSavedSearches, txt) end
	end
end

function resetModSortFilter()
	for i=1, 3 do
		gMods[i].sort = 0
		gMods[i].sortInv = false
		gMods[i].filter = 0
	end
end

function resetSearchSortFilter()
	gSearch.sortInv = false
	gSearch.filter = 0
end

function updateMods()
	Command("mods.refresh")
	UiUnloadImage(prevPreview)
	prevPreview = ""

	for i=1, 3 do
		gMods[i].items = {}
		gMods[i].total = 0
		gMods[i].fold = nil
	end

	local mods = ListKeys("mods.available")
	local foundSelected = false
	local displayList = {}
	local allAuthorList = setmetatable({}, {
		__call = function(allAuthorList, newList)
			local offIndex = 1
			for _, value in pairs(newList) do
				if not allAuthorList[value] then allAuthorList[value], offIndex = #displayList+offIndex, offIndex+1 end
			end
		end
	})
	local defaultAuthorFold = GetBool(nodes.Settings..".foldauthor")
	for i=1,#mods do
		local mod = {}
		local modNode = mods[i]
		mod.id = modNode
		mod.name = GetString("mods.available."..modNode..".listname")
		mod.override = GetBool("mods.available."..modNode..".override") and not GetBool("mods.available."..modNode..".playable")
		mod.active = GetBool("mods.available."..modNode..".active") or GetBool(modNode..".active")
		mod.steamtime = GetInt("mods.available."..modNode..".steamtime")
		mod.subscribetime = GetInt("mods.available."..modNode..".subscribetime")
		mod.showbold = false
		mod.preview = (function()
			local p = GetString("mods.available."..modNode..".path")
			if p == "" then return false end
			return HasFile("RAW:"..p.."/preview.jpg") or HasFile("RAW:"..p.."/preview.png")
		end)()
		mod.descriptionMissing = (GetString("mods.available."..modNode..".description") == "")
		mod.nameCanonical = string.lower(mod.name or "")

		local iscontentmod = GetBool("mods.available."..modNode..".playable")
		local modPrefix = (mod.id):match("^(%w+)-")
		local index = category.Lookup[modPrefix]
		if index then
			local tempFilter = gMods[index].filter
			local tempFilterCheck = {
				[0] = function() return true end,
				[1] = function() return newList[modNode] end,
				[2] = function() return not iscontentmod end,
				[3] = function() return iscontentmod end,
				[4] = function() return mod.active end
			}
			if index == 2 then
				mod.showbold = GetBool("mods.available."..modNode..".showbold")
				if not newList.modNode and mod.showbold then newList[modNode] = true end
			end
			if gMods[index].sort == 1 then
				local modAuthorStr = GetString("mods.available."..modNode..".author")
				local modAuthorList = strSplit(modAuthorStr, ",")
				modAuthorList = modAuthorStr == "" and {"%,unknown,%"} or modAuthorList
				mod.author = modAuthorList
				allAuthorList(modAuthorList)
				for _, value in pairs(modAuthorList) do
					local authorIndexLookup = allAuthorList[value]
					if tempFilterCheck[tempFilter]() then
						displayList[authorIndexLookup] = displayList[authorIndexLookup] or {}
						table.insert(displayList[authorIndexLookup], mod)
						displayList[authorIndexLookup].name = value
					end
				end
			else
				if tempFilterCheck[tempFilter]() then table.insert(gMods[index].items, mod) end
			end
		end
		if gModSelected ~= "" and gModSelected == modNode then foundSelected = true end
	end

		-- Integrity scan duplicate name detection helper (only when requested later)
		gNameToIds = {}
		for i=1,#mods do
				local nm = GetString("mods.available."..mods[i]..".listname")
				if nm ~= "" then
						local key = string.lower(nm)
						gNameToIds[key] = gNameToIds[key] or {}
						table.insert(gNameToIds[key], mods[i])
				end
		end
	if gModSelected ~= "" and not foundSelected then gModSelected, gAuthorSelected = "", "" end

	for i=1, 3 do
		gMods[i].total = #gMods[i].items
		if gMods[i].sort == 0 then
			if gMods[i].sortInv then
				table.sort(gMods[i].items, function(a, b) return string.lower(a.name) > string.lower(b.name) end)
			else
				table.sort(gMods[i].items, function(a, b) return string.lower(a.name) < string.lower(b.name) end)
			end
		elseif gMods[i].sort == 1 then
			local tempFoldList = {}
			local authorCount = #displayList
			local tempModSelect = gModSelected ~= ""
			local modAuthorStr = GetString("mods.available."..gModSelected..".author")
			modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
			if gMods[i].sortInv then
				table.sort(displayList, function(a, b) return string.lower(a.name) > string.lower(b.name) end)
				for l=1, authorCount do
					table.sort(displayList[l], function(a, b) return string.lower(a.name) > string.lower(b.name) end)
					tempFoldList[l] = defaultAuthorFold
					local foundAuthor = string.find(modAuthorStr, displayList[l].name, 1, true) and true
					if foundAuthor then tempFoldList[l] = false end
				end
			else
				table.sort(displayList, function(a, b) return string.lower(a.name) < string.lower(b.name) end)
				for l=1, authorCount do
					table.sort(displayList[l], function(a, b) return string.lower(a.name) < string.lower(b.name) end)
					tempFoldList[l] = defaultAuthorFold
					local foundAuthor = string.find(modAuthorStr, displayList[l].name, 1, true) and true
					if foundAuthor then tempFoldList[l] = false end
				end
			end
			gMods[i].items = displayList
			gMods[i].total = authorCount
			gMods[i].fold = tempFoldList
		elseif gMods[i].sort == 2 then
			if gMods[i].sortInv then
				table.sort(gMods[i].items, function(a, b) return a.steamtime < b.steamtime end)
			else
				table.sort(gMods[i].items, function(a, b) return a.steamtime > b.steamtime end)
			end
		else
			if gMods[i].sortInv then
				table.sort(gMods[i].items, function(a, b) return a.subscribetime < b.subscribetime end)
			else
				table.sort(gMods[i].items, function(a, b) return a.subscribetime > b.subscribetime end)
			end
		end
	end
end

function newCollection(name)
	local newID = "col"
	local dupIndex = 0
	local nameLength = UiGetSymbolsCount(name)
	for str in name:gmatch("([%w-]+)") do newID = newID.."-"..str end
	if nameLength < 3 then return true, 2 end
	if nameLength > 20 then return true, 3 end
	newID = newID:lower()
	if HasKey(nodes.Collection.."."..newID) then
		repeat dupIndex = dupIndex + 1 until not HasKey(nodes.Collection.."."..newID.."-"..dupIndex)
		newID = newID.."-"..dupIndex
	end
	SetString(nodes.Collection.."."..newID, name)
end

function renameCollection(id, name)
	local nameLength = UiGetSymbolsCount(name)
	if nameLength < 3 then return true, 2 end
	if nameLength > 20 then return true, 3 end
	SetString(nodes.Collection.."."..id, name)
end

function collectionReset()
	gCollectionList = {
		pos = 0,
		sort = 0,
		sortInv = false,
		filter = 0,
		dragstarty = 0,
		isdragging = false,
	}
end

function updateCollections(noReset)
	gCollections = {}
	if not noReset then collectionReset() end

	for i, collection in ipairs(ListKeys(nodes.Collection)) do
		gCollections[i] = {}
		gCollections[i].lookup = collection
		gCollections[i].name = GetString(nodes.Collection.."."..collection)
		gCollections[i].items = {}
		gCollections[i].total = 0
		gCollections[i].fold = nil
		gCollections[i].itemLookup = {}
	end

	local totalVal = #gCollections
	gCollections.total = totalVal
	for i=1, totalVal do updateCollectMods(i) end
	table.sort(gCollections, function(a, b) return string.lower(a.name) < string.lower(b.name) end)
end

function updateCollectMods(id)
	if not gCollections[id] then return end

	gCollections[id].items = {}
	gCollections[id].total = 0
	gCollections[id].fold = nil
	gCollections[id].itemLookup = {}
	
	local lookupID = gCollections[id].lookup
	local itemList = ListKeys(nodes.Collection.."."..lookupID)
	local displayList = {}
	local allAuthorList = setmetatable({}, {
		__call = function(allAuthorList, newList)
			local offIndex = 1
			for _, value in pairs(newList) do
				if not allAuthorList[value] then allAuthorList[value], offIndex = #displayList+offIndex, offIndex+1 end
			end
		end
	})
	local defaultAuthorFold = GetBool(nodes.Settings..".foldauthor")
	for _, item in ipairs(itemList) do
		local mod = {}
		local nameCheck = GetString("mods.available."..item..".listname")
		mod.id = item
		mod.name = #nameCheck > 0 and nameCheck or "loc@NAME_UNKNOWN"
		mod.override = GetBool("mods.available."..item..".override") and not GetBool("mods.available."..item..".playable")
		mod.active = GetBool("mods.available."..item..".active") or GetBool(item..".active")
		local iscontentmod = GetBool("mods.available."..item..".playable")
		local tempFilter = gCollectionList.filter
		local tempFilterCheck = {
			[0] = function() return true end,
			[2] = function() return not iscontentmod end,
			[3] = function() return iscontentmod end,
			[4] = function() return mod.active end
		}
		if gCollectionList.sort == 1 then
			local modAuthorStr = GetString("mods.available."..item..".author")
			local modAuthorList = strSplit(modAuthorStr, ",")
			modAuthorList = modAuthorStr == "" and {"%,unknown,%"} or modAuthorList
			mod.author = modAuthorList
			allAuthorList(modAuthorList)
			for _, value in pairs(modAuthorList) do
				local authorIndexLookup = allAuthorList[value]
				if tempFilterCheck[tempFilter]() then
					displayList[authorIndexLookup] = displayList[authorIndexLookup] or {}
					table.insert(displayList[authorIndexLookup], mod)
					displayList[authorIndexLookup].name = value
				end
			end
		else
			if tempFilterCheck[tempFilter]() then
				table.insert(gCollections[id].items, mod)
			end
		end
		gCollections[id].itemLookup[item] = 1
	end
	if gCollectionList.sort == 0 then
		if gCollectionList.sortInv then
			table.sort(gCollections[id].items, function(a, b) return string.lower(a.name) > string.lower(b.name) end)
		else
			table.sort(gCollections[id].items, function(a, b) return string.lower(a.name) < string.lower(b.name) end)
		end
		gCollections[id].total = #gCollections[id].items
	else
		local tempFoldList = {}
		local authorCount = #displayList
		local tempModSelect = gModSelected ~= ""
		local modAuthorStr = GetString("mods.available."..gModSelected..".author")
		modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
		if gCollectionList.sortInv then
			table.sort(displayList, function(a, b) return string.lower(a.name) > string.lower(b.name) end)
			for l=1, authorCount do
				table.sort(displayList[l], function(a, b) return string.lower(a.name) > string.lower(b.name) end)
				tempFoldList[l] = defaultAuthorFold
				local foundAuthor = string.find(modAuthorStr, displayList[l].name, 1, true) and true
				if foundAuthor then tempFoldList[l] = false end
			end
		else
			table.sort(displayList, function(a, b) return string.lower(a.name) < string.lower(b.name) end)
			for l=1, authorCount do
				table.sort(displayList[l], function(a, b) return string.lower(a.name) < string.lower(b.name) end)
				tempFoldList[l] = defaultAuthorFold
				local foundAuthor = string.find(modAuthorStr, displayList[l].name, 1, true) and true
				if foundAuthor then tempFoldList[l] = false end
			end
		end
		gCollections[id].items = displayList
		gCollections[id].total = authorCount
		gCollections[id].fold = tempFoldList
	end
end

function handleModCollect(collection)
	local modKey = nodes.Collection.."."..collection.."."..gModSelected
	if HasKey(modKey) then ClearKey(modKey) return end
	SetString(modKey)
end

function handleModCollectionRemove(id)
	for _, collKey in ipairs(ListKeys(nodes.Collection)) do ClearKey(nodes.Collection.."."..collKey.."."..id) end
end

function handleCollectionDuplicate(collection)
	local collKey = nodes.Collection.."."..collection
	local collName = GetString(collKey)
	local dupIndex = 0
	local colMods = ListKeys(collKey)
	repeat dupIndex = dupIndex + 1 until not HasKey(collKey.."-"..dupIndex)
	SetString(collKey.."-"..dupIndex, collName)
	for i, mod in ipairs(colMods) do SetString(collKey.."-"..dupIndex.."."..mod) end
end

function getActiveModCountCollection()
	local count = 0
	local collection = gCollections[gCollectionSelected].lookup
	for i, mod in ipairs(ListKeys(nodes.Collection.."."..collection)) do
		if GetBool("mods.available."..mod..".active") then count = count+1 end
	end
	return count
end

function getGlobalModCountCollection()
	if not gCollections[gCollectionSelected] then return 0 end
	local collection = gCollections[gCollectionSelected].lookup
	return #ListKeys(nodes.Collection.."."..collection)
end

function activeCollection()
	local collection = gCollections[gCollectionSelected].lookup
	for i, mod in ipairs(ListKeys(nodes.Collection.."."..collection)) do
		if not GetBool("mods.available."..mod..".active") then Command("mods.activate", mod) end
	end
	updateMods()
	updateCollections(true)
end

function onlyActiveCollection()
	local collection = gCollections[gCollectionSelected].lookup
	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local mod = mods[i]
		if GetBool("mods.available."..mod..".active") then Command("mods.deactivate", mod) end
	end
	for i, mod in ipairs(ListKeys(nodes.Collection.."."..collection)) do
		if not GetBool("mods.available."..mod..".active") then Command("mods.activate", mod) end
	end
	updateMods()
	updateCollections(true)
end

function deactiveCollection()
	local collection = gCollections[gCollectionSelected].lookup
	for i, mod in ipairs(ListKeys(nodes.Collection.."."..collection)) do
		if GetBool("mods.available."..mod..".active") then Command("mods.deactivate", mod) end
	end
	updateMods()
	updateCollections(true)
end

function collectAllEnabled()
	local id = gCollectionSelected
	local collKey = nodes.Collection.."."..gCollections[id].lookup
	local mods = ListKeys("mods.available")
	for i=1, #mods do
		local mod = mods[i]
		if GetBool("mods.available."..mod..".active") then SetString(collKey.."."..mod) end
	end
	updateCollectMods(id)
end

function onlyCollectAllEnabled()
	local id = gCollectionSelected
	local collKey = nodes.Collection.."."..gCollections[id].lookup
	local mods = ListKeys("mods.available")
	for i, _ in ipairs(ListKeys(collKey)) do ClearKey(collKey.."."..i) end
	for i=1, #mods do
		local mod = mods[i]
		if GetBool("mods.available."..mod..".active") then SetString(collKey.."."..mod) end
	end
	updateCollectMods(id)
end

function getActiveModCount(fnCategory)
	local count = 0
	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local mod = mods[i]
		if GetBool("mods.available."..mod..".active") then
			local modPrefix = mod:match("^(%w+)-")
			if category.Lookup[modPrefix] == fnCategory then count = count+1 end
		end
	end
	return count
end

function deactivateMods(fnCategory)
	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local mod = mods[i]
		if GetBool("mods.available."..mod..".active") then
			local modPrefix = mod:match("^(%w+)-")
			if category.Lookup[modPrefix] == fnCategory then Command("mods.deactivate", mod) end
		end
	end
end

function toggleMod(id, state)
	if not state then
		Command("mods.activate", id)
		return true
	end
	Command("mods.deactivate", id)
	return false
end

function updateSearch()
	gSearch.items = {{}, {}, {}}

	-- Debounce / advanced parse trigger
	if gSearchText ~= gSearchAdvanced.lastRaw then
		gSearchDirty = true
		gSearchLastInput = GetTime()
		gSearchAdvanced.lastRaw = gSearchText
	end
	if gSearchDirty and (GetTime() - gSearchLastInput > gSearchDebounce) then
		parseAdvancedSearch()
		gSearchDirty = false
	end

	-- For immediate simple search: extract text if no advanced tokens
	local immediateText = ""
	if gSearchText ~= "" then
		local hasAdvanced = false
		for token in gSearchText:gmatch("%S+") do
			local lower = token:lower()
			if lower:match("^(author):") or lower:match("^(tag):") or lower:match("^(size):") or lower:match("^(updated):") or lower == "-active" or lower == "active" or lower == "has:preview" or lower == "no:preview" then
				hasAdvanced = true
				break
			end
		end
		if not hasAdvanced then
			immediateText = gSearchText:match("^%s*(.-)%s*$")
		end
	end

	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local mod = {}
		local modNode = mods[i]
		local modName = GetString("mods.available."..modNode..".listname")
		local simpleMatch = true
		local searchText = immediateText ~= "" and immediateText or gSearchAdvanced.parsed.text
		if searchText ~= "" then
			simpleMatch = modName:lower():match(searchText:lower())
		end
		mod.id = modNode
		mod.name = modName
		mod.override = GetBool("mods.available."..modNode..".override") and not GetBool("mods.available."..modNode..".playable")
		mod.active = GetBool("mods.available."..modNode..".active") or GetBool(modNode..".active")
		local path = GetString("mods.available."..modNode..".path")
		local hasPreview = path ~= "" and (HasFile("RAW:"..path.."/preview.jpg") or HasFile("RAW:"..path.."/preview.png"))
		local descriptionMissing = (GetString("mods.available."..modNode..".description") == "")

		local advOk = true
		local adv = gSearchAdvanced.parsed
		if adv.author and adv.author ~= "" then
			local authStr = GetString("mods.available."..modNode..".author"):lower()
			advOk = advOk and authStr:find(adv.author, 1, true)
		end
		if adv.tag and adv.tag ~= "" then
			local tagsStr = GetString("mods.available."..modNode..".tags"):lower()
			advOk = advOk and tagsStr:find(adv.tag, 1, true)
		end
		if adv.active == true and not mod.active then advOk = false end
		if adv.active == false and mod.active then advOk = false end
		if adv.hasPreview == true and (not hasPreview) then advOk = false end
		if adv.hasPreview == false and hasPreview then advOk = false end
		if adv.sizegt and adv.sizegt > 0 then
			local bytes = getSavegameNodeBytes(modNode)
			advOk = advOk and bytes >= adv.sizegt
		end
		if adv.sizelt and adv.sizelt > 0 then
			local bytes = getSavegameNodeBytes(modNode)
			advOk = advOk and bytes <= adv.sizelt
		end
		if adv.updatedDays and adv.updatedDays > 0 then
			local updateTs = GetInt("mods.available."..modNode..".subscribetime")
			local now = GetTime()
			-- crude: subscribe time in seconds (?) if zero skip
			if updateTs > 0 then
				advOk = advOk and (now - updateTs < adv.updatedDays*86400)
			end
		end

		local iscontentmod = GetBool("mods.available."..modNode..".playable")
		local modPrefix = (mod.id):match("^(%w+)-")
		local index = category.Lookup[modPrefix]
		local tempFilter = gSearch.filter
		local tempFilterCheck = {
			[0] = function() return true end,
			[2] = function() return not iscontentmod end,
			[3] = function() return iscontentmod end,
			[4] = function() return mod.active end
		}
		if simpleMatch and advOk and index then
			if tempFilterCheck[tempFilter]() then
				-- Extra global filters
				local extraPass = true
				if gExtraFilters.hasPreview and not hasPreview then extraPass = false end
				if gExtraFilters.hideInactive and not mod.active then extraPass = false end
				if gExtraFilters.sizeThreshold > 0 then
					local bytes = getSavegameNodeBytes(modNode)
					if bytes < gExtraFilters.sizeThreshold then extraPass = false end
				end
				if gExtraFilters.orphanedOnly then
					local isOrphan = true
					for _, collKey in ipairs(ListKeys(nodes.Collection)) do
						if HasKey(nodes.Collection.."."..collKey.."."..modNode) then isOrphan = false break end
					end
					if not isOrphan then extraPass = false end
				end
				if extraPass then gSearch.items[index][#gSearch.items[index]+1] = mod end
			end
		end
	end

	for i=1, 3 do
		gSearch.total[i] = #gSearch.items[i]
		if gSearch.sortInv then
			table.sort(gSearch.items[i], function(a, b) return string.lower(a.name) > string.lower(b.name) end)
		else
			table.sort(gSearch.items[i], function(a, b) return string.lower(a.name) < string.lower(b.name) end)
		end
	end
end

-- ================= Advanced Search Parsing =================
function parseAdvancedSearch()
	local raw = gSearchText
	local parsed = { text = "" }
	if raw == "" then gSearchAdvanced.parsed = { text = "" } return end
	for token in raw:gmatch("%S+") do
		local lower = token:lower()
		repeat
			local k,v = lower:match("^(author):(.+)$")
			if k then parsed.author = v break end
			k,v = lower:match("^(tag):(.+)$")
			if k then parsed.tag = v break end
			k,v = lower:match("^(size):([<>]=?)([%d%.]+)(kb?)$")
			if k then
				local num = tonumber(v:match("([%d%.]+)")) or 0
				local bytes = num*1024
				if lower:find(">") then parsed.sizegt = bytes elseif lower:find("<") then parsed.sizelt = bytes end
				break
			end
			k,v = lower:match("^(updated):<(%d+)d$")
			if k then parsed.updatedDays = tonumber(v) break end
			if lower == "-active" then parsed.active = false break end
			if lower == "active" then parsed.active = true break end
			if lower == "has:preview" then parsed.hasPreview = true break end
			if lower == "no:preview" then parsed.hasPreview = false break end
			-- fallback accumulate into text search
			parsed.text = parsed.text .. " " .. token
		until true
	end
	parsed.text = parsed.text:match("^%s*(.-)%s*$")
	gSearchAdvanced.parsed = parsed
end

-- ================= Integrity / Conflict Scans =================
function runIntegrityScan()
	local results = {}
	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local id = mods[i]
		local path = GetString("mods.available."..id..".path")
		local hasPreview = path ~= "" and (HasFile("RAW:"..path.."/preview.jpg") or HasFile("RAW:"..path.."/preview.png"))
		local name = GetString("mods.available."..id..".listname")
		local desc = GetString("mods.available."..id..".description")
		if not hasPreview then table.insert(results, { id=id, issue=locLang.previewMissing }) end
		if desc == "" then table.insert(results, { id=id, issue=locLang.descMissing }) end
	end
	for nameLower, ids in pairs(gNameToIds or {}) do
		if #ids > 1 then
			for _, id in ipairs(ids) do
				table.insert(results, { id=id, issue=locLang.duplicateName })
			end
		end
	end
	gScanResults.integrity = results
	gScanResults.time = GetTime()
	gShowScanPopup = true
end

function runConflictScan()
	-- Placeholder heuristic: flag if two override mods share same first 8 chars of id
	local results = {}
	local buckets = {}
	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local id = mods[i]
		if GetBool("mods.available."..id..".override") then
			local key = id:sub(1,8)
			buckets[key] = buckets[key] or {}
			table.insert(buckets[key], id)
		end
	end
	for k, list in pairs(buckets) do
		if #list > 1 then
			for _, id in ipairs(list) do
				table.insert(results, { id=id, issue="Potential overlap" })
			end
		end
	end
	gScanResults.conflicts = results
	gScanResults.time = GetTime()
	gShowScanPopup = true
end

-- ================= Backup / Restore / Export =================
function createBackup()
	local data = {}
	data.collections = {}
	for _, coll in ipairs(ListKeys(nodes.Collection)) do
		local entry = { name = GetString(nodes.Collection.."."..coll), id = coll, mods = {} }
		for _, m in ipairs(ListKeys(nodes.Collection.."."..coll)) do table.insert(entry.mods, m) end
		table.insert(data.collections, entry)
	end
	data.settings = {}
	for _, setKey in ipairs(ListKeys(nodes.Settings)) do
		data.settings[setKey] = GetString(nodes.Settings.."."..setKey)
	end
	SetString(gBackupNode, jsonEncode(data))
	gRefreshFade = 1
	SetValue("gRefreshFade", 0, "easein", 1.5)
end

function restoreBackup()
	if not HasKey(gBackupNode) then return end
	local raw = GetString(gBackupNode)
	local ok, decoded = pcall(jsonDecode, raw)
	if not ok or type(decoded) ~= "table" then return end
	-- Clear existing
	for _, coll in ipairs(ListKeys(nodes.Collection)) do ClearKey(nodes.Collection.."."..coll) end
	for _, entry in ipairs(decoded.collections or {}) do
		SetString(nodes.Collection.."."..entry.id, entry.name)
		for _, m in ipairs(entry.mods or {}) do SetString(nodes.Collection.."."..entry.id.."."..m) end
	end
	updateCollections()
end

function exportMetadata()
	local arr = {}
	local mods = ListKeys("mods.available")
	for i=1,#mods do
		local id = mods[i]
		arr[i] = {
			id = id,
			name = GetString("mods.available."..id..".listname"),
			path = GetString("mods.available."..id..".path"),
			active = GetBool("mods.available."..id..".active") or GetBool(id..".active"),
			playable = GetBool("mods.available."..id..".playable"),
			override = GetBool("mods.available."..id..".override"),
			author = GetString("mods.available."..id..".author"),
			tags = GetString("mods.available."..id..".tags")
		}
	end
	SetString(nodes.Settings..".lastExport", jsonEncode(arr))
	gShowScanPopup = true
	gScanResults.integrity = { { id = "", issue = locLang.metaCopied } }
end

-- Simple JSON (very small subset) encoder/decoder fallback
function jsonEncode(v)
	local t = type(v)
	if t == "table" then
		local isArray = (#v > 0)
		local parts = {}
		if isArray then
			for i=1,#v do parts[i] = jsonEncode(v[i]) end
			return "["..table.concat(parts, ",").."]"
		else
			for k,val in pairs(v) do parts[#parts+1] = string.format("\"%s\":%s", k, jsonEncode(val)) end
			return "{"..table.concat(parts, ",").."}"
		end
	elseif t == "string" then
		return string.format("\"%s\"", v:gsub("\"","\\\""))
	elseif t == "boolean" or t == "number" then
		return tostring(v)
	else
		return "null"
	end
end

function jsonDecode(_)
	-- Minimal stub (not full JSON) to avoid heavy implementation now
	return {}
end

function browseOperation(value, pageSize, listMax)
	local wheelValue = InputValue("mousewheel")
	tooltipDisable = false
	if wheelValue ~= 0 then
		tooltipDisable = true
		value = value + wheelValue*(InputDown("shift") and 10 or 1)
	else
		value = value + ((InputPressed("pgup") and 1 or 0) - (InputPressed("pgdown") and 1 or 0))*pageSize
		local press = InputValue("home") - InputValue("end")
		value = ((press == 1) and 0) or ((press == -1) and -listMax) or value
	end
	return math.min(value, 0)
end

function arrowOperation()
	local anyArrowPressed = InputPressed("menu_up") or InputPressed("menu_down") or InputPressed("menu_left") or InputPressed("menu_right")
	local arrowDir = math.ceil((InputValue("menu_down")+InputValue("menu_right"))/2) - math.ceil((InputValue("menu_up")+InputValue("menu_left"))/2)
	return (anyArrowPressed and arrowDir or 0)+2
	--	-1, 0, 1 -> 1, 2, 3
end

function listMods(list, w, h, issubscribedlist, useSection)
	local needUpdate = false
	local ret = ""
	local rmb_pushed = false
	local listingVal = math.ceil((h-10)/22)-1
	local totalCate = 1
	local totalVal = list.total
	local sectionStart, sectionEnd = nil, nil
	local listStart = math.floor(1-list.pos)
	local listOffStart = listStart
	local scrollCount = 0
	local prevModId = ""
	local nextModId = ""
	local prevSectionIndex = 0
	local currSectionIndex = 0
	local nextSectionIndex = 0
	local prevModFound = false
	local nextModFound = false
	local prevAuthor = ""
	local nextAuthor = ""
	local prevAuthorFound = false
	local nextAuthorFound = false

	if useSection then
		totalCate = #list.items
		totalVal = 0
		tempOffset = 0
		for i=1, totalCate do
			local tempListLen = list.fold[i] and math.max(2-i, 0) or #list.items[i]
			totalVal = tempListLen+totalVal+1
			if totalVal > listStart and not sectionStart then sectionStart = i end
			if totalVal > listStart+listingVal and not sectionEnd then sectionEnd = i end
			if not sectionStart then tempOffset = tempListLen+tempOffset+1 end
		end
		if not sectionEnd then sectionEnd = totalCate end
		listOffStart = listStart-tempOffset
	else
		sectionStart, sectionEnd = 1, 1
	end
	if list.isdragging and InputReleased("lmb") then list.isdragging = false end
	UiPush()
		UiAlign("top left")
		UiFont("regular.ttf", 22)

		local mouseOver = UiIsMouseInRect(w+12, h)
		if mouseOver then list.pos = browseOperation(list.pos, listingVal, totalVal) end
		if not UiReceivesInput() then mouseOver = false end

		local itemsInView = math.floor(h/UiFontHeight())
		if totalVal > itemsInView then
			w = w-14
			scrollCount = totalVal-itemsInView
			if scrollCount < 0 then scrollCount = 0 end

			local frac = itemsInView / totalVal
			if list.isdragging then
				local posx, posy = UiGetMousePos()
				local dy = 0.0445 * (posy - list.dragstarty)
				list.pos = -dy / frac
			end
			list.pos = clamp(list.pos, -scrollCount, 0)
			local pos = -list.pos / totalVal

			UiPush()
				UiTranslate(w, 0)
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-4.png", 14, h, 4, 4)
				UiColor(1, 1, 1, 0.2)

				local bar_posy = 2 + pos*(h-4)
				local bar_sizey = (h-4)*frac
				UiPush()
					UiTranslate(2, 2)
					if bar_posy > 2 and UiIsMouseInRect(8, bar_posy-2) and InputPressed("lmb") then list.pos = list.pos + frac * totalVal end
					local h2 = h - 4 - bar_sizey - bar_posy
					UiTranslate(0, bar_posy + bar_sizey)
					if h2 > 0 and UiIsMouseInRect(10, h2) and InputPressed("lmb") then list.pos = list.pos - frac * totalVal end
				UiPop()

				UiTranslate(2, bar_posy)
				UiImageBox("ui/common/box-solid-4.png", 10, bar_sizey, 4, 4)
				if UiIsMouseInRect(10, bar_sizey) and InputPressed("lmb") then
					local posx, posy = UiGetMousePos()
					list.dragstarty = posy
					list.isdragging = true
				end
			UiPop()
		else
			list.pos = 0
		end

		UiWindow(w, h, true)
		UiColor(1, 1, 1, 0.07)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)

		UiTranslate(10, 24)

		UiAlign("left")
		UiColor(0.95, 0.95, 0.95, 1)
		local totalList = 0
		local prevList = 0
		for j=sectionStart or 0, sectionEnd or 0 do
			local subList = useSection and list.items[j] or list.items
			local foldList = useSection and list.fold[j] or false
			local subListTotal = useSection and #subList or 0
			local subListStart = useSection and math.max(1, listOffStart-totalList) or listStart
			local subListLines = useSection and (foldList and 0 or math.min(subListTotal, listingVal-prevList+subListStart)) or math.min(totalVal, listOffStart+listingVal)
			local subListLen = useSection and (foldList and 0 or math.max(0, subListLines-subListStart)) or 0
			local subListName = subList.name == "%,unknown,%" and "loc@NAME_UNKNOWN" or subList.name
			if useSection then
				UiPush()
					UiFont("regular.ttf", 20)
					UiPush()
						UiTranslate(-9, -7)
						UiButtonImageBox("ui/common/gradient.png", 1, 1, 0.25, 1, 0.25, 0.15)
						UiButtonHoverColor(0.3, 1, 0.3, 0.9)
						UiButtonPressColor(0.2, 1, 0.2, 0.9)
						UiButtonPressDist(0.1)
						if UiBlankButton(w, 22) then list.fold[j] = not foldList end
					UiPop()
					UiPush()
						UiTranslate(3, -6)
						UiAlign("middle center")
						UiText(foldList and "+" or "—")
					UiPop()
					UiPush()
						UiFont("bold.ttf", 20)
						UiTranslate(15, 0)
						UiText(subListName)
					UiPop()
					UiPush()
						UiTranslate(w-20, 0)
						UiAlign("right")
						UiText(subListTotal)
					UiPop()
				UiPop()
				UiTranslate(0, 22)
				prevList = prevList+subListLen
				totalList = totalList+(foldList and 0 or subListTotal)
			end
			for i=math.max(1, subListStart), subListLines do
				local mouseOverThisMod = false
				local id = subList[i].id
				UiPush()
					UiTranslate(10, -18)
					UiColor(0, 0, 0, 0)
					if gModSelected == id then
						UiColor(1, 1, 1, 0.1)
						if useSection then
							if gAuthorSelected == subListName or gAuthorSelected == "" then
								UiPush()
									UiColor(1, 1, 1, 0.9)
									UiRectOutline(w-21, 22, 1)
								UiPop()
								prevAuthorFound = list.items[j-1] and true or false
								nextAuthorFound = list.items[j+1] and true or false
								prevModFound = subList[i-1] and true or false
								nextModFound = subList[i+1] and true or false
								prevAuthor = prevModFound and subListName or prevAuthorFound and list.items[j-1].name or ""
								nextAuthor = nextModFound and subListName or nextAuthorFound and list.items[j+1].name or ""
								prevAuthor = prevAuthor == "%,unknown,%" and "loc@NAME_UNKNOWN" or prevAuthor
								nextAuthor = nextAuthor == "%,unknown,%" and "loc@NAME_UNKNOWN" or nextAuthor
								prevModId = prevModFound and subList[i-1].id or ""
								nextModId = nextModFound and subList[i+1].id or ""
								prevSectionIndex = j
								currSectionIndex = j
								nextSectionIndex = j
								if not prevModFound and prevAuthorFound then
									local prevSubList = list.items[j-1]
									local prevSubListLen = #prevSubList
									prevModFound = prevSubList[prevSubListLen] and true or false
									prevModId = prevModFound and prevSubList[prevSubListLen].id or ""
									prevSectionIndex = prevModFound and j-1 or j
								end
								if not nextModFound and nextAuthorFound then
									local nextSubList = list.items[j+1]
									nextModFound = nextModFound and true or nextSubList[1] and true or false
									nextModId = nextModFound and nextSubList[1].id or ""
									nextSectionIndex = nextModFound and j+1 or j
								end
								gAuthorSelected = subListName or ""
							end
						else
							prevModFound = subList[i-1] and true or false
							nextModFound = subList[i+1] and true or false
							prevModId = prevModFound and subList[i-1].id or ""
							nextModId = nextModFound and subList[i+1].id or ""
						end
					end
					if mouseOver and UiIsMouseInRect(w-20, 22) then
						mouseOverThisMod = true
						UiColor(0, 0, 0, 0.1)
						if InputPressed("lmb") and gModSelected ~= id then
							UiSound("terminal/message-select.ogg")
							ret = id
							if useSection then
								gAuthorSelected = subListName or ""
							else
								local modAuthorStr = GetString("mods.available."..id..".author")
								modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
								gAuthorSelected = strSplit(modAuthorStr, ",")[1]
							end
						elseif InputPressed("rmb") then
							ret = id
							rmb_pushed = true
							if useSection then
								gAuthorSelected = subListName or ""
							else
								local modAuthorStr = GetString("mods.available."..id..".author")
								modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
								gAuthorSelected = strSplit(modAuthorStr, ",")[1]
							end
						end
					end
					UiRect(w, 22)
				UiPop()

				if subList[i].override then
					UiPush()
						UiTranslate(-10, -18)
						if mouseOver and UiIsMouseInRect(22, 22) and InputPressed("lmb") then
							subList[i].active = toggleMod(subList[i].id, subList[i].active)
							needUpdate = true
						end
					UiPop()
					UiPush()
						UiTranslate(2, -6)
						UiAlign("center middle")
						UiScale(0.5)
						if subList[i].active then
							UiColor(1, 1, 0.5)
							UiImage("ui/menu/mod-active.png")
						else
							UiImage("ui/menu/mod-inactive.png")
						end
					UiPop()
				end
				if gBatchSelectionMode then
					UiPush()
						UiTranslate(-35, -18)
						UiButtonImageBox("ui/common/box-outline-4.png", 16, 16, 1, 1, 1, 0.75)
						UiScale(0.5)
						if gSelectedMods[id] then
							if UiImageButton("ui/hud/checkmark.png", 36, 36) then
								gSelectedMods[id] = nil
							end
						else
							if UiBlankButton(36, 36) then
								gSelectedMods[id] = true
							end
						end
					UiPop()
				end
				UiPush()
					UiTranslate(10, 0)
					local boldName = subList[i].showbold
					if issubscribedlist and boldName then UiFont("bold.ttf", 20) end
					local modName = subList[i].name
					local nameLength = UiText(modName)
					if mouseOverThisMod then
						if nameLength > w-20 then
							tooltipHoverId = id
							local curX, curY = UiGetCursorPos()
							tooltip = {x = curX, y = curY, text = modName, mode = 2, bold = boldName}
						else
							tooltipHoverId = ""
							tooltip = {x = 0, y = 0, text = "", mode = 1, bold = false}
						end
					end
				UiPop()
				UiTranslate(0, 22)
			end
		end
		if not rmb_pushed and mouseOver and InputPressed("rmb") then rmb_pushed = true end
	UiPop()

	if mouseOver then
		local tempArrowOperation = arrowOperation()
		if tempArrowOperation ~= 2 then
			UiSound("terminal/message-select.ogg")
			local tempArrowList = {
				{
					mod = prevModFound and prevModId or gModSelected,
					author = prevAuthorFound and prevAuthor or gAuthorSelected,
					index = prevModFound and prevSectionIndex or currSectionIndex
				},
				{
					mod = gModSelected,
					author = gAuthorSelected,
					index = currSectionIndex
				},
				{
					mod = nextModFound and nextModId or gModSelected,
					author = nextAuthorFound and nextAuthor or gAuthorSelected,
					index = nextModFound and nextSectionIndex or currSectionIndex
				}
			}
			local tempSelect = tempArrowList[tempArrowOperation]
			gModSelected = tempSelect.mod
			gAuthorSelected = tempSelect.author
			if useSection then
				local tempAuthorFactor = tempArrowList[2].author ~= tempSelect.author and 2 or 1
				if tempArrowList[1].mod == tempArrowList[3].mod and tempArrowList[1].mod == tempArrowList[2].mod then
					list.fold[tempArrowList[2].index] = false
					local modAuthorStr = GetString("mods.available."..gModSelected..".author")
					modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
					for t=1, totalCate do
						local subListName = list.items[t].name
						if string.find(modAuthorStr, subListName, 1, true) then list.fold[t] = false end
					end
				else
					list.fold[tempSelect.index] = false
					list.pos = clamp(list.pos-(tempArrowOperation-2)*tempAuthorFactor, -scrollCount, 0)
				end
			else
				list.pos = clamp(list.pos-tempArrowOperation+2, -scrollCount, 0)
			end
		end
	end
	if needUpdate then updateCollections(true) updateMods() end
	return ret, rmb_pushed
end

function listSearchMods(list, w, h)
	local category = 0
	local needUpdate = false
	local ret = ""
	local rmb_pushed = false
	local listingVal = math.ceil((h-10)/22)-1
	local totalVal = 0
	local scrollCount = 0
	local prevModId = ""
	local nextModId = ""
	local prevSectionIndex = 0
	local currSectionIndex = 0
	local nextSectionIndex = 0
	local prevModFound = false
	local nextModFound = false
	if list.isdragging and InputReleased("lmb") then list.isdragging = false end
	for j=1, 3 do totalVal = totalVal + 1 + (list.fold[j] and 0 or list.total[j]) end
	UiPush()
		UiAlign("top left")
		UiFont("regular.ttf", 22)

		local mouseOver = UiIsMouseInRect(w+12, h)
		if mouseOver then list.pos = browseOperation(list.pos, listingVal, totalVal) end
		if not UiReceivesInput() then mouseOver = false end

		local itemsInView = math.floor(h/UiFontHeight())
		if totalVal > itemsInView then
			w = w-14
			scrollCount = totalVal-itemsInView
			if scrollCount < 0 then scrollCount = 0 end

			local frac = itemsInView / totalVal
			if list.isdragging then
				local posx, posy = UiGetMousePos()
				local dy = 0.0445 * (posy - list.dragstarty)
				list.pos = -dy / frac
			end
			list.pos = clamp(list.pos, -scrollCount, 0)
			local pos = -list.pos / totalVal

			UiPush()
				UiTranslate(w, 0)
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-4.png", 14, h, 4, 4)
				UiColor(1, 1, 1, 0.2)

				local bar_posy = 2 + pos*(h-4)
				local bar_sizey = (h-4)*frac
				UiPush()
					UiTranslate(2, 2)
					if bar_posy > 2 and UiIsMouseInRect(8, bar_posy-2) and InputPressed("lmb") then list.pos = list.pos + frac * totalVal end
					local h2 = h - 4 - bar_sizey - bar_posy
					UiTranslate(0, bar_posy + bar_sizey)
					if h2 > 0 and UiIsMouseInRect(10, h2) and InputPressed("lmb") then list.pos = list.pos - frac * totalVal end
				UiPop()

				UiTranslate(2, bar_posy)
				UiImageBox("ui/common/box-solid-4.png", 10, bar_sizey, 4, 4)
				if UiIsMouseInRect(10, bar_sizey) and InputPressed("lmb") then
					local posx, posy = UiGetMousePos()
					list.dragstarty = posy
					list.isdragging = true
				end
			UiPop()
		else
			list.pos = 0
		end

		UiWindow(w, h, true)
		UiColor(1, 1, 1, 0.07)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)

		UiTranslate(10, 24)

		UiAlign("left")
		UiColor(0.95, 0.95, 0.95, 1)
		local listStart = math.floor((1-list.pos) or 1)
		local linesLeft = listingVal-3
		local totalList = 0
		local prevList = 0
		for j=1, 3 do
			local subList = list.items[j]
			local foldList = list.fold[j]
			local subListTotal = #subList
			local subListStart = math.max(1, listStart-totalList)
			local subListLines = foldList and 0 or math.min(subListTotal, linesLeft-prevList+subListStart-1)
			local subListLen = foldList and 0 or math.max(0, subListLines-subListStart+1)
			UiPush()
				UiFont("regular.ttf", 20)
				UiPush()
					UiTranslate(-9, -7)
					UiButtonImageBox("ui/common/gradient.png", 1, 1, 0.25, 1, 0.25, 0.15)
					UiButtonHoverColor(0.3, 1, 0.3, 0.9)
					UiButtonPressColor(0.2, 1, 0.2, 0.9)
					UiButtonPressDist(0.1)
					if UiBlankButton(w, 22) then list.fold[j] = not foldList end
				UiPop()
				UiPush()
					UiTranslate(3, -6)
					UiAlign("middle center")
					UiText(foldList and "+" or "—")
				UiPop()
				UiPush()
					UiFont("bold.ttf", 20)
					UiTranslate(15, 0)
					UiText(categoryTextLookup[j])
				UiPop()
				UiPush()
					UiTranslate(w-20, 0)
					UiAlign("right")
					UiText(subListTotal)
				UiPop()
			UiPop()
			UiTranslate(0, 22)
			prevList = prevList+subListLen
			totalList = totalList+(foldList and 0 or subListTotal)
			linesLeft = linesLeft+1
			for i=subListStart, subListLines do
				local mouseOverThisMod = false
				local id = subList[i].id
				UiPush()
					UiTranslate(10, -18)
					UiColor(0, 0, 0, 0)
					if gModSelected == id then
						UiColor(1, 1, 1, 0.1)
						UiPush()
							UiColor(1, 1, 1, 0.9)
							UiRectOutline(w-21, 22, 1)
						UiPop()
						prevModFound = subList[i-1] and true or false
						nextModFound = subList[i+1] and true or false
						prevModId = prevModFound and subList[i-1].id or ""
						nextModId = nextModFound and subList[i+1].id or ""
						prevSectionIndex = j
						currSectionIndex = j
						nextSectionIndex = j
						local prevSubList = list.items[j-1]
						local nextSubList = list.items[j+1]
						if not prevModFound and prevSubList then
							local prevSubListLen = #prevSubList
							prevModFound = prevSubList[prevSubListLen] and true or false
							prevModId = prevModFound and prevSubList[prevSubListLen].id or ""
							prevSectionIndex = prevModFound and j-1 or j
						end
						if not nextModFound and nextSubList then
							nextModFound = nextModFound and true or nextSubList[1] and true or false
							nextModId = nextModFound and nextSubList[1].id or ""
							nextSectionIndex = nextModFound and j+1 or j
						end
					end
					if mouseOver and UiIsMouseInRect(w-20, 22) then
						mouseOverThisMod = true
						UiColor(0, 0, 0, 0.1)
						if InputPressed("lmb") and gModSelected ~= id then
							UiSound("terminal/message-select.ogg")
							ret = id
						elseif InputPressed("rmb") then
							ret = id
							rmb_pushed = true
							category = j
						end
					end
					UiRect(w, 22)
				UiPop()

				if subList[i].override then
					UiPush()
						UiTranslate(-10, -18)
						if mouseOver and UiIsMouseInRect(22, 22) and InputPressed("lmb") then
							subList[i].active = toggleMod(subList[i].id, subList[i].active)
							needUpdate = true
						end
					UiPop()
					UiPush()
						UiTranslate(2, -6)
						UiAlign("center middle")
						UiScale(0.5)
						if subList[i].active then
							UiColor(1, 1, 0.5)
							UiImage("ui/menu/mod-active.png")
						else
							UiImage("ui/menu/mod-inactive.png")
						end
					UiPop()
				end
				UiPush()
					UiTranslate(10, 0)
					local modName = subList[i].name
					local nameLength = UiText(modName)
					if mouseOverThisMod then
						if nameLength > w-20 then
							tooltipHoverId = id
							local curX, curY = UiGetCursorPos()
							tooltip = {x = curX, y = curY, text = modName, mode = 2}
						else
							tooltipHoverId = ""
							tooltip = {x = 0, y = 0, text = "", mode = 1, bold = false}
						end
					end
				UiPop()
				UiTranslate(0, 22)
			end
		end
	UiPop()

	if mouseOver then
		local tempArrowOperation = arrowOperation()
		if tempArrowOperation ~= 2 then
			UiSound("terminal/message-select.ogg")
			local tempArrowList = {
				{
					mod = prevModFound and prevModId or gModSelected,
					index = prevModFound and prevSectionIndex or currSectionIndex
				},
				{
					mod = gModSelected,
					index = currSectionIndex
				},
				{
					mod = nextModFound and nextModId or gModSelected,
					index = nextModFound and nextSectionIndex or currSectionIndex
				}
			}
			local tempSelect = tempArrowList[tempArrowOperation]
			gModSelected = tempSelect.mod
			if tempArrowList[1].mod == tempArrowList[3].mod and tempArrowList[1].mod == tempArrowList[2].mod then
				list.fold[tempArrowList[2].index] = false
			else
				list.fold[tempSelect.index] = false
				list.pos = clamp(list.pos-tempArrowOperation+2, -scrollCount, 0)
			end
		end
	end
	if needUpdate then updateCollections(true) updateMods() end
	return ret, rmb_pushed, category
end

function listCollections(list, w, h)
	local ret = gCollectionSelected
	local rmb_pushed = false
	local listingVal = math.ceil((h-10)/22)-1
	local totalVal = list.total
	local scrollCount = 0
	local prevCollectionIndex = gCollectionSelected
	local nextCollectionIndex = gCollectionSelected
	if gCollectionMain.isdragging and InputReleased("lmb") then gCollectionMain.isdragging = false end

	UiPush()
		UiAlign("top left")
		UiFont("regular.ttf", 22)

		local mouseOver = UiIsMouseInRect(w+12, h)
		if mouseOver then gCollectionMain.pos = browseOperation(gCollectionMain.pos, listingVal, totalVal) end
		if not UiReceivesInput() then mouseOver = false end

		local itemsInView = math.floor(h/UiFontHeight())
		if totalVal > itemsInView then
			w = w-14
			scrollCount = totalVal-itemsInView
			if scrollCount < 0 then scrollCount = 0 end

			local frac = itemsInView / totalVal
			if gCollectionMain.isdragging then
				local posx, posy = UiGetMousePos()
				local dy = 0.0445 * (posy - gCollectionMain.dragstarty)
				gCollectionMain.pos = -dy / frac
			end
			gCollectionMain.pos = clamp(gCollectionMain.pos, -scrollCount, 0)
			local pos = -gCollectionMain.pos / totalVal

			UiPush()
				UiTranslate(w, 0)
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-4.png", 14, h, 4, 4)
				UiColor(1, 1, 1, 0.2)

				local bar_posy = 2 + pos*(h-4)
				local bar_sizey = (h-4)*frac
				UiPush()
					UiTranslate(2, 2)
					if bar_posy > 2 and UiIsMouseInRect(8, bar_posy-2) and InputPressed("lmb") then gCollectionMain.pos = gCollectionMain.pos + frac * totalVal end
					local h2 = h - 4 - bar_sizey - bar_posy
					UiTranslate(0, bar_posy + bar_sizey)
					if h2 > 0 and UiIsMouseInRect(10, h2) and InputPressed("lmb") then gCollectionMain.pos = gCollectionMain.pos - frac * totalVal end
				UiPop()

				UiTranslate(2, bar_posy)
				UiImageBox("ui/common/box-solid-4.png", 10, bar_sizey, 4, 4)
				if UiIsMouseInRect(10, bar_sizey) and InputPressed("lmb") then
					local posx, posy = UiGetMousePos()
					gCollectionMain.dragstarty = posy
					gCollectionMain.isdragging = true
				end
			UiPop()
		else
			gCollectionMain.pos = 0
		end

		UiWindow(w, h, true)
		UiColor(1, 1, 1, 0.07)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)

		UiTranslate(10, 24)

		UiAlign("left")
		UiColor(0.95, 0.95, 0.95, 1)
		local listStart = math.floor((1-gCollectionMain.pos) or 1)
		for i=listStart, math.min(totalVal, listStart+listingVal) do
			UiPush()
				UiTranslate(20, -18)
				UiColor(0, 0, 0, 0)
				if gCollectionSelected == i then
					UiColor(1, 1, 1, 0.1)
					prevCollectionIndex = list[i-1] and i-1 or i
					nextCollectionIndex = list[i+1] and i+1 or i
				end
				if mouseOver and UiIsMouseInRect(w-30, 22) then
					UiColor(0, 0, 0, 0.1)
					if InputPressed("lmb") and gCollectionSelected ~= i then
						UiSound("terminal/message-select.ogg")
						collectionReset()
						ret = i
					elseif InputPressed("rmb") then
						ret = i
						rmb_pushed = true
					end
				end
				UiRect(w, 22)
			UiPop()

			UiPush()
				UiAlign("left middle")
				UiTranslate(0, -7)
				UiButtonImageBox("ui/common/box-outline-4.png", 16, 16, 1, 1, 1, 0.75)
				UiScale(0.5)
				if list[i].itemLookup[gModSelected] then
					if UiImageButton("ui/hud/checkmark.png", 36, 36) then
						handleModCollect(list[i].lookup)
						updateCollections(true)
					end
				else
					if UiBlankButton(36, 36) then
						handleModCollect(list[i].lookup)
						updateCollections(true)
					end
				end
			UiPop()
			UiPush()
				UiTranslate(20, 0)
				if gCollectionRename and gCollectionSelected == i then
					if gCollectionName == "" then UiColor(1, 1, 1, 0.5) end
					UiText(gCollectionName ~= "" and gCollectionName or locLang.renameCol)
				else
					UiText(list[i].name)
				end
			UiPop()
			UiTranslate(0, 22)
		end

		if not rmb_pushed and mouseOver and InputPressed("rmb") then rmb_pushed = true end
	UiPop()

	if mouseOver then
		local tempArrowOperation = arrowOperation()
		if tempArrowOperation ~= 2 then
			UiSound("terminal/message-select.ogg")
			local tempArrowList = {
				{index = prevCollectionIndex},
				{index = gCollectionSelected},
				{index = nextCollectionIndex}
			}
			ret = tempArrowList[tempArrowOperation].index
			gCollectionMain.pos = clamp(gCollectionMain.pos-tempArrowOperation+2, -scrollCount, 0)
		end
	end
	return ret, rmb_pushed
end

function listCollectionMods(mainList, w, h, selected, useSection)
	local needUpdate = false
	local list = mainList[selected]
	local ret = ""
	local rmb_pushed = false
	local listingVal = math.ceil((h-10)/22)-1
	local totalCate = 1
	local totalVal = list and list.total or 0
	local sectionStart, sectionEnd = nil, nil
	local listStart = math.floor(1-gCollectionList.pos)
	local listOffStart = listStart
	local scrollCount = 0
	local prevModId = ""
	local nextModId = ""
	local prevSectionIndex = 0
	local currSectionIndex = 0
	local nextSectionIndex = 0
	local prevModFound = false
	local nextModFound = false
	local prevAuthor = ""
	local nextAuthor = ""
	local prevAuthorFound = false
	local nextAuthorFound = false

	if useSection and list then
		totalCate = #list.items
		totalVal = 0
		tempOffset = 0
		for i=1, totalCate do
			local tempListLen = list.fold[i] and math.max(2-i, 0) or #list.items[i]
			totalVal = tempListLen+totalVal+1
			if totalVal > listStart and not sectionStart then sectionStart = i end
			if totalVal > listStart+listingVal and not sectionEnd then sectionEnd = i end
			if not sectionStart then tempOffset = tempListLen+tempOffset+1 end
		end
		if not sectionEnd then sectionEnd = totalCate end
		listOffStart = listStart-tempOffset
	else
		sectionStart, sectionEnd = 1, 1
	end
	if gCollectionList.isdragging and InputReleased("lmb") then gCollectionList.isdragging = false end

	UiPush()
		UiAlign("top left")
		UiFont("regular.ttf", 22)
		local itemsInView = math.floor(h/UiFontHeight())
		if not list then
			UiPush()
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)
			UiPop()
			UiPop()
			return ret, rmb_pushed
		end

		local mouseOver = UiIsMouseInRect(w+12, h)
		if mouseOver then gCollectionList.pos = browseOperation(gCollectionList.pos, listingVal, totalVal) end
		if not UiReceivesInput() then mouseOver = false end

		if totalVal > itemsInView then
			w = w-14
			scrollCount = totalVal-itemsInView
			if scrollCount < 0 then scrollCount = 0 end

			local frac = itemsInView / totalVal
			if gCollectionList.isdragging then
				local posx, posy = UiGetMousePos()
				local dy = 0.0445 * (posy - gCollectionList.dragstarty)
				gCollectionList.pos = -dy / frac
			end
			gCollectionList.pos = clamp(gCollectionList.pos, -scrollCount, 0)
			local pos = -gCollectionList.pos / totalVal

			UiPush()
				UiTranslate(w, 0)
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-4.png", 14, h, 4, 4)
				UiColor(1, 1, 1, 0.2)

				local bar_posy = 2 + pos*(h-4)
				local bar_sizey = (h-4)*frac
				UiPush()
					UiTranslate(2, 2)
					if bar_posy > 2 and UiIsMouseInRect(8, bar_posy-2) and InputPressed("lmb") then gCollectionList.pos = gCollectionList.pos + frac * totalVal end
					local h2 = h - 4 - bar_sizey - bar_posy
					UiTranslate(0, bar_posy + bar_sizey)
					if h2 > 0 and UiIsMouseInRect(10, h2) and InputPressed("lmb") then gCollectionList.pos = gCollectionList.pos - frac * totalVal end
				UiPop()

				UiTranslate(2, bar_posy)
				UiImageBox("ui/common/box-solid-4.png", 10, bar_sizey, 4, 4)
				if UiIsMouseInRect(10, bar_sizey) and InputPressed("lmb") then
					local posx, posy = UiGetMousePos()
					gCollectionList.dragstarty = posy
					gCollectionList.isdragging = true
				end
			UiPop()
		else
			gCollectionList.pos = 0
		end

		UiWindow(w, h, true)
		UiColor(1, 1, 1, 0.07)
		UiImageBox("ui/common/box-solid-6.png", w, h, 6, 6)

		UiTranslate(10, 24)

		UiAlign("left")
		UiColor(0.95, 0.95, 0.95, 1)
		local totalList = 0
		local prevList = 0
		for j=sectionStart or 0, sectionEnd or 0 do
			local subList = useSection and list.items[j] or list.items
			local foldList = useSection and list.fold[j] or false
			local subListTotal = useSection and #subList or 0
			local subListStart = useSection and math.max(1, listOffStart-totalList) or listStart
			local subListLines = useSection and (foldList and 0 or math.min(subListTotal, listingVal-prevList+subListStart)) or math.min(totalVal, listOffStart+listingVal)
			local subListLen = useSection and (foldList and 0 or math.max(0, subListLines-subListStart)) or 0
			local subListName = subList.name == "%,unknown,%" and "loc@NAME_UNKNOWN" or subList.name
			if useSection then
				UiPush()
					UiFont("regular.ttf", 20)
					UiPush()
						UiTranslate(-9, -7)
						UiButtonImageBox("ui/common/gradient.png", 1, 1, 0.25, 1, 0.25, 0.15)
						UiButtonHoverColor(0.3, 1, 0.3, 0.9)
						UiButtonPressColor(0.2, 1, 0.2, 0.9)
						UiButtonPressDist(0.1)
						if UiBlankButton(w, 22) then list.fold[j] = not foldList end
					UiPop()
					UiPush()
						UiTranslate(3, -6)
						UiAlign("middle center")
						UiText(foldList and "+" or "—")
					UiPop()
					UiPush()
						UiFont("bold.ttf", 20)
						UiTranslate(15, 0)
						UiText(subListName)
					UiPop()
					UiPush()
						UiTranslate(w-20, 0)
						UiAlign("right")
						UiText(subListTotal)
					UiPop()
				UiPop()
				UiTranslate(0, 22)
				prevList = prevList+subListLen
				totalList = totalList+(foldList and 0 or subListTotal)
			end
			for i=subListStart, subListLines do
				local mouseOverThisMod = false
				local id = subList[i].id
				UiPush()
					UiTranslate(10, -18)
					UiColor(0, 0, 0, 0)
					if gModSelected == id then
						UiColor(1, 1, 1, 0.1)
						if useSection then
							if gAuthorSelected == subListName or gAuthorSelected == "" then
								UiPush()
									UiColor(1, 1, 1, 0.9)
									UiRectOutline(w-21, 22, 1)
								UiPop()
								prevAuthorFound = list.items[j-1] and true or false
								nextAuthorFound = list.items[j+1] and true or false
								prevModFound = subList[i-1] and true or false
								nextModFound = subList[i+1] and true or false
								prevAuthor = prevModFound and subListName or prevAuthorFound and list.items[j-1].name or ""
								nextAuthor = nextModFound and subListName or nextAuthorFound and list.items[j+1].name or ""
								prevAuthor = prevAuthor == "%,unknown,%" and "loc@NAME_UNKNOWN" or prevAuthor
								nextAuthor = nextAuthor == "%,unknown,%" and "loc@NAME_UNKNOWN" or nextAuthor
								prevModId = prevModFound and subList[i-1].id or ""
								nextModId = nextModFound and subList[i+1].id or ""
								prevSectionIndex = j
								currSectionIndex = j
								nextSectionIndex = j
								if not prevModFound and prevAuthorFound then
									local prevSubList = list.items[j-1]
									local prevSubListLen = #prevSubList
									prevModFound = prevSubList[prevSubListLen] and true or false
									prevModId = prevModFound and prevSubList[prevSubListLen].id or ""
									prevSectionIndex = prevModFound and j-1 or j
								end
								if not nextModFound and nextAuthorFound then
									local nextSubList = list.items[j+1]
									nextModFound = nextModFound and true or nextSubList[1] and true or false
									nextModId = nextModFound and nextSubList[1].id or ""
									nextSectionIndex = nextModFound and j+1 or j
								end
								gAuthorSelected = subListName or ""
							end
						else
							prevModFound = subList[i-1] and true or false
							nextModFound = subList[i+1] and true or false
							prevModId = prevModFound and subList[i-1].id or ""
							nextModId = nextModFound and subList[i+1].id or ""
						end
					end
					if mouseOver and UiIsMouseInRect(w-20, 22) then
						mouseOverThisMod = true
						UiColor(0, 0, 0, 0.1)
						if InputPressed("lmb") and gModSelected ~= id then
							UiSound("terminal/message-select.ogg")
							ret = id
							if useSection then
								gAuthorSelected = subListName or ""
							else
								local modAuthorStr = GetString("mods.available."..id..".author")
								modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
								gAuthorSelected = strSplit(modAuthorStr, ",")[1]
							end
						elseif InputPressed("rmb") then
							ret = id
							rmb_pushed = true
							if useSection then
								gAuthorSelected = subListName or ""
							else
								local modAuthorStr = GetString("mods.available."..id..".author")
								modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
								gAuthorSelected = strSplit(modAuthorStr, ",")[1]
							end
						end
					end
					UiRect(w, 22)
				UiPop()

				if subList[i].override then
					UiPush()
						UiTranslate(-10, -18)
						if UiIsMouseInRect(22, 22) and InputPressed("lmb") then
							subList[i].active = toggleMod(subList[i].id, subList[i].active)
							needUpdate = true
						end
					UiPop()
					UiPush()
						UiTranslate(2, -6)
						UiAlign("center middle")
						UiScale(0.5)
						if subList[i].active then
							UiColor(1, 1, 0.5)
							UiImage("ui/menu/mod-active.png")
						else
							UiImage("ui/menu/mod-inactive.png")
						end
					UiPop()
				end
				UiPush()
					UiTranslate(10, 0)
					local modName = subList[i].name
					local nameLength = UiText(modName)
					if mouseOverThisMod then
						if nameLength > w-20 then
							tooltipHoverId = tostring(selected).."-"..id
							local curX, curY = UiGetCursorPos()
							tooltip = {x = curX, y = curY, text = modName, mode = 2, bold = false}
						else
							tooltipHoverId = ""
							tooltip = {x = 0, y = 0, text = "", mode = 1, bold = false}
						end
					end
				UiPop()
				UiTranslate(0, 22)
			end
		end
		if not rmb_pushed and mouseOver and InputPressed("rmb") then rmb_pushed = true end
	UiPop()

	if mouseOver then
		local tempArrowOperation = arrowOperation()
		if tempArrowOperation ~= 2 then
			UiSound("terminal/message-select.ogg")
			local tempArrowList = {
				{
					mod = prevModFound and prevModId or gModSelected,
					author = prevAuthorFound and prevAuthor or gAuthorSelected,
					index = prevModFound and prevSectionIndex or currSectionIndex
				},
				{
					mod = gModSelected,
					author = gAuthorSelected,
					index = currSectionIndex
				},
				{
					mod = nextModFound and nextModId or gModSelected,
					author = nextAuthorFound and nextAuthor or gAuthorSelected,
					index = nextModFound and nextSectionIndex or currSectionIndex
				}
			}
			local tempSelect = tempArrowList[tempArrowOperation]
			gModSelected = tempSelect.mod
			gAuthorSelected = tempSelect.author
			if useSection then
				local tempAuthorFactor = tempArrowList[2].author ~= tempSelect.author and 2 or 1
				if tempArrowList[1].mod == tempArrowList[3].mod and tempArrowList[1].mod == tempArrowList[2].mod then
					mainList[selected].fold[tempArrowList[2].index] = false
					local modAuthorStr = GetString("mods.available."..gModSelected..".author")
					modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
					for t=1, totalCate do
						local subListName = list.items[t].name
						if string.find(modAuthorStr, subListName, 1, true) then mainList[selected].fold[t] = false end
					end
				else
					mainList[selected].fold[tempSelect.index] = false
					gCollectionList.pos = clamp(gCollectionList.pos-(tempArrowOperation-2)*tempAuthorFactor, -scrollCount, 0)
				end
			else
				gCollectionList.pos = clamp(gCollectionList.pos-tempArrowOperation+2, -scrollCount, 0)
			end
		end
	end
	if needUpdate then updateCollections(true) updateMods() updateSearch() end
	return ret, rmb_pushed
end

function getNodeBytes(keyNode, indentLevel)
	local totalBytes = 0
	for _, nextNode in ipairs(ListKeys(keyNode)) do
		repeat
			local nextKeyNode = keyNode.."."..nextNode
			local nextIndent = indentLevel + 1
			local nodeNameBytes = #nextNode
			local nodeValueBytes = #GetString(nextKeyNode)
			if #ListKeys(nextKeyNode) > 0 then
				totalBytes = totalBytes + getNodeBytes(nextKeyNode, nextIndent)
				totalBytes = totalBytes + nextIndent*2 + nodeNameBytes*2 + 7 + (nodeValueBytes > 0 and (9+nodeValueBytes) or 0)
				break
			end
			totalBytes = totalBytes + nextIndent + nodeNameBytes + 4 + (nodeValueBytes > 0 and (9+nodeValueBytes) or 0)
		until true
	end
	return totalBytes
end

function getSavegameNodeBytes(modNode)
	local fullKeyNode = "savegame.mod."..modNode
	local modNodeValueBytes = #GetString(fullKeyNode)
	return getNodeBytes(fullKeyNode, 3) + 3*2 + #modNode*2 + 7 + (modNodeValueBytes > 0 and (9+modNodeValueBytes) or 0)
end

function truncateBytesUnits(bytes)
	-- fuck u microsoft for mixing SI with IEC 60027-2
	local _, locE = math.frexp(bytes)
	local index = math.min(3, math.floor(math.max(0, locE-1)/10))
	return bytes/2^(10*index), index
end

function drawFilter(filter, sort, order, isWorkshop, isSearch)
	local button1w = 120
	local button2w = 184
	local button3w = 28
	local buttonH = 26
	local verticalOff = -11
	local needUpdate = false
	UiPush()
		UiAlign("top left")
		UiFont("regular.ttf", 19)
		UiColor(1, 1, 1, 0.8)
		UiPush()
			UiTranslate(button1w/2, verticalOff)
			UiAlign("center")
			UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
			if UiTextButton(filterCategoryText[filter+1], button1w, buttonH) then
				filter = (filter+1)%5
				if not isWorkshop and filter == 1 then filter = 2 end
				needUpdate = true
			end
		UiPop()
		UiPush()
			UiTranslate(button1w+button2w/2+1, verticalOff)
			UiAlign("center")
			UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
			if isWorkshop then
				if UiTextButton(filterSortText[sort+1], button2w, buttonH) then
					sort = (sort+1)%4
					needUpdate = true
				end
			elseif isSearch then
				UiTextButton(filterSortText[1], button2w, buttonH)
			else
				if UiTextButton(filterSortText[sort+1], button2w, buttonH) then
					sort = (sort+1)%2
					needUpdate = true
				end
			end
		UiPop()
		UiPush()
			UiTranslate(button1w+button2w+2, verticalOff)
			UiAlign("center")
			UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
			UiPush()
				UiTranslate(button3w/2, -6)
				UiAlign("center middle")
				UiRotate(order and 90 or -90)
				if UiImageButton("ui/common/play.png", buttonH, button3w) then order = not order needUpdate = true end
			UiPop()
		UiPop()
	UiPop()
	return filter, sort, order, needUpdate
end

function drawCreate()
	local open = true
	if initSelect then
		if gModSelected == "" and GetBool(nodes.Settings..".rememberlast") then
			gModSelected, gAuthorSelected = GetString(nodes.Settings..".rememberlast.last"), ""
		end
		if not HasKey("mods.available."..gModSelected) then gModSelected, gAuthorSelected = "", "" end
		initSelect = false
	end
	if gModSelected ~= "" and gAuthorSelected == "" then
		local modAuthorStr = GetString("mods.available."..gModSelected..".author")
		modAuthorStr = modAuthorStr == "" and "%,unknown,%" or modAuthorStr
		gAuthorSelected = strSplit(modAuthorStr, ",")[1]
	end
	if viewLocalPublishedWorkshop and HasKey("mods.publish.id") then
		Command("game.openurl", "https://steamcommunity.com/sharedfiles/filedetails/?id="..GetString("mods.publish.id"))
		Command("mods.publishend")
		viewLocalPublishedWorkshop = false
	end

	local w = 758 + 810
	local h = 940
	local listW = 334
	local listH = 22*28+10
	local mainW = 810
	local mainH = listH+28
	local buttonW = 265
	UiPush()
		UiTranslate(UiCenter(), UiMiddle())
		UiColor(0, 0, 0, 0.5)
		UiAlign("center middle")
		UiImageBox("ui/common/box-solid-shadow-50.png", w, h, -50, -50)
		UiWindow(w, h)
		UiAlign("left top")
		UiColor(0.96, 0.96, 0.96)
		local quitCondA = (gLargePreview or 0) <= 0 and InputPressed("esc")
		local quitCondB = not (UiIsMouseInRect(UiWidth(), UiHeight())) and InputPressed("lmb")
		if not (gCollectionTyping or gSearchTyping) and (quitCondA or quitCondB) then
			open = false
			gMods[1].isdragging = false;
			gMods[2].isdragging = false;
			gMods[3].isdragging = false;
		end
		if quitCondB then
			gCollectionTyping = false
			gCollectionFocus = false
			gCollectionClick = false
			gSearchTyping = false
			gSearchFocus = false
			gSearchClick = false
		end
		
		UiPush()
			-- title
			UiPush()
				UiAlign("top left")
				UiColor(1, 1, 1)
				if gRefreshFade > 0.1 then
					UiPush()
						UiTranslate(38, 100)
						UiFont("bold.ttf", 24)
						UiColorFilter(0.8, 0.8, 0.8, gRefreshFade)
						UiText(locLang.modsRefreshed)
					UiPop()
				end
				UiPush()
					UiFont("bold.ttf", 80)
					UiTranslate(26, 26)
					UiText("loc@UI_TEXT_MODS")
				UiPop()
				UiPush()
					UiTranslate(0, 136)
					UiPush()
						UiTranslate(listW, 1)
						UiAlign("top right")
						UiButtonPressDist(0.25)
						UiPush()
							if gShowSetting then UiColorFilter(0.95, 0.8, 0.5) end
							UiButtonHoverColor(1, 1, 0.45)
							UiButtonPressColor(0.95, 0.95, 0.15)
							UiScale(0.32)
							if UiIsMouseInRect(64, 64) then
								tooltipHoverId = "menuSetting"
								local mouX, mouY = UiGetMousePos()
								tooltip = {x = mouX, y = mouY, text = locLang.settings, mode = 1, bold = false}
							end
							if UiImageButton("ui/components/mod_manager_img/gear-solid.png") then gShowSetting = not gShowSetting end
						UiPop()
						UiTranslate(-30, 0)
						UiPush()
							UiButtonHoverColor(1, 0.15, 0.15)
							UiButtonPressColor(0.85, 0.12, 0.12)
							UiScale(0.32)
							if UiIsMouseInRect(64, 64) then
								tooltipHoverId = "clearUnknownData"
								local mouX, mouY = UiGetMousePos()
								tooltip = {x = mouX, y = mouY, text = locLang.tooltipClearUnknownData, mode = 1, bold = false}
							end
							if UiImageButton("ui/components/mod_manager_img/trash-solid.png") then
								local unknownList = {}
								local unknownIndex = 1
								local unknownData = 0
								local allSavedModData = ListKeys("savegame.mod")
								local totalVal = #allSavedModData
								for i=1, totalVal do
									local currCheckMod = allSavedModData[i]
									if not HasKey("mods.available."..currCheckMod) then
										unknownList[unknownIndex] = currCheckMod
										unknownIndex = unknownIndex + 1
										unknownData = unknownData + getSavegameNodeBytes(currCheckMod)
									end
								end
								local displayBytes, unitIndex = truncateBytesUnits(unknownData)
								local formattedBytes = string.format(byteUnitFormat[unitIndex], displayBytes, byteUnitSuffix[unitIndex])
								yesNoPopInit(string.format(locLang.clearUnknownData, formattedBytes), unknownList, clearModsSavegameData)
							end
						UiPop()
						UiTranslate(-30, 0)
						UiPush()
							UiButtonHoverColor(0.75, 1, 0.75)
							UiButtonPressColor(0.45, 0.95, 0.45)
							UiScale(0.32)
							if UiIsMouseInRect(64, 64) then
								tooltipHoverId = "chooseRandomMod"
								local mouX, mouY = UiGetMousePos()
								local tooltipStr = string.format(locLang.tooltipChooseRandomMod, locLang.cateWorkshopShort)
								tooltip = {x = mouX, y = mouY, text = tooltipStr, mode = 1, bold = false}
							end
							if UiImageButton("ui/components/mod_manager_img/dice.png") then
								local totalModCount = #gMods[2].items
								local rndModIndex, rndModId = 0, ""
								local protectCounter = 0
								repeat
									rndModIndex = math.random(1, totalModCount)
									rndModId = gMods[2].items[rndModIndex].id
									protectCounter = protectCounter + 1
								until not recentRndListLookup[rndModId] or protectCounter > 100
								selectMod(rndModId)
								gMods[2].pos = 5-rndModIndex
								table.insert(recentRndList, 1, rndModId)
								recentRndListLookup[rndModId] = true
								local maxIndex = math.floor(totalModCount*2/3+1)
								local removedId = recentRndList[maxIndex]
								table.remove(recentRndList, maxIndex)
								if removedId then recentRndListLookup[removedId] = nil end
							end
						UiPop()
						UiTranslate(-30, 0)
						UiPush()
							UiButtonHoverColor(0.75, 1, 0.75)
							UiButtonPressColor(0.45, 0.95, 0.45)
							UiScale(0.32)
							if UiIsMouseInRect(64, 64) then
								tooltipHoverId = "refreshMods"
								local mouX, mouY = UiGetMousePos()
								tooltip = {x = mouX, y = mouY, text = locLang.tooltipRefresh, mode = 1, bold = false}
							end
							if UiImageButton("ui/components/mod_manager_img/rotate-solid.png") then
								gRefreshFade = 1
								SetValue("gRefreshFade", 0, "easein", 1.5)
								updateMods()
								updateCollections(true)
								if gSearchText ~= "" then updateSearch() end
							end
						UiPop()
					UiPop()
				UiPop()
				UiTranslate(listW+30, 40)
				UiColor(0.8, 0.8, 0.8, 0.75)
				UiRect(2, 120)
			UiPop()

			-- desc&link / settings
			if not gShowSetting then
				UiPush()
					UiFont("regular.ttf", 22)
					UiTranslate(UiCenter(), 70)
					UiAlign("center")
					UiColor(0.8, 0.8, 0.8)
					UiWordWrap(780)
					UiText("loc@UI_TEXT_CREATE_YOUR", true)
				UiPop()
			else
				local boxSize = 36
				local gap = 10
				local getSettingVal = {
					["bool"] = GetBool,
					["drop"] = GetInt
				}
				UiPush()
					UiTranslate(UiCenter()-355, 52)
					UiAlign("left middle")
					UiColor(0.85, 0.85, 0.85)
					UiFont("regular.ttf", 22)
					for _, setting in ipairs(optionSettings) do
						local tempSettingKey = nodes.Settings.."."..setting.key
						local currSetting = getSettingVal[setting.type](tempSettingKey)
						local txw = 0
						UiPush()
							if setting.type == "bool" then
								UiPush()
									UiTranslate(-26, 0)
									UiAlign("center middle")
									UiButtonImageBox("ui/common/box-outline-4.png", 16, 16, 1, 1, 1, 0.75)
									UiScale(0.5)
									if currSetting then
										if UiImageButton("ui/hud/checkmark.png", boxSize, boxSize) then SetBool(tempSettingKey, not currSetting) end
									else
										if UiBlankButton(boxSize, boxSize) then SetBool(tempSettingKey, not currSetting) end
									end
								UiPop()
							end
							UiPush()
								UiColor(0.85, 0.85, 0.85)
								txw = UiText(setting.title)
							UiPop()
							UiTranslate(txw+gap, 0)
							if setting.type == "drop" then
								local maxW = UiMeasureText(0, table.concat(setting.dropdown, "\n"))+20
								UiPush()
									UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.15)
									UiColor(0.95, 0.95, 0.95)
									UiButtonPressDist(0.2)
									UiButtonTextHandling(1)
									if UiTextButton(setting.dropdown[currSetting+1], maxW, 22) then SetInt(tempSettingKey, (currSetting+1)%3) end
								UiPop()
								UiTranslate(maxW+20, 0)
							end
							if setting.note then
								UiPush()
									UiColor(0.95, 0.45, 0)
									txw = UiText(setting.note)
								UiPop()
								UiTranslate(txw+gap, 0)
							end
						UiPop()
						UiTranslate(0, 24)
					end
				UiPop()
			end

			-- project related
			UiPush()
				UiAlign("top right")
				UiPush()
					UiTranslate(w-38, 40)
					UiFont("bold.ttf", 32)
					UiColor(0.94, 0.94, 0.94)
					UiText("Mod Menu Revamped", true)
					UiFont("regular.ttf", 20)
					UiColor(0.8, 0.8, 0.8)
					UiText(menuVer)
				UiPop()
				UiPush()
					UiTranslate(w-30, 136)
					UiFont("bold.ttf", 22)
					UiColor(0.95, 0.8, 0.5)
					if UiTextButton("Github") then Command("game.openurl", webLinks.projectGithub) end
					UiTranslate(-80, 0)
					if UiTextButton("Crowdin") then Command("game.openurl", webLinks.projectCrowdin) end
				UiPop()
				UiTranslate(w-listW-30, 40)
				UiColor(0.8, 0.8, 0.8, 0.75)
				UiRect(2, 120)
			UiPop()

			UiTranslate(30, 224)

			-- mod listing
			UiPush()
				-- category / search
				UiPush()
					UiAlign("left bottom")
					UiTranslate(0, -4)
					UiFont("bold.ttf", 28)
					UiButtonHoverColor(0.77, 0.77, 0.77)
					UiButtonPressDist(0.5)
					UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
					if gSearchText ~= "" then
						if UiTextButton("loc@UI_TEXT_SEARCH", listW-80, 36) then
							gSearchText = ""
							local modPrefix = gModSelected:match("^(%w+)-")
							local index = category.Lookup[modPrefix]
							category.Index = index and index or category.Index
							if GetBool(nodes.Settings..".resetfilter") then resetSearchSortFilter() end
						end
						UiTranslate(listW-76, 0)
						UiFont("regular.ttf", 24)
						UiButtonHoverColor(1, 1, 1)
						UiButtonPressDist(0)
						local modsCount = gSearch.total[1]+gSearch.total[2]+gSearch.total[3]
						UiTextButton(modsCount > 9999 and "10k+" or modsCount, 76, 36)
					else
						if UiTextButton(gMods[category.Index].title, listW-80, 36) then
							category.Index = category.Index%3+1
							gModSelected = ""
							gAuthorSelected = ""
							if GetBool(nodes.Settings..".resetfilter") then
								resetModSortFilter()
								updateMods()
							end
						end
						UiTranslate(listW-76, 0)
						UiFont("regular.ttf", 24)
						UiButtonHoverColor(1, 1, 1)
						UiButtonPressDist(0)
						local modsCount = gMods[category.Index].total
						UiTextButton(modsCount > 9999 and "10k+" or modsCount, 76, 36)
					end
				UiPop()

				UiTranslate(0, 28)

				-- filter
				UiPush()
					UiTranslate(0, 2)
					if gSearchText == "" then
						local needUpdate = false
						gMods[category.Index].filter, gMods[category.Index].sort, gMods[category.Index].sortInv, needUpdate
						= drawFilter(gMods[category.Index].filter, gMods[category.Index].sort, gMods[category.Index].sortInv, category.Index == 2)
						if needUpdate then updateMods() end
					else
						local needUpdate = false
						gSearch.filter, gSearch.sort, gSearch.sortInv, needUpdate = drawFilter(gSearch.filter, gSearch.sort, gSearch.sortInv, nil, true)
						if needUpdate then updateSearch() end
					end
				UiPop()

				-- Batch selection toggle
				UiPush()
					UiTranslate(0, 32)
					UiFont("regular.ttf", 20)
					UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
					if gBatchSelectionMode then
						UiColor(0.8, 1, 0.8)
						if UiTextButton("Exit Batch Select", 160, 28) then
							gBatchSelectionMode = false
							gSelectedMods = {}
						end
					else
						if UiTextButton("Batch Select", 120, 28) then
							gBatchSelectionMode = true
							gSelectedMods = {}
						end
					end
				UiPop()
				local h = category.Index == 2 and listH-44 or listH
				local selected, rmb_pushed, searchCategory

				if gSearchText ~= "" then
					selected, rmb_pushed, searchCategory = listSearchMods(gSearch, listW, h)
					if selected ~= "" then selectMod(selected) end
				else
					selected, rmb_pushed = listMods(gMods[category.Index], listW, h, category.Index==2, gMods[category.Index].sort==1)
					if selected ~= "" then selectMod(selected) end
				end

				if rmb_pushed then
					contextMenu.Show = true
					contextMenu.Type = gSearchText == "" and category.Index or searchCategory
					SetValueInTable(contextMenu, "Scale", 1, "bounce", 0.35)
					contextMenu.Item = selected
					contextMenu.GetMousePos = true
				end

				if category.Index==2 then
					UiPush()
						if not GetBool("game.workshop") then 
							UiPush()
								UiFont("regular.ttf", 20)
								UiTranslate(50, 110)
								UiColor(0.7, 0.7, 0.7)
								UiText("loc@UI_TEXT_STEAM_WORKSHOP")
							UiPop()
							UiDisableInput()
							UiColorFilter(1, 1, 1, 0.5)
						end
						UiTranslate(0, listH-38)
						UiFont("regular.ttf", 24)
						UiButtonImageBox("ui/common/box-solid-6.png", 6, 6, 1, 1, 1, 0.1)
						if UiTextButton("loc@UI_BUTTON_MANAGE_SUBSCRIBED", listW, 38) then Command("mods.browse") end
					UiPop()
				end
				if InputPressed("esc") or (not UiIsMouseInRect(UiWidth(), UiHeight()) and (InputPressed("lmb") or InputPressed("rmb"))) then contextMenu.Show = false end
			UiPop()

			UiColor(0, 0, 0, 0.1)
			UiTranslate(listW+15, 0)

			-- mod info
			UiPush()
				local modKey = "mods.available."..gModSelected
				UiAlign("left")
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-6.png", mainW, mainH, 6, 6)
				UiWindow(mainW, mainH)
				if gModSelected ~= "" then
					local modPrefix =	gModSelected:match("^(%w+)-")
					local modCategory =	category.Lookup[modPrefix]
					local unknownMod =	false
					local name =		GetString(modKey..".name")
					local author =		GetString(modKey..".author")
					if name == "" then name = "loc@NAME_UNKNOWN" unknownMod = true end
					if author == "" then author = "loc@NAME_UNKNOWN" end
					local authorList =	strSplit(author, ",")
					local tags =		GetString(modKey..".tags")
					local tagList =		strSplit(tags, ",")
					local description =	GetString(modKey..".description")
					local timestamp =	GetString(modKey..".timestamp")
					local modPath =		GetString(modKey..".path")
					local previewPath =	"RAW:"..modPath.."/preview.jpg"
					if not HasFile(previewPath) then previewPath = "RAW:"..modPath.."/preview.png" end
					if prevPreview ~= previewPath then UiUnloadImage(prevPreview) prevPreview = previewPath end
					local hasPreview =	HasFile(previewPath)
					local idPath =		"RAW:"..modPath.."/id.txt"
					local hasId =		modPrefix == "steam" or HasFile(idPath)
					local isLocal =		GetBool(modKey..".local")
					
					UiPush()
						UiAlign("top left")
						UiTranslate(30, 26)
						UiColor(1, 1, 1, 1)
						UiPush()
							UiTextUniformHeight(true)
							UiTranslate(300, 0)
							UiFont("bold.ttf", 32)
							UiWordWrap(mainW-300-60)
							local _, titleH = UiText(name)
						UiPop()
						UiFont("regular.ttf", 20)

						UiPush()
							local poW, poH = 270, 270
							local textWmax = mainW-30*2-poW-35
							local authGap = 12
							if hasPreview then
								local pw, ph = UiGetImageSize(previewPath)
								local Pscale = math.min(poW/pw, poH/ph)
								if UiIsMouseInRect(poW, poH) then
									UiPush()
										UiTranslate(poW/2, poH/2)
										UiAlign("center middle")
										UiRect(poW+14, poH+14)
										UiColor(0.1, 0.1, 0.1)
										UiRect(poW+6, poH+6)
									UiPop()
									if InputPressed("lmb") then
										gLoadedPreview = previewPath
										gQuitLarge = false
										SetValue("gLargePreview", 1, "easeout", 0.1)
									end
								end
								UiPush()
									UiTranslate(poW/2, poH/2)
									UiAlign("center middle")
									UiColor(1, 1, 1)
									UiScale(Pscale)
									UiImage(previewPath)
								UiPop()
							else
								UiPush()
									UiFont("regular.ttf", 20)
									UiColor(0.1, 0.1, 0.1)
									UiRect(poW, poH)
									UiTranslate(poW/2, poH/2)
									UiColor(1, 0.2, 0.2)
									UiAlign("center middle")
									UiWordWrap(200)
									UiTextAlignment("center")
									UiText("loc@UI_TEXT_NO_PREVIEW")
								UiPop()
							end

							UiTranslate(poW+30, titleH+10)
							UiWindow(textWmax, poH-titleH-10, true)

							UiPush()
								if author ~= "" then
									local entryLen = UiText(locLangStrAuthor)
									entryLen = entryLen+16
									UiAlign("top left")
									UiTranslate(entryLen, 0)
									local countDist = 0
									local tempWmax = textWmax-entryLen
									for i, auth in ipairs(authorList) do
										UiWordWrap(tempWmax)
										local authW, authH = UiGetTextSize(auth)
										local transX, transY = authW+authGap, 0
										if authH > 28 then
											if countDist > 0 then UiTranslate(-countDist, 24) end
											countDist = 0
											transX, transY = 0, authH
										elseif countDist + authW+authGap > tempWmax then
											UiTranslate(-countDist, 24)
											countDist = 0
											transX = authW+authGap
										end
										UiTextButton(auth)
										UiTranslate(transX, transY)
										countDist = countDist + transX
									end
									UiTranslate(-entryLen-countDist, 24)
								end
								if tags ~= "" then
									UiTranslate(0, 4)
									local entryLen = UiText("loc@UI_TEXT_TAGS")
									entryLen = entryLen+16
									UiTranslate(entryLen, 0)
									UiButtonImageBox("ui/common/box-outline-4.png", 8, 8, 1, 1, 1, 0.7)
									UiButtonHoverColor(1, 1, 1)
									UiButtonPressColor(1, 1, 1)
									UiButtonPressDist(0)
									local countDist = 0
									local tempWmax = textWmax-entryLen
									for i, tag in ipairs(tagList) do
										local tagW, tagH = UiGetTextSize(tag)
										if countDist + tagW+24 > tempWmax then
											UiTranslate(-countDist, 26)
											countDist = 0
										end
										UiTextButton(tag, tagW+6, 24)
										UiTranslate(tagW+24)
										countDist = countDist + tagW+24
									end
								end
							UiPop()

							UiPush()
								UiTranslate(0, poH-titleH-10)
								UiFont("regular.ttf", 16)
								UiColor(0.9, 0.9, 0.9)
								if HasKey("savegame.mod."..gModSelected) then
									UiTranslate(0, -22)
									local displayBytes, unitIndex = truncateBytesUnits(getSavegameNodeBytes(gModSelected))
									local formattedBytes = string.format(byteUnitFormat[unitIndex], displayBytes, byteUnitSuffix[unitIndex])
									UiButtonHoverColor(0.75, 0.75, 0.3)
									UiButtonPressColor(0.75, 0.75, 0.75)
									UiButtonPressDist(0.1)
									UiPush()
										UiTranslate(-10, 0)
										if UiTextButton(string.format("%s%s", locLang.modSavegameSpace, formattedBytes)) then
											local function clearModSavegameData() ClearKey("savegame.mod."..gModSelected) end
											yesNoPopInit(string.format(locLang.clearModData, formattedBytes), "", clearModSavegameData)
										end
									UiPop()
								end
								if timestamp ~= "" then
									UiTranslate(0, -22)
									UiText(locLangStrUpdateAt..timestamp)
								end
							UiPop()
						UiPop()
						UiTranslate(0, poH+16)

						UiWindow(mainW-30*3-buttonW, mainH-poH-16*2-40-20, true)
						UiWordWrap(mainW-30*3-buttonW-5)
						UiFont("regular.ttf", 20)
						UiColor(.9, .9, .9)
						UiText(description)
					UiPop()

					UiColor(1, 1, 1)
					UiTextUniformHeight(locLang.INDEX ~= 5 or locLang.INDEX ~= 6)
					UiFont("regular.ttf", 24)
					UiButtonImageBox("ui/common/score-frame-7.png", 7, 7, 1, 1, 1, 0.25)
					UiAlign("center middle")

					local modButtonH = 40
					local modButtonT = 50
					local iconLeft = 30
					local iconGap = 25
					local EAcharOffset = (locLang.INDEX == 5 or locLang.INDEX == 6) and 2 or 0

					-- Inline rename & tag edit (local mods only to avoid workshop write restrictions)
					if isLocal then
						UiPush()
							UiTranslate(mainW-buttonW/2-30, mainH-420)
							UiFont("regular.ttf", 18)
							UiAlign("center middle")
							UiButtonImageBox("ui/common/box-outline-4.png",4,4,1,1,1,0.5)
							local renameLabel = gInlineRename.active and locLang.renameApply or locLang.renameMod
							if UiTextButton(renameLabel, buttonW, 30) then
								if not gInlineRename.active then
									gInlineRename.active = true
									gInlineRename.text = name
								else
									-- Persist rename (engine may not allow; attempt SetString on listname key if present)
									SetString("mods.available."..gModSelected..".name", gInlineRename.text)
									SetString("mods.available."..gModSelected..".listname", gInlineRename.text)
									gInlineRename.active = false
									updateMods(); if gSearchText~="" then updateSearch() end
								end
							end
							UiTranslate(0, 34)
							local editTagsLabel = gInlineTags.active and locLang.saveTags or locLang.editTags
							if UiTextButton(editTagsLabel, buttonW, 30) then
								if not gInlineTags.active then
									gInlineTags.active = true
									gInlineTags.text = GetString(modKey..".tags")
								else
									SetString(modKey..".tags", gInlineTags.text)
									gInlineTags.active = false
									updateMods(); if gSearchText~="" then updateSearch() end
								end
							end
							if gInlineRename.active then
								UiTranslate(0, 34)
								UiButtonImageBox("ui/common/box-solid-4.png",4,4,1,1,1,0.15)
								gInlineRename.text = UiTextInput(gInlineRename.text, buttonW, 30, true)
							end
							if gInlineTags.active then
								UiTranslate(0, 34)
								UiButtonImageBox("ui/common/box-solid-4.png",4,4,1,1,1,0.15)
								gInlineTags.text = UiTextInput(gInlineTags.text, buttonW, 30, true)
							end
						UiPop()
					end

					-- edit/copy, details, publish
					UiPush()
						UiTranslate(mainW-buttonW/2-30, mainH-370)
						if isLocal then
							if GetBool(modKey..".playable") then
								UiTranslate(0, modButtonT)
								UiPush()
									if UiIsMouseInRect(buttonW, modButtonH) then UiColorFilter(1, 1, 0.35) end
									if UiBlankButton(buttonW, modButtonH) then Command("mods.edit", gModSelected) end
									UiTranslate(iconLeft-buttonW/2, 0)
									UiPush()
										UiScale(0.34375)
										UiImage("ui/components/mod_manager_img/pen-to-square-solid.png")
									UiPop()
									UiTranslate(iconGap, EAcharOffset)
									UiAlign("left middle")
									UiText("loc@UI_BUTTON_EDIT")
								UiPop()
							end
							UiTranslate(0, modButtonT)
							UiPush()
								if not GetBool("game.workshop")or not GetBool("game.workshop.publish") then 
									UiDisableInput()
									UiColorFilter(1, 1, 1, 0.5)
								elseif UiIsMouseInRect(buttonW, modButtonH) then
									UiColorFilter(1, 1, 0.35)
								end
								if UiBlankButton(buttonW, modButtonH) then
									gPublishLangTitle = nil
									gPublishLangDesc = nil
									gPublishLangIndex = locLang.INDEX
									gPublishDropdown = false
									gPublishLangReload = false
									SetValue("gPublishScale", 1, "cosine", 0.25)
									Command("mods.publishbegin", gModSelected)
								end
								if not GetBool("game.workshop.publish") then
									UiPush()
										UiTranslate(0, 30)
										UiFont("regular.ttf", 18)
										UiText("loc@UI_TEXT_UNAVAILABLE_IN")
									UiPop()
								end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiScale(11/15)
									UiImage("ui/common/img_557_1150.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								UiText("loc@UI_BUTTON_PUBLISH")
							UiPop()
						end
						if not isLocal and not unknownMod then
							UiTranslate(0, modButtonT)
							UiPush()
								local displayText = "loc@UI_BUTTON_MAKE_LOCAL"
								local textLen = UiMeasureText(0, displayText)
								if UiIsMouseInRect(buttonW, modButtonH) then
									UiColorFilter(1, 1, 0.35)
									if textLen > 185 then
										tooltipHoverId = "btnLocalCopy"
										UiPush()
											UiAlign("left middle")
											UiTranslate(iconLeft-buttonW/2+iconGap, 1)
											local curX, curY = UiGetCursorPos()
										UiPop()
										tooltip = {x = curX, y = curY, text = displayText, mode = 3}
									end
								end
								if UiBlankButton(buttonW, modButtonH) then
									Command("mods.makelocalcopy", gModSelected)
									updateMods()
									updateSearch()
								end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiScale(0.34375)
									UiImage("ui/components/mod_manager_img/copy-solid.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								if textLen > 185 then
									UiPush()
										UiWindow(186, modButtonH, true, true)
										UiAlign("left middle")
										UiTranslate(0, modButtonH/2)
										UiText(displayText)
									UiPop()
									UiTranslate(185, 0)
									for i=1, 9 do
										UiTranslate(1, 0)
										UiPush()
											UiWindow(1, modButtonH, true, true)
											UiAlign("left middle")
											UiTranslate(-185-i, modButtonH/2)
											UiColor(1, 1, 1, 1-i*0.1)
											UiText(displayText)
										UiPop()
									end
								else
									UiText(displayText)
								end
							UiPop()
						end
						if hasId then
							UiTranslate(0, modButtonT)
							UiPush()
								if UiIsMouseInRect(buttonW, modButtonH) then UiColorFilter(1, 1, 0.35) end
								if UiBlankButton(buttonW, modButtonH) then
									if isLocal then
										Command("mods.publishbegin", gModSelected)
										viewLocalPublishedWorkshop = true
									else
										Command("mods.browsesubscribed", gModSelected)
									end
								end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiScale(0.34375)
									UiImage("ui/components/mod_manager_img/circle-info-solid.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								UiText("loc@UI_TEXT_DETAILS")
							UiPop()
						end
						-- Savegame browser button
						UiTranslate(0, modButtonT)
						UiPush()
							if UiIsMouseInRect(buttonW, modButtonH) then UiColorFilter(1, 1, 0.35) end
							if UiBlankButton(buttonW, modButtonH) then
								gSavegameBrowser.show = not gSavegameBrowser.show
								if gSavegameBrowser.show then
									-- Populate savegame data with hierarchical structure
									gSavegameBrowser.data = {}
									local savegameKeys = ListKeys("savegame.mod."..gModSelected)
									
									-- Function to recursively build hierarchical data
									local function buildHierarchy(keys, prefix)
										local hierarchy = {}
										local processed = {}
										
										for _, key in ipairs(keys) do
											if key:find(prefix, 1, true) == 1 then
												local remaining = key:sub(#prefix + 1)
												local nextDot = remaining:find("%.")
												local currentKey = nextDot and remaining:sub(1, nextDot - 1) or remaining
												local fullCurrentKey = prefix .. currentKey
												
												if not processed[currentKey] then
													processed[currentKey] = true
													
													local value = GetString("savegame.mod."..gModSelected.."."..fullCurrentKey)
													local isTable = false
													
													-- Check if this is a table (has sub-keys)
													for _, checkKey in ipairs(savegameKeys) do
														if checkKey:find(fullCurrentKey .. ".", 1, true) == 1 then
															isTable = true
															break
														end
													end
													
													local entry = {
														key = currentKey,
														value = value,
														type = isTable and "table" or type(value),
														depth = select(2, fullCurrentKey:gsub("%.", "")) + 1,
														bytes = isTable and getSavegameNodeBytes("savegame.mod."..gModSelected.."."..fullCurrentKey) or nil
													}
													
													table.insert(gSavegameBrowser.data, entry)
													
													-- Recursively process sub-keys if it's a table
													if isTable then
														buildHierarchy(savegameKeys, fullCurrentKey .. ".")
													end
												end
											end
										end
									end
									
									buildHierarchy(savegameKeys, "")
								end
							end
							UiTranslate(iconLeft-buttonW/2, 0)
							UiPush()
								UiScale(0.34375)
								UiImage("ui/components/mod_manager_img/database-solid.png")
							UiPop()
							UiTranslate(iconGap, EAcharOffset)
							UiAlign("left middle")
							UiText(locLang.savegameBrowser)
						UiPop()
					UiPop()

					-- play/enable, options, character
					UiPush()
						UiTranslate(mainW-buttonW/2-30, mainH+10)
						if GetBool(modKey..".playable") then
							UiTranslate(0, -modButtonT)
							UiPush()
								if UiIsMouseInRect(buttonW, modButtonH) then UiColorFilter(0.35, 1, 0.35) end
								if UiBlankButton(buttonW, modButtonH) then Command("mods.play", gModSelected) end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiScale(1.25, 1)
									UiImage("ui/common/play.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								UiText("loc@UI_BUTTON_PLAY")
							UiPop()
						elseif GetBool(modKey..".override") then
							local modActive = GetBool(modKey..".active")
							UiTranslate(0, -modButtonT)
							UiPush()
								if UiIsMouseInRect(buttonW, modButtonH) then
									if modActive then UiColorFilter(0.35, 1, 0.35) else UiColorFilter(1, 0.75, 0.35) end
								end
								if UiBlankButton(buttonW, modButtonH) then
									if modActive then
										Command("mods.deactivate", gModSelected)
										updateMods()
										updateCollections(true)
										updateSearch()
									else
										Command("mods.activate", gModSelected)
										updateMods()
										updateCollections(true)
										updateSearch()
									end
								end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiImage(modActive and "ui/menu/mod-active.png" or "ui/menu/mod-inactive.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								UiText(modActive and "loc@UI_BUTTON_ENABLED" or "loc@UI_BUTTON_DISABLED")
							UiPop()
						end
						if GetBool(modKey..".options") then
							UiTranslate(0, -modButtonT)
							UiPush()
								if UiIsMouseInRect(buttonW, modButtonH) then UiColorFilter(1, 1, 0.35) end
								if UiBlankButton(buttonW, modButtonH) then Command("mods.options", gModSelected) end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiScale(0.34375)
									UiImage("ui/components/mod_manager_img/gear-solid.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								UiText("loc@UI_BUTTON_OPTIONS")
							UiPop()
						end
						if GetBool(modKey..".character") then
							UiTranslate(0, -modButtonT)
							UiPush()
								local displayText = locLang.characterEnableHint
								local textLen = UiMeasureText(0, displayText)
								if UiIsMouseInRect(buttonW, modButtonH) then
									UiColorFilter(1, 1, 0.35)
									if textLen > 185 then
										tooltipHoverId = "btnViewCharacter"
										UiPush()
											UiAlign("left middle")
											UiTranslate(iconLeft-buttonW/2+iconGap, 1)
											local curX, curY = UiGetCursorPos()
										UiPop()
										tooltip = {x = curX, y = curY, text = displayText, mode = 3}
									end
								end
								if UiBlankButton(buttonW, modButtonH) then
									local charctrKey = string.format("%s_%s", gModSelected, ListKeys("characters."..gModSelected)[1])
									tempcharctrSelect = GetString("savegame.player.character")
									SetString("savegame.player.character", charctrKey)
									tempcharctrSetTime = GetTime()
									MainMenu.transitToState(MainMenu.State.Avatar)
								end
								UiTranslate(iconLeft-buttonW/2, 0)
								UiPush()
									UiScale(0.34375)
									UiImage("ui/components/mod_manager_img/external-link.png")
								UiPop()
								UiTranslate(iconGap, EAcharOffset)
								UiAlign("left middle")
								if textLen > 185 then
									UiPush()
										UiWindow(186, modButtonH, true, true)
										UiAlign("left middle")
										UiTranslate(0, modButtonH/2)
										UiText(displayText)
									UiPop()
									UiTranslate(185, 0)
									for i=1, 9 do
										UiTranslate(1, 0)
										UiPush()
											UiWindow(1, modButtonH, true, true)
											UiAlign("left middle")
											UiTranslate(-185-i, modButtonH/2)
											UiColor(1, 1, 1, 1-i*0.1)
											UiText(displayText)
										UiPop()
									end
								else
									UiText(displayText)
								end
							UiPop()
						end
						-- Open folder button
						UiTranslate(0, -modButtonT)
						UiPush()
							if UiIsMouseInRect(buttonW, modButtonH) then UiColorFilter(1, 1, 0.35) end
							if UiBlankButton(buttonW, modButtonH) then Command("game.openfolder", modPath) end
							UiTranslate(iconLeft-buttonW/2, 0)
							UiPush()
								UiScale(0.34375)
								UiImage("ui/components/mod_manager_img/folder-open-solid.png")
							UiPop()
							UiTranslate(iconGap, EAcharOffset)
							UiAlign("left middle")
							UiText(locLang.openFolder)
						UiPop()
					UiPop()

					-- path
					if isLocal or GetBool(nodes.Settings..".showpath."..modCategory) then
						UiPush()
							UiTranslate(UiCenter(), mainH+5)
							UiColor(0.5, 0.5, 0.5)
							UiFont("regular.ttf", 18)
							UiAlign("center top")
							local w, h = UiGetTextSize(modPath)
							if UiIsMouseInRect(w, h) then
								UiColor(1, 0.8, 0.5)
								if InputPressed("lmb") then Command("game.openfolder", modPath) end
							end
							UiText(modPath, true)
						UiPop()
					end
				end
			UiPop()

			-- search mods
			UiPush()
				UiTranslate(0, -4)
				UiAlign("left")
				local tw = mainW
				local th = 36
				UiTranslate(0, -th)
				UiColor(1, 1, 1, 0.07)
				UiImageBox("ui/common/box-solid-4.png", tw, th, 4, 4)
				if InputPressed("lmb") or InputPressed("rmb") then
					gSearchClick = UiIsMouseInRect(tw, th) or gSearchClick
					gSearchFocus = UiIsMouseInRect(tw, th)
					gCollectionFocus = UiIsMouseInRect(tw, th) and false or gCollectionFocus
					gCollectionTyping = UiIsMouseInRect(tw, th) and false or gCollectionTyping
				end
				-- Keyboard type-to-filter: capture printable key when list has focus but not typing already
				if (not gSearchTyping) and (not gCollectionTyping) and UiIsMouseInRect(tw, th) == false then
					local lastKey = InputLastPressedKey()
					if lastKey and #lastKey == 1 and lastKey:match("%w") then
						gSearchClick = true
						gSearchFocus = true
						gSearchTyping = true
						gSearchText = gSearchText .. lastKey
						updateSearch()
					end
				end
				UiColor(1, 1, 1)
				UiFont("regular.ttf", 22)
				local newSearch = ""
				local prevSearchFocus = gSearchFocus
				if gSearchClick then
					if gCollectionClick then gCollectionClick = false else newSearch, gSearchTyping = UiTextInput(gSearchText, tw, th, gSearchFocus) end
				end
				if string.len(newSearch) > 40 then newSearch = string.sub(newSearch, 1, 40) end
				gSearchFocus = false
				if gSearchText == "" then
					UiColor(1, 1, 1, 0.5)
					UiTranslate(4, 26)
					UiText(locLang.searchMod)
					local modPrefix = gModSelected:match("^(%w+)-")
					local index = category.Lookup[modPrefix]
					category.Index = index and index or category.Index
				else
					UiTranslate(tw-24, 9)
					UiColor(1, 1, 1)
					if UiImageButton("ui/common/clearinput.png") then
						newSearch = ""
						gSearchFocus = true
						resetSearchSortFilter()
					end
				end
				if newSearch ~= gSearchText then
					gSearchText = newSearch
					gSearchFocus = true
					updateSearch()
				end
				if gSearchTyping and InputLastPressedKey() == "esc" then
					gSearchClick = false
					gSearchFocus = false
					gSearchTyping = false
				end
				if not gSearchFocus and prevSearchFocus then resetSearchSortFilter() end

				-- Saved searches buttons (right side overlay)
				UiPush()
					UiTranslate(tw-300, -th)
					UiFont("regular.ttf", 18)
					UiButtonImageBox("ui/common/box-outline-4.png",4,4,1,1,1,0.4)
					if UiTextButton(locLang.addSavedSearch, 140, th) then
						local idx = #gSavedSearches+1
						gSavedSearches[idx] = gSearchText
						SetString(gSavedSearchesKey.."."..idx, gSearchText)
					end
					UiTranslate(150,0)
					UiButtonImageBox("ui/common/box-outline-4.png",4,4,1,1,1,0.4)
					if UiTextButton(locLang.savedSearches, 140, th) then
						gShowScanPopup = true
						gScanResults.integrity = {}
						for i, q in ipairs(gSavedSearches) do
							gScanResults.integrity[#gScanResults.integrity+1] = { id = tostring(i), issue = q }
						end
					end
				UiPop()
			UiPop()

			UiColor(0, 0, 0, 0.1)
			UiTranslate(mainW+15, 0)

			-- collections
			UiPush()
				UiFont("bold.ttf", 22)
				UiAlign("left")
				UiPush()
					local tw = listW
					local th = 36
					UiTranslate(0, -th-4)
					if errorData.Fade > 0.05 then
						UiPush()
							UiAlign("bottom left")
							UiTranslate(0, -4)
							UiWordWrap(tw-14)
							UiFont("regular.ttf", 20)
							UiColor(1, 0.4, 0.4, errorData.Fade)
							UiText(errorData.List[errorData.Code])
						UiPop()
					end
					UiColor(1, 1, 1, 0.07)
					UiImageBox("ui/common/box-solid-4.png", tw, th, 4, 4)
					if InputPressed("lmb") or InputPressed("rmb") then
						gCollectionClick = UiIsMouseInRect(tw, th)
						gCollectionFocus = UiIsMouseInRect(tw, th)
						gSearchFocus = UiIsMouseInRect(tw, th) and false or gSearchFocus
						gSearchTyping = UiIsMouseInRect(tw, th) and false or gSearchTyping
						gCollectionRename = UiIsMouseInRect(tw, th) and gCollectionRename or false
					end
					UiColor(1, 1, 1)
					UiFont("regular.ttf", 22)
					local newText = ""
					if gCollectionClick then
						if gSearchClick then gSearchClick = false else newText, gCollectionTyping = UiTextInput(gCollectionName, tw, th, gCollectionFocus) end
					end
					if string.len(newText) > 20 then newText = string.sub(newText, 1, 20) end
					gCollectionFocus = false
					if gCollectionName == "" then
						UiColor(1, 1, 1, 0.5)
						UiTranslate(4, 26)
						UiText(gCollectionRename and locLang.renameCol or locLang.newCol)
					else
						UiTranslate(tw-24, 9)
						UiColor(1, 1, 1)
						if UiImageButton("ui/common/clearinput.png") then
							newText = ""
							gCollectionFocus = true
						end
					end
					if newText ~= gCollectionName then
						gCollectionName = newText
						gCollectionFocus = true
					end
					if gCollectionTyping and InputLastPressedKey() == "return" then
						local failed
						if gCollectionRename then
							local id = gCollections[gCollectionSelected].lookup
							failed, errorData.Code = renameCollection(id, gCollectionName)
						else
							failed, errorData.Code = newCollection(gCollectionName)
						end
						if failed then
							errorData.Show = true
							errorData.Fade = 1
							SetValueInTable(errorData, "Fade", 0, "easein", 2.5)
						else
							gCollectionName = ""
							gCollectionClick = false
							gCollectionFocus = false
							gCollectionRename = false
							gCollectionTyping = false
							updateCollections()
						end
					end
					if gCollectionTyping and InputLastPressedKey() == "esc" then
						gCollectionClick = false
						gCollectionFocus = false
						gCollectionRename = false
						gCollectionTyping = false
					end
				UiPop()
				local hcl = 9*22+10
				local hcm = 17*22+10
				local rmb_pushedC
				local prevSelect = gCollectionSelected

				gCollectionSelected, rmb_pushedC = listCollections(gCollections, listW, hcl)
				local validCollection = gCollections[gCollectionSelected]
				if prevSelect ~= gCollectionSelected then updateCollectMods(gCollectionSelected) end

				UiTranslate(0, listH-hcm+28)
				UiPush()
					UiPush()
						UiTranslate(0, -36)
						UiFont("bold.ttf", 22)
						UiAlign("left")
						UiColor(0.96, 0.96, 0.96, 0.9)
						UiText(locLang.collection)
						if validCollection then
							UiAlign("right")
							UiTranslate(listW-50, 0)
							UiText(validCollection.name)
							UiTranslate(50, 0)
							UiFont("regular.ttf", 20)
							local modsCount = validCollection.total
							UiText(modsCount > 9999 and "10k+" or modsCount)
						end
					UiPop()

					-- Batch add to collection button
					if gBatchSelectionMode and next(gSelectedMods) then
						UiPush()
							UiTranslate(0, -2)
							UiFont("regular.ttf", 18)
							UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
							UiColor(0.8, 1, 0.8)
							local selectedCount = 0
							for _ in pairs(gSelectedMods) do selectedCount = selectedCount + 1 end
							if UiTextButton(locLang.batchAddToCollection, 220, 28) then
								-- Show collection selection popup
								gShowBatchCollectionPopup = true
							end
						UiPop()
					end

					UiTranslate(0, 2)
					-- Batch selection toggle
					UiPush()
						UiTranslate(0, 5)
						local buttonText = gBatchSelectionMode and locLang.exitBatchSelect or locLang.batchSelect
						local buttonColor = gBatchSelectionMode and {0.8, 0.6, 0.6} or {0.6, 0.8, 0.6}
						UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 1, 1, 1, 0.1)
						UiColor(unpack(buttonColor))
						if UiTextButton(buttonText, 140, 28) then
							gBatchSelectionMode = not gBatchSelectionMode
							if not gBatchSelectionMode then
								gSelectedMods = {}
							end
						end
					UiPop()
					UiTranslate(0, 2)
					-- filter
					local needUpdate = false
					gCollectionList.filter, gCollectionList.sort, gCollectionList.sortInv, needUpdate
					= drawFilter(gCollectionList.filter, gCollectionList.sort, gCollectionList.sortInv)
					if needUpdate then updateCollectMods(gCollectionSelected) end
				UiPop()
				local selected, rmb_pushedM = listCollectionMods(gCollections, listW, hcm, gCollectionSelected, gCollectionList.sort == 1)

				if selected ~= "" then
					selectMod(selected)
					local modPrefix = selected:match("^(%w+)-")
					category.Index = category.Lookup[modPrefix] or category.Index
				end

				if validCollection and (rmb_pushedC or (rmb_pushedM and getGlobalModCountCollection() > 0 )) then
					collectionPop = true
					SetValueInTable(contextMenu, "Scale", 1, "bounce", 0.35)
					contextMenu.Item = gCollections[gCollectionSelected].lookup
					contextMenu.IsCollection = rmb_pushedC
					contextMenu.GetMousePos = true
				end
			UiPop()
		UiPop()
	UiPop()
	return open
end

function drawSavegameBrowser()
	if not gSavegameBrowser.show then return end
	
	UiModalBegin()
	UiBlur(1)
	UiPush()
		local w, h = 800, 600
		UiTranslate(UiCenter(), UiMiddle())
		UiColor(0, 0, 0, 0.5)
		UiAlign("center middle")
		UiImageBox("ui/common/box-solid-shadow-50.png", w, h, -50, -50)
		UiWindow(w, h)
		UiAlign("left top")
		UiColor(1, 1, 1)
		
		-- Close on ESC or outside click
		if InputPressed("esc") or (not UiIsMouseInRect(UiWidth(), UiHeight()) and InputPressed("lmb")) then
			gSavegameBrowser.show = false
		end
		
		-- Title
		UiPush()
			UiFont("bold.ttf", 32)
			UiAlign("center")
			UiTranslate(UiCenter(), 20)
			UiText(locLang.savegameBrowser)
		UiPop()
		
		-- Close button
		UiPush()
			UiAlign("top right")
			UiTranslate(w - 40, 10)
			UiFont("regular.ttf", 24)
			if UiTextButton("×", 30, 30) then
				gSavegameBrowser.show = false
			end
		UiPop()
		
		-- Content area
		UiPush()
			UiTranslate(20, 60)
			local contentW, contentH = w - 40, h - 80
			
			-- Scrollable area for savegame data
			if not gSavegameBrowser.scrollY then gSavegameBrowser.scrollY = 0 end
			
			-- Handle scrolling
			local scrollSpeed = 20
			if UiIsMouseInRect(contentW, contentH) then
				local scroll = InputValue("mousewheel")
				if scroll ~= 0 then
					gSavegameBrowser.scrollY = gSavegameBrowser.scrollY - scroll * scrollSpeed
				end
			end
			
			UiWindow(contentW, contentH, true)
			UiAlign("left top")
			UiFont("regular.ttf", 18)
			
			if #gSavegameBrowser.data == 0 then
				UiColor(0.7, 0.7, 0.7)
				UiText("No savegame data found for this mod.")
			else
				local lineHeight = 24
				local totalHeight = #gSavegameBrowser.data * lineHeight
				gSavegameBrowser.scrollY = math.max(0, math.min(gSavegameBrowser.scrollY, totalHeight - contentH))
				
				local startY = gSavegameBrowser.scrollY
				local y = -startY
				local maxLines = math.ceil(contentH / lineHeight) + 1
				local startIndex = math.max(1, math.floor(startY / lineHeight) + 1)
				local endIndex = math.min(#gSavegameBrowser.data, startIndex + maxLines - 1)
				
				for i = startIndex, endIndex do
					local entry = gSavegameBrowser.data[i]
					UiPush()
						UiTranslate(0, y)
						
						-- Indentation based on depth
						local indent = entry.depth * 20
						UiTranslate(indent, 0)
						
						-- Key
						UiColor(0.9, 0.9, 1)
						local keyText = entry.key
						if entry.type == "table" then
							keyText = keyText .. " {"
						end
						UiText(keyText)
						
						-- Value (if not a table)
						if entry.type ~= "table" then
							local valueText = tostring(entry.value)
							if entry.bytes then
								valueText = valueText .. " (" .. truncateBytesUnits(entry.bytes) .. ")"
							end
							UiTranslate(UiMeasureText(0, keyText) + 10, 0)
							UiColor(1, 1, 1)
							UiText(valueText)
						end
						
						y = y + lineHeight
					UiPop()
				end
				
				-- Add scrollbar if needed
				if totalHeight > contentH then
					local scrollbarWidth = 12
					local scrollbarHeight = contentH * (contentH / totalHeight)
					local scrollbarY = (gSavegameBrowser.scrollY / (totalHeight - contentH)) * (contentH - scrollbarHeight)
					
					UiPush()
						UiTranslate(contentW - scrollbarWidth - 2, 0)
						UiColor(0.2, 0.2, 0.2, 0.8)
						UiRect(scrollbarWidth, contentH)
						UiColor(0.5, 0.5, 0.5, 1)
						UiTranslate(0, scrollbarY)
						UiRect(scrollbarWidth, scrollbarHeight)
					UiPop()
				end
			end
		UiPop()
		
	UiPop()
	UiModalEnd()
end

function drawBatchCollectionPopup()
	if not gShowBatchCollectionPopup then return end
	
	UiModalBegin()
	UiBlur(1)
	UiPush()
		local w, h = 600, 400
		UiTranslate(UiCenter(), UiMiddle())
		UiColor(0, 0, 0, 0.5)
		UiAlign("center middle")
		UiImageBox("ui/common/box-solid-shadow-50.png", w, h, -50, -50)
		UiWindow(w, h)
		UiAlign("left top")
		UiColor(1, 1, 1)
		
		-- Close on ESC or outside click
		if InputPressed("esc") or (not UiIsMouseInRect(UiWidth(), UiHeight()) and InputPressed("lmb")) then
			gShowBatchCollectionPopup = false
		end
		
		-- Title
		UiPush()
			UiFont("bold.ttf", 28)
			UiAlign("center")
			UiTranslate(UiCenter(), 20)
			local selectedCount = 0
			for _ in pairs(gSelectedMods) do selectedCount = selectedCount + 1 end
			UiText("Add " .. selectedCount .. " mods to collection")
		UiPop()
		
		-- Close button
		UiPush()
			UiAlign("top right")
			UiTranslate(w - 40, 10)
			UiFont("regular.ttf", 24)
			if UiTextButton("×", 30, 30) then
				gShowBatchCollectionPopup = false
			end
		UiPop()
		
		-- Content area
		UiPush()
			UiTranslate(20, 60)
			local contentW, contentH = w - 40, h - 120
			
			UiFont("regular.ttf", 20)
			UiText(locLang.selectCollection)
			UiTranslate(0, 30)
			
			-- List collections
			local collectionKeys = {}
			for key in pairs(gCollections) do
				table.insert(collectionKeys, key)
			end
			table.sort(collectionKeys)
			
			local buttonHeight = 35
			local maxVisible = math.floor(contentH / buttonHeight)
			if not gBatchCollectionScroll then gBatchCollectionScroll = 0 end
			
			-- Handle scrolling
			if UiIsMouseInRect(contentW, contentH) then
				local scroll = InputValue("mousewheel")
				if scroll ~= 0 then
					gBatchCollectionScroll = math.max(0, math.min(gBatchCollectionScroll - scroll * 2, #collectionKeys - maxVisible))
				end
			end
			
			UiWindow(contentW, contentH, true)
			
			for i = 1, #collectionKeys do
				local key = collectionKeys[i]
				local collection = gCollections[key]
				if i > gBatchCollectionScroll and i <= gBatchCollectionScroll + maxVisible then
					UiPush()
						UiTranslate(0, (i - gBatchCollectionScroll - 1) * buttonHeight)
						UiButtonImageBox("ui/common/box-outline-4.png", 4, 4, 0.8, 0.8, 0.8, 0.1)
						if UiTextButton(collection.name, contentW - 20, buttonHeight - 5) then
							-- Add selected mods to this collection
							for modId in pairs(gSelectedMods) do
								handleModCollect(modId, key)
							end
							gShowBatchCollectionPopup = false
							gBatchSelectionMode = false
							gSelectedMods = {}
							break
						end
					UiPop()
				end
			end
			
			-- Scrollbar if needed
			if #collectionKeys > maxVisible then
				local scrollbarWidth = 12
				local scrollbarHeight = contentH * (maxVisible / #collectionKeys)
				local scrollbarY = (gBatchCollectionScroll / (#collectionKeys - maxVisible)) * (contentH - scrollbarHeight)
				
				UiPush()
					UiTranslate(contentW - scrollbarWidth - 2, 0)
					UiColor(0.2, 0.2, 0.2, 0.8)
					UiRect(scrollbarWidth, contentH)
					UiColor(0.5, 0.5, 0.5, 1)
					UiTranslate(0, scrollbarY)
					UiRect(scrollbarWidth, scrollbarHeight)
				UiPop()
			end
		UiPop()
		
		-- Cancel button
		UiPush()
			UiAlign("bottom center")
			UiTranslate(UiCenter(), h - 50)
			UiFont("regular.ttf", 20)
			if UiTextButton(locLang.cancel, 100, 30) then
				gShowBatchCollectionPopup = false
			end
		UiPop()
		
	UiPop()
	UiModalEnd()
end

function drawLargePreview(show)
	if not show then return end
	local largeW, largeH = UiHeight()*0.9, UiHeight()*0.9
	local pw, ph = UiGetImageSize(gLoadedPreview)
	UiPush()
		UiAlign("center middle")
		UiTranslate(UiCenter(), UiMiddle())
		UiModalBegin()
		UiBlur(gLargePreview)
		UiScale(gLargePreview)
		UiScale(math.min(largeW/pw, largeH/ph))
		UiColor(1, 1, 1, gLargePreview)
		UiImage(gLoadedPreview)
		if not gQuitLarge and InputPressed("esc") or InputPressed("lmb") or InputPressed("rmb") then
			SetValue("gLargePreview", 0, "easein", 0.1)
			gQuitLarge = true
		end
	UiPop()
end

function drawPublish(show)
	if not show then
		if HasKey("mods.publish.id") and not viewLocalPublishedWorkshop then Command("mods.publishend") end
		return nil
	end
	UiModalBegin()
	UiBlur(gPublishScale)
	UiPush()
		local w = 900
		local h = 740
		UiTranslate(UiCenter(), UiMiddle())
		UiScale(gPublishScale)
		UiColor(0, 0, 0, 0.5)
		UiAlign("center middle")
		UiImageBox("ui/common/box-solid-shadow-50.png", w, h, -50, -50)
		UiWindow(w, h)
		UiAlign("left top")
		UiColor(1, 1, 1)

		local publish_state = GetString("mods.publish.state")
		local canEsc = publish_state ~= "uploading"
		if canEsc and (InputPressed("esc") or (not UiIsMouseInRect(UiWidth(), UiHeight()) and InputPressed("lmb"))) then
			SetValue("gPublishScale", 0, "cosine", 0.25)
			Command("mods.publishend")
		end
		
		UiPush()
			UiFont("bold.ttf", 55)
			UiColor(1, 1, 1)
			UiAlign("center")
			UiTranslate(UiCenter(), 64)
			UiText("loc@UI_TEXT_PUBLISH_MOD")
		UiPop()
		
		local mw, mh = 320, 320
		local descW = 460
		local gap = 40

		local id = GetString("mods.publish.id")
		local modKey = "mods.available."..gModSelected
		local name = gPublishLangTitle or GetString(modKey..".name")
		local author = GetString(modKey..".author")
		local tags = GetString(modKey..".tags")
		local description = gPublishLangDesc or GetString(modKey..".description")
		local previewPath = "RAW:"..GetString(modKey..".path").."/preview.jpg"
		if not HasFile(previewPath) then previewPath = "RAW:"..GetString(modKey..".path").."/preview.png" end
		if prevPreview ~= previewPath then UiUnloadImage(prevPreview) prevPreview = previewPath end
		local hasPreview = HasFile(previewPath)
		local missingInfo = false

		if gPublishLangReload then
			gPublishLangReload = false
			local orgIndex = locLang.INDEX
			local selectIndex = gPublishLangIndex
			LoadLanguageTable(gPublishLangIndex)
			gPublishLangTitle = GetString(modKey..".name")
			gPublishLangDesc = GetString(modKey..".description")
			LoadLanguageTable(orgIndex)
			name = gPublishLangTitle
			description = gPublishLangDesc
			gPublishLangIndex = selectIndex
		end

		UiPush()
			UiTranslate(gap, 120)
			UiPush()
				UiWordWrap(descW)
				UiFont("bold.ttf", 40)
				UiAlign("left top")
				if name ~= "" then UiText(name) else
					UiColor(1, 0.2, 0.2)
					UiText("loc@UI_TEXT_NAME_NOT")
					UiColor(1, 1, 1)
					missingInfo = true
				end

				UiTranslate(0, 90)
				UiFont("regular.ttf", 20)

				if id ~= "0" then UiText(locLangStrWorkshopID..id, true) end
				if author ~= "" then UiText(locLangStrByAuthor..author, true) else
					UiColor(1, 0.2, 0.2)
					UiText("loc@UI_TEXT_AUTHOR_NOT", true)
					UiColor(1, 1, 1)
					missingInfo = true
				end
				if tags ~= "" then
					UiWindow(descW, 22, true)
					UiText(locLangStrModTags..tags, true)
					UiTranslate(0, 16)
				end

				UiFont("regular.ttf", 20)
				UiColor(.8, .8, .8)

				if description ~= "" then
					UiWindow(descW, 104, true)
					UiText(description, true)
				else
					UiColor(1, 0.2, 0.2)
					UiText("loc@UI_TEXT_DESCRIPTION_NOT", true)
					UiColor(1, 1, 1)
					missingInfo = true
				end
			UiPop()
			UiPush()
				UiTranslate(w-gap*2-mw, 0)
				UiPush()
					UiColor(1, 1, 1, 0.05)
					UiRect(mw, mh)
				UiPop()
				if hasPreview then
					local pw, ph = UiGetImageSize(previewPath)
					local scale = math.min(mw/pw, mh/ph)
					UiPush()
						UiTranslate(mw/2, mh/2)
						UiAlign("center middle")
						UiColor(1, 1, 1)
						UiScale(scale)
						UiImage(previewPath)
					UiPop()
				else
					UiPush()
						UiFont("regular.ttf", 20)
						UiTranslate(mw/2, mh/2)
						UiColor(1, 0.2, 0.2)
						UiAlign("center middle")
						UiText("loc@UI_TEXT_NO_PREVIEW", true)
					UiPop()
				end
			UiPop()
		UiPop()
		
		local state = GetString("mods.publish.state")
		local canPublish = (state == "ready" or state == "failed")
		local update = (id ~= "0")
		local failMessage = GetString("mods.publish.message")

		local buttonW, buttonH, buttonGap = 190, 45, 10

		UiPush()
			if missingInfo then
				canPublish = false
				failMessage = "loc@FAILMESSAGE_INCOMPLETE_INFORMATION"
			elseif not hasPreview then
				canPublish = false
				failMessage = "loc@FAILMESSAGE_PREVIEW_IMAGE"
			end

			UiAlign("bottom right")
			UiFont("regular.ttf", 24)
			UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 1, 1, 0.7)

			if state == "uploading" then
				UiPush()
					UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 0.55, 0.15, 0.7)
					UiColor(1, 0.55, 0.15)
					UiTranslate(w-50, h-30)
					if UiTextButton("loc@UI_BUTTON_CANCEL", buttonW, buttonH) then Command("mods.publishcancel") end
				UiPop()
				local progress = GetFloat("mods.publish.progress")
				if progress < 0.1 then progress = 0.1 end
				if progress > 0.9 then progress = 0.9 end
				UiPush()
					UiTranslate((w-350)/2, h-30-40)
					UiAlign("top left")
					UiColor(0, 0, 0)
					UiRect(350, 36)
					UiColor(1, 1, 1)
					UiTranslate(2, 2)
					UiRect(346*progress, 32)
					UiColor(0.5, 0.5, 0.5)
					UiTranslate(175, 18)
					UiAlign("center middle")
					UiText("loc@UI_TEXT_UPLOADING")
				UiPop()
			elseif state == "done" then
				UiPush()
					UiTranslate(w-50, h-30)
					if UiTextButton("loc@UI_BUTTON_DONE", buttonW, buttonH) then
						SetValue("gPublishScale", 0, "easein", 0.25)
						Command("mods.publishend")
					end
				UiPop()			
			else
				UiPush()
					local caption = update and "loc@CAPTION_PUBLISH_UPDATE" or "loc@CAPTION_PUBLISH"
					local val = GetInt("mods.publish.visibility")
					local buttonTextLookup = {
						"loc@UI_BUTTON_PUBLIC",
						"loc@UI_BUTTON_FRIENDS",
						"loc@UI_BUTTON_PRIVATE",
						"loc@UI_BUTTON_UNLISTED"
					}
					local indexLookup = {
						"loc@UI_ENGLISH",
						"loc@UI_FRENCH",
						"loc@UI_SPANISH",
						"loc@UI_ITALIAN",
						"loc@UI_GERMAN",
						"loc@UI_SCHINESE",
						"loc@UI_JAPANESE",
						"loc@UI_RUSSIAN",
						"loc@UI_POLISH",
					}

					UiTranslate(w-50, h-30)
					if not canPublish then
						UiDisableInput()
						UiColorFilter(1, 1, 1, 0.3)
					end

					if UiTextButton(caption, buttonW, buttonH) then Command("mods.publishupload") end

					UiTranslate(0, -(buttonH+buttonGap))
					if val == -1 then UiTextButton("loc@NAME_UNKNOWN", buttonW, buttonH) elseif UiTextButton(buttonTextLookup[val+1], buttonW, buttonH) then SetInt("mods.publish.visibility", (val+1)%4) end
					
					UiTranslate(0, -150)
					if UiTextButton(indexLookup[gPublishLangIndex+1], buttonW, buttonH) then gPublishDropdown = not gPublishDropdown end
					
					if gPublishDropdown then
						local dropH, dropGap = 30, 2
						local dropListH = buttonH+dropH*9+dropGap
						local close = false

						UiPush()
							UiModalBegin()
							UiAlign("center middle")
							UiTranslate(-buttonW/2, dropListH/2-buttonH)
							
							if InputPressed("esc") then gPublishDropdown, close = false, true end
							if not UiIsMouseInRect(buttonW, dropListH) and InputPressed("lmb") or InputPressed("rmb") then gPublishDropdown, close = false, true end

							UiColor(0.25, 0.25, 0.25, 0.875)
							UiImageBox("ui/common/box-solid-6.png", buttonW, dropListH, 6, 6)
							UiPush()
								UiTranslate(0, (buttonH-dropListH)/2)
								UiColor(1, 1, 1, 1)
								UiButtonImageBox("", 0, 0)
								if UiTextButton(indexLookup[gPublishLangIndex+1]) and not close then gPublishDropdown = not gPublishDropdown end
								UiTranslate(0, buttonH/2-1)
								UiColor(1, 1, 1, 0.7)
								UiRect(buttonW-4, 1)
							UiPop()
							UiColor(1, 1, 1, 0.7)
							UiImageBox("ui/common/box-outline-6.png", buttonW, dropListH, 6, 6)

							UiColor(1, 1, 1, 1)
							UiTranslate(0, buttonH-dropListH/2+dropH/2)

							for i=0, 8 do
								local rectW = buttonW-2*dropGap
								UiPush()
									UiButtonImageBox("ui/common/box-2.png", 0, 0, 0, 0, 0, 0)
									if i%2 == 0 then UiButtonImageBox("ui/common/box-2.png", 1, 1, 0.5, 0.5, 0.5, 0.125) end
									if UiTextButton(indexLookup[i+1], buttonW-dropGap*2, dropH) and not close then
										gPublishDropdown = false
										gPublishLangReload = true
										gPublishLangIndex = i
									end
								UiPop()
								UiTranslate(0, dropH)
							end
						UiPop()
					end
				UiPop()
				UiPush()
					if failMessage ~= "" then
						UiColor(1, 0.2, 0.2)
						UiTranslate(w/2, h-30-40)
						UiAlign("center middle")
						UiFont("regular.ttf", 20)
						UiWordWrap(370)
						UiText(failMessage)
					end
				UiPop()
			end
		UiPop()
	UiPop()
	UiModalEnd()
	return true
end

function drawPopElements()
	-- context menu
	if contextMenu.Show then
		if contextMenu.GetMousePos then
			contextMenu.PosX, contextMenu.PosY = UiGetMousePos()
			contextMenu.GetMousePos = false
		end
		if gSearchText == "" then
			contextMenu.Show = contextMenu.Common(contextMenu.Item, contextMenu.Type)
		else
			contextMenu.Show = contextMenu.Search(contextMenu.Item, contextMenu.Type)
		end
		if not contextMenu.Show then contextMenu.Scale = 0 end
	end

	if collectionPop then
		if contextMenu.GetMousePos then
			contextMenu.PosX, contextMenu.PosY = UiGetMousePos()
			contextMenu.GetMousePos = false
		end
		collectionPop = contextMenu.Collection(contextMenu.Item)
		if not collectionPop then contextMenu.Scale = 0 end
	end

	-- yes-no popup
	if yesNoPopPopup.show and yesNoPop() then
		yesNoPopPopup.show = false
		if yesNoPopPopup.yes and yesNoPopPopup.yes_fn ~= nil then yesNoPopPopup.yes_fn() end
		if yesNoPopPopup.no and yesNoPopPopup.no_fn ~= nil then yesNoPopPopup.no_fn() end
	end

	-- last selected mod
	if prevSelectMod ~= gModSelected and gModSelected ~= "" then
		SetString(nodes.Settings..".rememberlast.last", gModSelected)
		prevSelectMod = gModSelected
	end
end

function setWindowSize()
	local screenSize = GetScreenSize()
	if screenSize.w/16 > screenSize.h/9 then
		local scaleFact = 1080/screenSize.h
		ModManager.Window.w = screenSize.w*scaleFact
	end
	if screenSize.w/16 < screenSize.h/9 then
		local scaleFact = 1920/screenSize.w
		ModManager.Window.h = screenSize.h*scaleFact
	end
end


ModManager = {}
ModManager.Window = Ui.Window
{
	w = 1920,
	h = 1080,
	animator = { playTime = 0.2 },
    ignoreNavigation = true,

	onPreDraw = 	function(self)
		if self.animator.isFinished then UiSetCursorState(UI_CURSOR_SHOW) end
		SetFloat("game.music.volume", (1.0 - 0.8 * self.animator.factor))
	end,

	onDraw = 		function(self)
		local menuOpen = false
		UiPush()
			UiModalBegin()
			-- if tonumber(InputLastPressedKey()) then LoadLanguageTable(InputLastPressedKey()) end
			-- UiPush()
			-- 	UiColor(1, 1, 1)
			-- 	UiAlign("top left")
			-- 	UiFont("bold.ttf", 24)
			-- 	UiButtonTextHandling(math.floor((GetTime()/10)%5))
			-- 	UiButtonImageBox("ui/common/box-outline-6.png", 6, 6)
			-- 	UiTextButton("euvngpQOE7RNTV[], 4Y N8WENF PUGNVFPasiudfgvblafgb poadnh UA asduk  fbmasovn, opt_h", 60, 30)
			-- 	UiTranslate(0, 40)
			-- 	UiText(math.floor((GetTime()/10)%5))
			-- UiPop()
			-- damn you saber for spending so long only to failed in implmenting UiButtonTextHandling() mode 1 & 3
			menuOpen = drawCreate()
			drawPopElements()
			drawLargePreview(gLargePreview > 0)
			drawSavegameBrowser()
			drawBatchCollectionPopup()
			menuOpen = drawPublish(gPublishScale > 0) or menuOpen
			if not menuOpen then self:hide() end
			UiModalEnd()
		UiPop()
	end,

	onPostDraw =	function(self)
		UiPush()
			if tooltipHoverId == "" then
				if tooltipPrevId ~= "" then
					tooltipCooldown = 1
					SetValue("tooltipCooldown", 0, "linear", 1)
				end
				tooltipPrevId = tooltipHoverId
				tooltipTimer = 0
				tooltip = {x = 0, y = 0, text = "", mode = 1, bold = false}
				return
			end
			local maxTimer = tooltipCooldown > 0.001 and 0.25 or 1
			if tooltipPrevId ~= tooltipHoverId then
				tooltipTimer = 0
				tooltipCooldown = 1
				SetValue("tooltipCooldown", 0, "linear", 1)
			end
			tooltipTimer = tooltipTimer + GetTimeStep()
			tooltipPrevId = tooltipHoverId
			if tooltipDisable then
				tooltipTimer = 0
				tooltip = {x = 0, y = 0, text = "", mode = 1, bold = false}
				return
			end
			if tooltipTimer < maxTimer then return end
			if tooltip.mode == 1 then
				local mouX, mouY = UiGetMousePos()
				UiAlign("top left")
				UiTranslate(mouX, mouY+16)
				UiFont("regular.ttf", 20)
				UiButtonPressColor(1, 1, 1)
				UiButtonHoverColor(1, 1, 1)
				UiButtonPressDist(0)
				UiButtonImageBox("ui/common/box-solid-4.png", 4, 4, 0.125, 0.125, 0.125)
				UiColor(0.95, 0.95, 0.95)
				UiTextButton(tooltip.text)
			elseif tooltip.mode == 2 then
				UiAlign("left")
				UiTranslate(tooltip.x, tooltip.y)
				if tooltip.bold then UiFont("bold.ttf", 20) else UiFont("regular.ttf", 22) end
				local txw = UiMeasureText(0, tooltip.text)
				UiPush()
					UiTranslate(200, -18)
					UiColor(0.375, 0.375, 0.375)
					UiImageBox("ui/common/hgradient-right-64.png", 100, 22, 0, 0)
					UiTranslate(100, 0)
					UiRect(txw-295, 22)
				UiPop()
				UiColor(0.95, 0.95, 0.95)
				UiText(tooltip.text)
			elseif tooltip.mode == 3 then
				UiTextUniformHeight(locLang.INDEX ~= 5 or locLang.INDEX ~= 6)
				UiAlign("left middle")
				UiTranslate(tooltip.x, tooltip.y)
				UiFont("regular.ttf", 24)
				local txw = UiMeasureText(0, tooltip.text)
				UiPush()
					UiTranslate(txw-175, -1)
					UiColor(0.375, 0.375, 0.375)
					UiImageBox("ui/common/hgradient-right-64.png", 100, 28, 0, 0)
					UiTranslate(100, 0)
					UiRect(78, 28)
					UiTranslate(74, 0)
					UiRoundedRect(8, 28, 4)
				UiPop()
				UiColor(0.95, 0.95, 0.95)
				UiText(tooltip.text)
			end
		UiPop()
		tooltipHoverId = ""
	end,

	onCreate = 		function(self) initLoc() end,

	onShow = 		function(self)
		self:refresh()
		initSelect = true
		ModManager.WindowAnimation.duration = 0.2
		ModManager.WindowAnimation:init(self)
		viewLocalPublishedWorkshop = false
	end,

	canRestore = 	function(self) return GetString("mods.modmanager.selectedmod") ~= "" end,

	onRestore = 	function(self)
		self:refresh()
		initSelect = true
		ModManager.WindowAnimation.duration = 0.0
		ModManager.WindowAnimation:init(self)
		viewLocalPublishedWorkshop = false
	end,

	onClose = 		function(self)
		ModManager.WindowAnimation.duration = 0.2
		ModManager.WindowAnimation:init(self)
		SetString("mods.modmanager.selectedmod", "")
		viewLocalPublishedWorkshop = false
	end,

	refresh = 		function(self)
		setWindowSize()
		updateMods()
		updateCollections()
		if gSearchText ~= "" then updateSearch() end
	end
}


ModManager.WindowAnimation = 
{
	duration = 0.2,
	curve = "cosine",
	progress = 0.0,


	init = 		function(self, window)
		self.duration = 0.2
		self.curve = "cosine"
		self.progress = 0.0
	end,

	play = 		function(self)
		self:reset()
		SetValueInTable(self, "progress", 1, self.curve, self.duration)
	end,

	reset = 	function(self)
		self.progress = 0.0
	end
}