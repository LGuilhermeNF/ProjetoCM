unit uFrmPosts;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.Buttons, uPostController;

type
  TOperacao = (opNovo, opAlterar, opNavegar);
  TfrmPosts = class(TForm)
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
    btnGravar: TBitBtn;
    btnCancelar: TBitBtn;
    edtCodigoPost: TEdit;
    edtTituloPost: TEdit;
    lblCodigoUsuario: TLabel;
    lblTituloPost: TLabel;
    lblCodigoPost: TLabel;
    edtCodigoUsuario: TEdit;
    memPost: TMemo;
    lblBodyPost: TLabel;
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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FPostsController: TPostController;
  public
    { Public declarations }
    FOperacao: TOperacao;
    procedure Novo;
    procedure Detalhar;
    procedure Configuracoes;
    procedure Listar;
    procedure Gravar;
    procedure Alterar;
    procedure Excluir;
    procedure Inserir;
    procedure Pesquisar;
    procedure CarregarPost;
    procedure HabilitarControles(aOperacao: TOperacao);
  end;

var
  frmPosts: TfrmPosts;

implementation

{$R *.dfm}

uses
  uPostModel;

procedure TfrmPosts.Alterar;
var
  LErro: String;
  oPostModel: TPostsModel;
begin
  oPostModel := TPostsModel.Create;
  try
    with oPostModel do
    begin
      Id     := StrToIntDef(edtCodigoPost.Text, 0);
      UserId := StrToInt(edtCodigoUsuario.Text);
      Title  := edtTituloPost.Text;
      Body   := memPost.Text;
    end;
    if FPostsController.Alterar(oPostModel, LErro) then
      MessageBox(handle,'Registro alterado com sucesso.', 'Informa��o', MB_OK + MB_ICONINFORMATION)
    else
      raise Exception.Create(LErro);
    FPostsController.CarregarTodosPosts(dsPesq);
   finally
    FreeAndNil(oPostModel);
  end;
end;

procedure TfrmPosts.btnAlterarClick(Sender: TObject);
begin
  FOperacao := opAlterar;
  HabilitarControles(opAlterar);
  edtCodigoUsuario.SetFocus;
end;

procedure TfrmPosts.btnCancelarClick(Sender: TObject);
begin
  HabilitarControles(opNavegar);
end;

procedure TfrmPosts.btnDetalharClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmPosts.btnExcluirClick(Sender: TObject);
begin
  Excluir;
end;

procedure TfrmPosts.btnFecharClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmPosts.btnGravarClick(Sender: TObject);
begin
  Gravar;
  HabilitarControles(opNavegar);
end;

procedure TfrmPosts.btnListarClick(Sender: TObject);
begin
  Listar;
end;

procedure TfrmPosts.btnNovoClick(Sender: TObject);
begin
  Novo;
  HabilitarControles(opNovo);
end;

procedure TfrmPosts.btnPesquisarClick(Sender: TObject);
begin
  Pesquisar;
end;

procedure TfrmPosts.CarregarPost;
var
  oPostModel: TPostsModel;
  oPostController: TPostController;
begin
  oPostModel := TPostsModel.Create;
  oPostController := TPostController.Create;
  try
     oPostController.CarregarPost(oPostModel, dsPesq.DataSet.FieldByName('UserId').AsInteger, dsPesq.DataSet.FieldByName('Id').AsInteger);
     with oPostModel do
     begin
       edtCodigoPost.Text := Id.ToString;
       edtCodigoUsuario.Text := UserId.ToString;
       edtTituloPost.Text := Title;
       memPost.Lines.Add(Body);
     end;
  finally
    FreeAndNil(oPostController);
    FreeAndNil(oPostModel);
  end;
end;

procedure TfrmPosts.Configuracoes;
begin
  tbPesq.TabVisible := False;
  tbDados.TabVisible := False;
  pgcPrincipal.ActivePage := tbPesq;
end;

procedure TfrmPosts.DBGrid1DblClick(Sender: TObject);
begin
  Detalhar;
end;

procedure TfrmPosts.Detalhar;
begin
  CarregarPost;
  HabilitarControles(opNavegar);
  FOperacao := opNavegar;
  pgcPrincipal.ActivePage := tbDados;
end;

procedure TfrmPosts.Excluir;
var
  LErro: String;
