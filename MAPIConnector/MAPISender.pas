unit MAPISender;

interface

uses EmailData;

type
  TMAPISender = class
  public
    function SendEmail(emailData: TEmailData): integer;

  private
    function ToAnsiStr(str: string): PAnsiChar;
  end;

implementation

uses Mapi, AnsiStrings;

function TMAPISender.SendEmail(emailData: TEmailData): integer;
var
  MapiMessage: TMapiMessage;
  MError: Cardinal;
  PRecip, Recipients: PMapiRecipDesc;
  PFiles, Attachments: PMapiFileDesc;
  i: Integer;
begin
  // Prepare memory for the structure
  MapiMessage.nRecipCount := emailData.Recipients.Count + emailData.CC.Count + emailData.BCC.Count;
  GetMem(Recipients, MapiMessage.nRecipCount * sizeof(TMapiRecipDesc));

  try
    with MapiMessage do
    begin
      ulReserved := 0;

      // Set subject
      lpszSubject := ToAnsiStr(emailData.Subject);

      // Set body
      lpszNoteText := ToAnsiStr(emailData.MessageBody);

      lpszMessageType := nil;
      lpszDateReceived := nil;
      lpszConversationID := nil;
      flFlags := 0;

      // Set all recipients
      if nRecipCount > 0 then
      begin
        PRecip := Recipients;

        for i := 1 to emailData.Recipients.Count do
        begin
          PRecip^.ulReserved := 0;
          PRecip^.ulRecipClass := MAPI_TO;
          PRecip^.lpszName := ToAnsiStr(emailData.Recipients.Strings[i - 1]);
          PRecip^.lpszAddress := ToAnsiStr('SMTP:' + emailData.Recipients.Strings[i - 1]);
          PRecip^.ulEIDSize := 0;
          PRecip^.lpEntryID := nil;
          Inc(PRecip);
        end;

        // Set all CC
        for i := 1 to emailData.CC.Count do
        begin
          PRecip^.ulReserved := 0;
          PRecip^.ulRecipClass := MAPI_CC;
          PRecip^.lpszName := ToAnsiStr(emailData.CC.Strings[i - 1]);
          PRecip^.lpszAddress := ToAnsiStr('SMTP:' + emailData.CC.Strings[i - 1]);
          PRecip^.ulEIDSize := 0;
          PRecip^.lpEntryID := nil;
          Inc(PRecip);
        end;

        // Set all BCC
        for i := 1 to emailData.BCC.Count do
        begin
          PRecip^.ulReserved := 0;
          PRecip^.ulRecipClass := MAPI_BCC;
          PRecip^.lpszName := ToAnsiStr(emailData.BCC.Strings[i - 1]);
          PRecip^.lpszAddress := ToAnsiStr('SMTP:' + emailData.BCC.Strings[i - 1]);
          PRecip^.ulEIDSize := 0;
          PRecip^.lpEntryID := nil;
          Inc(PRecip);
        end;
      end;

      lpRecips := Recipients;

      // Process attachements
      nFileCount := emailData.Attachements.Count;
      if nFileCount > 0 then
      begin
        GetMem(Attachments, MapiMessage.nFileCount * sizeof(TMapiFileDesc));

        try
          PFiles := Attachments;

          // Add attached files
          for i := 1 to nFileCount do
          begin
            // File full path
            Attachments^.lpszPathName := ToAnsiStr(emailData.Attachements.Strings[i - 1]);
            // File short name
            Attachments^.lpszFileName := ToAnsiStr(ExtractFileName(emailData.Attachements.Strings[i - 1]));
            Attachments^.ulReserved := 0;
            Attachments^.flFlags := 0;
            // Position should be -1 (see WinApi Help)
            Attachments^.nPosition := Cardinal(-1);
            Attachments^.lpFileType := nil;
            Inc(Attachments);
          end;

          lpFiles := PFiles;
        finally
          FreeMem(Attachments, MapiMessage.nFileCount * sizeof(TMapiFileDesc));
        end;
      end
      else
      begin
        lpFiles := nil;
      end;
    end;

    // Show Send Email dialog
    MError := MapiSendMail(0, 0, MapiMessage, MAPI_DIALOG
      or MAPI_LOGON_UI or MAPI_NEW_SESSION, 0);

    case MError of
      SUCCESS_SUCCESS:
      begin
        Result := 0;
      end;
      MAPI_E_USER_ABORT:
      begin
        Result := 2;
      end
      else
      begin
        Result := 1; // returns 1 in case of any error
      end;
    end;
  finally
    FreeMem(Recipients, MapiMessage.nRecipCount * sizeof(TMapiRecipDesc));
  end;
end;

function TMAPISender.ToAnsiStr(str: string): PAnsiChar;
begin
  Result := StrNew(PAnsiChar(AnsiString(str)));
end;

end.
