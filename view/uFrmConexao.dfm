object frmConexao: TfrmConexao
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Conex'#227'o Banco de Dados'
  ClientHeight = 111
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyPress = FormKeyPress
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 377
    Height = 111
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 21
      Width = 137
      Height = 13
      Caption = 'Selecione o banco de dados:'
    end
    object edtConexao: TEdit
      Left = 8
      Top = 40
      Width = 332
      Height = 21
      TabOrder = 0
    end
    object btnOpenDialog: TBitBtn
      Left = 342
      Top = 39
      Width = 24
      Height = 23
      Caption = '...'
      TabOrder = 1
      OnClick = btnOpenDialogClick
    end
    object btnConectar: TBitBtn
      Left = 291
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Conectar'
      TabOrder = 2
      OnClick = btnConectarClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = 'FireBird|*.fdb'
    Left = 224
    Top = 64
  end
end
