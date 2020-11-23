program ProjetoCM;

uses
  Vcl.Forms,
  uFrmConexao in 'view\uFrmConexao.pas' {frmConexao},
  uConexao in 'dao\uConexao.pas',
  uConfiguraIni in 'controller\uConfiguraIni.pas',
  uFrmPrincipal in 'view\uFrmPrincipal.pas' {frmPrincipal},
  uPostModel in 'model\uPostModel.pas',
  uPostController in 'controller\uPostController.pas',
  uPostsDAO in 'dao\uPostsDAO.pas',
  uFrmPosts in 'view\uFrmPosts.pas' {frmPosts},
  uFrmConectarAPI in 'view\uFrmConectarAPI.pas' {frmConectaAPI},
  uConexaoAPI in 'dao\uConexaoAPI.pas';

{$R *.res}

begin
  //ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.




