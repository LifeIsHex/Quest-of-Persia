object Form1: TForm1
  Left = 866
  Top = 589
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Nader'#39's Blade (Quest of Persia) - KeYGeN'
  ClientHeight = 165
  ClientWidth = 400
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl1: TLabel
    Left = 8
    Top = 8
    Width = 70
    Height = 13
    Caption = 'Serial Number:'
  end
  object lbl2: TLabel
    Left = 8
    Top = 48
    Width = 90
    Height = 13
    Caption = 'Registration Code:'
  end
  object lbl21: TLabel
    Left = 8
    Top = 88
    Width = 80
    Height = 13
    Caption = 'Activation Code:'
  end
  object lbl3: TLabel
    Left = 8
    Top = 144
    Width = 59
    Height = 13
    Caption = '16 sep 2010'
    Enabled = False
  end
  object edt1: TEdit
    Left = 112
    Top = 8
    Width = 273
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object edt2: TEdit
    Left = 112
    Top = 48
    Width = 273
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 1
  end
  object edt3: TEdit
    Left = 112
    Top = 88
    Width = 273
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object btn1: TButton
    Left = 312
    Top = 128
    Width = 75
    Height = 25
    Caption = 'Generate'
    TabOrder = 3
    OnClick = btn1Click
  end
end
