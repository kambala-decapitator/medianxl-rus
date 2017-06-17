[Setup]
AppName=Русификатор Median XL
AppVersion=2017.003
AppPublisher=kambala & Zelgadiss
AppReadmeFile=http://worldofplayers.ru/threads/32519/
VersionInfoVersion=1.0.0.0
DefaultDirName={reg:HKCU\Software\Blizzard Entertainment\Diablo II,InstallPath|{pf}\Diablo II}
DefaultGroupName=Русификатор Median XL
Compression=lzma2/ultra64
SolidCompression=yes
LZMAUseSeparateProcess=yes
OutputDir=.
OutputBaseFilename=mxl_russifier_archive

[Types]
Name: "full"; Description: "Полная"
Name: "custom"; Description: "Выборочная"; Flags: iscustom

[Components]
Name: "program"; Description: "Файлы русификации"; Types: full custom; Flags: fixed
Name: "plugy"; Description: "PlugY.dll (только для 10-й версии PlugY)"; Types: full
Name: "d2win"; Description: "D2Win.dll (только для 1.13c патча)"; Types: full

[Files]
Source: "PlugY.dll"; DestDir: "{app}"; Components: plugy; Flags: replacesameversion
Source: "D2Win.dll"; DestDir: "{app}"; Components: d2win; BeforeInstall: BackupD2WinDll
Source: "data\*"; DestDir: "{code:GetPlugyFolder}\data"; Components: program; Flags: recursesubdirs; BeforeInstall: RemoveLegacyFiles; AfterInstall: CreateBatchFiles

[Languages]
Name: "ru"; MessagesFile: "compiler:Languages\Russian.isl"

[UninstallDelete]
Type: files; Name: "{app}\mxlrus*.bat"
Type: files; Name: "{code:GetPlugyFolder}\mxlrus_plugy.bat"

[Code] 
procedure BackupD2WinDll;
begin
  RenameFile(ExpandConstant('{app}\D2Win.dll'), ExpandConstant('{app}\D2Win.dll.bak'))
end;

var
plugyFolder: String;  

procedure SetPlugyFolder;
begin
  if DirExists(ExpandConstant('{app}\ModPlugY')) then
    plugyFolder := 'ModPlugY'
  else
    plugyFolder := 'Mod PlugY'
end;

function GetPlugyFolder(foo: String) : String;
begin
  if Length(plugyFolder) = 0 then SetPlugyFolder;
  Result := ExpandConstant('{app}\' + plugyFolder)
end;

function _GetPlugyFolder : String;
begin
  Result := GetPlugyFolder('')
end;

procedure RemoveLegacyFiles;
begin      
  DeleteFile(_GetPlugyFolder + '\data\global\excel\levels.bin');
  DeleteFile(_GetPlugyFolder + '\data\global\excel\gems.bin')
end;

procedure CreateBatchFiles;
begin   
  SaveStringToFile(ExpandConstant('{app}\mxlrus.bat'),       Format('cd "%s" && start ..\game.exe -direct', [plugyFolder]), False);
  SaveStringToFile(ExpandConstant('{app}\mxlrus_plugy.bat'), Format('cd "%s" && start plugy.exe -direct', [plugyFolder]), False)
  SaveStringToFile(_GetPlugyFolder + '\mxlrus_plugy.bat', 'start plugy.exe -direct', False)
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usPostUninstall then RenameFile(ExpandConstant('{app}\D2Win.dll.bak'), ExpandConstant('{app}\D2Win.dll'))
end;