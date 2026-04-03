# Monster Hunter Wilds Macros

AutoHotkey v2 macro scripts for Monster Hunter Wilds on PC.

## Scripts

| File | Weapon | Bindings |
|------|--------|----------|
| [hunting_horn.ahk](./hunting_horn.ahk) | Hunting Horn | Default KB+M |

---

## Hunting Horn

Maps all Hunting Horn combo patterns to F1–F12. Assumes default keyboard + mouse bindings.

### Requirements

- Default PC keyboard + mouse bindings

### Assumed Bindings

| Key | Action |
|-----|--------|
| Left Mouse Button (LMB) | Attack 1 / Note 1 — Left Swing |
| Right Mouse Button (RMB) | Attack 2 / Note 2 — Right Swing |
| LMB + RMB (simultaneous) | Attack 3 / Note 3 — Overhead Smash |
| `R` | Perform / Recital |
| `R` + `Space` | Echo Bubble |
| `R` + LMB + RMB | Special Performance |
| `W` | Move forward (used in smash chains) |

### Combo Reference

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

Effect depends on which Hunting Horn you have equipped:

| Type | Effect |
|------|--------|
| **Offset Melody** | Counter-attack that interrupts monster attacks |
| **Resounding Melody** | Spin slam finisher + Echo Bubble Reverb pulses |
| **Melody of Life** | AoE heal for you and nearby allies |

### Tuning

If combos are dropping inputs, open `hunting_horn.ahk` and increase the timing values near the top:

```ahk
dShort   := 100   ; ms between light attack inputs
dMid     := 220   ; ms after Note 3 / heavy attacks
dPerform := 520   ; ms to wait for Recital animation
```

Increase in steps of 50ms until the combo lands consistently.

If the script doesn't activate in-game, open Task Manager → **Details** tab while the game is running, find the exact `.exe` name, and update this line in `hunting_horn.ahk`:

```ahk
#HotIf WinActive("ahk_exe MonsterHunterWilds.exe")
```

### Hunting Horn Notes Primer

- Each attack generates a note: LMB = Note 1, RMB = Note 2, LMB+RMB = Note 3
- Up to 3 melodies can be queued before performing
- Performing all 3 at once increases buff potency and duration
- Encore after a Recital extends all active buff durations (buffs turn purple)
- Echo Bubbles trigger Reverb pulses on every attack performed inside them
- Every horn provides **Self Improvement** passively (movement speed + Mind's Eye)
