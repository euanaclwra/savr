unit uSetup;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Ani, FMX.TabControl, FMX.Controls.Presentation, FMX.StdCtrls, FMX.Edit,
  uConfigGeralDAO, uAppGlobals, FMX.Styles.Objects, FMX.ComboEdit, FMX.Layouts,
  FMX.ListBox, uEditMoeda, FMX.EditBox, FMX.SpinBox, uUtils, uMain;

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
    txtWelcomeName: TText;
    txtDados: TText;
    fxWelcomeName: TFloatAnimation;
    fxDados: TFloatAnimation;
    lnValorSalario: TLine;
    txtValorSalario: TText;
    StyleBook1: TStyleBook;
    ltValorSalario: TLayout;
    fxLtValorSalario: TFloatAnimation;
    edtValorSalario: TEditMoeda;
    itmDatas: TTabItem;
    txtDiaAdiantamento: TText;
    txtPctAdiantamento: TText;
    edtPctAdiantamento: TEditMoeda;
    lnPctAdiantamento: TLine;
    txtPct: TText;
    txtDiaPagamento: TText;
    ltPagamentoParcelado: TLayout;
    txDiaPagamentoPadrao: TText;
    ltPagamentoPadrao: TLayout;
    ckbAdiantamento: TCheckBox;
    txtLast: TText;
    lnDiaAdiantamento: TLine;
    edtDiaAdiantamento: TEdit;
    edtDiaPagamento: TEdit;
    lnDiaPagamento: TLine;
    edtDiaPagamentoPadrao: TEdit;
    lnDiaPagamentoPadrao: TLine;
    function SalvarNomeUsuario: Boolean;
    function SalvarInfoSalario: Boolean;
    function ValidarDadosTab3(out CampoInvalido: TEdit): Boolean;
    procedure SalvarInfoDatas;
    procedure SalvarInfoDatasPadrao;
    procedure SalvarInfoDatasParcelado;
    procedure AvancarPagina;
    procedure VoltarPagina;
    procedure ExibirNomeUsuario;
    procedure ExibirLayoutSalario;
    procedure UpdateNavegacao;
    procedure AtivarAnimacoesProximaPagina(ATabControl: TTabControl; ATabIndex: Integer);
    procedure btnProximoClick(Sender: TObject);
    procedure btnVoltarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FinalizarSetup;
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
   CampoInvalido: TEdit;
begin
  PaginaAtual := tbcSetup.TabIndex;
  ProximaPagina := tbcSetup.TabIndex + 1;

  // Executa métodos diferentes a depender da página atual
  case PaginaAtual of
    1:
    begin
      // Página 1 - Salva e exibe o nome do usuário
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
      // Página 2 - Salva o valor do salário
      if not ValidarDados(edtValorSalario.Text, Moeda) then
      begin
        ExibirMensagemErro(edtValorSalario);
        Exit;
      end;

      SalvarInfoSalario;
      ExibirLayoutSalario;
    end;
    3:
    begin
      // Página 3 - Salva as datas do salário e finaliza o setup
      if not ValidarDadosTab3(CampoInvalido) then
      begin
        // Exibe a mensagem de erro no campo retornado como inválido pela validação
        ExibirMensagemErro(CampoInvalido);
        Exit;
      end;

      SalvarInfoDatas;
      FinalizarSetup;
    end;
  end;

  // Métodos executados ao avançar qualquer página
  AvancarPagina;
  AtivarAnimacoesProximaPagina(tbcSetup, ProximaPagina);
  UpdateNavegacao;
end;

procedure TfrmSetup.FinalizarSetup;
begin
  Application.MainForm := frmMain;
  frmMain.Show;
end;

function TfrmSetup.ValidarDadosTab3(out CampoInvalido: TEdit): Boolean;
begin
  Result := False;

  // Os campos dessa página mudam dependendo do tipo de salário (com ou sem adiantamento)
  // Esse método realiza as validações necessárias a depender do tipo informado pelo usuário

  // Validações do salário com adiantamento
  if AppConfig.FlagParcelado then
  begin
    if not ValidarDados(edtDiaAdiantamento.Text, Inteiro) then
    begin
      CampoInvalido := edtDiaAdiantamento;
      Exit
    end;
    if not ValidarDados(edtPctAdiantamento.Text, Moeda) then
    begin
      CampoInvalido := edtPctAdiantamento;
      Exit
    end;
    if not ValidarDados(edtDiaPagamento.Text, Inteiro) then
    begin
      CampoInvalido := edtDiaPagamento;
      Exit
    end;
  end
  // Validações do salário sem adiantamento
  else
  begin
    if not ValidarDados(edtDiaPagamentoPadrao.Text, Inteiro) then
    begin
      CampoInvalido := edtDiaPagamentoPadrao;
      Exit
    end;
  end;

  Result := True;
