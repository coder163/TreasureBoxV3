object FormRss: TFormRss
  Left = 0
  Top = 0
  Caption = #30721#20892#23453#30418
  ClientHeight = 181
  ClientWidth = 707
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 32
    Width = 60
    Height = 15
    Caption = 'URL'#22320#22336#65306
  end
  object Label2: TLabel
    Left = 40
    Top = 72
    Width = 65
    Height = 15
    Caption = #20445#23384#21517#31216#65306
  end
  object EdtUrl: TEdit
    Left = 128
    Top = 29
    Width = 561
    Height = 23
    TabOrder = 0
    Text = 'https://rsshub.gneko.io/juejin/column/7020427173014175757'
  end
  object EdtTitle: TEdit
    Left = 128
    Top = 69
    Width = 561
    Height = 23
    TabOrder = 1
    Text = #20048#35895#30340#23398#20064#20048#22253
  end
  object Button1: TButton
    Left = 40
    Top = 114
    Width = 75
    Height = 25
    Caption = #27979#35797#35299#26512
    TabOrder = 2
    OnClick = Button1Click
  end
  object scGPActivityBar1: TscGPActivityBar
    AlignWithMargins = True
    Left = 3
    Top = 167
    Width = 701
    Height = 11
    Align = alBottom
    FluentUIOpaque = False
    TabOrder = 3
    PointCount = 10
    PointAlpha = 200
    TransparentBackground = True
  end
  object PythonEngine1: TPythonEngine
    DllPath = 'D:\workspace-delphi\RSS\TreasureBoxV3\bin\python310'
    OnBeforeLoad = PythonEngine1BeforeLoad
    Left = 320
    Top = 112
  end
end
