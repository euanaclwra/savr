unit uConfigGeral;

interface
type
  TConfigGeral = class
  private
    FID: Integer;
    FValorSalario: Double;
    FFlagParcelado: Boolean;
    FPercentualAdiantamento: Double;
    FDiaAdiantamento: Integer;
    FDiaPagamentoFinal: Integer;
    FNomeUsuario: String;
    FValorSaldo: Double;
  public
    property ID: Integer read FID write FID;
    property ValorSalario: Double read FValorSalario write FValorSalario;
    property FlagParcelado: Boolean read FFlagParcelado write FFlagParcelado;
    property PercentualAdiantamento: Double read FPercentualAdiantamento write FPercentualAdiantamento;
    property DiaAdiantamento: Integer read FDiaAdiantamento write FDiaAdiantamento;
    property DiaPagamentoFinal: Integer read FDiaPagamentoFinal write FDiaPagamentoFinal;
    property NomeUsuario: String read FNomeUsuario write FNomeUsuario;
    property ValorSaldo: Double read FValorSaldo write FValorSaldo;
  end;

implementation

end.
