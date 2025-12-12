-- MMRV In-Game Registry / Savegame Editor (standalone)
-- Draws a small button in-game to open the same editor UI

-- State
local reg = {
  show = false,
  path = "mods.available",
  root = "mods.available",
  scroll = 0,
  selected = "",
  editKey = "",
  editValue = "",
  adding = false,
  newKeyName = "",
  newKeyValue = "",
  error = "",
}

-- Bridge state: use Mod Manager's registry editor renderer in-game
-- local bridgeActive = false  -- Disabled to use standalone modal

-- Helpers
local function sanitizeKeyName(s)
  s = s or ""
  return (s:gsub("[^%w%-_]", "_"))
end

local function openAtDefaultPath()
  -- Always start at the selected root for full registry access
  reg.path = reg.root
  reg.scroll = 0
  reg.selected = ""
  reg.editKey = ""
  reg.editValue = ""
  reg.adding = false
  reg.newKeyName = ""
  reg.newKeyValue = ""
  reg.error = ""
end

local function drawKeyList(w)
  local keys = {}
  local listNode = reg.path
  if HasKey(listNode) then
    for _, k in ipairs(ListKeys(listNode)) do table.insert(keys, k) end
    table.sort(keys, function(a,b) return string.lower(a) < string.lower(b) end)
  end
  UiTranslate(0, 12)
  UiPush()
    UiColor(1,1,1,0.08)
    UiImageBox("ui/common/box-solid-6.png", w-32, 320, 6, 6)
    UiTranslate(8,8)
    UiWindow(w-48, 304, true)
    UiFont("regular.ttf", 18)
    UiColor(1,1,1,0.85)
    local lineH = 24
    local maxLines = math.floor(304/lineH)
    local startIndex = math.max(1, 1 + math.floor(-reg.scroll))
    local endIndex = math.min(#keys, startIndex + maxLines)
    for i = startIndex, endIndex do
      local k = keys[i]
      local fullKey = listNode.."."..k
      local isGroup = (#ListKeys(fullKey) > 0)
      local display = k .. (isGroup and "/" or "")
      if UiIsMouseInRect(w-48, lineH) then
        UiColor(1,1,1,0.15)
        UiRect(w-48, lineH)
        UiColor(1,1,1,0.85)
        if InputPressed("lmb") then
          if isGroup then
            reg.path = fullKey
            reg.scroll = 0
            reg.selected = ""
          else
            reg.selected = fullKey
            reg.editKey = k
            reg.editValue = GetString(fullKey)
          end
        end
      end
      UiText(display)
      UiTranslate(0, lineH)
    end
    local wheel = InputValue("mousewheel")
    if wheel ~= 0 then
      reg.scroll = math.min(0, reg.scroll + wheel*(InputDown("shift") and 4 or 1))
    end
  UiPop()
end

local function drawSelectedKey(w)
  UiTranslate(0, 340)
  UiFont("bold.ttf", 22)
  UiText("Selected Key")
  UiTranslate(0, 8)
  UiFont("regular.ttf", 18)
  UiPush()
    UiColor(1,1,1,0.08)
    UiImageBox("ui/common/box-solid-6.png", w-32, 120, 6, 6)
    UiTranslate(8,8)
    if reg.selected ~= "" then
      UiFont("regular.ttf", 18)
      UiColor(1,1,1,0.65)
      UiText(reg.selected)
      UiTranslate(0, 8)
      UiColor(1,1,1,1)
      local newVal, _ = UiTextInput(reg.editValue or "", w-48, 32)
      reg.editValue = newVal
    else
      UiColor(1,1,1,0.35)
      UiText("(none)")
    end
  UiPop()
end

local function drawControls(w)
  UiTranslate(0, 140)
  UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 1, 1, 0.7)
  UiFont("regular.ttf", 22)

  UiPush()
    if UiTextButton("Up", 120, 42) then
      if reg.path ~= reg.root then
        local parent = reg.path:match("^(.*)%.([^%.]+)$")
        if parent and parent ~= "" then reg.path = parent else reg.path = reg.root end
        reg.scroll = 0
        reg.selected = ""
      end
    end
  UiPop()

  UiTranslate(130, 0)
  UiPush()
    if UiTextButton("Save", 140, 42) and reg.selected ~= "" then
      SetString(reg.selected, reg.editValue or "")
    end
  UiPop()

  UiTranslate(280, 0)
  UiPush()
    if UiTextButton("Close", 140, 42) then
      reg.show = false
    end
  UiPop()

  -- Root toggle placed before Add Key for visibility
  UiTranslate(430, 0)
  UiPush()
    local label = "Root: "..(reg.root)
    if UiTextButton(label, 180, 42) then
      -- Cycle root between savegame -> savegame.mod -> options
      if reg.root == "savegame" then
        reg.root = "savegame.mod"
      elseif reg.root == "savegame.mod" then
        reg.root = "options"
      else
        reg.root = "savegame"
      end
      reg.path = reg.root
      reg.scroll = 0
      reg.selected = ""
      reg.adding = false
    end
  UiPop()

  UiTranslate(600, 0)
  UiPush()
    if UiTextButton("Add Key", 160, 42) then
      reg.adding = not reg.adding
      if reg.adding then
        reg.newKeyName = reg.newKeyName or ""
        reg.newKeyValue = reg.newKeyValue or ""
        reg.error = ""
      end
    end
  UiPop()

  if reg.adding then
    UiTranslate(-430, 52)
    UiPush()
      UiColor(1,1,1,0.08)
      UiImageBox("ui/common/box-solid-6.png", w-32, 100, 6, 6)
      UiTranslate(8,8)
      UiFont("regular.ttf", 18)
      UiColor(1,1,1,0.85)
      UiText("New key under: "..(reg.path or "savegame"))
      UiTranslate(0, 6)
      UiPush()
        UiText("Name:")
        UiTranslate(70, -4)
        UiColor(1,1,1,1)
        reg.newKeyName = select(1, UiTextInput(reg.newKeyName or "", 260, 28))
      UiPop()
      UiTranslate(0, 34)
      UiPush()
        UiText("Value:")
        UiTranslate(70, -4)
        reg.newKeyValue = select(1, UiTextInput(reg.newKeyValue or "", w-48-70-200, 28))
      UiPop()
      UiTranslate(0, 36)
      UiButtonImageBox("ui/common/box-outline-6.png", 6, 6, 1, 1, 1, 0.7)
      UiFont("regular.ttf", 20)
      UiPush()
        if UiTextButton("Create", 120, 36) then
          local base = reg.path or "savegame"
          local name = sanitizeKeyName(reg.newKeyName or "")
          if name == "" then
            reg.error = "Invalid key name"
          elseif HasKey(base.."."..name) then
            reg.error = "Key already exists"
          else
            SetString(base.."."..name, reg.newKeyValue or "")
            reg.adding = false
            reg.selected = base.."."..name
            reg.editKey = name
            reg.editValue = reg.newKeyValue or ""
            reg.newKeyName = ""
            reg.newKeyValue = ""
            reg.error = ""
          end
        end
      UiPop()
      UiTranslate(130, 0)
      UiPush()
        if UiTextButton("Cancel", 120, 36) then
          reg.adding = false
          reg.error = ""
        end
      UiPop()
      if reg.error and reg.error ~= "" then
        UiTranslate(270, 6)
        UiColor(1,0.4,0.4,0.95)
        UiText(reg.error)
        UiColor(1,1,1,1)
      end
    UiPop()
  end
end

local function drawRegEditor()
  UiMakeInteractive()
  UiModalBegin()
  UiBlur(0.35)
  UiPush()
    local w, h = 900, 640
    UiTranslate(UiCenter()-w/2, UiMiddle()-h/2)
    UiAlign("top left")
    UiWindow(w, h)
    UiColor(0.18,0.18,0.18)
    UiImageBox("common/box-solid-6.png", w, h, 6, 6)
    UiColor(1,1,1)
    UiImageBox("common/box-outline-6.png", w, h, 6, 6)

    UiTranslate(16,24)
    UiFont("bold.ttf", 28)
    UiText("Registry / Savegame Editor")
    UiTranslate(0, 14)
    UiFont("regular.ttf", 18)
    UiColor(0.85,0.85,0.85)
    UiText("Path ("..reg.root.."): "..(reg.path or ""))

    drawKeyList(w)
    drawSelectedKey(w)
    drawControls(w)
  UiPop()
  UiModalEnd()
end

-- Teardown hooks
function init()
  -- Persist hotkey under savegame.mod.mmrv.regedit.hotkey
  local hkNode = "savegame.mod.mmrv.regedit.hotkey"
  if GetString(hkNode) == "" then
    SetString(hkNode, "f8")
  end
end

function tick(dt)
  -- toggle on configured hotkey (read from savegame.mod.* registry)
  local hk = string.lower(GetString("savegame.mod.mmrv.regedit.hotkey"))
  if hk == "" then hk = "f8" end
  if InputPressed(hk) then
    if reg.show then
      reg.show = false
    else
      openAtDefaultPath()
      reg.show = true
    end
  end
end

function draw()
  -- Use standalone registry editor instead of Mod Manager bridge
  if reg.show then
    UiSetCursorState(UI_CURSOR_SHOW)
    drawRegEditor()
  end
end
