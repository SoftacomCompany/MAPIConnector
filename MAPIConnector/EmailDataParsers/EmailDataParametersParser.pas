unit EmailDataParametersParser;

interface

uses
  EmailData, EmailDataParser;

type
  TEmailDataParametersParser = class(TInterfacedObject, IEmailDataParser)
    function GetEmailData(): TEmailData;
  end;

implementation

uses
  SysUtils, Classes, ParamHelper;

function TEmailDataParametersParser.GetEmailData(): TEmailData;
var
  data: TEmailData;
  messageFilePath: string;
  messageList: TStringList;
begin
  data := TEmailData.Create();

  data.Subject := GetParam('s');

  messageFilePath := GetParam('m');
  if ((messageFilePath.Length > 0) and (FileExists(messageFilePath))) then
  begin
    messageList := TStringList.Create;
    messageList.Loadfromfile(messageFilePath);
    data.MessageBody := messageList.text;
    messageList.Free;
  end;

  data.Recipients.Delimiter := ';';
  data.Recipients.StrictDelimiter := true;
  data.Recipients.DelimitedText := GetParam('r');

  data.CC.Delimiter := ';';
  data.CC.StrictDelimiter := true;
  data.CC.DelimitedText := GetParam('cc');

  data.BCC.Delimiter := ';';
  data.BCC.StrictDelimiter := true;
  data.BCC.DelimitedText := GetParam('bcc');

  data.Attachements.Delimiter := ';';
  data.Attachements.StrictDelimiter := true;
  data.Attachements.DelimitedText := GetParam('a');

  Result := data;
end;

end.
