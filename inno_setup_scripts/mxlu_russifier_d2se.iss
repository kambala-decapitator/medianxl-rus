[Setup]
AppName=Русификатор Median XL Ultimative (D2SE-версия)
AppVersion=XVc
VersionInfoVersion=1.0.0.0
DefaultDirName={reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}\MODS\Median XL - Ultimative
DefaultGroupName=Русификатор Median XL Ultimative (D2SE-версия)
Compression=lzma2/ultra64
SolidCompression=yes
OutputDir=D:\MXLU_Russifier    
OutputBaseFilename=mxlu_russifier_d2se

[Types]
Name: "full"; Description: "Полная"
Name: "custom"; Description: "Выборочная"; Flags: iscustom

[Components]
Name: "program"; Description: "Файлы русификации"; Types: full custom; Flags: fixed
Name: "plugy"; Description: "PlugY.dll (только для 10й версии PlugY)"; Types: full      

[Files]
Source: "D2Win.dll"; DestDir: "{app}\Language_RUS"; Components: program
Source: "RUS.mpq"; DestDir: "{app}\Language_RUS"; Components: program
Source: "PlugY.dll"; DestDir: "{app}\Language_RUS"; Components: plugy

[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"

[Run]
Filename: "{reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}\D2SE.exe"; Description: "Запустить D2SE"; Flags: postinstall

[INI]
Filename: "{reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}\MODS\Median XL - Ultimative\D2SE_SETUP.ini"; Section: "USERSETTINGS"; Key:Language; String: "RUS"