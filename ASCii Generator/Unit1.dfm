object Form1: TForm1
  Left = 247
  Top = 125
  Caption = 'ASCii Generator'
  ClientHeight = 654
  ClientWidth = 933
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 121
    Height = 635
    Align = alLeft
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 0
    ExplicitHeight = 634
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
      Height = 155
      Caption = ' Color '
      ItemIndex = 7
      Items.Strings = (
        'Red'
        'Green'
        'Blue'
        'Aqua'
        'Pink'
        'Yellow'
        'Gray'
        'RGB')
      TabOrder = 4
      OnClick = RadioGroup1Click
    end
    object GroupBox1: TGroupBox
      Left = 7
      Top = 450
      Width = 108
      Height = 175
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
        Left = 24
        Top = 142
        Width = 70
        Height = 19
        TabOrder = 2
        Text = '#'
      end
      object RadioButton3: TRadioButton
        Left = 8
        Top = 119
        Width = 60
        Height = 17
        Caption = 'Custom'
        TabOrder = 3
        OnClick = RadioButton3Click
      end
      object RadioButton4: TRadioButton
        Left = 8
        Top = 62
        Width = 88
        Height = 17
        Caption = 'Special Chars'
        TabOrder = 4
        OnClick = RadioButton4Click
      end
      object RadioButton5: TRadioButton
        Left = 8
        Top = 81
        Width = 65
        Height = 17
        Caption = 'Alphabet'
        TabOrder = 5
        OnClick = RadioButton5Click
      end
      object RadioButton6: TRadioButton
        Left = 8
        Top = 100
        Width = 61
        Height = 17
        Caption = 'Decimal'
        TabOrder = 6
        OnClick = RadioButton6Click
      end
    end
    object GroupBox2: TGroupBox
      Left = 6
      Top = 299
      Width = 109
      Height = 145
      Caption = ' RGB && BumpMap'
      TabOrder = 6
      object Shape1: TShape
        Left = 50
        Top = 29
        Width = 25
        Height = 19
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
        TabStop = False
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
        TabStop = False
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
        TabStop = False
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
    Top = 635
    Width = 933
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
    ExplicitTop = 634
    ExplicitWidth = 929
  end
  object Panel2: TPanel
    Left = 121
    Top = 0
    Width = 812
    Height = 635
    Align = alClient
    BevelOuter = bvNone
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 2
    ExplicitWidth = 808
    ExplicitHeight = 634
    object ScrollBox1: TScrollBox
      Left = 0
      Top = 0
      Width = 812
      Height = 635
      HorzScrollBar.Smooth = True
      HorzScrollBar.Tracking = True
      VertScrollBar.Smooth = True
      VertScrollBar.Tracking = True
      Align = alClient
      BorderStyle = bsNone
      Ctl3D = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      PopupMenu = PopupMenu1
      TabOrder = 0
      ExplicitWidth = 808
      ExplicitHeight = 634
      object Image1: TImage
        Left = 3
        Top = 3
        Width = 14
        Height = 14
        AutoSize = True
        PopupMenu = PopupMenu1
      end
      object Label5: TLabel
        Left = 304
        Top = 232
        Width = 23
        Height = 13
        Caption = 'View'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
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
    object Picture1: TMenuItem
      Caption = 'Picture'
      OnClick = Picture1Click
    end
    object Generate1: TMenuItem
      Caption = 'Generate'
      Enabled = False
      OnClick = Generate1Click
    end
    object Font1: TMenuItem
      Caption = 'Font'
      OnClick = Font1Click
    end
    object Art1: TMenuItem
      Caption = 'Art'
      object ASCii1: TMenuItem
        AutoCheck = True
        Caption = 'ASCii'
        Checked = True
        RadioItem = True
        OnClick = ASCii1Click
      end
      object Binary1: TMenuItem
        AutoCheck = True
        Caption = 'Binary'
        RadioItem = True
        OnClick = Binary1Click
      end
      object SpecialChars1: TMenuItem
        AutoCheck = True
        Caption = 'Special Chars'
        RadioItem = True
        OnClick = SpecialChars1Click
      end
      object Alphabet1: TMenuItem
        AutoCheck = True
        Caption = 'Alphabet'
        RadioItem = True
        OnClick = Alphabet1Click
      end
      object Decimal1: TMenuItem
        AutoCheck = True
        Caption = 'Decimal'
        RadioItem = True
        OnClick = Decimal1Click
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object Custom1: TMenuItem
        AutoCheck = True
        Caption = 'Custom'
        RadioItem = True
        OnClick = Custom1Click
      end
    end
    object Save1: TMenuItem
      Caption = 'Save'
      Enabled = False
      OnClick = Save1Click
    end
    object ReloadPicture1: TMenuItem
      Caption = 'Reload Picture'
      Enabled = False
      OnClick = ReloadPicture1Click
    end
    object Clear1: TMenuItem
      Caption = 'Clear'
      Enabled = False
      OnClick = Clear1Click
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object Invert1: TMenuItem
      Caption = 'Invert'
      Enabled = False
      OnClick = Invert1Click
    end
    object Resample1: TMenuItem
      Caption = 'Resample (1%)'
      Enabled = False
      OnClick = Resample1Click
    end
    object Highlight1: TMenuItem
      Caption = 'Highlight (Silver)'
      Enabled = False
      OnClick = Highlight1Click
    end
    object Blur1: TMenuItem
      Caption = 'Blur (1%)'
      Enabled = False
      OnClick = Blur1Click
    end
    object Sepia1: TMenuItem
      Caption = 'Sepia (10%)'
      Enabled = False
      OnClick = Sepia1Click
    end
    object BumpMap1: TMenuItem
      AutoCheck = True
      Caption = 'BumpMap (RGB)'
      Enabled = False
      OnClick = BumpMap1Click
    end
    object Color1: TMenuItem
      Caption = 'Color'
      Enabled = False
      object Red1: TMenuItem
        AutoCheck = True
        Caption = 'Red'
        RadioItem = True
        OnClick = Red1Click
      end
      object Green1: TMenuItem
        AutoCheck = True
        Caption = 'Green'
        RadioItem = True
        OnClick = Green1Click
      end
      object Blue1: TMenuItem
        AutoCheck = True
        Caption = 'Blue'
        RadioItem = True
        OnClick = Blue1Click
      end
      object Aqua1: TMenuItem
        AutoCheck = True
        Caption = 'Aqua'
        RadioItem = True
        OnClick = Aqua1Click
      end
      object Pink1: TMenuItem
        AutoCheck = True
        Caption = 'Pink'
        RadioItem = True
        OnClick = Pink1Click
      end
      object Yellow1: TMenuItem
        AutoCheck = True
        Caption = 'Yellow'
        RadioItem = True
        OnClick = Yellow1Click
      end
      object Gray1: TMenuItem
        AutoCheck = True
        Caption = 'Gray'
        RadioItem = True
        OnClick = Gray1Click
      end
      object RGB1: TMenuItem
        AutoCheck = True
        Caption = 'RGB'
        Checked = True
        RadioItem = True
        OnClick = RGB1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Bumpmap2: TMenuItem
        Caption = 'Bumpmap'
        OnClick = Bumpmap2Click
      end
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object Stretch1: TMenuItem
      AutoCheck = True
      Caption = 'Stretch'
      OnClick = Stretch1Click
    end
    object Trz1: TMenuItem
      Caption = 'Tranzparent'
      Enabled = False
      OnClick = Trz1Click
    end
    object Frame1: TMenuItem
      Caption = 'Frame'
      object Draw1: TMenuItem
        AutoCheck = True
        Caption = 'Draw'
        OnClick = Draw1Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Color2: TMenuItem
        Caption = 'Color'
        OnClick = Color2Click
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object x11: TMenuItem
        AutoCheck = True
        Caption = 'x1'
        RadioItem = True
        OnClick = x11Click
      end
      object x21: TMenuItem
        AutoCheck = True
        Caption = 'x2'
        RadioItem = True
        OnClick = x11Click
      end
      object x31: TMenuItem
        AutoCheck = True
        Caption = 'x3'
        Checked = True
        RadioItem = True
        OnClick = x11Click
      end
      object x41: TMenuItem
        AutoCheck = True
        Caption = 'x4'
        RadioItem = True
        OnClick = x11Click
      end
      object x51: TMenuItem
        AutoCheck = True
        Caption = 'x5'
        RadioItem = True
        OnClick = x11Click
      end
      object x61: TMenuItem
        AutoCheck = True
        Caption = 'x6'
        RadioItem = True
        OnClick = x11Click
      end
      object x71: TMenuItem
        AutoCheck = True
        Caption = 'x7'
        RadioItem = True
        OnClick = x11Click
      end
      object x81: TMenuItem
        AutoCheck = True
        Caption = 'x8'
        RadioItem = True
        OnClick = x11Click
      end
      object x91: TMenuItem
        AutoCheck = True
        Caption = 'x9'
        RadioItem = True
        OnClick = x11Click
      end
      object x101: TMenuItem
        AutoCheck = True
        Caption = 'x10'
        RadioItem = True
        OnClick = x11Click
      end
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object FlipX1: TMenuItem
      Caption = 'Flip X'
      Enabled = False
      OnClick = FlipX1Click
    end
    object FlipY1: TMenuItem
      Caption = 'Flip Y'
      Enabled = False
      OnClick = FlipY1Click
    end
    object Rotate1: TMenuItem
      Caption = 'Rotate'
      Enabled = False
      OnClick = Rotate1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Panel3: TMenuItem
      AutoCheck = True
      Caption = 'Panel'
      Checked = True
      OnClick = Panel3Click
    end
  end
  object ColorDialog2: TColorDialog
    Left = 169
    Top = 280
  end
end
