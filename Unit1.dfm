object Form1: TForm1
  Left = 69
  Top = 6
  Width = 900
  Height = 700
  Caption = '0'
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
  object Image1: TImage
    Left = 8
    Top = 0
    Width = 697
    Height = 417
  end
  object Label2: TLabel
    Left = 548
    Top = 421
    Width = 61
    Height = 13
    Caption = 'choose case'
  end
  object Label4: TLabel
    Left = 613
    Top = 416
    Width = 95
    Height = 13
    Caption = 'WRITE temperature'
  end
  object Label1: TLabel
    Left = 65
    Top = 522
    Width = 3
    Height = 13
    Caption = 't'
  end
  object Label5: TLabel
    Left = 0
    Top = 520
    Width = 8
    Height = 13
    Caption = 'ik'
  end
  object Button1: TButton
    Left = 28
    Top = 424
    Width = 75
    Height = 25
    Caption = 'Go'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button3: TButton
    Left = 28
    Top = 488
    Width = 75
    Height = 25
    Caption = 'Exit'
    TabOrder = 1
    OnClick = Button3Click
  end
  object Edit2: TEdit
    Left = 614
    Top = 432
    Width = 82
    Height = 24
    TabOrder = 2
    Text = 'T,K'
  end
  object ListBox1: TListBox
    Left = 15
    Top = 520
    Width = 44
    Height = 17
    ItemHeight = 13
    Items.Strings = (
      '1'
      '2'
      '3'
      '4')
    TabOrder = 3
  end
  object Memo1: TMemo
    Left = 144
    Top = 416
    Width = 401
    Height = 121
    Lines.Strings = (
      
        ' Input activation energy and lattice parameter -- case of 1,2,3 ' +
        'or 4:'
      ' 1 - for Fe Hev=x*250800 J, lattice parameter a=3.4e-10 m'
      ' 2 - for Cu Hev=x*205632 J, lattice parameter a=3.64e-10 m'
      ' 3 - for Na Hev=x*48070 J, lattice parameter a=2.6e-10 m'
      
        ' 4 - for diffusion C in Fe Hev=x*80256 J, lattice parameter a=3.' +
        '4e-10 m'
      
        ' Input temperature in intervals:  1400-1600 K for Fe,  1000-1300' +
        ' K  for Cu,'
      '        300-350 K  for Na,           500-600 K  for C')
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button2: TButton
    Left = 28
    Top = 456
    Width = 75
    Height = 25
    Caption = 'Diff b'
    TabOrder = 5
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 614
    Top = 464
    Width = 82
    Height = 24
    TabOrder = 6
    Text = '1e-12'
  end
  object Edit3: TEdit
    Left = 614
    Top = 488
    Width = 82
    Height = 24
    TabOrder = 7
    Text = '1e-10'
  end
  object RadioGroup2: TRadioGroup
    Left = 552
    Top = 432
    Width = 49
    Height = 105
    ItemIndex = 0
    Items.Strings = (
      'Fe'
      'Cu'
      'Na'
      'C')
    TabOrder = 8
  end
  object Edit4: TEdit
    Left = 73
    Top = 518
    Width = 65
    Height = 24
    TabOrder = 9
    Text = '0'
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 8
    Top = 432
  end
end
