unit uAppGlobals;

interface

uses
  uConfigGeral, uConfigGeralDAO;

var
  AppConfig: TConfigGeral;

procedure UpdateConfiguracaoGlobal;

implementation

// Método global para atualizar o objeto de configuração
procedure UpdateConfiguracaoGlobal;
begin
  AppConfig := TConfigGeralDAO.UpdateInstanciaConfig;
end;

end.
