; example1.nsi
;
; This script is perhaps one of the simplest NSIs you can make. All of the
; optional settings are left to their default settings. The installer simply 
; prompts the user asking them where to install, and drops a copy of example1.nsi
; there. 

;--------------------------------

; The name of the installer
Name "WinAnt"

; The file to write
OutFile "winant-install.exe"

; The default installation directory
InstallDir $PROGRAMFILES\WinAnt

;--------------------------------

; Pages

PageEx license
  LicenseText "Read before installing" "Next >"
  LicenseData info.txt
PageExEnd

Page directory
Page instfiles "" "" "post_install"

Function post_install
  MessageBox MB_OK "Now you need to log off and then log back in."
FunctionEnd

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

; The stuff to install
Section "Install"

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  ; Put file there
  File /r apache-ant-1.7.0\*.*

  ; Put Ant on the path
  WriteRegExpandStr HKCU "Environment" "ANT_HOME" "$INSTDIR"
  ReadRegStr $0 HKCU "Environment" "PATH"
  WriteRegExpandStr HKCU "Environment" "PATH" "$0;%ANT_HOME%\bin"

  WriteUninstaller $INSTDIR\uninstaller.exe
  
SectionEnd ; end the section


Section "Uninstall"
  Delete $INSTDIR\Uninst.exe ; delete self (see explanation below why this works)
  RMDir /r $INSTDIR

  ; Take Ant off the path
  DeleteRegValue HKCU "Environment" "ANT_HOME"
SectionEnd

