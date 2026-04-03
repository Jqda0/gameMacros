# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project

AutoHotkey v2 macro script for Monster Hunter Wilds — automates Hunting Horn combos on PC (keyboard + mouse, default bindings).

## Running the script

This is a Windows-only `.ahk` file. To run it, double-click `mhCombos.ahk` on a Windows machine with AutoHotkey v2 installed. There is no build step.

To stop the script: right-click the tray icon → Exit.

## Architecture

Single file: `hunting_horn.ahk`

- `#HotIf WinActive("ahk_exe MonsterHunterWilds.exe")` — all hotkeys are scoped to the game window only
- `Note3()` — helper function for the simultaneous LMB+RMB press (Attack 3 / Note 3), which is impossible to do reliably by hand
- F1–F12 hotkeys each encode a specific combo sequence using `Send`, `Sleep`, and `Click` calls
- Three timing globals (`dShort`, `dMid`, `dPerform`) control the ms delays between inputs — the primary tuning knobs if combos drop inputs

## Default bindings assumed

| Input | Action |
|-------|--------|
| LMB | Attack 1 / Note 1 (Left Swing) |
| RMB | Attack 2 / Note 2 (Right Swing) |
| LMB+RMB | Attack 3 / Note 3 (Overhead Smash) |
| R | Perform / Recital |
| R + Space | Echo Bubble |
| R + LMB + RMB | Special Performance |
| W | Move forward (used in smash chains) |
