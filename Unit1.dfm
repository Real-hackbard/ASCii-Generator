object Form1: TForm1
  Left = 247
  Top = 125
  Caption = 'ASCii Generator 1.0'
  ClientHeight = 510
  ClientWidth = 761
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 104
    Top = 24
    Width = 633
    Height = 465
  end
  object Image1: TImage
    Left = 112
    Top = 32
    Width = 617
    Height = 457
  end
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'load'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 101
    Width = 75
    Height = 25
    Caption = 'ascii'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 39
    Width = 75
    Height = 25
    Caption = 'font'
    TabOrder = 2
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 8
    Top = 70
    Width = 75
    Height = 25
    Caption = 'save'
    TabOrder = 3
    OnClick = Button4Click
  end
  object RadioGroup1: TRadioGroup
    Left = 8
    Top = 144
    Width = 75
    Height = 97
    Caption = ' Color '
    ItemIndex = 1
    Items.Strings = (
      'Red'
      'RGB')
    TabOrder = 4
  end
  object FontDialog1: TFontDialog
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Left = 40
    Top = 256
  end
end
