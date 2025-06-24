program savr;

uses
  System.StartUpCopy,
  FMX.Forms,
  SysUtils,
  Vcl.Dialogs,
  uConexao in 'uConexao.pas' {dmConexao: TDataModule},
  uSetup in 'uSetup.pas' {frmSetup},
  uMain in 'uMain.pas' {frmMain},
  uConfigGeral in 'uConfigGeral.pas',
  uCategoria in 'uCategoria.pas',
  uLancamento in 'uLancamento.pas',
  uConfigGeralDAO in 'uConfigGeralDAO.pas',
  uAppGlobals in 'uAppGlobals.pas',
  uEditMoeda in 'uEditMoeda.pas',
  uUtils in 'uUtils.pas',
  uBootstrap in 'uBootstrap.pas' {frmBootstrap},
  uFrmCategorias in 'uFrmCategorias.pas' {frmCategorias},
  uFrmCategoriaEditor in 'uFrmCategoriaEditor.pas' {frmCategoriaEditor},
  uCategoriaDAO in 'uCategoriaDAO.pas',
  uFrmDialog in 'uFrmDialog.pas' {frmDialog},
  uFrmConfiguracoes in 'uFrmConfiguracoes.pas' {frmConfiguracoes},
  uFrmConfigUsuario in 'uFrmConfigUsuario.pas' {frmConfigUsuario};

{$R *.res}

begin
  Application.Initialize;

  dmConexao := TdmConexao.Create(nil);
  try
    dmConexao.Conectar;
  except
    on E : Exception do
      ShowMessage(E.Message);
  end;

  AppConfig := TConfigGeralDAO.UpdateInstanciaConfig;

  Application.CreateForm(TfrmBootstrap, frmBootstrap);
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmSetup, frmSetup);
  Application.CreateForm(TfrmCategorias, frmCategorias);
  Application.CreateForm(TfrmCategoriaEditor, frmCategoriaEditor);
  Application.CreateForm(TfrmConfiguracoes, frmConfiguracoes);
  Application.CreateForm(TfrmConfigUsuario, frmConfigUsuario);
  Application.Run;
end.
