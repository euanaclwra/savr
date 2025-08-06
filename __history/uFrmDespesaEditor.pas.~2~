unit uFrmDespesaEditor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmLancamentoBase, FMX.Memo.Types, FMX.Objects, FMX.ScrollBox, FMX.Memo,
  FMX.ListBox, FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit,
  uEditMoeda, FMX.Layouts, uCategoria;

type
  TfrmDespesaEditor = class(TfrmLancamentoBase)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDespesaEditor: TfrmDespesaEditor;

implementation

{$R *.fmx}

procedure TfrmDespesaEditor.FormShow(Sender: TObject);
begin
  inherited;
  CarregarCategorias(cmbCategoria, tcDespesa)
end;

end.
