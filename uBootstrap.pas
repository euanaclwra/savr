unit uBootstrap;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, uAppGlobals, uSetup,
  uMain;

type
  TfrmBootstrap = class(TForm)
    procedure FormShow(Sender: TObject);
    function GetFirstForm: TForm;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBootstrap: TfrmBootstrap;

implementation

{$R *.fmx}

procedure TfrmBootstrap.FormShow(Sender: TObject);
var
   Form: TForm;
begin
  Form := GetFirstForm;

  // Define o form principal da aplica��o
  // Impede que a aplica��o finalize ao fechar o primeiro form criado
  try
    Application.MainForm := Form;
    Form.Show;
  finally
    Close;
  end;
end;

function TfrmBootstrap.GetFirstForm: TForm;
begin
  // Inicia o form de Setup caso a aplica��o n�o possua as configura��es iniciais
  if (AppConfig <> nil) and (AppConfig.NomeUsuario <> '') then
    Result := frmMain
  else
    Result := frmSetup
end;

end.
