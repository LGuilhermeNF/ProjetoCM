unit uConexao;

interface

uses
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, Data.DB,
  FireDAC.Comp.Client, FireDAC.Phys.MySQLDef, FireDAC.Phys.FB, System.SysUtils,
  FireDAC.DApt, FireDAC.VCLUI.Wait, FireDAC.Stan.Def;

type
  TConexao = class
  private
    FConn: TFDConnection;
    class var FInstance: TConexao;
    class var FDataBasePath: String;
    class function getInstance: TConexao; static;
    procedure ConfigurarConexao;
  public
    constructor Create;
    destructor Destroy; override;
    property Conectar: TFDConnection read FConn;
    class property Instance: TConexao read getInstance;
    class property DataBasePath: String read FDataBasePath write FDataBasePath;
  end;


implementation

{ TConexao }

procedure TConexao.ConfigurarConexao;
begin
  with FConn.Params do
  begin
    try
      Clear;
      Values['DriverID']  := 'FB';
      Values['DataBase']  := FDataBasePath;
      Values['User_Name'] := 'SYSDBA';
      Values['Password']  := 'masterkey';
      FConn.Connected := true;
    except on E: Exception do

    end;
  end;
end;

constructor TConexao.Create;
begin
  FConn := TFDConnection.Create(nil);
  ConfigurarConexao;
end;

destructor TConexao.Destroy;
begin
  if Assigned(FConn) then
  begin
    if FConn.Connected then
      FConn.Close;
    FreeAndNil(FConn);
  end;
  if Assigned(FConn) then
    FreeAndNil(FConn);
  inherited;
end;

class function TConexao.getInstance: TConexao;
begin
  if not Assigned(FInstance) then
    FInstance := TConexao.Create();
  result := FInstance;
end;

initialization

finalization
if Assigned(TConexao.FInstance) then
  FreeAndNil(TConexao.FInstance);
end.
