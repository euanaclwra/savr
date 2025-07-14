unit uFrmConfigRenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, uFrmDialog, FMX.Edit, FMX.Layouts,
  uEditMoeda, uConfigGeral, uConfigGeralDAO, uAppGlobals, uUtils;

type
  TfrmConfigRenda = class(TForm)
    txtConfigRenda: TText;
    btnCancelar: TSpeedButton;
    rtCancelar: TRectangle;
    txtCancelar: TText;
    btnSalvar: TSpeedButton;
    rtSalvar: TRectangle;
    txtSalvar: TText;
    ltConfiguracoes: TLayout;
    ltRenda: TLayout;
    txtValorRenda: TText;
    lnValor: TLine;
    edtValor: TEditMoeda;
    StyleBook1: TStyleBook;
    ckbAdiantamento: TCheckBox;
    txtDiaPagamento: TText;
    edtDiaPagamento: TEdit;
    lnDiaPagamento: TLine;
    edtPctAdiantamento: TEditMoeda;
    lnPctAdiantamento: TLine;
    txtPctAdiantamento: TText;
    ltAdiantamento: TLayout;
    edtDiaAdiantamento: TEdit;
    lnDiaAdiantamento: TLine;
    txtDiaAdiantamento: TText;
    procedure btnCancelarClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    procedure CarregaConfiguracoesRenda;
    procedure CarregaConfiguracoesAdiantamento;
    procedure SalvaConfiguracoesRenda;
  public
    { Public declarations }
  end;

var
  frmConfigRenda: TfrmConfigRenda;

implementation

{$R *.fmx}

procedure TfrmConfigRenda.btnCancelarClick(Sender: TObject);
begin
  // Exibe a mensagem de confirmação
  if TfrmDialog.ShowConfirmDialog('Tem certeza? Nenhuma alteração será salva!') then
    Close;
end;

procedure TfrmConfigRenda.SalvaConfiguracoesRenda;
begin
  //
end;

procedure TfrmConfigRenda.CarregaConfiguracoesRenda;
begin
  if Assigned(AppConfig) then
  begin
    // Obtém o nome do usuário das configurações globais e exibe na tela
    edtValor.Text := FloatToStr(AppConfig.ValorSalario);
    edtDiaPagamento.Text := IntToStr(AppConfig.DiaPagamentoFinal);
    // Se a renda for parcelada, exibe as configurações do adiantamento
    if AppConfig.FlagParcelado = True then
      CarregaConfiguracoesAdiantamento;
  end;
end;

procedure TfrmConfigRenda.FormShow(Sender: TObject);
begin
  CarregaConfiguracoesRenda;
end;

procedure TfrmConfigRenda.btnSalvarClick(Sender: TObject);
begin
  SalvaConfiguracoesRenda;
end;

procedure TfrmConfigRenda.CarregaConfiguracoesAdiantamento;
begin
  ckbAdiantamento.IsChecked := True;
  edtPctAdiantamento.Text := FloatToStr(AppConfig.PercentualAdiantamento);
  edtDiaAdiantamento.Text := IntToStr(AppConfig.DiaAdiantamento);
end;

end.
