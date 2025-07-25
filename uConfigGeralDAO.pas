unit uConfigGeralDAO;

interface

uses
  uConfigGeral, uConexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DApt, uUtils;

type
  TConfigGeralDAO = class
  public
    function AlterarConfiguracao(AColuna: String; ANovoValor: Variant): Boolean;
    procedure InsereRegistroDefault;
    class function UpdateInstanciaConfig: TConfigGeral;
  end;

implementation

// A tabela de configura��o � est�tica, pois o sistema n�o armazena m�ltiplas configura��es
// Ela cont�m apenas um registro, que representa o estado atual das configura��es do usu�rio
// Este m�todo insere uma linha inicial com valores zerados caso n�o exista nenhum registro
// Assim, garante que o registro est�tico sempre esteja presente para uso e atualiza��o
procedure TConfigGeralDAO.InsereRegistroDefault;
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);

  try
    Qry.Connection := dmConexao.FDConnection;
    // Consulta a tabela de configura��es
    Qry.SQL.Text := 'SELECT * FROM configuracao ORDER BY id LIMIT 1';
    Qry.Open;

    // Se a query n�o retornar resultados (tabela vazia)
    if Qry.IsEmpty then
    begin
      Qry.Close;
      Qry.SQL.Text := 'INSERT INTO configuracao(valorsalario, flagparcelado, percentualadiantamento, diaadiantamento, diapagamentofinal, nomeusuario) ' +
                'VALUES (:vsal, :fparc, :perad, :diaadiant, :diapag, :nome)';

      // Insere uma linha zerada
      Qry.ParamByName('vsal').AsFloat := 0;
      Qry.ParamByName('fparc').AsBoolean := False;
      Qry.ParamByName('perad').AsFloat := 0;
      Qry.ParamByName('diaadiant').AsInteger := 0;
      Qry.ParamByName('diapag').AsInteger := 0;
      Qry.ParamByName('nome').AsString := '';
      Qry.ExecSQL;
    end
    else
      Exit
  finally
    Qry.Free;
  end;
end;

// M�todo que atualiza a linha est�tica de configura��es
// Atualiza uma coluna por vez
// Recebe a coluna e o novo valor como par�metros
function TConfigGeralDAO.AlterarConfiguracao(AColuna: String; ANovoValor: Variant): Boolean;
var
  Qry: TFDQuery;
begin
  Result := False;
  Qry := TFDQuery.Create(nil);

  try
    Qry.Connection := dmConexao.FDConnection;
    Qry.SQL.Text := 'UPDATE configuracao SET ' + AColuna + ' = :Valor WHERE id = 1';
    Qry.ParamByName('Valor').Value := ANovoValor;
    Qry.ExecSQL;

    Result := True;
  finally
    Qry.Free;
  end;
end;

// M�todo que atualiza o objeto local de configura��o
// Garante que o objeto esteja sempre sincronizado com o banco de dados
class function TConfigGeralDAO.UpdateInstanciaConfig: TConfigGeral;
var
   Qry: TFDQuery;
   Config: TConfigGeral;
   DAO: TConfigGeralDAO;
begin
  Result := nil;
  Qry := TFDQuery.Create(nil);
  DAO := TConfigGeralDAO.Create;
  DAO.InsereRegistroDefault;

  try
    Qry.Connection := dmConexao.FDConnection;
    Qry.SQL.Text := 'SELECT * FROM configuracao LIMIT 1';
    Qry.Open;

    if not Qry.IsEmpty then
    begin
      // Define as propriedades do objeto de acordo com a respectiva coluna do BD
      Config := TConfigGeral.Create;
      Config.ValorSalario := Qry.FieldByName('ValorSalario').AsFloat;
      Config.FlagParcelado := Qry.FieldByName('FlagParcelado').AsBoolean;
      Config.PercentualAdiantamento := Qry.FieldByName('PercentualAdiantamento').AsFloat;
      Config.DiaAdiantamento := Qry.FieldByName('DiaAdiantamento').AsInteger;
      Config.DiaPagamentoFinal := Qry.FieldByName('DiaPagamentoFinal').AsInteger;
      Config.NomeUsuario := Qry.FieldByName('NomeUsuario').AsString;

      Result := Config;
    end
    else
    begin
      // Retorna o objeto atualizado
      Result := TConfigGeral.Create;
    end;
  finally
    Qry.Free;
  end;
end;

end.
