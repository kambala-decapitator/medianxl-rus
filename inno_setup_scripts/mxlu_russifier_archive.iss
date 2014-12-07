[Setup]
AppName=Русификатор Median XL Ultimative
AppVersion=XVc
VersionInfoVersion=1.0.0.0
DefaultDirName={reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}
DefaultGroupName=Русификатор Median XL Ultimative
Compression=lzma2/ultra64
SolidCompression=yes
OutputDir=D:\MXLU_Russifier   
OutputBaseFilename=mxlu_russifier_archive

[Types]
Name: "full"; Description: "Полная"
Name: "custom"; Description: "Выборочная"; Flags: iscustom

[Components]
Name: "program"; Description: "Файлы русификации"; Types: full custom; Flags: fixed
Name: "plugy"; Description: "PlugY.dll (только для 10й версии PlugY)"; Types: full      
Name: "d2win"; Description: "D2Win.dll (только для 1.13c патча)"; Types: full      

[Files]
Source: "D2Win.dll"; DestDir: "{app}"; Components: d2win
Source: "files\*"; DestDir: "{app}\ModPlugY"; Components: program; Flags: recursesubdirs; Check: MyDirCheck(ExpandConstant('{app}\ModPlugY')); BeforeInstall: DeleteGemsBinAndLevelsBin(ExpandConstant('{app}\ModPlugY'))
Source: "files\*"; DestDir: "{app}\Mod PlugY"; Components: program; Flags: recursesubdirs; BeforeInstall: DeleteGemsBinAndLevelsBin(ExpandConstant('{app}\Mod PlugY'))
Source: "PlugY.dll"; DestDir: "{app}"; Components: plugy
Source: "mxlrus_1.bat"; DestName: "mxlrus.bat"; DestDir: "{app}"; Components: program; Check: MyDirCheck(ExpandConstant('{app}\ModPlugY'))
Source: "mxlrus_2.bat"; DestName: "mxlrus.bat"; DestDir: "{app}"; Components: program
Source: "mxlrus_plugy_1.bat"; DestName: "mxlrus_plugy.bat"; DestDir: "{app}"; Components: program; Check: MyDirCheck(ExpandConstant('{app}\ModPlugY'))
Source: "mxlrus_plugy_2.bat"; DestName: "mxlrus_plugy.bat"; DestDir: "{app}"; Components: program
Source: "mxlrus_plugy_dir.bat"; DestName: "mxlrus_plugy.bat"; DestDir: "{app}\ModPlugY"; Components: program; Check: MyDirCheck(ExpandConstant('{app}\ModPlugY'))
Source: "mxlrus_plugy_dir.bat"; DestName: "mxlrus_plugy.bat"; DestDir: "{app}\Mod PlugY"; Components: program

[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"

[Code]
function MyDirCheck(DirName: String): Boolean;
begin
  Result := DirExists(DirName);
end;

procedure DeleteGemsBinAndLevelsBin (DirName: String);
begin
  DeleteFile(DirName + '\data\global\excel\levels.bin')
  DeleteFile(DirName + '\data\global\excel\gems.bin')
end; 