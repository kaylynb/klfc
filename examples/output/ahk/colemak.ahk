﻿#MaxHotkeysPerInterval 200

SendUps(ByRef modifiers) {
  for index, modifier in modifiers {
    if (modifier == "Caps")
      SetCapsLockState, off
    else if (modifier == "Num")
      SetNumLockState, off
    else if InStr(modifier, "Extend")
      %modifier% := false
    else
      Send {%modifier% Up}
  }
  modifiers := Object()
}

SendAsUnicode(string) {
  Result := ""
  Loop, Parse, string
    Result .= Format("{{}U+{:04x}{}}", Ord(A_LoopField))
  Send {Blind}%Result%
}

DeadKeys := Object()

DeadKey(baseChar, table) {
  Global ActiveDeadKey
  if (ActiveDeadKey != "") {
    NewActiveDeadKey := Object()
    for key, value in table {
      NewActiveDeadKey[key] := ActiveDeadKey[value]
    }
    ActiveDeadKey := NewActiveDeadKey
  } else {
    ActiveDeadKey := table
  }
  Input key, L1, {Esc}
  if (ErrorLevel != "NewInput") {
    value := ActiveDeadKey[key]
    ActiveDeadKey := ""
    if (IsObject(value)) {
      DeadKey(baseChar, value)
    } else if (value != "") {
      SendAsUnicode(value)
    } else {
      SendAsUnicode(baseChar . key)
    }
  }
}

*SC03a::Extend := true ; QWERTY CapsLock
*SC03a Up::Extend := false
SC029::VKc0SC029 ; QWERTY ~: ~
SC002::VK31SC002 ; QWERTY 1: 1
SC003::VK32SC003 ; QWERTY 2: 2
SC004::VK33SC004 ; QWERTY 3: 3
SC005::VK34SC005 ; QWERTY 4: 4
SC006::VK35SC006 ; QWERTY 5: 5
SC007::VK36SC007 ; QWERTY 6: 6
SC008::VK37SC008 ; QWERTY 7: 7
SC009::VK38SC009 ; QWERTY 8: 8
SC00a::VK39SC00a ; QWERTY 9: 9
SC00b::VK30SC00b ; QWERTY 0: 0
SC00c::VKbdSC00c ; QWERTY -: -
SC00d::VKbbSC00d ; QWERTY +: +
SC010::VK51SC010 ; QWERTY Q: Q
SC011::VK57SC011 ; QWERTY W: W
SC012::VK46SC012 ; QWERTY E: F
SC013::VK50SC013 ; QWERTY R: P
SC014::VK47SC014 ; QWERTY T: G
SC015::VK4aSC015 ; QWERTY Y: J
SC016::VK4cSC016 ; QWERTY U: L
SC017::VK55SC017 ; QWERTY I: U
SC018::VK59SC018 ; QWERTY O: Y
SC019::VKbaSC019 ; QWERTY P: ;
SC01a::VKdbSC01a ; QWERTY [: [
SC01b::VKddSC01b ; QWERTY ]: ]
SC02b::VKdcSC02b ; QWERTY \: \
*SC01e::Send {Blind}{VK41SC01e DownTemp} ; QWERTY A: A
*SC01e up::
Send {Blind}{VK41SC01e Up}
SendUps(ModsSC01e)
Return
SC01f::VK52SC01f ; QWERTY S: R
*SC020::Send {Blind}{VK53SC020 DownTemp} ; QWERTY D: S
*SC020 up::
Send {Blind}{VK53SC020 Up}
SendUps(ModsSC020)
Return
*SC021::Send {Blind}{VK54SC021 DownTemp} ; QWERTY F: T
*SC021 up::
Send {Blind}{VK54SC021 Up}
SendUps(ModsSC021)
Return
SC022::VK44SC022 ; QWERTY G: D
SC023::VK48SC023 ; QWERTY H: H
SC024::VK4eSC024 ; QWERTY J: N
SC025::VK45SC025 ; QWERTY K: E
SC026::VK49SC026 ; QWERTY L: I
SC027::VK4fSC027 ; QWERTY ;: O
SC028::VKdeSC028 ; QWERTY ': '
SC02c::VK5aSC02c ; QWERTY Z: Z
SC02d::VK58SC02d ; QWERTY X: X
SC02e::VK43SC02e ; QWERTY C: C
SC02f::VK56SC02f ; QWERTY V: V
SC030::VK42SC030 ; QWERTY B: B
SC031::VK4bSC031 ; QWERTY N: K
SC032::VK4dSC032 ; QWERTY M: M
SC033::VKbcSC033 ; QWERTY ,: ,
SC034::VKbeSC034 ; QWERTY .: .
SC035::VKbfSC035 ; QWERTY /: /
SC039::VK20SC039 ; QWERTY Space: Space
SC001::VK1bSC001 ; QWERTY Escape: Escape
SC03b::VK70SC03b ; QWERTY F1: F1
SC03c::VK71SC03c ; QWERTY F2: F2
SC03d::VK72SC03d ; QWERTY F3: F3
SC03e::VK73SC03e ; QWERTY F4: F4
SC03f::VK74SC03f ; QWERTY F5: F5
SC040::VK75SC040 ; QWERTY F6: F6
SC041::VK76SC041 ; QWERTY F7: F7
SC042::VK77SC042 ; QWERTY F8: F8
SC043::VK78SC043 ; QWERTY F9: F9
SC044::VK79SC044 ; QWERTY F10: F10
SC057::VK7aSC057 ; QWERTY F11: F11
SC058::VK7bSC058 ; QWERTY F12: F12

