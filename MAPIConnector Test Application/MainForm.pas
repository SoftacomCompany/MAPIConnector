unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TMain = class(TForm)
    rgVersion: TRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Panel1: TPanel;
    Label6: TLabel;
    btnAddAttachement: TButton;
    lbAttachements: TListBox;
    Label5: TLabel;
    Label4: TLabel;
    edBCC: TEdit;
    edCC: TEdit;
    edRecipients: TEdit;
    edSubject: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    odFileSelect: TOpenDialog;
    btnSelectSettings: TButton;
    lblSettingsFilePath: TLabel;
    Panel2: TPanel;
    btnSend: TButton;
    lblMessageFilePath: TLabel;
    btnSelectMessageFile: TButton;
    btnResetSettingsFile: TButton;
    procedure btnSendClick(Sender: TObject);
    procedure btnAddAttachementClick(Sender: TObject);
    procedure btnSelectMessageFileClick(Sender: TObject);
    procedure btnSelectSettingsClick(Sender: TObject);
    procedure btnResetSettingsFileClick(Sender: TObject);
  private
    function PrepareCommandLine: string;
    procedure Execute(commandLine: string);
  public
    { Public declarations }
  end;

var
  Main: TMain;

implementation

uses
  ShellApi;

{$R *.dfm}

procedure TMain.btnSendClick(Sender: TObject);
var
  commandLine: string;
begin
  commandLine := PrepareCommandLine;
  Execute(commandLine);
end;

function TMain.PrepareCommandLine: string;
var
  commandLine: string;
begin
  if (lblSettingsFilePath.Caption = 'No file selected') then
  begin
    lbAttachements.Items.Delimiter := ';';
    
    commandLine := commandLine +
      '/s="' + edSubject.Text + '" ' +
      '/m="' + lblMessageFilePath.Caption + '" ' +
      '/r="' + edRecipients.Text + '" ' +
      '/cc="' + edCC.Text + '" ' +
      '/bcc="' + edBCC.Text + '" ' +
      '/a="' + lbAttachements.Items.DelimitedText + '"';;
  end
  else
    commandLine := '/f="' + lblSettingsFilePath.Caption + '"';

  Result := commandLine;
end;

procedure TMain.Execute(commandLine: string);
var
  executablePath: string;
begin
  if (rgVersion.ItemIndex = 0) then
    executablePath := 'MAPIConnector_32.exe'
  else
    executablePath := 'MAPIConnector.exe';

  executablePath := ExtractFileDir(Application.ExeName) + '\' + executablePath;
  ShellExecute(Application.Handle, 'open', PChar(executablePath), PChar(commandLine), nil, SW_SHOWNORMAL);
end;

procedure TMain.btnAddAttachementClick(Sender: TObject);
begin
  if (odFileSelect.Execute) then
    lbAttachements.Items.Add(odFileSelect.Files[0]);
end;

procedure TMain.btnSelectMessageFileClick(Sender: TObject);
begin
  if (odFileSelect.Execute) then
    lblMessageFilePath.Caption := odFileSelect.Files[0];
end;

procedure TMain.btnSelectSettingsClick(Sender: TObject);
begin
  if (odFileSelect.Execute) then
    lblSettingsFilePath.Caption := odFileSelect.Files[0];
end;

procedure TMain.btnResetSettingsFileClick(Sender: TObject);
begin
  lblSettingsFilePath.Caption := 'No file selected';
end;

end.
