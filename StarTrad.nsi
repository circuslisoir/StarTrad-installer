;NSIS Modern User Interface
;Welcome/Finish Page Example Script
;Written by Joost Verburg

;--------------------------------
;Include Modern UI

  !include "MUI2.nsh"

;--------------------------------
;Include Dialog creator

  !include "nsDialogs.nsh"

;--------------------------------
;General

  ;Name and file
  Name "StarTrad"
  OutFile "StarTrad_setup_0.9.1-BETA.exe"
  Unicode True

  ;Default installation folder
  InstallDir "$LOCALAPPDATA\Startrad"

  ;Request application privileges for Windows Vista
  RequestExecutionLevel user

;--------------------------------
;Interface Settings

  !define MUI_WELCOMEFINISHPAGE_BITMAP "${NSISDIR}\Contrib\Graphics\Wizard\orange.bmp"
  !define MUI_ABORTWARNING
  !define MUI_ICON "E:\startrad-installer\StarTrad_sombre.ico"
  !define MUI_UNICON "E:\startrad-installer\StarTrad_sombre.ico"

  ; !define MUI_BGCOLOR 252525
  ; !define MUI_TEXTCOLOR FFFFFF

;--------------------------------
;Options finish

  !define MUI_FINISHPAGE_RUN "$LOCALAPPDATA\Startrad\StarTrad.exe"
  !define MUI_FINISHPAGE_RUN_TEXT "Lancer StarTrad sans attendre"

;--------------------------------
;Pages

  Function dotnet8
    !insertmacro MUI_HEADER_TEXT "test1" "test2"
  FunctionEnd

  !insertmacro MUI_PAGE_WELCOME
  ;!insertmacro MUI_PAGE_LICENSE "${NSISDIR}\Docs\Modern UI\License.txt"
  ;!insertmacro MUI_PAGE_COMPONENTS
  Page custom dotnet8
  !insertmacro MUI_PAGE_DIRECTORY
  !insertmacro MUI_PAGE_INSTFILES
  !insertmacro MUI_PAGE_FINISH

  !insertmacro MUI_UNPAGE_WELCOME
  !insertmacro MUI_UNPAGE_CONFIRM
  !insertmacro MUI_UNPAGE_INSTFILES
  !insertmacro MUI_UNPAGE_FINISH

;--------------------------------
;Languages

  !insertmacro MUI_LANGUAGE "French"

;--------------------------------
;Installer Sections

Section "Dummy Section" SecDummy

  SetOutPath "$INSTDIR"

  ;ADD YOUR OWN FILES HERE...
  File /r "StarTrad_x64\"

  ;Store installation folder
  ;WriteRegStr HKCU "Software\Modern UI Test" "" $INSTDIR

  ;Create uninstaller
  WriteUninstaller "$INSTDIR\Uninstall.exe"

	# Shortcut
  createShortCut "$DESKTOP\StarTrad.lnk" "$INSTDIR\StarTrad.exe" "" "$INSTDIR\StarTrad.ico"
  createShortCut "$SMSTARTUP\StarTrad.lnk" "$INSTDIR\StarTrad.exe" "" "$INSTDIR\StarTrad.ico"
 
	# Registry information for add/remove programs
	WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "DisplayName"           "StarTrad"
	WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "UninstallString"       "$\"$INSTDIR\uninstall.exe$\""
	WriteRegStr HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "QuietUninstallString"  "$\"$INSTDIR\uninstall.exe$\" /S"
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "InstallLocation"       "$\"$INSTDIR$\""
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "DisplayIcon"           "$\"$INSTDIR\StarTrad.ico$\""
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "Publisher"             "$\"Startrad$\""
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "HelpLink"              "$\"$\""
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "URLUpdateInfo"         "$\"$\""
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "URLInfoAbout"          "$\"https://startrad.fr$\""
	WriteRegStr HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "DisplayVersion"        "$\"0.9.1-BETA$\""
	WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "VersionMajor"        1
	WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "VersionMinor"        0
	# There is no option for modifying or repairing the install
	WriteRegDWORD HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "NoModify" 1
	WriteRegDWORD HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "NoRepair" 1
	# Set the INSTALLSIZE constant (!defined at the top of this script) so Add/Remove Programs can accurately report the size
	WriteRegDWORD HKCU "Software\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad" "EstimatedSize" 719

SectionEnd

;--------------------------------
;Descriptions

  ;Language strings
  LangString DESC_SecDummy ${LANG_ENGLISH} "A test section."

  ;Assign language strings to sections
  !insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
    !insertmacro MUI_DESCRIPTION_TEXT ${SecDummy} $(DESC_SecDummy)
  !insertmacro MUI_FUNCTION_DESCRIPTION_END

;--------------------------------
;Uninstaller Section

Section "Uninstall"

  RMDir /r $INSTDIR

	# Shortcut
  Delete "$DESKTOP\StarTrad.lnk"
  Delete "$SMSTARTUP\StarTrad.lnk"

  ;DeleteRegKey /ifempty HKCU "Software\Modern UI Test"
	# Remove uninstaller information from the registry
	DeleteRegKey HKCU "SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\StarTrad"

SectionEnd
