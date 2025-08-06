unit uCategoria;

interface
type
  TTipoCategoria = (tcDespesa, tcReceita, tcTodos);

  TCategoria = class
  private
    FID: Integer;
    FNome: string;
    FTipo: TTipoCategoria;
  public
    property ID: Integer read FID write FID;
    property Nome: string read FNome write FNome;
    property Tipo: TTipoCategoria read FTipo write FTipo;
  end;

implementation

end.
