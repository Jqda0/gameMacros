# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

A collection of AutoHotkey v2 macro scripts for PC games. Each game has its own subfolder containing `.ahk` scripts and a README.

## Structure

```
<game-name>/
    <weapon-or-mode>.ahk   # macro script
    README.md              # setup, bindings, and combo reference for this game
README.md                  # top-level index linking to each game folder
```

When adding a new game, create a new subfolder named after the game (kebab-case) with the script and a README following the same pattern as `monster-hunter-wilds/`.

## Running scripts

Windows-only `.ahk` files — double-click to run with AutoHotkey v2. No build step. Right-click tray icon → Exit to stop.

## AHK v2 script conventions

- `#HotIf WinActive("ahk_exe <Game>.exe")` scopes all hotkeys to the game window
- Timing globals (`dShort`, `dMid`, `dPerform`) at the top of each file are the primary tuning knobs
- Helper functions handle inputs that require simultaneous key/button presses (e.g. `Note3()` for LMB+RMB)
- Use `Send("{Key down/up}")` for held inputs, `Send("{Key}")` for taps
- Mouse buttons use `Send("{LButton}")` / `Send("{RButton}")` syntax
