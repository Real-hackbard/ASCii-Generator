object Form1: TForm1
  Left = 247
  Top = 125
  Caption = 'ASCii Generator'
  ClientHeight = 539
  ClientWidth = 786
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 520
    Align = alLeft
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    object Button1: TButton
      Left = 8
      Top = 8
      Width = 107
      Height = 25
      Caption = 'Picture'
      TabOrder = 0
      TabStop = False
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 8
      Top = 101
      Width = 107
      Height = 25
      Caption = 'Generate'
      TabOrder = 1
      TabStop = False
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 8
      Top = 39
      Width = 107
      Height = 25
      Caption = 'Font'
      TabOrder = 2
      TabStop = False
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 8
      Top = 70
      Width = 107
      Height = 25
      Caption = 'Save'
      TabOrder = 3
      TabStop = False
      OnClick = Button4Click
    end
    object RadioGroup1: TRadioGroup
      Left = 7
      Top = 132
      Width = 108
      Height = 113
      Caption = ' Color '
      ItemIndex = 4
      Items.Strings = (
        'Red'
        'Green'
        'Blue'
        'Gray'
        'RGB')
      TabOrder = 4
      OnClick = RadioGroup1Click
    end
    object GroupBox1: TGroupBox
      Left = 8
      Top = 402
      Width = 107
      Height = 115
      Caption = ' Art '
      TabOrder = 5
      object RadioButton1: TRadioButton
        Left = 8
        Top = 24
        Width = 51
        Height = 17
        Caption = 'ASCii'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = RadioButton1Click
      end
      object RadioButton2: TRadioButton
        Left = 8
        Top = 43
        Width = 57
        Height = 17
        Caption = 'Binary'
        TabOrder = 1
        OnClick = RadioButton2Click
      end
      object Edit1: TEdit
        Left = 25
        Top = 85
        Width = 70
        Height = 19
        TabOrder = 2
        Text = '#'
      end
      object RadioButton3: TRadioButton
        Left = 8
        Top = 62
        Width = 60
        Height = 17
        Caption = 'Custom'
        TabOrder = 3
        OnClick = RadioButton3Click
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 251
      Width = 109
      Height = 145
      Caption = ' RGB && BumpMap'
      TabOrder = 6
      object Shape1: TShape
        Left = 50
        Top = 24
        Width = 25
        Height = 25
        Cursor = crHandPoint
        OnMouseDown = Shape1MouseDown
      end
      object Label1: TLabel
        Left = 14
        Top = 32
        Width = 30
        Height = 13
        Caption = 'Color :'
      end
      object Label2: TLabel
        Left = 26
        Top = 58
        Width = 18
        Height = 13
        Caption = 'R :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 26
        Top = 86
        Width = 18
        Height = 13
        Caption = 'G :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGreen
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label4: TLabel
        Left = 27
        Top = 114
        Width = 17
        Height = 13
        Caption = 'B :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object SpinEdit1: TSpinEdit
        Left = 50
        Top = 55
        Width = 45
        Height = 22
        Ctl3D = True
        MaxValue = 255
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 0
        Value = 255
      end
      object SpinEdit2: TSpinEdit
        Left = 50
        Top = 83
        Width = 45
        Height = 22
        Ctl3D = True
        MaxValue = 255
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 1
        Value = 0
      end
      object SpinEdit3: TSpinEdit
        Left = 50
        Top = 111
        Width = 45
        Height = 22
        Ctl3D = True
        MaxValue = 255
        MinValue = 0
        ParentCtl3D = False
        TabOrder = 2
        Value = 0
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 520
    Width = 786
    Height = 19
    Panels = <
      item
        Text = 'Dimension :'
        Width = 70
      end
      item
        Text = 'X-0 - Y-0'
        Width = 100
      end
      item
        Text = 'Ext :'
        Width = 30
      end
      item
        Width = 50
      end
      item
        Text = 'File :'
        Width = 35
      end
      item
        Width = 250
      end
      item
        Text = 'Font :'
        Width = 40
      end
      item
        Text = 'Terminal'
        Width = 100
      end
      item
        Text = 'Size :'
        Width = 40
      end
      item
        Text = '5'
        Width = 50
      end>
  end
  object Panel2: TPanel
    Left = 121
    Top = 0
    Width = 665
    Height = 520
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 0
      Width = 665
      Height = 520
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      ParentCtl3D = False
      TabOrder = 0
      object Image1: TImage
        Left = 3
        Top = 3
        Width = 14
        Height = 14
        AutoSize = True
        PopupMenu = PopupMenu1
      end
    end
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 168
    Top = 144
  end
  object OpenDialog1: TOpenDialog
    Left = 248
    Top = 144
  end
  object SaveDialog1: TSaveDialog
    Filter = 
      'Bitmap (*.BMP)|*.bmp|Joint Photographic Experts Group (*.JPG;*.J' +
      'PEG)|*.jpg|Portable Network Graphic (*.PNG)|*.png|Graphics Inter' +
      'change Format (*.GIF)|*.gif'
    Left = 337
    Top = 144
  end
  object ColorDialog1: TColorDialog
    Left = 169
    Top = 216
  end
  object PopupMenu1: TPopupMenu
    Left = 249
    Top = 216
    object ReloadPicture1: TMenuItem
      Caption = 'Reload Picture'
      OnClick = ReloadPicture1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Invert1: TMenuItem
      Caption = 'Invert'
      OnClick = Invert1Click
    end
    object Resample1: TMenuItem
      Caption = 'Resample (1%)'
      OnClick = Resample1Click
    end
    object Highlight1: TMenuItem
      Caption = 'Highlight (Silver)'
      OnClick = Highlight1Click
    end
    object Blur1: TMenuItem
      Caption = 'Blur (1%)'
      OnClick = Blur1Click
    end
    object Sepia1: TMenuItem
      Caption = 'Sepia (10%)'
      OnClick = Sepia1Click
    end
    object BumpMap1: TMenuItem
      Caption = 'BumpMap (RGB)'
      OnClick = BumpMap1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      OnClick = Clear1Click
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object Trz1: TMenuItem
      Caption = 'Tranzparent'
      OnClick = Trz1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object FlipX1: TMenuItem
      Caption = 'Flip X'
      OnClick = FlipX1Click
    end
    object FlipY1: TMenuItem
      Caption = 'Flip Y'
      OnClick = FlipY1Click
    end
    object Rotate1: TMenuItem
      Caption = 'Rotate'
      OnClick = Rotate1Click
    end
  end
end
