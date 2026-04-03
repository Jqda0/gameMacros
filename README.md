# MH Wilds — Hunting Horn Macros

AutoHotkey v2 macro script for the **Hunting Horn** in Monster Hunter Wilds on PC. Maps complex combo sequences to single F-key presses so you can focus on positioning and monster tells instead of input timing.

Macros only fire when the MH Wilds window is focused — all other applications are unaffected.

---

## Requirements

- Windows PC
- [AutoHotkey v2](https://www.autohotkey.com/) (free, open source)
- Monster Hunter Wilds with **default keyboard + mouse bindings**

---

## Installation

1. Install AutoHotkey v2 from [autohotkey.com](https://www.autohotkey.com/)
2. Download or clone this repo
3. Double-click `hunting_horn.ahk` — a green tray icon appears in the system tray
4. Launch Monster Hunter Wilds and equip a Hunting Horn
5. Press any F-key macro while in combat

To stop the script: right-click the tray icon → **Exit**

> **Optional:** Right-click the tray icon → **Run at startup** if you want it to load automatically with Windows.

---

## Assumed Default Bindings

The script is built around the default PC keyboard + mouse layout. If you've rebound any of these, edit the corresponding `Send` calls in `hunting_horn.ahk`.

| Key | Action |
|-----|--------|
| Left Mouse Button (LMB) | Attack 1 / Note 1 — Left Swing |
| Right Mouse Button (RMB) | Attack 2 / Note 2 — Right Swing |
| LMB + RMB (simultaneous) | Attack 3 / Note 3 — Overhead Smash |
| `R` | Perform / Recital |
| `R` + `Space` | Echo Bubble |
| `R` + LMB + RMB | Special Performance |
| `W` | Move forward (used in smash chains) |

---

## Combo Reference

| Key | Name | Input Sequence | Notes |
|-----|------|----------------|-------|
| F1 | Recital | `R` | Performs all queued melodies |
| F2 | Performance Beat | `R` → `R` | Second R mid-animation for bonus hit |
| F3 | Echo Bubble | `R + Space` | Drops AOE zone at your feet (up to 3 active, ~60s each) |
| F4 | Special Performance | `R + LMB + RMB` | Offset / Resounding / Melody of Life — depends on your horn |
| F5 | 3-Note Combo → Recital | `LMB → RMB → LMB+RMB → R` | Builds one melody and immediately performs it |
| F6 | Triple Stack → Recital | `(LMB→RMB→LMB+RMB) ×3 → R` | Queues all 3 melodies then performs — stronger buffs |
| F7 | Triple Stack → Recital → Encore | `×3 notes → R → LMB+RMB` | Encore turns buffs purple, extending their duration |
| F8 | Spinning Smash Chain | `(W + LMB+RMB) ×3` | Overhead Smash loop — good for downed monsters |
| F9 | Echo Bubble + Special | Drop bubble → Special Performance inside | Reverb pulses trigger on the Special Performance |
| F10 | Full Burst | `×3 notes → R → Encore → Special` | Maximum buff + damage output, takes a few seconds |
| F11 | Note Build Only | `LMB → RMB → LMB+RMB` | Pre-loads notes without performing — manual Recital when ready |
| F12 | Compact Full Cycle | `Build → R → R (Beat) → Encore` | Note build + Performance Beat + Encore in one press |

### Special Performance types (F4 / F9 / F10)

The effect depends on which Hunting Horn you have equipped:

| Type | Effect |
|------|--------|
| **Offset Melody** | Counter-attack that interrupts monster attacks |
| **Resounding Melody** | Spin slam finisher + Echo Bubble Reverb pulses |
| **Melody of Life** | AoE heal for you and nearby allies |

---

## Tuning

If combos are dropping inputs (moves don't execute cleanly), open `hunting_horn.ahk` and increase the timing values near the top of the file:

```ahk
dShort   := 100   ; ms between light attack inputs
dMid     := 220   ; ms after Note 3 / heavy attacks
dPerform := 520   ; ms to wait for Recital animation
```

Increase in steps of 50ms until the combo lands consistently. Higher values = more reliable but slower execution.

If the script doesn't activate in-game, the window title may differ on your system. Open Task Manager → **Details** tab while the game is running and find the exact `.exe` name, then update this line in `hunting_horn.ahk`:

```ahk
#HotIf WinActive("ahk_exe MonsterHunterWilds.exe")
```

---

## Hunting Horn Notes Primer

The Hunting Horn builds songs by queueing notes through attacks, then activates them via Recital. Every horn provides **Self Improvement** passively (movement speed + Mind's Eye). Additional songs vary by weapon but all share the same input patterns this script uses.

- Each attack generates a note: LMB = Note 1, RMB = Note 2, LMB+RMB = Note 3
- Up to 3 melodies can be queued before performing
- Performing all 3 at once increases buff potency and duration
- Encore after a Recital extends all active buff durations (buffs turn purple)
- Echo Bubbles placed inside the monster's hitbox trigger Reverb pulses on every attack performed inside them
