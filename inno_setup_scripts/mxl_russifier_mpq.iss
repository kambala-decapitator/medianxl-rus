[Setup]
AppName=Русификатор Median XL (MPQ)
AppVersion=2017-1.2
AppPublisher=kambala & Zelgadiss
AppReadmeFile=http://worldofplayers.ru/threads/32519/
VersionInfoVersion=1.0.0.0
DefaultDirName={reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}
DefaultGroupName=Русификатор Median XL (MPQ)
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes
OutputDir=.
OutputBaseFilename=mxl_russifier_mpq

[Types]
Name: "full"; Description: "Полная"
Name: "custom"; Description: "Выборочная"; Flags: iscustom

[Components]
Name: "program"; Description: "Файлы русификации"; Types: full custom; Flags: fixed
Name: "plugy"; Description: "PlugY.dll (только для 10-й версии PlugY)"; Types: full
Name: "d2win"; Description: "D2Win.dll (только для 1.13c патча)"; Types: full
Name: "mpqlang"; Description: "MpqLangChanger (смена языка MPQ)"; Types: full

[Files]
Source: "{src}\patch_d2.mpq"; DestDir: "{app}"; Components: program; Flags: external
Source: "mod\Fog.dll"; DestDir: "{app}"; Components: program; Flags: replacesameversion
Source: "mod\msvcr110.dll"; DestDir: "{app}"; Components: program; Flags: replacesameversion
Source: "mod\MXL.dll"; DestDir: "{app}"; Components: program; Flags: replacesameversion
Source: "D2Win.dll"; DestDir: "{app}"; Components: d2win; BeforeInstall: BackupD2WinDll
Source: "PlugY.dll"; DestDir: "{app}"; Components: plugy; Flags: replacesameversion
Source: "MpqLangChanger.exe"; DestDir: "{app}"; Components: mpqlang
Source: "patch2*.bat"; DestDir: "{app}"; Components: mpqlang

[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"

[Code]
procedure BackupD2WinDll;
begin
  RenameFile(ExpandConstant('{app}\D2Win.dll'), ExpandConstant('{app}\D2Win.dll.bak'))
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then RenameFile(ExpandConstant('{app}\D2Win.dll.bak'), ExpandConstant('{app}\D2Win.dll'))
end;