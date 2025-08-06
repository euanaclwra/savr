unit uLancamentoDAO;

interface

uses
  uLancamento, uConexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DApt, uUtils, System.Generics.Collections, Vcl.Dialogs, uCategoriaDAO, uCategoria;

type
  TLancamentoDAO = class
  public
    function BuscarLancamentos: TObjectList<TLancamento>;
    procedure InserirLancamento(const ALancamento: TLancamento);
  end;

implementation

function TLancamentoDAO.BuscarLancamentos: TObjectList<TLancamento>;
var
  ResultSet: TObjectList<TLancamento>;
  Lancamento: TLancamento;
  Qry: TFDQuery;
  DAOCategoria: TCategoriaDAO;
begin
  Result := nil;
  DAOCategoria := TCategoriaDAO.Create;
  Qry := TFDQuery.Create(nil);
  // Inicializa a lista de objetos para armazenar os lançamentos
  ResultSet := TObjectList<TLancamento>.Create(False);

  try
    // Consulta todas os lançamentos existentes
     Qry.Connection := dmConexao.FDConnection;
     Qry.SQL.Text := 'SELECT * FROM lancamentos';
     Qry.Open;

     // Se a query não estiver vazia, ou seja, se houver algum lançamento
     if not Qry.IsEmpty then
     begin
      // Percorre todos os lançamentos do BD
       while not Qry.Eof do
       begin
        try
          // Cria um objeto de Lançamento para o registro atual
          Lancamento := TLancamento.Create;
          Lancamento.ID := Qry.FieldByName('ID').AsInteger;
          Lancamento.CategoriaID := Qry.FieldByName('categoria').AsInteger;
          Lancamento.Categoria := DAOCategoria.BuscarCategoriaPorID(Lancamento.CategoriaID);
          Lancamento.Tipo := StrToCat(Qry.FieldByName('tipo').AsString);
          Lancamento.Descricao := Qry.FieldByName('descricao').AsString;
          Lancamento.Valor := Qry.FieldByName('valor').AsFloat;
          Lancamento.Data := Qry.FieldByName('data').AsDateTime;
          Lancamento.Observacoes := Qry.FieldByName('observacoes').AsString;
          Lancamento.Entidade := Qry.FieldByName('entidade').AsString;

          // Adiciona o lançamento ao ResultSet
          ResultSet.Add(Lancamento);
          Qry.Next;
        except
          on E: Exception do
            ShowMessage(E.Message);
        end;
       end;

       Result := ResultSet;
     end;
  finally
    Qry.Free;
  end;
end;

procedure TLancamentoDAO.InserirLancamento(const ALancamento: TLancamento);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);

  try
    try
      Qry.Connection := dmConexao.FDConnection;
      // SQL para inserir o novo lançamento
      Qry.SQL.Text := 'INSERT INTO lancamentos (categoria, tipo, descricao, valor, data, observacoes, entidade) VALUES' +
      '(:categoria, :tipo, :descricao, :valor, :data, :observacoes, :entidade)';

      // Define as propriedades do lançamento como parâmetro pro insert
      Qry.ParamByName('categoria').AsInteger := ALancamento.CategoriaID;
      Qry.ParamByName('tipo').AsString := CatToStr(ALancamento.Tipo);
      Qry.ParamByName('descricao').AsString := ALancamento.Descricao;
      Qry.ParamByName('valor').AsFloat := ALancamento.Valor;
      Qry.ParamByName('data').AsDate := ALancamento.Data;
      Qry.ParamByName('observacoes').AsString := ALancamento.Observacoes;
      qry.ParamByName('entidade').AsString := ALancamento.Entidade;

      // Executa a query
      Qry.ExecSQL;

      // Recupera o ID do lançamento inserido e grava no objeto
      ALancamento.ID := Qry.Connection.ExecSQLScalar('SELECT LAST_INSERT_ID()');
    except
        on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Qry.Free;
  end;
end;

end.
