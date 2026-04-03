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
KeyHistory(200)

; Only activate when MH Wilds is the focused window
#HotIf WinActive("ahk_exe MonsterHunterWilds.exe")

; ── Timing (ms) — increase if inputs are dropped ──────────────
dShort   := 500   ; gap between sequential note inputs
dMid     := 1000  ; gap after Note 3 / heavy attacks
dPerform := 3000  ; wait for Recital animation to finish
dHold    := 150   ; how long to hold simultaneous button combinations
dBeat    := 400   ; gap before second R press in Performance Beat

; ── Helper: simultaneous LMB+RMB → Note 3 / Overhead Smash ───
Note3() {
    Send("{LButton down}{RButton down}")
    Sleep(dHold)
    Send("{LButton up}{RButton up}")
}

; ── Helper: clear any residual button state before a macro ────
ResetButtons() {
    Send("{LButton up}{RButton up}{r up}{Space up}{w up}")
    Sleep(100)
}

; ─────────────────────────────────────────────────────────────
; F1 — Recital
; Performs all queued melodies and activates their buffs.
; ─────────────────────────────────────────────────────────────
F1:: {
    ToolTip("F1: Recital")
    Send("{r}")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F2 — Performance Beat  (Recital → Recital)
; Press R a second time mid-animation for a bonus damage hit
; and slightly faster buff activation.
; ─────────────────────────────────────────────────────────────
F2:: {
    ToolTip("F2: Recital 1")
    Send("{r}")
    Sleep(dBeat)
    ToolTip("F2: Recital 2 (Beat)")
    Send("{r}")
    ToolTip("F2: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F3 — Echo Bubble  (R + Space)
; Places a stationary AOE zone at your feet. Up to 3 active at
; once. Attacks/performances inside trigger Reverb pulses for
; bonus damage. Lasts ~60 seconds.
; ─────────────────────────────────────────────────────────────
F3:: {
    ToolTip("F3: Echo Bubble")
    Send("{r down}{Space down}")
    Sleep(dHold)
    Send("{r up}{Space up}")
    ToolTip("F3: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F4 — Special Performance  (R + LMB + RMB)
; Effect depends on your equipped horn:
;   Offset Melody    → counter-attack that interrupts monsters
;   Resounding Melody → spin slam + Echo Bubble Reverb pulses
;   Melody of Life   → AoE heal for you and nearby allies
; ─────────────────────────────────────────────────────────────
F4:: {
    ToolTip("F4: Special Performance")
    Send("{r down}{LButton down}{RButton down}")
    Sleep(dHold)
    Send("{r up}{LButton up}{RButton up}")
    ToolTip("F4: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F5 — Standard 3-Note Combo → Recital
; LMB → RMB → (LMB+RMB) → R
; Builds one full melody then performs it immediately.
; ─────────────────────────────────────────────────────────────
F5:: {
    ResetButtons()
    ToolTip("F5: LButton")
    Send("{LButton}")
    Sleep(dShort)
    ToolTip("F5: RButton")
    Send("{RButton}")
    Sleep(dShort)
    ToolTip("F5: Note3")
    Note3()
    Sleep(dMid)
    ToolTip("F5: Recital")
    Send("{r}")
    ToolTip("F5: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F6 — Triple Melody Stack → Recital All
; (LMB → RMB → LMB+RMB) × 3 → R
; Queues all 3 melodies then performs them in one go.
; Performing all 3 together increases buff potency and duration.
; ─────────────────────────────────────────────────────────────
F6:: {
    ResetButtons()
    Loop 3 {
        ToolTip("F6: Loop iter " A_Index " - LButton")
        Send("{LButton}")
        Sleep(dShort)
        ToolTip("F6: Loop iter " A_Index " - RButton")
        Send("{RButton}")
        Sleep(dShort)
        ToolTip("F6: Loop iter " A_Index " - Note3")
        Note3()
        Sleep(dMid)
    }
    ToolTip("F6: Recital")
    Send("{r}")
    ToolTip("F6: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F7 — Triple Melody Stack → Recital → Encore
; (LMB → RMB → LMB+RMB) × 3 → R → (LMB+RMB)
; After Recital, the Encore turns all active melody buffs purple,
; extending their duration significantly.
; ─────────────────────────────────────────────────────────────
F7:: {
    ResetButtons()
    Loop 3 {
        ToolTip("F7: Loop iter " A_Index " - LButton")
        Send("{LButton}")
        Sleep(dShort)
        ToolTip("F7: Loop iter " A_Index " - RButton")
        Send("{RButton}")
        Sleep(dShort)
        ToolTip("F7: Loop iter " A_Index " - Note3")
        Note3()
        Sleep(dMid)
    }
    ToolTip("F7: Recital")
    Send("{r}")
    Sleep(dPerform)
    ToolTip("F7: Encore")
    Note3()
    ToolTip("F7: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F8 — Overhead Smash Loop × 3  (Spinning Smash chain)
; (W + LMB+RMB) × 3
; Hold forward while pressing Note 3 for the big overhead slam.
; Repeated inputs chain into the Spinning Overhead Smash.
; ─────────────────────────────────────────────────────────────
F8:: {
    ResetButtons()
    Loop 3 {
        ToolTip("F8: Loop iter " A_Index " - W+Note3")
        Send("{w down}")
        Sleep(dHold)
        Note3()
        Sleep(dMid)
        Send("{w up}")
        Sleep(dHold)
    }
    ToolTip("F8: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F9 — Drop Echo Bubble → Special Performance inside it
; Places a bubble at your feet then fires Special Performance.
; Standing inside your own bubble triggers Reverb pulses on the
; Special Performance for extra damage.
; Increase dPerform if you need time to reposition into the bubble.
; ─────────────────────────────────────────────────────────────
F9:: {
    ResetButtons()
    ToolTip("F9: Echo Bubble")
    Send("{r down}{Space down}")
    Sleep(dHold)
    Send("{r up}{Space up}")
    Sleep(dPerform)
    ToolTip("F9: Special Performance")
    Send("{r down}{LButton down}{RButton down}")
    Sleep(dHold)
    Send("{r up}{LButton up}{RButton up}")
    ToolTip("F9: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F10 — Full Burst Sequence
; 3× melody build → Recital → Encore → Special Performance
; Maximum buff + damage output. Takes several seconds to execute.
; ─────────────────────────────────────────────────────────────
F10:: {
    ResetButtons()
    Loop 3 {
        ToolTip("F10: Loop iter " A_Index " - LButton")
        Send("{LButton}")
        Sleep(dShort)
        ToolTip("F10: Loop iter " A_Index " - RButton")
        Send("{RButton}")
        Sleep(dShort)
        ToolTip("F10: Loop iter " A_Index " - Note3")
        Note3()
        Sleep(dMid)
    }
    ToolTip("F10: Recital")
    Send("{r}")
    Sleep(dPerform)
    ToolTip("F10: Encore")
    Note3()
    Sleep(dMid)
    ToolTip("F10: Special Performance")
    Send("{r down}{LButton down}{RButton down}")
    Sleep(dHold)
    Send("{r up}{LButton up}{RButton up}")
    ToolTip("F10: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F11 — Note Build Only (no Recital)
; LMB → RMB → (LMB+RMB)
; Pre-loads one full set of notes without performing.
; Useful for queuing a melody while the monster is out of reach,
; then manually hitting R (or F1) when in range.
; ─────────────────────────────────────────────────────────────
F11:: {
    ResetButtons()
    ToolTip("F11: LButton")
    Send("{LButton}")
    Sleep(dShort)
    ToolTip("F11: RButton")
    Send("{RButton}")
    Sleep(dShort)
    ToolTip("F11: Note3")
    Note3()
    ToolTip("F11: Done")
    Sleep(1000)
    ToolTip()
}

; ─────────────────────────────────────────────────────────────
; F12 — Note Build → Performance Beat → Encore
; LMB → RMB → (LMB+RMB) → R → R (Beat) → (LMB+RMB) (Encore)
; Compact full cycle: builds notes, performs with a mid-animation
; bonus hit, then Encore extends the resulting buff.
; ─────────────────────────────────────────────────────────────
F12:: {
    ResetButtons()
    ToolTip("F12: LButton")
    Send("{LButton}")
    Sleep(dShort)
    ToolTip("F12: RButton")
    Send("{RButton}")
    Sleep(dShort)
    ToolTip("F12: Note3")
    Note3()
    Sleep(dMid)
    ToolTip("F12: Recital")
    Send("{r}")
    Sleep(dBeat)
    ToolTip("F12: Performance Beat")
    Send("{r}")
    Sleep(dPerform)
    ToolTip("F12: Encore")
    Note3()
    ToolTip("F12: Done")
    Sleep(1000)
    ToolTip()
}

#HotIf
