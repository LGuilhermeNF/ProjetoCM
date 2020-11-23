object frmModelo: TfrmModelo
  Left = 0
  Top = 0
  BorderStyle = bsSingle
  ClientHeight = 487
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poMainFormCenter
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlRodape: TPanel
    Left = 0
    Top = 446
    Width = 626
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      626
      41)
    object btnFechar: TButton
      Left = 531
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akTop, akRight, akBottom]
      Caption = 'Fechar'
      TabOrder = 0
      OnClick = btnFecharClick
    end
  end
  object pgcPrincipal: TPageControl
    Left = 0
    Top = 0
    Width = 626
    Height = 446
    ActivePage = tbPesq
    Align = alClient
    TabOrder = 0
    object tbPesq: TTabSheet
      Caption = 'tbPesq'
      object pnlFiltro: TPanel
        Left = 0
        Top = 0
        Width = 618
        Height = 60
        Align = alTop
        BevelOuter = bvNone
        Color = clInactiveCaption
        ParentBackground = False
        TabOrder = 0
        DesignSize = (
          618
          60)
        object edtPesquisar: TLabeledEdit
          Left = 16
          Top = 27
          Width = 497
          Height = 21
          Anchors = [akLeft, akTop, akRight]
          EditLabel.Width = 50
          EditLabel.Height = 13
          EditLabel.Caption = 'Descricao:'
          TabOrder = 0
        end
        object btnPesquisar: TButton
          Left = 527
          Top = 25
          Width = 75
          Height = 25
          Caption = 'Pesquisar'
          TabOrder = 1
          OnClick = btnPesquisarClick
        end
      end
      object pnlBtnsPesq: TPanel
        Left = 0
        Top = 376
        Width = 618
        Height = 42
        Align = alBottom
        BevelOuter = bvNone
        Color = clInactiveCaption
        ParentBackground = False
        TabOrder = 1
        object btnNovo: TButton
          Left = 365
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Novo'
          TabOrder = 0
          OnClick = btnNovoClick
        end
        object btnDetalhar: TButton
          Left = 446
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Detalhar'
          TabOrder = 1
          OnClick = btnDetalharClick
        end
        object btnExcluir: TButton
          Left = 527
          Top = 9
          Width = 75
          Height = 25
          Caption = 'Excluir'
          TabOrder = 2
          OnClick = btnExcluirClick
        end
      end
      object DBGrid1: TDBGrid
        AlignWithMargins = True
        Left = 3
        Top = 63
        Width = 612
        Height = 310
        Align = alClient
        DataSource = dsPesq
        DrawingStyle = gdsGradient
        TabOrder = 2
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnDblClick = DBGrid1DblClick
      end
    end
    object tbDados: TTabSheet
      Caption = 'tbDados'
      ImageIndex = 1
      object lblCodigo: TLabel
        Left = 16
        Top = 24
        Width = 37
        Height = 13
        Caption = 'C'#243'digo:'
      end
      object lblDescricao: TLabel
        Left = 16
        Top = 80
        Width = 50
        Height = 13
        Caption = 'Descri'#231#227'o:'
      end
      object pnlBtnsCad: TPanel
        Left = 0
        Top = 377
        Width = 618
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Color = clInactiveCaption
        ParentBackground = False
        TabOrder = 0
        object btnListar: TButton
          Left = 286
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Listar'
          TabOrder = 3
          OnClick = btnListarClick
        end
        object btnAlterar: TButton
          Left = 367
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Alterar'
          TabOrder = 0
          OnClick = btnAlterarClick
        end
        object btnGravar: TButton
          Left = 448
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Gravar'
          TabOrder = 1
          OnClick = btnGravarClick
        end
        object btnCancelar: TButton
          Left = 527
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Cancelar'
          TabOrder = 2
          OnClick = btnCancelarClick
        end
      end
      object edtCodigo: TEdit
        Left = 16
        Top = 43
        Width = 121
        Height = 21
        Enabled = False
        TabOrder = 1
      end
      object edtDescricao: TEdit
        Left = 16
        Top = 99
        Width = 586
        Height = 21
        TabOrder = 2
      end
    end
  end
  object dsPesq: TDataSource
    Left = 76
    Top = 288
  end
end
