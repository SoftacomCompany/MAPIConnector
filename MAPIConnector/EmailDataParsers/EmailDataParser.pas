unit EmailDataParser;

interface

uses
  EmailData;

type
  IEmailDataParser = interface
    function GetEmailData(): TEmailData;
  end;

implementation

end.
