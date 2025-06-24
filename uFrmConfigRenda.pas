unit uFrmConfigRenda;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, uFrmDialog, FMX.Edit, FMX.Layouts,
  uEditMoeda;

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
    ltValorRenda: TLayout;
    txtNomeUsuario: TText;
    lnValor: TLine;
    edtValor: TEditMoeda;
    StyleBook1: TStyleBook;
    procedure btnCancelarClick(Sender: TObject);
  private
    { Private declarations }
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

end.