begin
  if (MessageBox(handle,'Deseja excluir este registro?', 'Exclus�o', MB_YESNO + MB_ICONQUESTION) = IDYES) and (dsPesq.DataSet.FieldByName('Id').AsInteger > 0) then
  begin
    if FPostsController.Excluir(dsPesq.DataSet.FieldByName('UserId').AsInteger, dsPesq.DataSet.FieldByName('Id').AsInteger, LErro) then
      MessageBox(handle,'Registro excluido com sucesso.', 'Informa��o', MB_OK + MB_ICONINFORMATION)
    else
      raise Exception.Create(LErro);
    FPostsController.Pesquisar(dsPesq, edtPesquisar.Text);
  end;
end;

procedure TfrmPosts.FormCreate(Sender: TObject);
begin
  FPostsController := TPostController.Create;
  FPostsController.CarregarTodosPosts(dsPesq);
end;

procedure TfrmPosts.FormDestroy(Sender: TObject);
begin
  if Assigned(FPostsController) then
    FreeAndNil(FPostsController);
end;

procedure TfrmPosts.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    key := #0;
    Perform(WM_NEXTDLGCTL, 0, 0);
  end;
end;

procedure TfrmPosts.FormShow(Sender: TObject);
begin
  Configuracoes;
end;

procedure TfrmPosts.Gravar;
begin
  if  (edtCodigoUsuario.Text <> EmptyStr) or (edtTituloPost.Text <> EmptyStr) or (memPost.Text <> EmptyStr) then
  begin
    case FOperacao of
      opNovo: Inserir;
      opAlterar: Alterar;
    end;
  end
  else
    MessageBox(handle, 'Favor informar usu�rio, t�tulo e conte�do do post.', 'Informa��o', MB_OK + MB_ICONINFORMATION)
end;

procedure TfrmPosts.HabilitarControles(aOperacao: TOperacao);
var
  i: Integer;
begin
  // Apenas para mostrar o uso de RTTI
  case aOperacao of
    opNovo, opAlterar:
    begin
      for i := 0 to ComponentCount -1 do
      begin
        if (Components[i] is TBitBtn) then
          (Components[i] as TBitBtn).Enabled := True;

        if (Components[i] is TButton) then
          (Components[i] as TButton).Enabled := False;

        if (Components[i] is TEdit) and ((Components[i] as TEdit).Name <> 'edtCodigoPost') then
          (Components[i] as TEdit).Enabled := True;

        if (Components[i] is TMemo) then
          (Components[i] as TMemo).Enabled := True;
      end;
    end;
    opNavegar:
    begin
      for i := 0 to ComponentCount -1 do
      begin
        if (Components[i] is TBitBtn) then
          (Components[i] as TBitBtn).Enabled := False;

        if (Components[i] is TButton) then
          (Components[i] as TButton).Enabled := True;

        if (Components[i] is TEdit) and ((Components[i] as TEdit).Name <> 'edtCodigoPost') then
          (Components[i] as TEdit).Enabled := False;

        if (Components[i] is TMemo) then
          (Components[i] as TMemo).Enabled := False;
      end;
    end;
  end;
end;

procedure TfrmPosts.Inserir;
var
  LErro: String;
  oPostModel: TPostsModel;
begin
  oPostModel := TPostsModel.Create;
  try
    with oPostModel do
    begin
      UserId := StrToInt(edtCodigoUsuario.Text);
      ID     := StrToInt(edtCodigoPost.Text);
      Title  := edtTituloPost.Text;
      Body   := memPost.Text;
    end;
    if FPostsController.Inserir(oPostModel, LErro) then
      MessageBox(handle, 'Registro inserido com sucesso.', 'Informa��o', MB_OK + MB_ICONINFORMATION)
    else
      raise Exception.Create(LErro);
    FPostsController.CarregarTodosPosts(dsPesq);
  finally
    FreeAndNil(oPostModel);
  end;
end;

procedure TfrmPosts.Listar;
begin
  FPostsController.CarregarTodosPosts(dsPesq);
  pgcPrincipal.ActivePage := tbPesq;
end;

procedure TfrmPosts.Novo;
begin
  edtCodigoPost.Text := FPostsController.GerarId.ToString;
  FOperacao := opNovo;
  pgcPrincipal.ActivePage := tbDados;
end;

procedure TfrmPosts.Pesquisar;
begin
  if edtPesquisar.Text <> EmptyStr then
    FPostsController.Pesquisar(dsPesq, edtPesquisar.Text)
  else
    FPostsController.CarregarTodosPosts(dsPesq);
end;

end.
