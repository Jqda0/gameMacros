; =============================================
; Monster Hunter Wilds — Hunting Horn Macros
; Requires: AutoHotkey v2.0 (https://www.autohotkey.com)
; =============================================
;
; HOW TO USE:
;   1. Install AutoHotkey v2 from autohotkey.com
;   2. Double-click this file to run it (tray icon appears)
;   3. Launch MH Wilds — macros only fire when the game is focused
;   4. Right-click the tray icon > Exit to stop
;
; TUNING:
;   If combos are dropping inputs, increase dShort/dMid/dPerform below.
;   If the window isn't detected, open Task Manager > Details tab
;   while the game is running and copy the exact .exe name.
;
; DEFAULT PC BINDINGS ASSUMED:
;   LMB         = Attack 1 / Note 1 (Left Swing)
;   RMB         = Attack 2 / Note 2 (Right Swing)
;   LMB + RMB   = Attack 3 / Note 3 (Overhead Smash)
;   R           = Perform / Recital
;   R + Space   = Echo Bubble
;   R+LMB+RMB   = Special Performance (Offset / Resounding / Life)
;   W           = Move forward (for directional smash attacks)
; =============================================

#Requires AutoHotkey v2.0
#SingleInstance Force

; Only activate when MH Wilds is the focused window
#HotIf WinActive("ahk_exe MonsterHunterWilds.exe")

; ── Timing (ms) — increase if inputs are dropped ──────────────
dShort   := 100   ; gap between light attack inputs
dMid     := 220   ; gap after Note 3 / heavy attacks
dPerform := 520   ; wait for Recital animation to finish

; ── Helper: simultaneous LMB+RMB → Note 3 / Overhead Smash ───
Note3() {
    Send("{LButton down}{RButton down}")
    Sleep(30)
    Send("{LButton up}{RButton up}")
}

; ─────────────────────────────────────────────────────────────
; F1 — Recital
; Performs all queued melodies and activates their buffs.
; ─────────────────────────────────────────────────────────────
F1:: Send("{r}")

; ─────────────────────────────────────────────────────────────
; F2 — Performance Beat  (Recital → Recital)
; Press R a second time mid-animation for a bonus damage hit
; and slightly faster buff activation.
; ─────────────────────────────────────────────────────────────
F2:: {
    Send("{r}")
    Sleep(80)
    Send("{r}")
}

; ─────────────────────────────────────────────────────────────
; F3 — Echo Bubble  (R + Space)
; Places a stationary AOE zone at your feet. Up to 3 active at
; once. Attacks/performances inside trigger Reverb pulses for
; bonus damage. Lasts ~60 seconds.
; ─────────────────────────────────────────────────────────────
F3:: {
    Send("{r down}{Space down}")
    Sleep(50)
    Send("{r up}{Space up}")
}

; ─────────────────────────────────────────────────────────────
; F4 — Special Performance  (R + LMB + RMB)
; Effect depends on your equipped horn:
;   Offset Melody    → counter-attack that interrupts monsters
;   Resounding Melody → spin slam + Echo Bubble Reverb pulses
;   Melody of Life   → AoE heal for you and nearby allies
; ─────────────────────────────────────────────────────────────
F4:: {
    Send("{r down}{LButton down}{RButton down}")
    Sleep(60)
    Send("{r up}{LButton up}{RButton up}")
}

; ─────────────────────────────────────────────────────────────
; F5 — Standard 3-Note Combo → Recital
; LMB → RMB → (LMB+RMB) → R
; Builds one full melody then performs it immediately.
; ─────────────────────────────────────────────────────────────
F5:: {
    Send("{LButton}")
    Sleep(dShort)
    Send("{RButton}")
    Sleep(dShort)
    Note3()
    Sleep(dMid)
    Send("{r}")
}

; ─────────────────────────────────────────────────────────────
; F6 — Triple Melody Stack → Recital All
; (LMB → RMB → LMB+RMB) × 3 → R
; Queues all 3 melodies then performs them in one go.
; Performing all 3 together increases buff potency and duration.
; ─────────────────────────────────────────────────────────────
F6:: {
    Loop 3 {
        Send("{LButton}")
        Sleep(dShort)
        Send("{RButton}")
        Sleep(dShort)
        Note3()
        Sleep(dMid)
    }
    Send("{r}")
}

; ─────────────────────────────────────────────────────────────
; F7 — Triple Melody Stack → Recital → Encore
; (LMB → RMB → LMB+RMB) × 3 → R → (LMB+RMB)
; After Recital, the Encore turns all active melody buffs purple,
; extending their duration significantly.
; ─────────────────────────────────────────────────────────────
F7:: {
    Loop 3 {
        Send("{LButton}")
        Sleep(dShort)
        Send("{RButton}")
        Sleep(dShort)
        Note3()
        Sleep(dMid)
    }
    Send("{r}")
    Sleep(dPerform)
    Note3()  ; Encore
}

; ─────────────────────────────────────────────────────────────
; F8 — Overhead Smash Loop × 3  (Spinning Smash chain)
; (W + LMB+RMB) × 3
; Hold forward while pressing Note 3 for the big overhead slam.
; Repeated inputs chain into the Spinning Overhead Smash.
; ─────────────────────────────────────────────────────────────
F8:: {
    Loop 3 {
        Send("{w down}")
        Sleep(20)
        Note3()
        Sleep(dMid)
        Send("{w up}")
        Sleep(60)
    }
}

; ─────────────────────────────────────────────────────────────
; F9 — Drop Echo Bubble → Special Performance inside it
; Places a bubble at your feet then fires Special Performance.
; Standing inside your own bubble triggers Reverb pulses on the
; Special Performance for extra damage.
; Increase dPerform if you need time to reposition into the bubble.
; ─────────────────────────────────────────────────────────────
F9:: {
    Send("{r down}{Space down}")
    Sleep(50)
    Send("{r up}{Space up}")
    Sleep(dPerform)
    Send("{r down}{LButton down}{RButton down}")
    Sleep(60)
    Send("{r up}{LButton up}{RButton up}")
}

; ─────────────────────────────────────────────────────────────
; F10 — Full Burst Sequence
; 3× melody build → Recital → Encore → Special Performance
; Maximum buff + damage output. Takes several seconds to execute.
; ─────────────────────────────────────────────────────────────
F10:: {
    Loop 3 {
        Send("{LButton}")
        Sleep(dShort)
        Send("{RButton}")
        Sleep(dShort)
        Note3()
        Sleep(dMid)
    }
    Send("{r}")        ; Recital
    Sleep(dPerform)
    Note3()            ; Encore (extends all buff durations)
    Sleep(dMid)
    Send("{r down}{LButton down}{RButton down}")  ; Special Performance
    Sleep(60)
    Send("{r up}{LButton up}{RButton up}")
}

; ─────────────────────────────────────────────────────────────
; F11 — Note Build Only (no Recital)
; LMB → RMB → (LMB+RMB)
; Pre-loads one full set of notes without performing.
; Useful for queuing a melody while the monster is out of reach,
; then manually hitting R (or F1) when in range.
; ─────────────────────────────────────────────────────────────
F11:: {
    Send("{LButton}")
    Sleep(dShort)
    Send("{RButton}")
    Sleep(dShort)
    Note3()
}

; ─────────────────────────────────────────────────────────────
; F12 — Note Build → Performance Beat → Encore
; LMB → RMB → (LMB+RMB) → R → R (Beat) → (LMB+RMB) (Encore)
; Compact full cycle: builds notes, performs with a mid-animation
; bonus hit, then Encore extends the resulting buff.
; ─────────────────────────────────────────────────────────────
F12:: {
    Send("{LButton}")
    Sleep(dShort)
    Send("{RButton}")
    Sleep(dShort)
    Note3()
    Sleep(dMid)
    Send("{r}")        ; Recital
    Sleep(80)
    Send("{r}")        ; Performance Beat (bonus hit mid-animation)
    Sleep(dPerform)
    Note3()            ; Encore
}

#HotIf
