unit uCategoriaDAO;

interface

uses
  uCategoria, uConexao, System.SysUtils, FireDAC.Comp.Client, FireDAC.Stan.Param,
  FireDAC.DApt, uUtils, System.Generics.Collections, Vcl.Dialogs;

type
  TCategoriaDAO = class
  public
    function BuscarCategorias: TObjectList<TCategoria>;
    procedure InserirCategoria(const ACategoria: TCategoria);
    procedure AtualizarCategoria(const ACategoria: TCategoria);
    procedure ExcluirCategoria(const ACategoria: TCategoria);
  end;

implementation

procedure TCategoriaDAO.InserirCategoria(const ACategoria: TCategoria);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);

  try
    try
      Qry.Connection := dmConexao.FDConnection;
      // SQL para inserir a nova categoria
      Qry.SQL.Text := 'INSERT INTO categorias (nome, tipo) VALUES (:nome, :tipo)';
      // Define as propriedades da categoria como par�metro pro insert
      Qry.ParamByName('nome').AsString := ACategoria.Nome;
      Qry.ParamByName('tipo').AsString := CatToStr(ACategoria.Tipo);
      // Executa a query
      Qry.ExecSQL;

      // Recupera o ID da categoria inserida e grava no objeto
      ACategoria.ID := Qry.Connection.ExecSQLScalar('SELECT LAST_INSERT_ID()');
    except
        on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Qry.Free;
  end;
end;

function TCategoriaDAO.BuscarCategorias: TObjectList<TCategoria>;
var
  ResultSet: TObjectList<TCategoria>;
  Categoria: TCategoria;
  Qry: TFDQuery;
begin
  Result := nil;
  Qry := TFDQuery.Create(nil);
  // Inicializa a lista de objetos para armazenar as categorias
  ResultSet := TObjectList<TCategoria>.Create(False);

  try
    // Consulta todas as categorias existentes
    Qry.Connection := dmConexao.FDConnection;
    Qry.SQL.Text := 'SELECT * FROM categorias';
    Qry.Open;

    // Se a query n�o estiver vazia, ou seja, se houver alguma categoria...
    if not Qry.IsEmpty then
    begin
      // Percorre todas as categorias do BD
      while not Qry.Eof do
      begin
        try
          // Cria um objeto de Categoria para o registro atual
          Categoria := TCategoria.Create;
          Categoria.ID := Qry.FieldByName('ID').AsInteger;
          Categoria.Nome := Qry.FieldByName('Nome').AsString;
          Categoria.Tipo := StrToCat(Qry.FieldByName('Tipo').AsString);

          // Adiciona a categoria ao ResultSet
          ResultSet.Add(Categoria);
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

procedure TCategoriaDAO.AtualizarCategoria(const ACategoria: TCategoria);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);

  try
    try
      Qry.Connection := dmConexao.FDConnection;
      // SQL para atualizar a categoria
      Qry.SQL.Text := 'UPDATE categorias SET nome = :nome, tipo = :tipo WHERE id = :id';
      // Define as propriedades da categoria como par�metro pro update
      Qry.ParamByName('id').AsInteger := ACategoria.ID;
      Qry.ParamByName('nome').AsString := ACategoria.Nome;
      Qry.ParamByName('tipo').AsString := CatToStr(ACategoria.Tipo);
      // Executa a query
      Qry.ExecSQL;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    Qry.Free;
  end;
end;

procedure TCategoriaDAO.ExcluirCategoria(const ACategoria: TCategoria);
var
  Qry: TFDQuery;
begin
  Qry := TFDQuery.Create(nil);

  try
    Qry.Connection := dmConexao.FDConnection;
    // Verifica se categoria selecionada existe
    Qry.SQL.Text := 'SELECT * FROM categorias WHERE id = :id';
    Qry.ParamByName('id').AsInteger := ACategoria.ID;
    Qry.Open;

    // Se a query n�o estiver vazia, ou seja, se a categoria existir...
    if not Qry.IsEmpty then
    begin
      try
        Qry.Close;
        // Exclui a categoria com o ID selecionado
        Qry.SQL.Text := 'DELETE FROM categorias WHERE id = :id';
        Qry.ParamByName('id').AsInteger := ACategoria.ID;
        Qry.ExecSQL;
      except
        on E: Exception do
          ShowMessage(E.Message);
      end;
    end;
  finally
    Qry.Free;
  end;
end;

end.
