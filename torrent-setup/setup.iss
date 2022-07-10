#define ModName "Median XL Σ"
#define MyAppName "Diablo II + " + ModName
#define MyAppVersion "2.3.2"
#define MyAppPublisher "kambala"
#define MyAppSupportURL "https://rutracker.org/forum/viewtopic.php?t=5686364"

#define ToolsDir "{src}\tools"
#define AppCompatFlagsReg "Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
#define VideoTestExe "{app}\D2VidTst.exe"
#define D2Exe "{app}\Diablo II.exe"

[Setup]
AppId={{FA8CB446-B30C-433A-8916-8572A217E4B3}
AppName={#MyAppName}
AppPublisher={#MyAppPublisher}
AppSupportURL={#MyAppSupportURL}
AppVersion={#MyAppVersion}
DefaultDirName={src}\game
DefaultGroupName={#MyAppName}

AllowNoIcons=yes
AppendDefaultDirName=no
DirExistsWarning=no
LanguageDetectionMethod=none
;PrivilegesRequired=lowest
;PrivilegesRequiredOverridesAllowed=dialog
UninstallDisplayIcon={#D2Exe}
UsePreviousAppDir=no
WizardStyle=modern

[Languages]
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopRus"; Description: "Русская версия"; GroupDescription: "{cm:AdditionalIcons}"
Name: "desktopEng"; Description: "Английская версия"; GroupDescription: "{cm:AdditionalIcons}"

[Types]
Name: "recommended"; Description: "Рекомендуемая установка"
Name: "compact"; Description: "Компактная установка"
Name: "custom"; Description: "Выборочная установка"; Flags: iscustom

[Components]
Name: "mod"; Description: "Файлы мода"; Types: recommended compact custom; Flags: fixed
Name: "glide"; Description: "Sven's Glide Wrapper (глайд)"; Types: recommended custom
Name: "launcher"; Description: "Median XL Launcher"; Types: custom

[Files]
Source: "{src}\mod\*"; DestDir: "{app}"; Components: mod; Flags: external replacesameversion
Source: "{#ToolsDir}\glide\*"; DestDir: "{app}"; Components: glide; Flags: external

[Dirs]
Name: "{userappdata}\MedianXL\save"; Flags: uninsneveruninstall
Name: "{app}\Logs"; Flags: uninsneveruninstall
Name: "{app}\Screenshots"; Flags: uninsneveruninstall
Name: "{app}\Themes"; Flags: uninsneveruninstall

[Registry]
Root: HKCU; Subkey: "Software\Blizzard Entertainment\Diablo II"; ValueName: InstallPath; ValueType: string; ValueData: "{app}"; Flags: createvalueifdoesntexist
Root: HKCU; Subkey: "{#AppCompatFlagsReg}"; ValueType: string; ValueData: "WINXPSP3"; ValueName: "{#VideoTestExe}"
Root: HKCU; Subkey: "{#AppCompatFlagsReg}"; ValueType: string; ValueData: "WINXPSP3"; ValueName: "{app}\Game.exe"

[Icons]
#define CreateShortcut(str Location, str Language) \
  'Name: "' + AddBackslash(Location) + ModName + ' ' + UpperCase(Language) + \
  '"; Filename: "{app}\sigma_' + Language + '.bat"; WorkingDir: "{app}"; IconFilename: "' + D2Exe + '"'

#emit CreateShortcut("{group}", "rus")
#emit CreateShortcut("{group}", "eng")
Name: "{group}\{cm:UninstallProgram,{#MyAppName}}"; Filename: "{uninstallexe}"

#emit CreateShortcut("{autodesktop}", "rus") + '; Tasks: desktopRus'
#emit CreateShortcut("{autodesktop}", "eng") + '; Tasks: desktopEng'

[Run]
Filename: "{cmd}"; Parameters: "/c ""if not exist cmd_args.txt type NUL > cmd_args.txt"""; WorkingDir: "{app}"; Flags: runhidden
Filename: "{#ToolsDir}\Median XL Web Setup.exe"; Components: launcher; Flags: nowait skipifsilent
Filename: "{#VideoTestExe}"; Description: "Запустить видео тест"; Flags: nowait postinstall runascurrentuser skipifsilent
