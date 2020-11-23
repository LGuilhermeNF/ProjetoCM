object frmPrincipal: TfrmPrincipal
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'Projeto Casa Magalh'#227'es'
  ClientHeight = 101
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object MainMenu1: TMainMenu
    Left = 16
    Top = 16
    object Cadastro1: TMenuItem
      Caption = 'Cadastro'
      object InserirPost1: TMenuItem
        Caption = 'Posts'
        OnClick = InserirPost1Click
      end
    end
    object Movimento1: TMenuItem
      Caption = 'Movimento'
      object CarregarDadosAPI1: TMenuItem
        Caption = 'Popular Base de Dados - API  (JasonPlaceHolder)'
        OnClick = CarregarDadosAPI1Click
      end
    end
    object Sair1: TMenuItem
      Caption = 'Sair'
      OnClick = Sair1Click
    end
  end
end
