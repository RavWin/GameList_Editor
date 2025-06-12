{######################################################}
{### (c) Computer Stars Software, 2012              ###}
{###        RVer  v2.0a                             ###}
{###        Unit version 2.0a                       ###}
{###        Version info utility                    ###}
{######################################################}
{### Developer: Andrew Kambaroff aka Raven aka RaJa ###}
{######################################################}
unit RVer;

interface

  function GetVersion: string;

implementation
uses Windows, SysUtils;

function GetVersion: string;
 var
   VerInfoSize: LongWord;
   VerInfo: Pointer;
   VerValueSize: LongWORD;
   VerValue: PVSFixedFileInfo;
   Dummy: LongWORD;
   exe: String;
 begin
   exe:=ParamStr(0);
   VerInfoSize := GetFileVersionInfoSize(PWideChar(exe), Dummy);
   GetMem(VerInfo, VerInfoSize);
   GetFileVersionInfo(PChar(ParamStr(0)), 0, VerInfoSize, VerInfo);
   VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
   with VerValue^ do
   begin
     Result := IntToStr(dwFileVersionMS shr 16);
     Result := Result + '.' + IntToStr(dwFileVersionMS and $FFFF);
     Result := Result + '.' + IntToStr(dwFileVersionLS shr 16);
     Result := Result + '.' + IntToStr(dwFileVersionLS and $FFFF);
   end;
   FreeMem(VerInfo, VerInfoSize);
 end;

end.