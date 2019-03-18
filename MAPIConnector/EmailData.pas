unit EmailData;

interface

uses Classes;

type
  TEmailData = class
  public
    Subject: string;
    MessageBody: string;
    Recipients: TStringList;
    CC: TStringList; //CC Recipients
    BCC: TStringList; //BCC Recipients
    Attachements: TStringList;

    constructor Create();
    destructor Destroy; override;
  end;

implementation

constructor TEmailData.Create();
begin
  Recipients := TStringList.Create;
  CC := TStringList.Create;
  BCC := TStringList.Create;
  Attachements := TStringList.Create;
end;

destructor TEmailData.Destroy;
begin
  Recipients.Free;
  CC.Free;
  BCC.Free;
  Attachements.Free;

  inherited;
end;

end.
