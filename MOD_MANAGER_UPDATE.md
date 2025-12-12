# Mod Manager Update (Teardown Experimental 2.x)

This repo overrides Teardown’s UI mod manager by providing a custom implementation in the project’s `components/` directory.

## Scope

- Updated files are **only** in `components/` and project root.
- `ref/data/` is treated as **read-only** reference material and is not modified.

## Reference

Vanilla updated implementation used for comparison:

- `ref/data/ui/components/mod_manager.lua`

Key upstream dependencies (vanilla includes):

- `script/common.lua`
- `ui/ui_extensions.lua`
- `ui/ui_helpers.lua`
- `buttons.lua`
- `game.lua`

## Changes Made

### components/mod_manager.lua

- Updated `#include` paths to match the current vanilla UI layout:
  - Adds `#include "script/common.lua"`
  - Uses `#include "ui/ui_extensions.lua"` and `#include "ui/ui_helpers.lua"`
- Ensures `ModManager` is not clobbered if already present by using `ModManager = ModManager or {}`.
- Aligns `ModManager.Sort`, `ModManager.Filter`, and `ModManager.PlayMode` enums with vanilla (`ref/data/ui/components/mod_manager.lua`) including `toString()`.
- Updates `UiImageBox` usage to match the Experimental 2.x API signature (removes a legacy extra argument on some outline boxes).
- Updates icon-button rendering to match the Experimental 2.x API signature (`UiImageButton` only accepts a path); sized icon buttons now use a `UiBlankButton` hitbox with an overlaid `UiImage`.
- Keeps the custom immediate-mode UI implementation (lists, search, collections, registry editor, publish, batch tools) intact.

### components/mod_manager_locLang.lua

- No functional changes in this update; still provides extra localization strings for the revamped UI.

## Compatibility Notes

- This implementation intentionally diverges from vanilla’s declarative UI (`Ui.VerticalLayout`, `Ui.VerticalList` trees). It runs a custom immediate-mode renderer inside a `Ui.Window` wrapper.
- The enums on `ModManager.*` are aligned with vanilla so future Teardown UI glue code (or other components) can rely on stable values.

## Manual Test Steps (Teardown Experimental Build)

Run these in the **current Teardown Experimental** build.

1. Launch Teardown → open the main menu.
1. Open Mod Manager.
1. Verify the window opens/closes cleanly and the main menu does not hang.
1. Browse categories:

   - Built-in
   - Workshop
   - Local

1. Sorting & filtering:

   - Change sort modes and reverse sort order (if supported by your UI).
   - Toggle filters and confirm the list updates.

1. Search:

   - Type in the search box and confirm results update after a short delay.
   - Clear search and confirm category restores.

1. Collections:

   - Create a collection
   - Add/remove mods
   - Apply/disuse the collection

1. Workshop batch tools:

   - Multi-select several mods (if enabled)
   - Batch Activate/Deactivate
   - Add selected to a collection

1. Global mods batch enable:

   - Open the “Batch Enable Global Mods” dialog
   - Select/deselect items
   - Enable Selected
   - Confirm `mods.available.<id>.active` toggles appropriately (mods enabled in list)

1. Registry/Savegame editor:

   - Open Savegame Data
   - Navigate roots (savegame/savegame.mod/options/info/game/mods/mods.available)
   - Edit a value and Save
   - Add a new key/value and confirm it persists

1. Publish flow (local mod only):

   - Start publish and cancel; confirm UI remains responsive.

## Troubleshooting

- If the mod manager fails to open, confirm Teardown can resolve vanilla includes:
  - `script/common.lua`
  - `ui/ui_extensions.lua`
  - `ui/ui_helpers.lua`
- If you see missing function errors (e.g., `SetValueInTable`), it generally indicates `script/common.lua` was not included or did not load.
