unit uSetup;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  uConfigGeralDAO, uAppGlobals, FMX.Styles.Objects, FMX.ComboEdit, FMX.Layouts,
  FMX.ListBox, uEditMoeda, FMX.EditBox, FMX.SpinBox, uUtils;

type
  TfrmSetup = class(TForm)
    txtWelcome: TText;
    txtHello: TText;
    imgLogo: TImage;
    fxHello: TFloatAnimation;
    fxWelcome: TFloatAnimation;
    fxLogo: TFloatAnimation;
    tbcSetup: TTabControl;
    itmWelcome: TTabItem;
    itmName: TTabItem;
    itmSalario: TTabItem;
    txtName: TText;
    edtName: TEdit;
    lnName: TLine;
    btnProximo: TSpeedButton;
    txtProximo: TText;
    imgProximo: TImage;
    btnVoltar: TSpeedButton;
    txtVoltar: TText;
    imgVoltar: TImage;
    fxBtnProximo: TFloatAnimation;
    fxBtnVoltar: TFloatAnimation;
    txtErrorName: TText;
    txtWelcomeName: TText;
    txtDados: TText;
    fxWelcomeName: TFloatAnimation;
    fxDados: TFloatAnimation;
    lnValorSalario: TLine;
    txtValorSalario: TText;
    StyleBook1: TStyleBook;
    lnParcelado: TLine;
    txtParcelado: TText;
    ltValorSalario: TLayout;
    fxLtValorSalario: TFloatAnimation;
    cmbParcelado: TComboBox;
    edtValorSalario: TEditMoeda;
    itmDatas: TTabItem;
    txtLast: TText;
    FloatAnimation1: TFloatAnimation;
    spbDiaAdiantamento: TSpinBox;
    lnDiaAdiantamento: TLine;
    txtDiaAdiantamento: TText;
    txtPctAdiantamento: TText;
    edtPctAdiantamento: TEditMoeda;
    lnPctAdiantamento: TLine;
    txtPct: TText;
    lnDiaPagamento: TLine;
    spbDiaPagamento: TSpinBox;
    txtDiaPagamento: TText;
    ltPagamentoParcelado: TLayout;
    lnDiaPagamentoPadrao: TLine;
    spbDiaPagamentoPadrao: TSpinBox;
    txDiaPagamentoPadrao: TText;
    ltPagamentoPadrao: TLayout;
    txtErrorSalario: TText;
    procedure AvancarPagina;
    procedure VoltarPagina;
    function SalvarNomeUsuario: Boolean;
    function SalvarInfoSalario: Boolean;
    procedure ExibirNomeUsuario;
    procedure UpdateNavegacao;
    procedure AtivarAnimacoesProximaPagina(ATabControl: TTabControl; ATabIndex: Integer);
    procedure btnProximoClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetup: TfrmSetup;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}
{$R *.Surface.fmx MSWINDOWS}

procedure TfrmSetup.btnProximoClick(Sender: TObject);
var
   PaginaAtual: Integer;
   ProximaPagina: Integer;
begin
  PaginaAtual := tbcSetup.TabIndex;
  ProximaPagina := tbcSetup.TabIndex + 1;

  case PaginaAtual of
    1:
    begin
      if not ValidarDados(edtName.Text, Texto) then
      begin
        ExibirMensagemErro(edtName);
        Exit;
      end;

      SalvarNomeUsuario;
      ExibirNomeUsuario;
    end;
    2:
    begin
      //sd
    end;
  end;

  AvancarPagina;
  AtivarAnimacoesProximaPagina(tbcSetup, ProximaPagina);
  UpdateNavegacao;
end;

procedure TfrmSetup.AtivarAnimacoesProximaPagina(ATabControl: TTabControl; ATabIndex: Integer);
var
  Tab: TTabItem;
  procedure AtivarAnimacoes(AComponente: TFmxObject);
  var
    i: Integer;
  begin
    if AComponente is TFloatAnimation then
      TFloatAnimation(AComponente).Enabled := True;

    for i := 0 to AComponente.ChildrenCount - 1 do
      AtivarAnimacoes(AComponente.Children[i]);
  end;
begin
  if (ATabIndex < 0) or (ATabIndex >= ATabControl.TabCount) then Exit;

  Tab := tbcSetup.Tabs[ATabIndex];
  AtivarAnimacoes(Tab);
end;

procedure TfrmSetup.ExibirNomeUsuario;
var
   Nome: String;
begin
  Nome := AppConfig.NomeUsuario;
  txtWelcomeName.Text := 'Que bom te ter conosco, ' + Nome + '!';
end;

procedure TfrmSetup.btnVoltarClick(Sender: TObject);
begin
  VoltarPagina;
  UpdateNavegacao;
end;

procedure TfrmSetup.AvancarPagina;
begin
  tbcSetup.TabIndex := tbcSetup.TabIndex + 1;
end;
procedure TfrmSetup.VoltarPagina;
begin
  tbcSetup.TabIndex := tbcSetup.TabIndex - 1;
end;

function TfrmSetup.SalvarNomeUsuario: Boolean;
var
 DAO: TConfigGeralDAO;
 Nome: String;
begin
  Result := False;
  Nome := Trim(edtName.Text);

  DAO := TConfigGeralDAO.Create;
  try
    if DAO.AlterarConfiguracao('NomeUsuario', Nome) then
    begin
      AppConfig := DAO.UpdateInstanciaConfig;
      Result := True
    end
    else
      Exit;
  finally
    DAO.Free;
  end;
end;

function TfrmSetup.SalvarInfoSalario: Boolean;
var
 DAO: TConfigGeralDAO;
 ValorSalario: Double;
 FlagParcelado: Boolean;

begin
  Result := False;
  ValorSalario := StrToFloat(edtValorSalario.Text);

  if ValorSalario = 0 then
  begin
    txtErrorSalario.Opacity := 1;
    lnValorSalario.Stroke.Color := $FF952727;
    Exit;
  end;

  DAO := TConfigGeralDAO.Create;
  try
    if DAO.AlterarConfiguracao('ValorSalario', ValorSalario) then
    begin
      AppConfig := DAO.UpdateInstanciaConfig;
      Result := True
    end
    else
      Exit;
  finally
    DAO.Free;
  end;
end;

procedure TfrmSetup.UpdateNavegacao;
begin
  btnVoltar.Enabled := tbcSetup.TabIndex > 0;
end;

end.
