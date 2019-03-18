object Main: TMain
  Left = 577
  Top = 161
  Width = 838
  Height = 641
  Caption = 'MAPIConnector Test Application'
  Color = clBtnFace
  Constraints.MinWidth = 800
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 20
  object rgVersion: TRadioGroup
    Left = 0
    Top = 0
    Width = 822
    Height = 65
    Align = alTop
    Caption = 'MAPI version'
    Columns = 10
    ItemIndex = 1
    Items.Strings = (
      '32 bit'
      '64 bit')
    TabOrder = 0
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 65
    Width = 822
    Height = 424
    Align = alClient
    Caption = 'Manual settings'
    TabOrder = 1
    object Panel1: TPanel
      Left = 2
      Top = 22
      Width = 818
      Height = 395
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 0
      DesignSize = (
        818
        395)
      object Label6: TLabel
        Left = 8
        Top = 356
        Width = 93
        Height = 20
        Caption = 'Message file:'
      end
      object Label5: TLabel
        Left = 8
        Top = 197
        Width = 104
        Height = 20
        Caption = 'Attachements:'
      end
      object Label4: TLabel
        Left = 8
        Top = 152
        Width = 37
        Height = 20
        Caption = 'BCC:'
      end
      object Label1: TLabel
        Left = 8
        Top = 32
        Width = 58
        Height = 20
        Caption = 'Subject:'
      end
      object Label2: TLabel
        Left = 8
        Top = 72
        Width = 79
        Height = 20
        Caption = 'Recipients:'
      end
      object Label3: TLabel
        Left = 8
        Top = 112
        Width = 26
        Height = 20
        Caption = 'CC:'
      end
      object lblMessageFilePath: TLabel
        Left = 112
        Top = 356
        Width = 108
        Height = 20
        Caption = 'No file selected'
      end
      object btnAddAttachement: TButton
        Left = 670
        Top = 312
        Width = 137
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Add attachement'
        TabOrder = 0
        OnClick = btnAddAttachementClick
      end
      object lbAttachements: TListBox
        Left = 128
        Top = 192
        Width = 680
        Height = 113
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 20
        TabOrder = 1
      end
      object edBCC: TEdit
        Left = 128
        Top = 148
        Width = 680
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 2
        Text = 'testmail4@gmail.com;testmail5@gmail.com;testmail6@gmail.com'
      end
      object edCC: TEdit
        Left = 128
        Top = 108
        Width = 680
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 3
        Text = 'testmail2@gmail.com;testmail3@gmail.com'
      end
      object edRecipients: TEdit
        Left = 128
        Top = 68
        Width = 680
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 4
        Text = 'mail@softacom.com;testmail1@gmail.com'
      end
      object edSubject: TEdit
        Left = 128
        Top = 28
        Width = 680
        Height = 28
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 5
        Text = 'Test subject'
      end
      object btnSelectMessageFile: TButton
        Left = 670
        Top = 352
        Width = 137
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Select file'
        TabOrder = 6
        OnClick = btnSelectMessageFileClick
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 489
    Width = 822
    Height = 70
    Align = alBottom
    Caption = 'Settings from file'
    TabOrder = 2
    DesignSize = (
      822
      70)
    object lblSettingsFilePath: TLabel
      Left = 9
      Top = 31
      Width = 108
      Height = 20
      Caption = 'No file selected'
    end
    object btnSelectSettings: TButton
      Left = 598
      Top = 29
      Width = 137
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Select file'
      TabOrder = 0
      OnClick = btnSelectSettingsClick
    end
    object btnResetSettingsFile: TButton
      Left = 742
      Top = 29
      Width = 67
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Reset'
      TabOrder = 1
      OnClick = btnResetSettingsFileClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 559
    Width = 822
    Height = 44
    Align = alBottom
    TabOrder = 3
    DesignSize = (
      822
      44)
    object btnSend: TButton
      Left = 670
      Top = 11
      Width = 137
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Send email'
      TabOrder = 0
      OnClick = btnSendClick
    end
  end
  object odFileSelect: TOpenDialog
    Left = 632
    Top = 401
  end
end
