Persistent
#Requires AutoHotkey v2.0.18+
#SingleInstance Force
HotIfWinActive("ahk_exe eldenring.exe")
SendMode("Input")

configFile := A_ScriptDir . "\er_kbm_config.ini"

ReadIngameConfigValue(valueName, defaultValue) {
    return IniRead(configFile, "Ingame-Settings", valueName, defaultValue)
}

ReadHotkeyConfigValue(valueName, defaultValue) {
    return IniRead(configFile, "Hotkey-Settings", valueName, defaultValue)
}

sprint := ReadIngameConfigValue("sprint", "i")
moveTargetUp := ReadIngameConfigValue("moveTargetUp", "Numpad4")
moveTargetDown := ReadIngameConfigValue("moveTargetDown", "Numpad5")
switchSorcery := ReadIngameConfigValue("switchSorcery", "2")
switchItem := ReadIngameConfigValue("switchItem", "4")
switchLeftHandArmament := ReadIngameConfigValue("switchLeftHandArmament", "1")
switchRightHandArmament := ReadIngameConfigValue("switchRightHandArmament", "3")
eventAction := ReadIngameConfigValue("eventAction", "e")
attack := ReadIngameConfigValue("attack", "LButton")

weaponWieldStyle := ReadHotkeyConfigValue("weaponWieldStyle", "f")
pouchUp := ReadHotkeyConfigValue("pouchUp", "z")
pouchDown := ReadHotkeyConfigValue("pouchDown", "c")
pouchLeft := ReadHotkeyConfigValue("pouchLeft", "b")
pouchRight := ReadHotkeyConfigValue("pouchRight", "n")
moveTargetUpAlt := ReadHotkeyConfigValue("moveTargetUpAlt", "WheelUp")
moveTargetDownAlt := ReadHotkeyConfigValue("moveTargetDownAlt", "WheelDown")
sprintAlt := ReadHotkeyConfigValue("sprintAlt", "Shift")
roll := ReadHotkeyConfigValue("roll", "l")

HoldEventActionAndSend(sendString) {
    Sleep(25)
    Send("{" . eventAction . " down}") 
    Sleep(25)
    Send("{" . sendString . " down}")
    Sleep(25)
    Send("{" . sendString . " up}")
    Sleep(25)
    Send("{" . eventAction . " up}")
}

SleepAndSend(sendString) {
    Sleep(25)
    Send("{" . sendString . "}")
}

RollWhileSprinting(*) {
    Sleep(25)
    if GetKeyState(sprintAlt, "P") {
        Send("{" . sprint . " up}")
        Sleep(25)
        
        Send("{" . sprint . " down}")
        Sleep(25)
        Send("{" . sprint . " up}")
        
        Sleep(25)
        Send("{" . sprint . " down}")
    } else {
        Send("{" . sprint . " down}")
        Sleep(25)
        Send("{" . sprint . " up}")
    }
}

Hotkey(weaponWieldStyle, (*) => HoldEventActionAndSend(attack))
Hotkey(pouchUp, (*) => HoldEventActionAndSend(switchSorcery))
Hotkey(pouchDown, (*) => HoldEventActionAndSend(switchItem))
Hotkey(pouchLeft, (*) => HoldEventActionAndSend(switchLeftHandArmament))
Hotkey(pouchRight, (*) => HoldEventActionAndSend(switchRightHandArmament))

Hotkey(moveTargetUpAlt, (*) => SleepAndSend(moveTargetUp))
Hotkey(moveTargetDownAlt, (*) => SleepAndSend(moveTargetDown))

Hotkey(sprintAlt, (*) => Send("{" . sprint . " down}"))
Hotkey(sprintAlt . " up", (*) => Send("{" . sprint . " up}"))
Hotkey("$" . roll, RollWhileSprinting)