unit uAppGlobals;

interface

uses
  uConfigGeral, uConfigGeralDAO;

var
  AppConfig: TConfigGeral;

procedure UpdateConfiguracaoGlobal;

implementation

// M�todo global para atualizar o objeto de configura��o
procedure UpdateConfiguracaoGlobal;
begin
  AppConfig := TConfigGeralDAO.UpdateInstanciaConfig;
end;

end.
