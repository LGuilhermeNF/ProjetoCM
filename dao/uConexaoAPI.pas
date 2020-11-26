unit uConexaoAPI;

interface

uses
  REST.Client, uPostsDAO, System.SysUtils, System.Classes, Vcl.Forms,
  System.JSON, uPostModel;

type
  TConexaoAPI = class
  private
    FClientAPI: TRESTClient;
    FResponseAPI: TRESTResponse;
    FRequestAPI: TRESTRequest;
    FTotalRegistros: Integer;
    FProgressStep: Integer;
    procedure RegistrarEvento(aInformacao: String);
  public
    destructor Destroy; override;
    procedure SincronizarAPI;
    function ConectarAPI(aBaseUrl, aResouce: String; var aError: String): Boolean;
    property TotalRegistros: Integer read FTotalRegistros;
    property ProgressStep: Integer read FProgressStep;
  end;

implementation

{ TConexaoAPI }

uses uFrmPosts, uPostController;


function TConexaoAPI.ConectarAPI(aBaseUrl, aResouce: String; var aError: String): Boolean;
begin
  try
    FClientAPI   := TRESTClient.Create(aBaseUrl);
    FResponseAPI := TRESTResponse.Create(nil);
    FRequestAPI  := TRESTRequest.Create(nil);
    FRequestAPI.Response := FResponseAPI;
    FRequestAPI.Client   := FClientAPI;
    FRequestAPI.Resource := aResouce;
    FRequestAPI.Execute;
    Result := True;
  except on E: Exception do
    begin
      aError := 'Erro ao conectar com a aplicação' + sLineBreak + E.Message;
      RegistrarEvento(aError);
      Result := False;
    end;
  end;
end;

destructor TConexaoAPI.Destroy;
begin
  FreeAndNil(FRequestAPI);
  FreeAndNil(FResponseAPI);
  FreeAndNil(FClientAPI);
  inherited;
end;

procedure TConexaoAPI.RegistrarEvento(aInformacao: String);
var
  LArquivo: TextFile;
  LLocalArquivo: string;
begin
  TThread.CreateAnonymousThread(
    procedure()
    begin
      TThread.Synchronize(TThread.CurrentThread,
      procedure()
      begin
        LLocalArquivo := ExtractFilePath(Application.ExeName) + 'Auditoria.txt';
        AssignFile(LArquivo, LLocalArquivo);
        if not FileExists(LLocalArquivo) then
          Rewrite(LArquivo);
        Append(LArquivo);
        Writeln(LArquivo, DateTimeToStr(Now) + ' - ' + aInformacao);
        CloseFile(LArquivo);
      end);
    end).Start;
end;

procedure TConexaoAPI.SincronizarAPI;
var
  i: Integer;
  LError: String;
  oJson: TJSONObject;
  JsonArray: TJSONArray;
  oPostModel: TPostsModel;
  oPostController: TPostController;
begin
  oPostModel := TPostsModel.Create;
  oPostController := TPostController.Create;
  JsonArray := TJSONObject.ParseJSONValue(FResponseAPI.Content) as TJSONArray;
  FTotalRegistros := JsonArray.Count;
  try
    for i := 0 to JsonArray.Count - 1 do
    begin
      FProgressStep := i;
      oJson := JSONArray.Items[i] as TJSONObject;
      with oPostModel do
      begin
        UserId := oJson.GetValue<Integer>('userId');
        ID     := oJson.GetValue<Integer>('id');
        Title  := oJson.GetValue<string>('title');
        Body   := oJson.GetValue<string>('body');
      end;
      oPostController.Inserir(oPostModel, LError);
    end;
  finally
    FreeAndNil(JSONArray);
  end;

end;

end.
