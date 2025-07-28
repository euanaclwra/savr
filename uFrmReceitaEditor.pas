unit uFrmReceitaEditor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmLancamentoBase, FMX.Memo.Types, FMX.Objects, FMX.ScrollBox, FMX.Memo,
  FMX.ListBox, FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit,
  uEditMoeda, FMX.Layouts, uCategoria;

type
  TfrmReceitaEditor = class(TfrmLancamentoBase)
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReceitaEditor: TfrmReceitaEditor;

implementation

{$R *.fmx}

procedure TfrmReceitaEditor.FormShow(Sender: TObject);
begin
  inherited;
  CarregarCategorias(cmbCategoria, tcReceita);
end;

end.
