unit uFrmSelecaoLancamento;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Objects, uFrmLancamentoBase;

type
  TfrmSelecaoLancamento = class(TForm)
    rdReceita: TRadioButton;
    ltGroupRadio: TLayout;
    StyleBook1: TStyleBook;
    rdDespesa: TRadioButton;
    btnCriar: TSpeedButton;
    txtSelecione: TText;
    procedure FormShow(Sender: TObject);
    procedure btnCriarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSelecaoLancamento: TfrmSelecaoLancamento;

implementation

{$R *.fmx}

procedure TfrmSelecaoLancamento.btnCriarClick(Sender: TObject);
begin
  frmLancamentoBase.Show;
end;

procedure TfrmSelecaoLancamento.FormShow(Sender: TObject);
begin
  rdReceita.IsChecked := False;
  rdDespesa.IsChecked := False;
end;

end.
