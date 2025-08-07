unit uFrmFluxoCaixa;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, uFrmSelecaoLancamento, FMX.Layouts,
  FMX.DateTimeCtrls, FMX.ListBox, uLancamento, uLancamentoDAO, System.Generics.Collections,
  uUtils, System.Rtti, FMX.Grid.Style, FMX.Grid, FMX.ScrollBox, uCategoria, uCategoriaDAO;

type
  TfrmFluxoCaixa = class(TForm)
    txtFluxo: TText;
    btnInserir: TSpeedButton;
    rtInserir: TRectangle;
    txtInserir: TText;
    ltFiltros: TLayout;
    ltTipo: TLayout;
    txtTipo: TText;
    rdReceitas: TRadioButton;
    StyleBook1: TStyleBook;
    rdDespesas: TRadioButton;
    rdAmbos: TRadioButton;
    ltPeriodo: TLayout;
    txtInicio: TText;
    dtInicio: TDateEdit;
    lnInicio: TLine;
    txtFim: TText;
    dtFim: TDateEdit;
    lnFim: TLine;
    ltCategoria: TLayout;
    txtCategoria: TText;
    cmbCategoria: TComboBox;
    lnCategoria: TLine;
    grdLancamentos: TStringGrid;
    clData: TStringColumn;
    clEntidade: TStringColumn;
    clDescricao: TStringColumn;
    clObservacoes: TStringColumn;
    clCategoria: TStringColumn;
    clValor: TStringColumn;
    clTipo: TStringColumn;
    btnAplicarFiltros: TSpeedButton;
    rtAplicarFiltros: TRectangle;
    txtAplicarFiltros: TText;
    ltAplicarFiltros: TLayout;
    procedure btnInserirClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnAplicarFiltrosClick(Sender: TObject);
  private
    FFiltroTipo: TTipoCategoria;
    FFiltroDataInicial: TDate;
    FFiltroDataFinal: TDate;
    FFiltroCategoria: Integer;
    procedure CarregaListaLancamentos(ATipo: TTipoCategoria; ADataInicial: TDate; ADataFinal: TDate; ACategoria: Integer);
    procedure CarregarCategorias;
    procedure ResizeGridColumns;
    procedure LimparFiltros;
  end;

var
  frmFluxoCaixa: TfrmFluxoCaixa;

implementation

{$R *.fmx}
{$R *.Windows.fmx MSWINDOWS}

procedure TfrmFluxoCaixa.LimparFiltros;
begin
  FFiltroTipo := tcTodos;
  FFiltroDataInicial := 0;
  FFiltroDataFinal := 0;
  FFiltroCategoria := 0;
end;

procedure TfrmFluxoCaixa.CarregarCategorias;
var
  DAO: TCategoriaDAO;
  Lista: TObjectList<TCategoria>;
  Categoria: TCategoria;
  Item: TListBoxItem;
begin
  // Começa limpando os itens que já estavam na combobox
  cmbCategoria.Clear;
  // Cria o objeto de acesso ao BD
  DAO := TCategoriaDAO.Create;

  try
    // Busca todos as categorias no Banco de Dados e armazena numa lista
    Lista := DAO.BuscarCategorias;

    // Se houver algum objeto na lista...
    if Lista <> nil then
    try
      for Categoria in Lista do
      begin
        // Para cada categoria encontrada, é criado um novo item na TComboBox
        Item := TListBoxItem.Create(nil);
        Item.Parent := cmbCategoria;
        Item.Text := Categoria.Nome;
        // Aplica o estilo padrão
        Item.StyledSettings := [];
        Item.TextSettings.Font.Family := 'Montserrat';
        Item.TextSettings.Font.Size := 11;
        Item.TextSettings.FontColor := $FF34495E;
        // Vincula a categoria selecionada ao item da combobox
        Item.TagObject := Categoria;
        cmbCategoria.AddObject(Item);
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    DAO.Free;
    Lista.Free;
  end;
end;

procedure TfrmFluxoCaixa.ResizeGridColumns;
var
  TotalWidth: Single;
