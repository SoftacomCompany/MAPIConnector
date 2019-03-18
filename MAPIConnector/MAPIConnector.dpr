program MAPIConnector;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  System.SysUtils,
  Classes,
  EmailData in 'EmailData.pas',
  MAPISender in 'MAPISender.pas',
  ParamHelper in 'ParamHelper.pas',
  EmailDataParametersParser in 'EmailDataParsers\EmailDataParametersParser.pas',
  EmailDataFileParsers in 'EmailDataParsers\EmailDataFileParsers.pas',
  EmailDataParser in 'EmailDataParsers\EmailDataParser.pas';

var
  emailData: TEmailData;
  sender: TMAPISender;
  filePath: string;
  emailDataParser: IEmailDataParser;
  resultCode: integer;

begin
  try
    try
      filePath := GetParam('f');
      if (filePath.Length > 0) then
      begin
        // Parse from file
        emailDataParser := TEmailDataFileParser.Create(filePath);
      end
      else
      begin
        // Parse from command line
        emailDataParser := TEmailDataParametersParser.Create();
      end;
      emailData := emailDataParser.GetEmailData();

      sender := TMAPISender.Create;
      resultCode := sender.SendEmail(emailData);
      Writeln(resultCode);

      ExitCode := resultCode;

    except
      on E: Exception do
      begin
        Writeln(E.ClassName, ': ', E.Message);
        ExitCode := 1;
      end;
  end;
finally
  emailData.Free;
  sender.Free;
end;
end.
