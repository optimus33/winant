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
  
  ; Set JAVA_HOME
  WriteRegExpandStr HKCU "Environment" "JAVA_HOME" "$JDK_DIR"

  WriteUninstaller $INSTDIR\uninstaller.exe
  
SectionEnd ; end the section


Section "Uninstall"
  Delete $INSTDIR\Uninst.exe
  RMDir /r $INSTDIR

  ; Take Ant off the path
  DeleteRegValue HKCU "Environment" "ANT_HOME"
  
  DeleteRegValue HKCU "Environment" "JAVA_HOME"
SectionEnd