; QWERTY ~
#if not Extend
SC029::Send {Blind}{U+0060} ; `
+SC029::Send {Blind}{U+007e} ; ~
>!<^SC029::
; tilde
if (DeadKeys["tilde"] == "") {
  DeadKeys["tilde"] := Object()
  DeadKeys["tilde"]["A"] := "Ã"
  DeadKeys["tilde"]["a"] := "ã"
  DeadKeys["tilde"]["E"] := "Ẽ"
  DeadKeys["tilde"]["e"] := "ẽ"
  DeadKeys["tilde"]["I"] := "Ĩ"
  DeadKeys["tilde"]["i"] := "ĩ"
  DeadKeys["tilde"]["N"] := "Ñ"
  DeadKeys["tilde"]["n"] := "ñ"
  DeadKeys["tilde"]["O"] := "Õ"
  DeadKeys["tilde"]["o"] := "õ"
  DeadKeys["tilde"]["U"] := "Ũ"
  DeadKeys["tilde"]["u"] := "ũ"
  DeadKeys["tilde"]["V"] := "Ṽ"
  DeadKeys["tilde"]["v"] := "ṽ"
  DeadKeys["tilde"]["Y"] := "Ỹ"
  DeadKeys["tilde"]["y"] := "ỹ"
}
DeadKey("~", DeadKeys["tilde"])
Return
+>!<^SC029::Return
#if Extend
*SC029::Return

; QWERTY 1
#if not Extend
SC002::Send {Blind}{U+0031} ; 1
+SC002::Send {Blind}{U+0021} ; !
>!<^SC002::Send {Blind}{U+00a1} ; ¡
+>!<^SC002::Send {Blind}{U+00b9} ; ¹
#if Extend
*SC002::Send {Blind}{F1}

; QWERTY 2
#if not Extend
SC003::Send {Blind}{U+0032} ; 2
+SC003::Send {Blind}{U+0040} ; @
>!<^SC003::Send {Blind}{U+00ba} ; º
+>!<^SC003::Send {Blind}{U+00b2} ; ²
#if Extend
*SC003::Send {Blind}{F2}

; QWERTY 3
#if not Extend
SC004::Send {Blind}{U+0033} ; 3
+SC004::Send {Blind}{U+0023} ; #
>!<^SC004::Send {Blind}{U+00aa} ; ª
+>!<^SC004::Send {Blind}{U+00b3} ; ³
#if Extend
*SC004::Send {Blind}{F3}

; QWERTY 4
#if not Extend
SC005::Send {Blind}{U+0034} ; 4
+SC005::Send {Blind}{U+0024} ; $
>!<^SC005::Send {Blind}{U+00a2} ; ¢
+>!<^SC005::Send {Blind}{U+00a3} ; £
#if Extend
*SC005::Send {Blind}{F4}

; QWERTY 5
#if not Extend
SC006::Send {Blind}{U+0035} ; 5
+SC006::Send {Blind}{U+0025} ; %
>!<^SC006::Send {Blind}{U+20ac} ; €
+>!<^SC006::Send {Blind}{U+00a5} ; ¥
#if Extend
*SC006::Send {Blind}{F5}

; QWERTY 6
#if not Extend
SC007::Send {Blind}{U+0036} ; 6
+SC007::Send {Blind}{U+005e} ; ^
>!<^SC007::Send {Blind}{U+0127} ; ħ
+>!<^SC007::Send {Blind}{U+0126} ; Ħ
#if Extend
*SC007::Send {Blind}{F6}

; QWERTY 7
#if not Extend
SC008::Send {Blind}{U+0037} ; 7
+SC008::Send {Blind}{U+0026} ; &
>!<^SC008::Send {Blind}{U+00f0} ; ð
+>!<^SC008::Send {Blind}{U+00d0} ; Ð
#if Extend
*SC008::Send {Blind}{F7}

; QWERTY 8
#if not Extend
SC009::Send {Blind}{U+0038} ; 8
+SC009::Send {Blind}{U+002a} ; *
>!<^SC009::Send {Blind}{U+00fe} ; þ
+>!<^SC009::Send {Blind}{U+00de} ; Þ
#if Extend
*SC009::Send {Blind}{F8}

; QWERTY 9
#if not Extend
SC00a::Send {Blind}{U+0039} ; 9
+SC00a::Send {Blind}{U+0028} ; (
>!<^SC00a::Send {Blind}{U+2018} ; ‘
+>!<^SC00a::Send {Blind}{U+201c} ; “
#if Extend
*SC00a::Send {Blind}{F9}

; QWERTY 0
#if not Extend
SC00b::Send {Blind}{U+0030} ; 0
+SC00b::Send {Blind}{U+0029} ; )
>!<^SC00b::Send {Blind}{U+2019} ; ’
+>!<^SC00b::Send {Blind}{U+201d} ; ”
#if Extend
*SC00b::Send {Blind}{F10}

; QWERTY -
#if not Extend
SC00c::Send {Blind}{U+002d} ; -
+SC00c::Send {Blind}{U+005f} ; _
>!<^SC00c::Send {Blind}{U+2013} ; –
+>!<^SC00c::Send {Blind}{U+2014} ; —
#if Extend
*SC00c::Send {Blind}{F11}

; QWERTY +
#if not Extend
SC00d::Send {Blind}{U+003d} ; =
+SC00d::Send {Blind}{U+002b} ; +
>!<^SC00d::Send {Blind}{U+00d7} ; ×
+>!<^SC00d::Send {Blind}{U+00f7} ; ÷
#if Extend
*SC00d::Send {Blind}{F12}

; QWERTY Q
#if not Extend
SC010::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0071} ; q
} else {
  Send {Blind}{U+0051} ; Q
}
Return
+SC010::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0051} ; Q
} else {
  Send {Blind}{U+0071} ; q
}
Return
>!<^SC010::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e4} ; ä
} else {
  Send {Blind}{U+00c4} ; Ä
}
Return
+>!<^SC010::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c4} ; Ä
} else {
  Send {Blind}{U+00e4} ; ä
}
Return
#if Extend
*SC010::Send {Blind}{Esc}

; QWERTY W
#if not Extend
SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0077} ; w
} else {
  Send {Blind}{U+0057} ; W
}
Return
+SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0057} ; W
} else {
  Send {Blind}{U+0077} ; w
}
Return
>!<^SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e5} ; å
} else {
  Send {Blind}{U+00c5} ; Å
}
Return
+>!<^SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c5} ; Å
} else {
  Send {Blind}{U+00e5} ; å
}
Return
#if Extend
*SC011::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{WheelUp}
} else {
  Send {Blind}{WheelRight}
}
Return
+SC011::
if not GetKeyState("CapsLock", "T") {
  Send {WheelRight}
} else {
  Send {WheelUp}
}
Return

; QWERTY E
#if not Extend
SC012::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0066} ; f
} else {
  Send {Blind}{U+0046} ; F
}
Return
+SC012::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0046} ; F
} else {
  Send {Blind}{U+0066} ; f
}
Return
>!<^SC012::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e3} ; ã
} else {
  Send {Blind}{U+00c3} ; Ã
}
Return
+>!<^SC012::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c3} ; Ã
} else {
  Send {Blind}{U+00e3} ; ã
}
Return
#if Extend
*SC012::Send {Blind}{Browser_Back}

; QWERTY R
#if not Extend
SC013::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0070} ; p
} else {
  Send {Blind}{U+0050} ; P
}
Return
+SC013::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0050} ; P
} else {
  Send {Blind}{U+0070} ; p
}
Return
>!<^SC013::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00f8} ; ø
} else {
  Send {Blind}{U+00d8} ; Ø
}
Return
+>!<^SC013::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00d8} ; Ø
} else {
  Send {Blind}{U+00f8} ; ø
}
Return
#if Extend
*SC013::Send {Blind}{Browser_Forward}

; QWERTY T
#if not Extend
SC014::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0067} ; g
} else {
  Send {Blind}{U+0047} ; G
}
Return
+SC014::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0047} ; G
} else {
  Send {Blind}{U+0067} ; g
}
Return
>!<^SC014::
if not GetKeyState("CapsLock", "T") {
  ; ogonek
  if (DeadKeys["ogonek"] == "") {
    DeadKeys["ogonek"] := Object()
    DeadKeys["ogonek"]["A"] := "Ą"
    DeadKeys["ogonek"]["a"] := "ą"
    DeadKeys["ogonek"]["E"] := "Ę"
    DeadKeys["ogonek"]["e"] := "ę"
    DeadKeys["ogonek"]["I"] := "Į"
    DeadKeys["ogonek"]["i"] := "į"
    DeadKeys["ogonek"]["O"] := "Ǫ"
    DeadKeys["ogonek"]["o"] := "ǫ"
    DeadKeys["ogonek"]["U"] := "Ų"
    DeadKeys["ogonek"]["u"] := "ų"
  }
  DeadKey("˛", DeadKeys["ogonek"])
} else {
}
Return
+>!<^SC014::
if not GetKeyState("CapsLock", "T") {
} else {
  ; ogonek
  if (DeadKeys["ogonek"] == "") {
    DeadKeys["ogonek"] := Object()
    DeadKeys["ogonek"]["A"] := "Ą"
    DeadKeys["ogonek"]["a"] := "ą"
    DeadKeys["ogonek"]["E"] := "Ę"
    DeadKeys["ogonek"]["e"] := "ę"
    DeadKeys["ogonek"]["I"] := "Į"
    DeadKeys["ogonek"]["i"] := "į"
    DeadKeys["ogonek"]["O"] := "Ǫ"
    DeadKeys["ogonek"]["o"] := "ǫ"
    DeadKeys["ogonek"]["U"] := "Ų"
    DeadKeys["ogonek"]["u"] := "ų"
  }
  DeadKey("˛", DeadKeys["ogonek"])
}
Return
#if Extend
*SC014::Send {Blind}{Click Rel 0,-17,0}

; QWERTY Y
#if not Extend
SC015::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006a} ; j
} else {
  Send {Blind}{U+004a} ; J
}
Return
+SC015::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004a} ; J
} else {
  Send {Blind}{U+006a} ; j
}
Return
>!<^SC015::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0111} ; đ
} else {
  Send {Blind}{U+0110} ; Đ
}
Return
+>!<^SC015::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0110} ; Đ
} else {
  Send {Blind}{U+0111} ; đ
}
Return
#if Extend
*SC015::Send {Blind}{PgUp}

; QWERTY U
#if not Extend
SC016::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006c} ; l
} else {
  Send {Blind}{U+004c} ; L
}
Return
+SC016::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004c} ; L
} else {
  Send {Blind}{U+006c} ; l
}
Return
>!<^SC016::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0142} ; ł
} else {
  Send {Blind}{U+0141} ; Ł
}
Return
+>!<^SC016::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0141} ; Ł
} else {
  Send {Blind}{U+0142} ; ł
}
Return
#if Extend
*SC016::Send {Blind}{Home}

; QWERTY I
#if not Extend
SC017::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0075} ; u
} else {
  Send {Blind}{U+0055} ; U
}
Return
+SC017::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0055} ; U
} else {
  Send {Blind}{U+0075} ; u
}
Return
>!<^SC017::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00fa} ; ú
} else {
  Send {Blind}{U+00da} ; Ú
}
Return
+>!<^SC017::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00da} ; Ú
} else {
  Send {Blind}{U+00fa} ; ú
}
Return
#if Extend
*SC017::Send {Blind}{Up}

; QWERTY O
#if not Extend
SC018::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0079} ; y
} else {
  Send {Blind}{U+0059} ; Y
}
Return
+SC018::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0059} ; Y
} else {
  Send {Blind}{U+0079} ; y
}
Return
>!<^SC018::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00fc} ; ü
} else {
  Send {Blind}{U+00dc} ; Ü
}
Return
+>!<^SC018::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00dc} ; Ü
} else {
  Send {Blind}{U+00fc} ; ü
}
Return
#if Extend
*SC018::Send {Blind}{End}

; QWERTY P
#if not Extend
SC019::Send {Blind}{U+003b} ; ;
+SC019::Send {Blind}{U+003a} ; :
>!<^SC019::Send {Blind}{U+00f6} ; ö
+>!<^SC019::Send {Blind}{U+00d6} ; Ö
#if Extend
*SC019::Send {Blind}{Del}

; QWERTY [
#if not Extend
SC01a::Send {Blind}{U+005b} ; [
+SC01a::Send {Blind}{U+007b} ; {
>!<^SC01a::Send {Blind}{U+00ab} ; «
+>!<^SC01a::Send {Blind}{U+2039} ; ‹
#if Extend
*SC01a::Send {Blind}{Esc}

; QWERTY ]
#if not Extend
SC01b::Send {Blind}{U+005d} ; ]
+SC01b::Send {Blind}{U+007d} ; }
>!<^SC01b::Send {Blind}{U+00bb} ; »
+>!<^SC01b::Send {Blind}{U+203a} ; ›
#if Extend
*SC01b::Send {Blind}{Ins}

; QWERTY \
#if not Extend
SC02b::Send {Blind}{U+005c} ; \
+SC02b::Send {Blind}{U+007c} ; |
>!<^SC02b::
; special
if (DeadKeys["special"] == "") {
  DeadKeys["special"] := Object()
  DeadKeys["special"]["c"] := "©"
  DeadKeys["special"]["r"] := "®"
  DeadKeys["special"]["t"] := "™"
  DeadKeys["special"]["d"] := "°"
  DeadKeys["special"]["m"] := "µ"
  DeadKeys["special"]["n"] := "№"
  DeadKeys["special"]["p"] := "¶"
  DeadKeys["special"]["s"] := "§"
  DeadKeys["special"]["."] := "…"
  DeadKeys["special"]["+"] := "±"
  DeadKeys["special"]["="] := "≠"
  DeadKeys["special"]["<"] := "≤"
  DeadKeys["special"][">"] := "≥"
  DeadKeys["special"]["~"] := "≈"
  DeadKeys["special"]["%"] := "‰"
  DeadKeys["special"]["|"] := "¦"
}
DeadKey("", DeadKeys["special"])
Return
+>!<^SC02b::Return
#if Extend
*SC02b::Send {Blind}{Browser_Favorites}
+SC02b::Send {Launch_App1}

; QWERTY A
#if not Extend
SC01e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0061} ; a
} else {
  Send {Blind}{U+0041} ; A
}
Return
+SC01e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0041} ; A
} else {
  Send {Blind}{U+0061} ; a
}
Return
>!<^SC01e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e1} ; á
} else {
  Send {Blind}{U+00c1} ; Á
}
Return
+>!<^SC01e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c1} ; Á
} else {
  Send {Blind}{U+00e1} ; á
}
Return
#if Extend
*SC01e::
Send {Blind}{Alt Down}
if (ModsSC01e == "")
  ModsSC01e := Object()
ModsSC01e.Insert("Alt")
Return

; QWERTY S
#if not Extend
SC01f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0072} ; r
} else {
  Send {Blind}{U+0052} ; R
}
Return
+SC01f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0052} ; R
} else {
  Send {Blind}{U+0072} ; r
}
Return
>!<^SC01f::
if not GetKeyState("CapsLock", "T") {
  ; grave
  if (DeadKeys["grave"] == "") {
    DeadKeys["grave"] := Object()
    DeadKeys["grave"][" "] := "``"
    DeadKeys["grave"]["A"] := "À"
    DeadKeys["grave"]["a"] := "à"
    DeadKeys["grave"]["E"] := "È"
    DeadKeys["grave"]["e"] := "è"
    DeadKeys["grave"]["I"] := "Ì"
    DeadKeys["grave"]["i"] := "ì"
    DeadKeys["grave"]["N"] := "Ǹ"
    DeadKeys["grave"]["n"] := "ǹ"
    DeadKeys["grave"]["O"] := "Ò"
    DeadKeys["grave"]["o"] := "ò"
    DeadKeys["grave"]["U"] := "Ù"
    DeadKeys["grave"]["u"] := "ù"
    DeadKeys["grave"]["W"] := "Ẁ"
    DeadKeys["grave"]["w"] := "ẁ"
    DeadKeys["grave"]["Y"] := "Ỳ"
    DeadKeys["grave"]["y"] := "ỳ"
  }
  DeadKey("``", DeadKeys["grave"])
} else {
}
Return
+>!<^SC01f::
if not GetKeyState("CapsLock", "T") {
} else {
  ; grave
  if (DeadKeys["grave"] == "") {
    DeadKeys["grave"] := Object()
    DeadKeys["grave"][" "] := "``"
    DeadKeys["grave"]["A"] := "À"
    DeadKeys["grave"]["a"] := "à"
    DeadKeys["grave"]["E"] := "È"
    DeadKeys["grave"]["e"] := "è"
    DeadKeys["grave"]["I"] := "Ì"
    DeadKeys["grave"]["i"] := "ì"
    DeadKeys["grave"]["N"] := "Ǹ"
    DeadKeys["grave"]["n"] := "ǹ"
    DeadKeys["grave"]["O"] := "Ò"
    DeadKeys["grave"]["o"] := "ò"
    DeadKeys["grave"]["U"] := "Ù"
    DeadKeys["grave"]["u"] := "ù"
    DeadKeys["grave"]["W"] := "Ẁ"
    DeadKeys["grave"]["w"] := "ẁ"
    DeadKeys["grave"]["Y"] := "Ỳ"
    DeadKeys["grave"]["y"] := "ỳ"
  }
  DeadKey("``", DeadKeys["grave"])
}
Return
#if Extend
*SC01f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{WheelDown}
} else {
  Send {Blind}{WheelLeft}
}
Return
+SC01f::
if not GetKeyState("CapsLock", "T") {
  Send {WheelLeft}
} else {
  Send {WheelDown}
}
Return

; QWERTY D
#if not Extend
SC020::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0073} ; s
} else {
  Send {Blind}{U+0053} ; S
}
Return
+SC020::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0053} ; S
} else {
  Send {Blind}{U+0073} ; s
}
Return
>!<^SC020::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00df} ; ß
} else {
}
Return
+>!<^SC020::
if not GetKeyState("CapsLock", "T") {
} else {
  Send {Blind}{U+00df} ; ß
}
Return
#if Extend
*SC020::
Send {Blind}{Shift Down}
if (ModsSC020 == "")
  ModsSC020 := Object()
ModsSC020.Insert("Shift")
Return

; QWERTY F
#if not Extend
SC021::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0074} ; t
} else {
  Send {Blind}{U+0054} ; T
}
Return
+SC021::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0054} ; T
} else {
  Send {Blind}{U+0074} ; t
}
Return
>!<^SC021::
if not GetKeyState("CapsLock", "T") {
  ; acute
  if (DeadKeys["acute"] == "") {
    DeadKeys["acute"] := Object()
    DeadKeys["acute"][" "] := "'"
    DeadKeys["acute"]["A"] := "Á"
    DeadKeys["acute"]["a"] := "á"
    DeadKeys["acute"]["Æ"] := "Ǽ"
    DeadKeys["acute"]["æ"] := "ǽ"
    DeadKeys["acute"]["C"] := "Ć"
    DeadKeys["acute"]["c"] := "ć"
    DeadKeys["acute"]["E"] := "É"
    DeadKeys["acute"]["e"] := "é"
    DeadKeys["acute"]["G"] := "Ǵ"
    DeadKeys["acute"]["g"] := "ǵ"
    DeadKeys["acute"]["I"] := "Í"
    DeadKeys["acute"]["i"] := "í"
    DeadKeys["acute"]["K"] := "Ḱ"
    DeadKeys["acute"]["k"] := "ḱ"
    DeadKeys["acute"]["L"] := "Ĺ"
    DeadKeys["acute"]["l"] := "ĺ"
    DeadKeys["acute"]["M"] := "Ḿ"
    DeadKeys["acute"]["m"] := "ḿ"
    DeadKeys["acute"]["N"] := "Ń"
    DeadKeys["acute"]["n"] := "ń"
    DeadKeys["acute"]["O"] := "Ó"
    DeadKeys["acute"]["o"] := "ó"
    DeadKeys["acute"]["Ø"] := "Ǿ"
    DeadKeys["acute"]["ø"] := "ǿ"
    DeadKeys["acute"]["P"] := "Ṕ"
    DeadKeys["acute"]["p"] := "ṕ"
    DeadKeys["acute"]["R"] := "Ŕ"
    DeadKeys["acute"]["r"] := "ŕ"
    DeadKeys["acute"]["S"] := "Ś"
    DeadKeys["acute"]["s"] := "ś"
    DeadKeys["acute"]["U"] := "Ú"
    DeadKeys["acute"]["u"] := "ú"
    DeadKeys["acute"]["W"] := "Ẃ"
    DeadKeys["acute"]["w"] := "ẃ"
    DeadKeys["acute"]["Y"] := "Ý"
    DeadKeys["acute"]["y"] := "ý"
    DeadKeys["acute"]["Z"] := "Ź"
    DeadKeys["acute"]["z"] := "ź"
  }
  DeadKey("´", DeadKeys["acute"])
} else {
  ; doubleacute
  if (DeadKeys["doubleacute"] == "") {
    DeadKeys["doubleacute"] := Object()
    DeadKeys["doubleacute"]["O"] := "Ő"
    DeadKeys["doubleacute"]["o"] := "ő"
    DeadKeys["doubleacute"]["U"] := "Ű"
    DeadKeys["doubleacute"]["u"] := "ű"
  }
  DeadKey("˝", DeadKeys["doubleacute"])
}
Return
+>!<^SC021::
if not GetKeyState("CapsLock", "T") {
  ; doubleacute
  if (DeadKeys["doubleacute"] == "") {
    DeadKeys["doubleacute"] := Object()
    DeadKeys["doubleacute"]["O"] := "Ő"
    DeadKeys["doubleacute"]["o"] := "ő"
    DeadKeys["doubleacute"]["U"] := "Ű"
    DeadKeys["doubleacute"]["u"] := "ű"
  }
  DeadKey("˝", DeadKeys["doubleacute"])
} else {
  ; acute
  if (DeadKeys["acute"] == "") {
    DeadKeys["acute"] := Object()
    DeadKeys["acute"][" "] := "'"
    DeadKeys["acute"]["A"] := "Á"
    DeadKeys["acute"]["a"] := "á"
    DeadKeys["acute"]["Æ"] := "Ǽ"
    DeadKeys["acute"]["æ"] := "ǽ"
    DeadKeys["acute"]["C"] := "Ć"
    DeadKeys["acute"]["c"] := "ć"
    DeadKeys["acute"]["E"] := "É"
    DeadKeys["acute"]["e"] := "é"
    DeadKeys["acute"]["G"] := "Ǵ"
    DeadKeys["acute"]["g"] := "ǵ"
    DeadKeys["acute"]["I"] := "Í"
    DeadKeys["acute"]["i"] := "í"
    DeadKeys["acute"]["K"] := "Ḱ"
    DeadKeys["acute"]["k"] := "ḱ"
    DeadKeys["acute"]["L"] := "Ĺ"
    DeadKeys["acute"]["l"] := "ĺ"
    DeadKeys["acute"]["M"] := "Ḿ"
    DeadKeys["acute"]["m"] := "ḿ"
    DeadKeys["acute"]["N"] := "Ń"
    DeadKeys["acute"]["n"] := "ń"
    DeadKeys["acute"]["O"] := "Ó"
    DeadKeys["acute"]["o"] := "ó"
    DeadKeys["acute"]["Ø"] := "Ǿ"
    DeadKeys["acute"]["ø"] := "ǿ"
    DeadKeys["acute"]["P"] := "Ṕ"
    DeadKeys["acute"]["p"] := "ṕ"
    DeadKeys["acute"]["R"] := "Ŕ"
    DeadKeys["acute"]["r"] := "ŕ"
    DeadKeys["acute"]["S"] := "Ś"
    DeadKeys["acute"]["s"] := "ś"
    DeadKeys["acute"]["U"] := "Ú"
    DeadKeys["acute"]["u"] := "ú"
    DeadKeys["acute"]["W"] := "Ẃ"
    DeadKeys["acute"]["w"] := "ẃ"
    DeadKeys["acute"]["Y"] := "Ý"
    DeadKeys["acute"]["y"] := "ý"
    DeadKeys["acute"]["Z"] := "Ź"
    DeadKeys["acute"]["z"] := "ź"
  }
  DeadKey("´", DeadKeys["acute"])
}
Return
#if Extend
*SC021::
Send {Blind}{Ctrl Down}
if (ModsSC021 == "")
  ModsSC021 := Object()
ModsSC021.Insert("Ctrl")
Return

; QWERTY G
#if not Extend
SC022::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0064} ; d
} else {
  Send {Blind}{U+0044} ; D
}
Return
+SC022::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0044} ; D
} else {
  Send {Blind}{U+0064} ; d
}
Return
>!<^SC022::
if not GetKeyState("CapsLock", "T") {
  ; diaeresis
  if (DeadKeys["diaeresis"] == "") {
    DeadKeys["diaeresis"] := Object()
    DeadKeys["diaeresis"][" "] := """"
    DeadKeys["diaeresis"]["A"] := "Ä"
    DeadKeys["diaeresis"]["a"] := "ä"
    DeadKeys["diaeresis"]["E"] := "Ë"
    DeadKeys["diaeresis"]["e"] := "ë"
    DeadKeys["diaeresis"]["H"] := "Ḧ"
    DeadKeys["diaeresis"]["h"] := "ḧ"
    DeadKeys["diaeresis"]["I"] := "Ï"
    DeadKeys["diaeresis"]["i"] := "ï"
    DeadKeys["diaeresis"]["O"] := "Ö"
    DeadKeys["diaeresis"]["o"] := "ö"
    DeadKeys["diaeresis"]["t"] := "ẗ"
    DeadKeys["diaeresis"]["U"] := "Ü"
    DeadKeys["diaeresis"]["u"] := "ü"
    DeadKeys["diaeresis"]["W"] := "Ẅ"
    DeadKeys["diaeresis"]["w"] := "ẅ"
    DeadKeys["diaeresis"]["X"] := "Ẍ"
    DeadKeys["diaeresis"]["x"] := "ẍ"
    DeadKeys["diaeresis"]["Y"] := "Ÿ"
    DeadKeys["diaeresis"]["y"] := "ÿ"
  }
  DeadKey("¨", DeadKeys["diaeresis"])
} else {
}
Return
+>!<^SC022::
if not GetKeyState("CapsLock", "T") {
} else {
  ; diaeresis
  if (DeadKeys["diaeresis"] == "") {
    DeadKeys["diaeresis"] := Object()
    DeadKeys["diaeresis"][" "] := """"
    DeadKeys["diaeresis"]["A"] := "Ä"
    DeadKeys["diaeresis"]["a"] := "ä"
    DeadKeys["diaeresis"]["E"] := "Ë"
    DeadKeys["diaeresis"]["e"] := "ë"
    DeadKeys["diaeresis"]["H"] := "Ḧ"
    DeadKeys["diaeresis"]["h"] := "ḧ"
    DeadKeys["diaeresis"]["I"] := "Ï"
    DeadKeys["diaeresis"]["i"] := "ï"
    DeadKeys["diaeresis"]["O"] := "Ö"
    DeadKeys["diaeresis"]["o"] := "ö"
    DeadKeys["diaeresis"]["t"] := "ẗ"
    DeadKeys["diaeresis"]["U"] := "Ü"
    DeadKeys["diaeresis"]["u"] := "ü"
    DeadKeys["diaeresis"]["W"] := "Ẅ"
    DeadKeys["diaeresis"]["w"] := "ẅ"
    DeadKeys["diaeresis"]["X"] := "Ẍ"
    DeadKeys["diaeresis"]["x"] := "ẍ"
    DeadKeys["diaeresis"]["Y"] := "Ÿ"
    DeadKeys["diaeresis"]["y"] := "ÿ"
  }
  DeadKey("¨", DeadKeys["diaeresis"])
}
Return
#if Extend
*SC022::Send {Blind}{Click Rel 0,17,0}

; QWERTY H
#if not Extend
SC023::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0068} ; h
} else {
  Send {Blind}{U+0048} ; H
}
Return
+SC023::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0048} ; H
} else {
  Send {Blind}{U+0068} ; h
}
Return
>!<^SC023::
if not GetKeyState("CapsLock", "T") {
  ; caron
  if (DeadKeys["caron"] == "") {
    DeadKeys["caron"] := Object()
    DeadKeys["caron"]["A"] := "Ǎ"
    DeadKeys["caron"]["a"] := "ǎ"
    DeadKeys["caron"]["C"] := "Č"
    DeadKeys["caron"]["c"] := "č"
    DeadKeys["caron"]["D"] := "Ď"
    DeadKeys["caron"]["d"] := "ď"
    DeadKeys["caron"]["E"] := "Ě"
    DeadKeys["caron"]["e"] := "ě"
    DeadKeys["caron"]["G"] := "Ǧ"
    DeadKeys["caron"]["g"] := "ǧ"
    DeadKeys["caron"]["H"] := "Ȟ"
    DeadKeys["caron"]["h"] := "ȟ"
    DeadKeys["caron"]["I"] := "Ǐ"
    DeadKeys["caron"]["i"] := "ǐ"
    DeadKeys["caron"]["j"] := "ǰ"
    DeadKeys["caron"]["K"] := "Ǩ"
    DeadKeys["caron"]["k"] := "ǩ"
    DeadKeys["caron"]["L"] := "Ľ"
    DeadKeys["caron"]["l"] := "ľ"
    DeadKeys["caron"]["N"] := "Ň"
    DeadKeys["caron"]["n"] := "ň"
    DeadKeys["caron"]["O"] := "Ǒ"
    DeadKeys["caron"]["o"] := "ǒ"
    DeadKeys["caron"]["R"] := "Ř"
    DeadKeys["caron"]["r"] := "ř"
    DeadKeys["caron"]["S"] := "Š"
    DeadKeys["caron"]["s"] := "š"
    DeadKeys["caron"]["T"] := "Ť"
    DeadKeys["caron"]["t"] := "ť"
    DeadKeys["caron"]["U"] := "Ǔ"
    DeadKeys["caron"]["u"] := "ǔ"
    DeadKeys["caron"]["Z"] := "Ž"
    DeadKeys["caron"]["z"] := "ž"
    DeadKeys["caron"]["Ʒ"] := "Ǯ"
    DeadKeys["caron"]["ʒ"] := "ǯ"
  }
  DeadKey("ˇ", DeadKeys["caron"])
} else {
}
Return
+>!<^SC023::
if not GetKeyState("CapsLock", "T") {
} else {
  ; caron
  if (DeadKeys["caron"] == "") {
    DeadKeys["caron"] := Object()
    DeadKeys["caron"]["A"] := "Ǎ"
    DeadKeys["caron"]["a"] := "ǎ"
    DeadKeys["caron"]["C"] := "Č"
    DeadKeys["caron"]["c"] := "č"
    DeadKeys["caron"]["D"] := "Ď"
    DeadKeys["caron"]["d"] := "ď"
    DeadKeys["caron"]["E"] := "Ě"
    DeadKeys["caron"]["e"] := "ě"
    DeadKeys["caron"]["G"] := "Ǧ"
    DeadKeys["caron"]["g"] := "ǧ"
    DeadKeys["caron"]["H"] := "Ȟ"
    DeadKeys["caron"]["h"] := "ȟ"
    DeadKeys["caron"]["I"] := "Ǐ"
    DeadKeys["caron"]["i"] := "ǐ"
    DeadKeys["caron"]["j"] := "ǰ"
    DeadKeys["caron"]["K"] := "Ǩ"
    DeadKeys["caron"]["k"] := "ǩ"
    DeadKeys["caron"]["L"] := "Ľ"
    DeadKeys["caron"]["l"] := "ľ"
    DeadKeys["caron"]["N"] := "Ň"
    DeadKeys["caron"]["n"] := "ň"
    DeadKeys["caron"]["O"] := "Ǒ"
    DeadKeys["caron"]["o"] := "ǒ"
    DeadKeys["caron"]["R"] := "Ř"
    DeadKeys["caron"]["r"] := "ř"
    DeadKeys["caron"]["S"] := "Š"
    DeadKeys["caron"]["s"] := "š"
    DeadKeys["caron"]["T"] := "Ť"
    DeadKeys["caron"]["t"] := "ť"
    DeadKeys["caron"]["U"] := "Ǔ"
    DeadKeys["caron"]["u"] := "ǔ"
    DeadKeys["caron"]["Z"] := "Ž"
    DeadKeys["caron"]["z"] := "ž"
    DeadKeys["caron"]["Ʒ"] := "Ǯ"
    DeadKeys["caron"]["ʒ"] := "ǯ"
  }
  DeadKey("ˇ", DeadKeys["caron"])
}
Return
#if Extend
*SC023::Send {Blind}{PgDn}

; QWERTY J
#if not Extend
SC024::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006e} ; n
} else {
  Send {Blind}{U+004e} ; N
}
Return
+SC024::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004e} ; N
} else {
  Send {Blind}{U+006e} ; n
}
Return
>!<^SC024::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00f1} ; ñ
} else {
  Send {Blind}{U+00d1} ; Ñ
}
Return
+>!<^SC024::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00d1} ; Ñ
} else {
  Send {Blind}{U+00f1} ; ñ
}
Return
#if Extend
*SC024::Send {Blind}{Left}

; QWERTY K
#if not Extend
SC025::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0065} ; e
} else {
  Send {Blind}{U+0045} ; E
}
Return
+SC025::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0045} ; E
} else {
  Send {Blind}{U+0065} ; e
}
Return
>!<^SC025::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e9} ; é
} else {
  Send {Blind}{U+00c9} ; É
}
Return
+>!<^SC025::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c9} ; É
} else {
  Send {Blind}{U+00e9} ; é
}
Return
#if Extend
*SC025::Send {Blind}{Down}

; QWERTY L
#if not Extend
SC026::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0069} ; i
} else {
  Send {Blind}{U+0049} ; I
}
Return
+SC026::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0049} ; I
} else {
  Send {Blind}{U+0069} ; i
}
Return
>!<^SC026::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00ed} ; í
} else {
  Send {Blind}{U+00cd} ; Í
}
Return
+>!<^SC026::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00cd} ; Í
} else {
  Send {Blind}{U+00ed} ; í
}
Return
#if Extend
*SC026::Send {Blind}{Right}

; QWERTY ;
#if not Extend
SC027::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006f} ; o
} else {
  Send {Blind}{U+004f} ; O
}
Return
+SC027::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004f} ; O
} else {
  Send {Blind}{U+006f} ; o
}
Return
>!<^SC027::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00f3} ; ó
} else {
  Send {Blind}{U+00d3} ; Ó
}
Return
+>!<^SC027::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00d3} ; Ó
} else {
  Send {Blind}{U+00f3} ; ó
}
Return
#if Extend
*SC027::Send {Blind}{BackSpace}

; QWERTY '
#if not Extend
SC028::Send {Blind}{U+0027} ; '
+SC028::Send {Blind}{U+0022} ; "
>!<^SC028::Send {Blind}{U+00f5} ; õ
+>!<^SC028::Send {Blind}{U+00d5} ; Õ
#if Extend
*SC028::Send {Blind}{AppsKey}

; QWERTY Z
#if not Extend
SC02c::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+007a} ; z
} else {
  Send {Blind}{U+005a} ; Z
}
Return
+SC02c::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+005a} ; Z
} else {
  Send {Blind}{U+007a} ; z
}
Return
>!<^SC02c::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e6} ; æ
} else {
  Send {Blind}{U+00c6} ; Æ
}
Return
+>!<^SC02c::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c6} ; Æ
} else {
  Send {Blind}{U+00e6} ; æ
}
Return
#if Extend
*SC02c::Send {Blind}^{VK5aSC02c}

; QWERTY X
#if not Extend
SC02d::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0078} ; x
} else {
  Send {Blind}{U+0058} ; X
}
Return
+SC02d::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0058} ; X
} else {
  Send {Blind}{U+0078} ; x
}
Return
>!<^SC02d::
if not GetKeyState("CapsLock", "T") {
  ; circumflex
  if (DeadKeys["circumflex"] == "") {
    DeadKeys["circumflex"] := Object()
    DeadKeys["circumflex"][" "] := "^"
    DeadKeys["circumflex"]["A"] := "Â"
    DeadKeys["circumflex"]["a"] := "â"
    DeadKeys["circumflex"]["C"] := "Ĉ"
    DeadKeys["circumflex"]["c"] := "ĉ"
    DeadKeys["circumflex"]["E"] := "Ê"
    DeadKeys["circumflex"]["e"] := "ê"
    DeadKeys["circumflex"]["G"] := "Ĝ"
    DeadKeys["circumflex"]["g"] := "ĝ"
    DeadKeys["circumflex"]["H"] := "Ĥ"
    DeadKeys["circumflex"]["h"] := "ĥ"
    DeadKeys["circumflex"]["I"] := "Î"
    DeadKeys["circumflex"]["i"] := "î"
    DeadKeys["circumflex"]["J"] := "Ĵ"
    DeadKeys["circumflex"]["j"] := "ĵ"
    DeadKeys["circumflex"]["O"] := "Ô"
    DeadKeys["circumflex"]["o"] := "ô"
    DeadKeys["circumflex"]["S"] := "Ŝ"
    DeadKeys["circumflex"]["s"] := "ŝ"
    DeadKeys["circumflex"]["U"] := "Û"
    DeadKeys["circumflex"]["u"] := "û"
    DeadKeys["circumflex"]["W"] := "Ŵ"
    DeadKeys["circumflex"]["w"] := "ŵ"
    DeadKeys["circumflex"]["Y"] := "Ŷ"
    DeadKeys["circumflex"]["y"] := "ŷ"
    DeadKeys["circumflex"]["Z"] := "Ẑ"
    DeadKeys["circumflex"]["z"] := "ẑ"
  }
  DeadKey("^", DeadKeys["circumflex"])
} else {
}
Return
+>!<^SC02d::
if not GetKeyState("CapsLock", "T") {
} else {
  ; circumflex
  if (DeadKeys["circumflex"] == "") {
    DeadKeys["circumflex"] := Object()
    DeadKeys["circumflex"][" "] := "^"
    DeadKeys["circumflex"]["A"] := "Â"
    DeadKeys["circumflex"]["a"] := "â"
    DeadKeys["circumflex"]["C"] := "Ĉ"
    DeadKeys["circumflex"]["c"] := "ĉ"
    DeadKeys["circumflex"]["E"] := "Ê"
    DeadKeys["circumflex"]["e"] := "ê"
    DeadKeys["circumflex"]["G"] := "Ĝ"
    DeadKeys["circumflex"]["g"] := "ĝ"
    DeadKeys["circumflex"]["H"] := "Ĥ"
    DeadKeys["circumflex"]["h"] := "ĥ"
    DeadKeys["circumflex"]["I"] := "Î"
    DeadKeys["circumflex"]["i"] := "î"
    DeadKeys["circumflex"]["J"] := "Ĵ"
    DeadKeys["circumflex"]["j"] := "ĵ"
    DeadKeys["circumflex"]["O"] := "Ô"
    DeadKeys["circumflex"]["o"] := "ô"
    DeadKeys["circumflex"]["S"] := "Ŝ"
    DeadKeys["circumflex"]["s"] := "ŝ"
    DeadKeys["circumflex"]["U"] := "Û"
    DeadKeys["circumflex"]["u"] := "û"
    DeadKeys["circumflex"]["W"] := "Ŵ"
    DeadKeys["circumflex"]["w"] := "ŵ"
    DeadKeys["circumflex"]["Y"] := "Ŷ"
    DeadKeys["circumflex"]["y"] := "ŷ"
    DeadKeys["circumflex"]["Z"] := "Ẑ"
    DeadKeys["circumflex"]["z"] := "ẑ"
  }
  DeadKey("^", DeadKeys["circumflex"])
}
Return
#if Extend
*SC02d::Send {Blind}^{VK58SC02d}

; QWERTY C
#if not Extend
SC02e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0063} ; c
} else {
  Send {Blind}{U+0043} ; C
}
Return
+SC02e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0043} ; C
} else {
  Send {Blind}{U+0063} ; c
}
Return
>!<^SC02e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00e7} ; ç
} else {
  Send {Blind}{U+00c7} ; Ç
}
Return
+>!<^SC02e::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+00c7} ; Ç
} else {
  Send {Blind}{U+00e7} ; ç
}
Return
#if Extend
*SC02e::Send {Blind}^{VK43SC02e}

; QWERTY V
#if not Extend
SC02f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0076} ; v
} else {
  Send {Blind}{U+0056} ; V
}
Return
+SC02f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0056} ; V
} else {
  Send {Blind}{U+0076} ; v
}
Return
>!<^SC02f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0153} ; œ
} else {
  Send {Blind}{U+0152} ; Œ
}
Return
+>!<^SC02f::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0152} ; Œ
} else {
  Send {Blind}{U+0153} ; œ
}
Return
#if Extend
*SC02f::Send {Blind}^{VK56SC02f}

; QWERTY B
#if not Extend
SC030::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0062} ; b
} else {
  Send {Blind}{U+0042} ; B
}
Return
+SC030::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+0042} ; B
} else {
  Send {Blind}{U+0062} ; b
}
Return
>!<^SC030::
if not GetKeyState("CapsLock", "T") {
  ; breve
  if (DeadKeys["breve"] == "") {
    DeadKeys["breve"] := Object()
    DeadKeys["breve"]["A"] := "Ă"
    DeadKeys["breve"]["a"] := "ă"
    DeadKeys["breve"]["E"] := "Ĕ"
    DeadKeys["breve"]["e"] := "ĕ"
    DeadKeys["breve"]["G"] := "Ğ"
    DeadKeys["breve"]["g"] := "ğ"
    DeadKeys["breve"]["I"] := "Ĭ"
    DeadKeys["breve"]["i"] := "ĭ"
    DeadKeys["breve"]["O"] := "Ŏ"
    DeadKeys["breve"]["o"] := "ŏ"
    DeadKeys["breve"]["U"] := "Ŭ"
    DeadKeys["breve"]["u"] := "ŭ"
  }
  DeadKey("˘", DeadKeys["breve"])
} else {
}
Return
+>!<^SC030::
if not GetKeyState("CapsLock", "T") {
} else {
  ; breve
  if (DeadKeys["breve"] == "") {
    DeadKeys["breve"] := Object()
    DeadKeys["breve"]["A"] := "Ă"
    DeadKeys["breve"]["a"] := "ă"
    DeadKeys["breve"]["E"] := "Ĕ"
    DeadKeys["breve"]["e"] := "ĕ"
    DeadKeys["breve"]["G"] := "Ğ"
    DeadKeys["breve"]["g"] := "ğ"
    DeadKeys["breve"]["I"] := "Ĭ"
    DeadKeys["breve"]["i"] := "ĭ"
    DeadKeys["breve"]["O"] := "Ŏ"
    DeadKeys["breve"]["o"] := "ŏ"
    DeadKeys["breve"]["U"] := "Ŭ"
    DeadKeys["breve"]["u"] := "ŭ"
  }
  DeadKey("˘", DeadKeys["breve"])
}
Return
#if Extend
*SC030::Send {Blind}{LButton}

; QWERTY N
#if not Extend
SC031::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006b} ; k
} else {
  Send {Blind}{U+004b} ; K
}
Return
+SC031::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004b} ; K
} else {
  Send {Blind}{U+006b} ; k
}
Return
>!<^SC031::
if not GetKeyState("CapsLock", "T") {
  ; abovering
  if (DeadKeys["abovering"] == "") {
    DeadKeys["abovering"] := Object()
    DeadKeys["abovering"]["A"] := "Å"
    DeadKeys["abovering"]["a"] := "å"
    DeadKeys["abovering"]["U"] := "Ů"
    DeadKeys["abovering"]["u"] := "ů"
    DeadKeys["abovering"]["w"] := "ẘ"
    DeadKeys["abovering"]["y"] := "ẙ"
  }
  DeadKey("˚", DeadKeys["abovering"])
} else {
}
Return
+>!<^SC031::
if not GetKeyState("CapsLock", "T") {
} else {
  ; abovering
  if (DeadKeys["abovering"] == "") {
    DeadKeys["abovering"] := Object()
    DeadKeys["abovering"]["A"] := "Å"
    DeadKeys["abovering"]["a"] := "å"
    DeadKeys["abovering"]["U"] := "Ů"
    DeadKeys["abovering"]["u"] := "ů"
    DeadKeys["abovering"]["w"] := "ẘ"
    DeadKeys["abovering"]["y"] := "ẙ"
  }
  DeadKey("˚", DeadKeys["abovering"])
}
Return
#if Extend
*SC031::Send {Blind}{MButton}

; QWERTY M
#if not Extend
SC032::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+006d} ; m
} else {
  Send {Blind}{U+004d} ; M
}
Return
+SC032::
if not GetKeyState("CapsLock", "T") {
  Send {Blind}{U+004d} ; M
} else {
  Send {Blind}{U+006d} ; m
}
Return
>!<^SC032::
if not GetKeyState("CapsLock", "T") {
  ; macron
  if (DeadKeys["macron"] == "") {
    DeadKeys["macron"] := Object()
    DeadKeys["macron"]["A"] := "Ā"
    DeadKeys["macron"]["a"] := "ā"
    DeadKeys["macron"]["E"] := "Ē"
    DeadKeys["macron"]["e"] := "ē"
    DeadKeys["macron"]["G"] := "Ḡ"
    DeadKeys["macron"]["g"] := "ḡ"
    DeadKeys["macron"]["I"] := "Ī"
    DeadKeys["macron"]["i"] := "ī"
    DeadKeys["macron"]["O"] := "Ō"
    DeadKeys["macron"]["o"] := "ō"
    DeadKeys["macron"]["U"] := "Ū"
    DeadKeys["macron"]["u"] := "ū"
    DeadKeys["macron"]["Y"] := "Ȳ"
    DeadKeys["macron"]["y"] := "ȳ"
    DeadKeys["macron"]["Æ"] := "Ǣ"
    DeadKeys["macron"]["æ"] := "ǣ"
  }
  DeadKey("¯", DeadKeys["macron"])
} else {
}
Return
+>!<^SC032::
if not GetKeyState("CapsLock", "T") {
} else {
  ; macron
  if (DeadKeys["macron"] == "") {
    DeadKeys["macron"] := Object()
    DeadKeys["macron"]["A"] := "Ā"
    DeadKeys["macron"]["a"] := "ā"
    DeadKeys["macron"]["E"] := "Ē"
    DeadKeys["macron"]["e"] := "ē"
    DeadKeys["macron"]["G"] := "Ḡ"
    DeadKeys["macron"]["g"] := "ḡ"
    DeadKeys["macron"]["I"] := "Ī"
    DeadKeys["macron"]["i"] := "ī"
    DeadKeys["macron"]["O"] := "Ō"
    DeadKeys["macron"]["o"] := "ō"
    DeadKeys["macron"]["U"] := "Ū"
    DeadKeys["macron"]["u"] := "ū"
    DeadKeys["macron"]["Y"] := "Ȳ"
    DeadKeys["macron"]["y"] := "ȳ"
    DeadKeys["macron"]["Æ"] := "Ǣ"
    DeadKeys["macron"]["æ"] := "ǣ"
  }
  DeadKey("¯", DeadKeys["macron"])
}
Return
#if Extend
*SC032::Send {Blind}{RButton}

; QWERTY ,
#if not Extend
SC033::Send {Blind}{U+002c} ; ,
+SC033::Send {Blind}{U+003c} ; <
>!<^SC033::
; cedilla
if (DeadKeys["cedilla"] == "") {
  DeadKeys["cedilla"] := Object()
  DeadKeys["cedilla"]["C"] := "Ç"
  DeadKeys["cedilla"]["c"] := "ç"
  DeadKeys["cedilla"]["D"] := "Ḑ"
  DeadKeys["cedilla"]["d"] := "ḑ"
  DeadKeys["cedilla"]["E"] := "Ȩ"
  DeadKeys["cedilla"]["e"] := "ȩ"
  DeadKeys["cedilla"]["G"] := "Ģ"
  DeadKeys["cedilla"]["g"] := "ģ"
  DeadKeys["cedilla"]["H"] := "Ḩ"
  DeadKeys["cedilla"]["h"] := "ḩ"
  DeadKeys["cedilla"]["K"] := "Ķ"
  DeadKeys["cedilla"]["k"] := "ķ"
  DeadKeys["cedilla"]["L"] := "Ļ"
  DeadKeys["cedilla"]["l"] := "ļ"
  DeadKeys["cedilla"]["N"] := "Ņ"
  DeadKeys["cedilla"]["n"] := "ņ"
  DeadKeys["cedilla"]["R"] := "Ŗ"
  DeadKeys["cedilla"]["r"] := "ŗ"
  DeadKeys["cedilla"]["S"] := "Ş"
  DeadKeys["cedilla"]["s"] := "ş"
  DeadKeys["cedilla"]["T"] := "Ţ"
  DeadKeys["cedilla"]["t"] := "ţ"
}
DeadKey("¸", DeadKeys["cedilla"])
Return
+>!<^SC033::Return
#if Extend
*SC033::Send {Blind}{Click Rel -17,0,0}

; QWERTY .
#if not Extend
SC034::Send {Blind}{U+002e} ; .
+SC034::Send {Blind}{U+003e} ; >
>!<^SC034::
; abovedot
if (DeadKeys["abovedot"] == "") {
  DeadKeys["abovedot"] := Object()
  DeadKeys["abovedot"]["A"] := "Ȧ"
  DeadKeys["abovedot"]["a"] := "ȧ"
  DeadKeys["abovedot"]["B"] := "Ḃ"
  DeadKeys["abovedot"]["b"] := "ḃ"
  DeadKeys["abovedot"]["C"] := "Ċ"
  DeadKeys["abovedot"]["c"] := "ċ"
  DeadKeys["abovedot"]["D"] := "Ḋ"
  DeadKeys["abovedot"]["d"] := "ḋ"
  DeadKeys["abovedot"]["E"] := "Ė"
  DeadKeys["abovedot"]["e"] := "ė"
  DeadKeys["abovedot"]["F"] := "Ḟ"
  DeadKeys["abovedot"]["f"] := "ḟ"
  DeadKeys["abovedot"]["G"] := "Ġ"
  DeadKeys["abovedot"]["g"] := "ġ"
  DeadKeys["abovedot"]["H"] := "Ḣ"
  DeadKeys["abovedot"]["h"] := "ḣ"
  DeadKeys["abovedot"]["I"] := "İ"
  DeadKeys["abovedot"]["i"] := "ı"
  DeadKeys["abovedot"]["M"] := "Ṁ"
  DeadKeys["abovedot"]["m"] := "ṁ"
  DeadKeys["abovedot"]["N"] := "Ṅ"
  DeadKeys["abovedot"]["n"] := "ṅ"
  DeadKeys["abovedot"]["O"] := "Ȯ"
  DeadKeys["abovedot"]["o"] := "ȯ"
  DeadKeys["abovedot"]["P"] := "Ṗ"
  DeadKeys["abovedot"]["p"] := "ṗ"
  DeadKeys["abovedot"]["R"] := "Ṙ"
  DeadKeys["abovedot"]["r"] := "ṙ"
  DeadKeys["abovedot"]["S"] := "Ṡ"
  DeadKeys["abovedot"]["s"] := "ṡ"
  DeadKeys["abovedot"]["T"] := "Ṫ"
  DeadKeys["abovedot"]["t"] := "ṫ"
  DeadKeys["abovedot"]["W"] := "Ẇ"
  DeadKeys["abovedot"]["w"] := "ẇ"
  DeadKeys["abovedot"]["X"] := "Ẋ"
  DeadKeys["abovedot"]["x"] := "ẋ"
  DeadKeys["abovedot"]["Y"] := "Ẏ"
  DeadKeys["abovedot"]["y"] := "ẏ"
  DeadKeys["abovedot"]["Z"] := "Ż"
  DeadKeys["abovedot"]["z"] := "ż"
}
DeadKey("˙", DeadKeys["abovedot"])
Return
+>!<^SC034::Return
#if Extend
*SC034::Send {Blind}{Click Rel 17,0,0}

; QWERTY /
#if not Extend
SC035::Send {Blind}{U+002f} ; /
+SC035::Send {Blind}{U+003f} ; ?
>!<^SC035::Send {Blind}{U+00bf} ; ¿
+>!<^SC035::Return
#if Extend
*SC035::Return

; QWERTY Space
#if not Extend
>!<^SC039::Send {Blind}{U+0020} ;  
+>!<^SC039::Send {Blind}{U+00a0} ;  
#if Extend
*SC039::Send {Blind}{Enter}

; QWERTY Escape
#if Extend
*SC001::Send {Blind}{CapsLock}

; QWERTY F1
#if Extend
*SC03b::Send {Blind}{Media_Play_Pause}
+SC03b::Return

; QWERTY F2
#if Extend
*SC03c::Send {Blind}{Media_Prev}
+SC03c::Return

; QWERTY F3
#if Extend
*SC03d::Send {Blind}{Media_Next}
+SC03d::Return

; QWERTY F4
#if Extend
*SC03e::Send {Blind}{Media_Stop}
+SC03e::Return

; QWERTY F5
#if Extend
*SC03f::Send {Blind}{Volume_Mute}
+SC03f::Send {Browser_Refresh}

; QWERTY F6
#if Extend
*SC040::Send {Blind}{Volume_Down}
+SC040::Return

; QWERTY F7
#if Extend
*SC041::Send {Blind}{Volume_Up}
+SC041::Return

; QWERTY F8
#if Extend
*SC042::Send {Blind}{Launch_Media}
+SC042::Send {Sleep}

; QWERTY F9
#if Extend
*SC043::Send {Blind}{Browser_Home}
+SC043::Return

; QWERTY F10
#if Extend
*SC044::Return
+SC044::Send {Launch_Mail}

; QWERTY F11
#if Extend
*SC057::Return
+SC057::Send {Launch_App1}

; QWERTY F12
#if Extend
*SC058::Send {Blind}{Launch_App2}
+SC058::Send {Launch_App2}