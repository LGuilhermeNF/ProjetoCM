unit uFrmConectarAPI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, Vcl.ComCtrls, uConexaoAPI, System.StrUtils;

type
  TfrmConectaAPI = class(TForm)
    Panel1: TPanel;
    edtURL: TLabeledEdit;
    btnConectar: TBitBtn;
    Panel2: TPanel;
    dsAPI: TDataSource;
    Panel3: TPanel;
    ProgressBar: TProgressBar;
    Label1: TLabel;
    btnSincronizar: TBitBtn;
    btnSair: TBitBtn;
    lblConexaoAPI: TLabel;
    procedure btnConectarClick(Sender: TObject);
    procedure btnSincronizarClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FError: String;
    FBaseUrl: String;
    FConectado: Boolean;
    FConexaoAPI: TConexaoAPI;
  public
    { Public declarations }
    procedure ConectarAPI;
    procedure SincornizarBaseDados;
  end;

var
  frmConectaAPI: TfrmConectaAPI;

implementation

{$R *.dfm}

procedure TfrmConectaAPI.btnConectarClick(Sender: TObject);
begin
  ConectarAPI;
end;

procedure TfrmConectaAPI.btnSairClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmConectaAPI.btnSincronizarClick(Sender: TObject);
begin
  SincornizarBaseDados;
end;

procedure TfrmConectaAPI.ConectarAPI;
begin
  FBaseUrl := edtURL.Text;
  if FBaseUrl = EmptyStr then
  begin
    MessageBox(handle,'Favor informar a URL para conex�o com a Aplica��o','Erro', MB_ICONERROR + MB_OK);
    edtURL.SetFocus;
  end;

  try
    if FConexaoAPI.ConectarAPI('posts', FBaseUrl, FError) then
    begin
      btnSincronizar.Enabled := True;
      FConectado := True;
    end;
  except on E: Exception do
    begin
      MessageBox(handle,PWideChar(FError),'Erro', MB_ICONERROR + MB_OK);
      FConectado := False;
    end;
  end;

  MessageBox(handle,'Conex�o realizada com sucesso!','Conex�o', MB_ICONINFORMATION + MB_OK);
  lblConexaoAPI.Visible := True;
end;

procedure TfrmConectaAPI.FormCreate(Sender: TObject);
begin
  FConexaoAPI := TConexaoAPI.Create;
end;

procedure TfrmConectaAPI.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FConexaoAPI);
end;

procedure TfrmConectaAPI.FormShow(Sender: TObject);
begin
  lblConexaoAPI.Visible := False;
end;

procedure TfrmConectaAPI.SincornizarBaseDados;
var
  i: Integer;
begin
  try
    if FConectado then
    begin
      FConexaoAPI.SincronizarAPI;
      ProgressBar.Max := FConexaoAPI.TotalRegistros;
      for i := 0 to FConexaoAPI.TotalRegistros - 1 do
      begin
        ProgressBar.Position := FConexaoAPI.ProgressStep;
      end;
      MessageBox(handle,'Processo concluido.','Informa��o', MB_ICONINFORMATION + MB_OK);
    end
    else
    begin
      MessageBox(handle,'Necess�rio conectar com aplica��o.','Informa��o', MB_ICONINFORMATION + MB_OK);
    end;
  finally

  end;
end;

end.
