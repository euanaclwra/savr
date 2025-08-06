unit uFrmDespesaEditor;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  uFrmLancamentoBase, FMX.Memo.Types, FMX.Objects, FMX.ScrollBox, FMX.Memo,
  FMX.ListBox, FMX.DateTimeCtrls, FMX.Controls.Presentation, FMX.Edit,
  uEditMoeda, FMX.Layouts, uCategoria, uLancamento, uLancamentoDAO, uFrmDialog;

type
  TfrmDespesaEditor = class(TfrmLancamentoBase)
    procedure FormShow(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDespesaEditor: TfrmDespesaEditor;

implementation

{$R *.fmx}

procedure TfrmDespesaEditor.btnSalvarClick(Sender: TObject);
var
  Lancamento: TLancamento;
  DAO: TLancamentoDAO;
begin
  // Valida os campos obrigatórios (valor, data, descrição e categoria)
  if not ValidaCamposObrigatorios then Exit;

  // Cria o objeto de acesso ao banco de dados
  DAO := TLancamentoDAO.Create;

  try
    // Gera um lançamento de despesa
    Lancamento := CriarLancamento(tcDespesa);
    // Salva o lançamento no banco de dados
    DAO.InserirLancamento(Lancamento);
  finally
    DAO.Free;
  end;

  TfrmDialog.ShowSuccessDialog('Acesse o Fluxo de Caixa para visualizar o lançamento.');
  Close;
end;

procedure TfrmDespesaEditor.FormShow(Sender: TObject);
begin
  inherited;
  CarregarCategorias(cmbCategoria, tcDespesa)
end;

end.
