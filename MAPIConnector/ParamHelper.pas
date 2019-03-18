unit ParamHelper;

interface

function GetParam(key: string): string;

implementation

uses System.SysUtils;

function GetParam(key: string): string;
var
  i: integer;
  keyToFind, param: string;
begin
  Result := '';
  keyToFind := '/' + key + '=';

  for i := 0 to ParamCount do
  begin
    param := ParamStr(i);
    if (Pos(keyToFind, param) = 1) then
    begin
      Delete(param, 1, keyToFind.Length);
      Result := param;
    end;
  end;
end;

end.
