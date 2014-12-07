[Setup]
AppName=Русификатор Median XL Ultimative (MPQ)
AppVersion=XVc
VersionInfoVersion=1.0.0.0
DefaultDirName={reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}
DefaultGroupName=Русификатор Median XL Ultimative (MPQ)      
Compression=none
SolidCompression=yes
OutputDir=D:\MXLU_Russifier
OutputBaseFilename=mxlu_russifier_mpq

[Types]
Name: "full"; Description: "Полная"
Name: "custom"; Description: "Выборочная"; Flags: iscustom

[Components]
Name: "program"; Description: "Файлы русификации"; Types: full custom; Flags: fixed
Name: "plugy"; Description: "PlugY.dll (только для 10й версии PlugY)"; Types: full   
Name: "d2win"; Description: "D2Win.dll (только для 1.13c патча)"; Types: full     

[Files]
Source: "D2Win.dll"; DestDir: "{app}"; Components: d2win
Source: "{src}\patch_d2.mpq"; DestDir: "{app}"; Components: program; Flags: external
Source: "PlugY.dll"; DestDir: "{app}"; Components: plugy

[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"
