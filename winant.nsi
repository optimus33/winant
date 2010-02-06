!include "EnvVarUpdate.nsh"


; The name of the installer
Name "WinAnt"

; The file to write
OutFile "winant-install-v4.1.exe"

; The default installation directory
InstallDir $PROGRAMFILES\WinAnt

;--------------------------------

; Pages

PageEx license
  LicenseText "Read before installing" "Next >"
  LicenseData info.txt
PageExEnd

Page components

; Custom page to locate Java directory
Function .onInit
  InitPluginsDir
  File /oname=$PLUGINSDIR\find_java.ini find_java.ini
FunctionEnd

Page custom FindJava

Function FindJava
  Var /GLOBAL JDK_DIR
  InstallOptions::dialog $PLUGINSDIR\find_java.ini
  ReadINIStr $JDK_DIR "$PLUGINSDIR\find_java.ini" "Field 4" "State"
FunctionEnd

Page directory
Page instfiles "" "" "post_install"

Function post_install
  MessageBox MB_OK "You may need to log off and log back in to complete the install process."
FunctionEnd

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------

Section "Ant"
SectionIn RO ; Makes this section required

  ; Set output path to the installation directory.
  SetOutPath $INSTDIR
  
  File /r apache-ant-1.7.1\*.*

  ; Put Ant on the path
  WriteRegExpandStr HKCU "Environment" "ANT_HOME" "$INSTDIR"
  ${EnvVarUpdate} $0 "PATH" "A" "HKCU" "$INSTDIR\bin" ; this line didn't seem to work when %ANT_HOME% was used, so i just put in $INSTDIR
  
  ; Set JAVA_HOME
  WriteRegExpandStr HKCU "Environment" "JAVA_HOME" "$JDK_DIR"

  WriteUninstaller $INSTDIR\uninstaller.exe
  
SectionEnd

Section "Ant-Contrib tasks"
    File /oname=lib\ant-contrib-1.0b3.jar ant-contrib\ant-contrib-1.0b3.jar
SectionEnd


Section "Uninstall"
  Delete $INSTDIR\Uninst.exe
  RMDir /r $INSTDIR

  ; Take Ant off the path
  DeleteRegValue HKCU "Environment" "ANT_HOME"
  ${un.EnvVarUpdate} $0 "PATH" "R" "HKCU" "$INSTDIR\bin"
  
  DeleteRegValue HKCU "Environment" "JAVA_HOME"
SectionEnd

