unit uFrmModelo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids;

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TfrmModelo = class(TForm)
    pnlRodape: TPanel;
    btnFechar: TButton;
    pgcPrincipal: TPageControl;
    tbPesq: TTabSheet;
    tbDados: TTabSheet;
    pnlFiltro: TPanel;
    edtPesquisar: TLabeledEdit;
    btnPesquisar: TButton;
    pnlBtnsPesq: TPanel;
    btnNovo: TButton;
    btnDetalhar: TButton;
    btnExcluir: TButton;
    DBGrid1: TDBGrid;
    dsPesq: TDataSource;
    pnlBtnsCad: TPanel;
    btnListar: TButton;
    btnAlterar: TButton;
    btnGravar: TButton;
    btnCancelar: TButton;
    edtCodigo: TEdit;
    edtDescricao: TEdit;
    lblCodigo: TLabel;
    lblDescricao: TLabel;
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure btnFecharClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnDetalharClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnListarClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnGravarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    FOperacao: TOperacao;
    procedure Novo;
    procedure Detalhar;
    procedure Configuracoes;
    procedure Listar;
    procedure HabilitarControles(aOperacao: TOperacao);
    procedure Gravar; virtual; abstract;
    procedure Alterar; virtual; abstract;
    procedure Excluir; virtual; abstract;
    procedure Inserir; virtual; abstract;
    procedure Pesquisar; virtual; abstract;
    procedure CarregarCliente; virtual; abstract;
  end;

var
  frmModelo: TfrmModelo;

implementation

{$R *.dfm}

procedure TfrmModelo.btnAlterarClick(Sender: TObject);
begin
  FOperacao := opAlterar;
  HabilitarControles(opAlterar);
end;

procedure TfrmModelo.btnCancelarClick(Sender: TObject);
begin
  HabilitarControles(opNavegar);
end;

procedure TfrmModelo.btnDetalharClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmModelo.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfrmModelo.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmModelo.btnGravarClick(Sender: TObject);
begin
  Gravar;
  HabilitarControles(opNavegar);
end;

procedure TfrmModelo.btnListarClick(Sender: TObject);
begin
  Listar;
end;

procedure TfrmModelo.btnNovoClick(Sender: TObject);
begin
  Novo;
  HabilitarControles(opNovo);
end;

procedure TfrmModelo.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmModelo.Configuracoes;
begin
  tbPesq.TabVisible := False;
  tbDados.TabVisible := False;
  pgcPrincipal.ActivePage := tbPesq;
end;

procedure TfrmModelo.DBGrid1DblClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmModelo.Detalhar;
begin
  CarregarCliente;
  HabilitarControles(opNavegar);
  FOperacao := opNavegar;
  pgcPrincipal.ActivePage := tbDados;
end;

procedure TfrmModelo.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmModelo.FormShow(Sender: TObject);
begin
  Configuracoes;
end;

procedure TfrmModelo.HabilitarControles(aOperacao: TOperacao);
begin
  case aOperacao of
    opNovo, opAlterar:
    begin
      edtDescricao.Enabled := True;
      btnListar.Enabled    := False;
      btnFechar.Enabled    := False;
      btnAlterar.Enabled   := False;
      btnGravar.Enabled    := True;
      btnCancelar.Enabled  := True;
    end;
    opNavegar:
    begin
      edtDescricao.Enabled := False;
      btnListar.Enabled    := True;
      btnFechar.Enabled    := True;
      btnAlterar.Enabled   := True;
      btnGravar.Enabled    := False;
      btnCancelar.Enabled  := False;
    end;
  end;
end;

procedure TfrmModelo.Listar;
begin
  pgcPrincipal.ActivePage := tbPesq;
end;

procedure TfrmModelo.Novo;
begin
  FOperacao := opNovo;
  pgcPrincipal.ActivePage := tbDados;
end;

end.