begin
  TotalWidth := grdLancamentos.Width;

  // Define a largura das colunas de acordo com a largura total da tela
  grdLancamentos.Columns[0].Width := TotalWidth * 0.10;
  grdLancamentos.Columns[1].Width := TotalWidth * 0.15;
  grdLancamentos.Columns[2].Width := TotalWidth * 0.25;
  grdLancamentos.Columns[3].Width := TotalWidth * 0.25;
  grdLancamentos.Columns[4].Width := TotalWidth * 0.10;
  grdLancamentos.Columns[5].Width := TotalWidth * 0.10;
  grdLancamentos.Columns[6].Width := TotalWidth * 0.05;
end;

procedure TfrmFluxoCaixa.CarregaListaLancamentos(ATipo: TTipoCategoria; ADataInicial: TDate; ADataFinal: TDate; ACategoria: Integer);
var
  DAO: TLancamentoDAO;
  Lista: TObjectList<TLancamento>;
  Lancamento: TLancamento;
begin
  // Começa limpando os lançamentos que já estavam no TStringGrid
  grdLancamentos.RowCount := 0;
  // Cria o objeto de acesso ao BD
  DAO := TLancamentoDAO.Create;

  try
    // Busca todos os lançamentos do Banco de Dados e armazena numa lista
    Lista := DAO.BuscarLancamentos(ATipo, ADataInicial, ADataFinal, ACategoria);

    // Se houver algum objeto na lista...
    if Lista <> nil then
    try
      // Para cada lançamento, é criada uma nova linha no TStringGrid
      for Lancamento in Lista do
      begin
        grdLancamentos.RowCount := grdLancamentos.RowCount + 1;
        grdLancamentos.Cells[0, grdLancamentos.RowCount - 1] := DateToStr(Lancamento.Data);
        grdLancamentos.Cells[1, grdLancamentos.RowCount - 1] := Lancamento.Entidade;
        grdLancamentos.Cells[2, grdLancamentos.RowCount - 1] := Lancamento.Descricao;
        grdLancamentos.Cells[3, grdLancamentos.RowCount - 1] := Lancamento.Observacoes;
        grdLancamentos.Cells[4, grdLancamentos.RowCount - 1] := Lancamento.Categoria.Nome;
        grdLancamentos.Cells[5, grdLancamentos.RowCount - 1] := FormatFloat('R$ #,##0.00', Lancamento.Valor);

        if Lancamento.Tipo = tcReceita then
          grdLancamentos.Cells[6, grdLancamentos.RowCount - 1] := '🟢'
        else
          grdLancamentos.Cells[6, grdLancamentos.RowCount - 1] := '🔴'
      end;
    except
      on E: Exception do
        ShowMessage(E.Message);
    end;
  finally
    DAO.Free;
  end;
end;

procedure TfrmFluxoCaixa.FormShow(Sender: TObject);
begin
  CarregarCategorias;
  LimparFiltros;
  ResizeGridColumns;
  CarregaListaLancamentos(FFiltroTipo, FFiltroDataInicial, FFiltroDataFinal, FFiltroCategoria);
end;

procedure TfrmFluxoCaixa.btnAplicarFiltrosClick(Sender: TObject);
begin
  // Tipo
  if rdReceitas.IsChecked then
    FFiltroTipo := tcReceita
  else if rdDespesas.IsChecked then
    FFiltroTipo := tcDespesa
  else
    FFiltroTipo := tcTodos;

  // Data
  FFiltroDataInicial := dtInicio.Date;
  FFiltroDataFinal := dtFim.Date;

  // Categoria
  if (cmbCategoria.ItemIndex >= 0) and Assigned(cmbCategoria.ListItems[cmbCategoria.ItemIndex].TagObject) then
    FFiltroCategoria := TCategoria(cmbCategoria.ListItems[cmbCategoria.ItemIndex].TagObject).ID;

  // Busca os lançamentos com os filtros aplicados
  CarregaListaLancamentos(FFiltroTipo, FFiltroDataInicial, FFiltroDataFinal, FFiltroCategoria)
end;

procedure TfrmFluxoCaixa.btnInserirClick(Sender: TObject);
begin
  frmSelecaoLancamento.ShowModal;
end;

end.
