unit EmailDataFileParsers;

interface

uses
  Classes, EmailData, EmailDataParser;

type
  TEmailDataFileParser = class(TInterfacedObject, IEmailDataParser)
  public
    constructor Create(filePath: string);
    function GetEmailData(): TEmailData;

  private
    filePath: string;
    currentLine: string;
    const allowedSections: array of string = ['[Subject]', '[Message]', '[Recipients]', '[CC]', '[BCC]', '[Attachments]'];

    procedure ParseSubjectSection(var fileHandle: TextFile; data: TEmailData);
    procedure ParseMessageSection(var fileHandle: TextFile; data: TEmailData);
    procedure ParseRecipientsSection(var fileHandle: TextFile; data: TEmailData);
    procedure ParseCCSection(var fileHandle: TextFile; data: TEmailData);
    procedure ParseBCCSection(var fileHandle: TextFile; data: TEmailData);
    procedure ParseAttachmentsSection(var fileHandle: TextFile; data: TEmailData);
    procedure ParseSectionToStringList(var fileHandle: TextFile; stringList: TStringList);
    function IsSection: boolean;
  end;

implementation

uses
  SysUtils, StrUtils;

constructor TEmailDataFileParser.Create(filePath: string);
begin
  Self.filePath := filePath;
end;

function TEmailDataFileParser.GetEmailData(): TEmailData;
var
  data: TEmailData;
  fileHandle: TextFile;
begin
  data := TEmailData.Create();

  if (FileExists(filePath)) then
  begin
    AssignFile(fileHandle, filePath);
    try
      Reset(fileHandle);
      ReadLn(fileHandle, currentLine);

      while not Eof(fileHandle) do
      begin
        case IndexStr(currentLine, allowedSections) of
          0: ParseSubjectSection(fileHandle, data);
          1: ParseMessageSection(fileHandle, data);
          2: ParseRecipientsSection(fileHandle, data);
          3: ParseCCSection(fileHandle, data);
          4: ParseBCCSection(fileHandle, data);
          5: ParseAttachmentsSection(fileHandle, data);
          else ReadLn(fileHandle, currentLine);
        end;

      end;
    finally
      CloseFile(fileHandle);
    end;
  end;

  Result := data;
end;

procedure TEmailDataFileParser.ParseSubjectSection(var fileHandle: TextFile; data: TEmailData);
begin
  ReadLn(fileHandle, currentLine);
  data.Subject := currentLine;

  // Move to the next section
  while not (Eof(fileHandle) or IsSection) do
    ReadLn(fileHandle, currentLine);
end;

procedure TEmailDataFileParser.ParseMessageSection(var fileHandle: TextFile; data: TEmailData);
begin
  ReadLn(fileHandle, currentLine);

  // Read this section untill the next section
  while not (Eof(fileHandle) or IsSection) do
  begin
    data.MessageBody := data.MessageBody + #13#10 + currentLine;
    ReadLn(fileHandle, currentLine);
  end;
end;

procedure TEmailDataFileParser.ParseRecipientsSection(var fileHandle: TextFile; data: TEmailData);
begin
  ParseSectionToStringList(fileHandle, data.Recipients);
end;

procedure TEmailDataFileParser.ParseCCSection(var fileHandle: TextFile; data: TEmailData);
begin
  ParseSectionToStringList(fileHandle, data.CC);
end;

procedure TEmailDataFileParser.ParseBCCSection(var fileHandle: TextFile; data: TEmailData);
begin
  ParseSectionToStringList(fileHandle, data.BCC);
end;

procedure TEmailDataFileParser.ParseAttachmentsSection(var fileHandle: TextFile; data: TEmailData);
begin
  ParseSectionToStringList(fileHandle, data.Attachements);
end;

procedure TEmailDataFileParser.ParseSectionToStringList(var fileHandle: TextFile; stringList: TStringList);
begin
  ReadLn(fileHandle, currentLine);

  // Read lines untill the next section
  while not (Eof(fileHandle) or IsSection) do
  begin
    if not (currentLine = '') then
      stringList.Add(currentLine);
    ReadLn(fileHandle, currentLine);
  end;
  if (Eof(fileHandle)) then
    stringList.Add(currentLine);
end;

function TEmailDataFileParser.IsSection: boolean;
begin
  Result := IndexStr(currentLine,  allowedSections) > 0;
end;


end.
