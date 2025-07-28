unit uLancamento;

interface

uses uCategoria;

type
  TLancamento = class
  private
    FID: Integer;
    FCategoriaID: Integer;
    FTipo: TTipoCategoria;
    FDescricao: string;
    FValor: Double;
    FData: TDate;
    FObservacoes: string;
  public
    property ID: Integer read FID write FID;
    property CategoriaID: Integer read FCategoriaID write FCategoriaID;
    property Tipo: TTipoCategoria read FTipo write FTipo;
    property Descricao: string read FDescricao write FDescricao;
    property Valor: Double read FValor write FValor;
    property Data: TDate read FData write FData;
    property Observacoes: string read FObservacoes write FObservacoes;
  end;

implementation

end.
