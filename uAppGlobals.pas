unit uAppGlobals;

interface

uses
  uConfigGeral, uConfigGeralDAO;

var
  AppConfig: TConfigGeral;

procedure UpdateConfiguracaoGlobal;

implementation

procedure UpdateConfiguracaoGlobal;
begin
  AppConfig := TConfigGeralDAO.UpdateInstanciaConfig;
end;

end.
