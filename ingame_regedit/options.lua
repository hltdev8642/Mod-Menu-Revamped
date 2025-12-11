-- Options UI for MMRV In-Game Registry Editor
-- Lets the user configure the hotkey that toggles the in-game editor

-- Unified helpers: read from options first, fallback to savegame; write both
local function getHotkey()
    local optNode = "options.modmenu.mmrv.regedit.hotkey"
    local sgNode = "savegame.mod.mmrv.regedit.hotkey"
    local hk = GetString(optNode)
    if hk == "" then hk = GetString(sgNode) end
    return string.lower(hk or "")
end

local function setHotkey(key)
    key = string.lower(key or "")
    if key == "" then key = "f8" end
    SetString("options.modmenu.mmrv.regedit.hotkey", key)
    SetString("savegame.mod.mmrv.regedit.hotkey", key)
end

function init()
    local hk = getHotkey()
    if hk == "" then hk = "f8" end
    SetString("options.modmenu.mmrv.regedit.hotkey", hk)
    SetString("savegame.mod.mmrv.regedit.hotkey", hk)
    captureHotkey = false
    lastCapturedKey = ""
    hotkeyInput = hk
end

function draw()
    UiPush()
        UiAlign("left top")
        UiTranslate(40, 40)
        UiFont("bold.ttf", 28)
        UiColor(1,1,1)
        UiText("In-Game Registry Editor")

        UiTranslate(0, 20)
        UiFont("regular.ttf", 20)
        UiColor(0.9,0.9,0.9)
        UiText("Configure the hotkey to toggle the in-game editor.")

        UiTranslate(0, 24)
        UiFont("regular.ttf", 22)
        UiColor(1,1,1)
        UiText("Hotkey:")
        UiTranslate(120, -6)
        UiPush()
            UiColor(1,1,1,0.08)
            UiImageBox("ui/common/box-solid-6.png", 200, 40, 6, 6)
            UiTranslate(8, 6)
            UiColor(1,1,1,1)
            local curStored = getHotkey()
            local newRaw, _ = UiTextInput(hotkeyInput or curStored, 184, 28)
            hotkeyInput = string.lower(newRaw or "")
            -- Save button commits input explicitly (placed inside the same container for consistent layout)
            UiTranslate(8, 34)
            UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 1, 1, 0.7)
            if UiTextButton("Save", 90, 32) then
                local sanitized = (hotkeyInput or ""):gsub("[^%w]", "")
                if sanitized ~= "" then
                    setHotkey(sanitized)
                    lastCapturedKey = sanitized
                end
            end
        UiPop()
        

        UiTranslate(-260, 40)
        UiFont("regular.ttf", 20)
        UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 1, 1, 0.7)
        if UiTextButton(captureHotkey and "Press any key…" or "Capture Key", 200, 36) then
            captureHotkey = not captureHotkey
        end
        if captureHotkey then
            local pressed = string.lower(tostring(InputLastPressedKey() or ""))
            if pressed ~= "" then
                -- normalize common function keys formatting
                pressed = pressed:gsub("[^%w]", "")
                setHotkey(pressed)
                lastCapturedKey = pressed
                captureHotkey = false
                hotkeyInput = pressed
            end
        end

        -- Show live capture feedback and current hotkey
        UiTranslate(220, 0)
        UiFont("regular.ttf", 20)
        UiColor(0.9,0.9,0.9)
        local current = getHotkey()
        local status = captureHotkey and "Capturing… press a key" or (lastCapturedKey ~= "" and ("Captured: "..lastCapturedKey) or "")
        if status ~= "" then UiText(status) end
        UiTranslate(0, 26)
        UiColor(1,1,1)
        UiText("Current hotkey: "..(current ~= "" and current or "(none)"))
    UiPop()
end
