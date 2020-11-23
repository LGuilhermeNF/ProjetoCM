unit uPostController;

interface

uses uPostModel, uPostsDAO, Data.Db, uConexao, System.SysUtils;

type
  TPostController = class
  private
    FPostsDAO: TPostsDAO;
  public
    constructor Create;
    destructor Destroy; Override;
    function Inserir(oPost: TPostsModel; var aErro: String): Boolean;
    function Alterar(oPost: TPostsModel; var aErro: String): Boolean;
    function Excluir(aCodigo, aID: Integer; var aErro: String): Boolean;
    function GerarId: Integer;
    procedure CarregarPost(oPost: TPostsModel; aCodigo, aID: Integer);
    procedure CarregarTodosPosts(aDataSource: TDataSource);
    procedure Pesquisar(aDataSource: TDataSource; aDescricao: String);
  end;

implementation

{ TPostController }

function TPostController.Alterar(oPost: TPostsModel; var aErro: String): Boolean;
begin
  result := FPostsDAO.Alterar(oPost, aErro);
end;

procedure TPostController.CarregarPost(oPost: TPostsModel; aCodigo, aID: Integer);
begin
  FPostsDAO.CarregarPost(oPost, aCodigo, aID);
end;

procedure TPostController.CarregarTodosPosts(aDataSource: TDataSource);
begin
  FPostsDAO.CarregarTodosPosts(aDataSource);
end;

constructor TPostController.Create;
begin
  FPostsDAO := TPostsDAO.Create(TConexao.Instance.Conectar);
end;

destructor TPostController.Destroy;
begin
//  if Assigned(FPostsDAO) then
//    FreeAndNil(FPostsDAO);
  inherited;
end;

function TPostController.Excluir(aCodigo, aID: Integer; var aErro: String): Boolean;
begin
  result := FPostsDAO.Excluir(aCodigo, aID, aErro)
end;

function TPostController.GerarId: Integer;
begin
  result := FPostsDAO.GerarId;
end;

function TPostController.Inserir(oPost: TPostsModel; var aErro: String): Boolean;
begin
  result := FPostsDAO.Inserir(oPost, aErro);
end;

procedure TPostController.Pesquisar(aDataSource: TDataSource; aDescricao: String);
begin
  FPostsDAO.Pesquisar(aDataSource, aDescricao);
end;

end.