end;

procedure TfrmSetup.ExibirLayoutSalario;
begin
  // Exibe os campos correspondentes a depender do tipo de salário selecionado
  if AppConfig.FlagParcelado then
  begin
    ltPagamentoParcelado.Visible := True;
    ltPagamentoPadrao.Visible := False;
  end
  else
  begin
    ltPagamentoPadrao.Visible := True;
    ltPagamentoParcelado.Visible := False
  end;
end;

procedure TfrmSetup.AtivarAnimacoesProximaPagina(ATabControl: TTabControl; ATabIndex: Integer);
var
  Tab: TTabItem;
  // Procedure recursiva interna
  procedure AtivarAnimacoes(AComponente: TFmxObject);
  var
    i: Integer;
  begin
    // Se o componente atual for uma animação, ela é ativada
    if AComponente is TFloatAnimation then
      TFloatAnimation(AComponente).Enabled := True;

    // Percorre todos os componentes filhos do componente atual, até encontrar uma animação
    for i := 0 to AComponente.ChildrenCount - 1 do
      AtivarAnimacoes(AComponente.Children[i]);
  end;
begin
  // Sai do método se a página atual for inválida
  if (ATabIndex < 0) or (ATabIndex >= ATabControl.TabCount) then Exit;

  // Executa a procedure interna com base na página atual do TabControl
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

procedure TfrmSetup.FormCreate(Sender: TObject);
var
  DAO: TConfigGeralDAO;
begin
  tbcSetup.TabIndex := 0;
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
  ValorSalario := CurrencyToFloat(edtValorSalario.Text);
  FlagParcelado := ckbAdiantamento.IsChecked;

  DAO := TConfigGeralDAO.Create;
  try
    if DAO.AlterarConfiguracao('ValorSalario', ValorSalario)
    and DAO.AlterarConfiguracao('FlagParcelado', BoolToInt(FlagParcelado))
    then
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

procedure TfrmSetup.SalvarInfoDatasPadrao;
var
  DAO: TConfigGeralDAO;
  DiaPagamento: Integer;
begin
  DiaPagamento := StrToInt(edtDiaPagamentoPadrao.Text);
  DAO := TConfigGeralDAO.Create;

  try
    if DAO.AlterarConfiguracao('DiaPagamentoFinal', DiaPagamento)
    then
    begin
      AppConfig := DAO.UpdateInstanciaConfig;
    end
    else
      Exit;
  finally
    DAO.Free;
  end;
end;

procedure TfrmSetup.SalvarInfoDatasParcelado;
var
 DAO: TConfigGeralDAO;
 DiaAdiantamento: Integer;
 PercentualAdiantamento: Double;
 DiaPagamentoFinal: Integer;

begin
  DiaAdiantamento := StrToInt(edtDiaAdiantamento.Text);
  PercentualAdiantamento := StrToFloat(edtPctAdiantamento.Text);
  DiaPagamentoFinal := StrToInt(edtDiaPagamento.Text);

  DAO := TConfigGeralDAO.Create;
  try
    if DAO.AlterarConfiguracao('DiaAdiantamento', DiaAdiantamento)
     and DAO.AlterarConfiguracao('PercentualAdiantamento', PercentualAdiantamento)
     and DAO.AlterarConfiguracao('DiaPagamentoFinal', DiaPagamentoFinal)
    then
    begin
      AppConfig := DAO.UpdateInstanciaConfig;
    end
    else
      Exit;
  finally
    DAO.Free;
  end;
end;

procedure TfrmSetup.SalvarInfoDatas;
begin
  if AppConfig.FlagParcelado then
    SalvarInfoDatasParcelado
  else
    SalvarInfoDatasPadrao;
end;

procedure TfrmSetup.UpdateNavegacao;
begin
  btnVoltar.Enabled := tbcSetup.TabIndex > 0;
end;

end.
