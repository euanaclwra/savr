unit uFrmCategorias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects, uCategoria, System.Generics.Collections, uCategoriaDAO,
  uUtils, FMX.Controls.Presentation, FMX.StdCtrls, uFrmNovaCategoria;

type
  TfrmCategorias = class(TForm)
    txtCategorias: TText;
    lbCategorias: TListBox;
    StyleBook1: TStyleBook;
    ltHeader: TLayout;
    rtHeader: TRectangle;
    txtLabelName: TText;
    txtLabelType: TText;
    ltListaCategorias: TLayout;
    btnInserir: TSpeedButton;
    rtInserir: TRectangle;
    txtInserir: TText;
    procedure FormShow(Sender: TObject);
    procedure btnInserirClick(Sender: TObject);
  private
    procedure CarregaListaCategorias;
    procedure PreencheLabelsItemCategoria(AItem: TListBoxItem; ACategoria: TCategoria);
  public
    { Public declarations }
  end;

var
  frmCategorias: TfrmCategorias;

implementation

{$R *.fmx}

procedure TfrmCategorias.btnInserirClick(Sender: TObject);
begin
  frmNovaCategoria.Show;
end;

procedure TfrmCategorias.CarregaListaCategorias;
var
  DAO: TCategoriaDAO;
  Lista: TObjectList<TCategoria>;
  Categoria: TCategoria;
  Item: TListBoxItem;
begin
  try
    DAO := TCategoriaDAO.Create;
    Lista := DAO.BuscarCategorias;

    if Lista <> nil then
    try
      for Categoria in Lista do
      begin
        Item := TListBoxItem.Create(lbCategorias);
        PreencheLabelsItemCategoria(Item, Categoria)
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

procedure TfrmCategorias.PreencheLabelsItemCategoria(AItem: TListBoxItem; ACategoria: TCategoria);
var
  LabelNome, LabelTipo: TText;
begin
  AItem.Parent := lbCategorias;
  AItem.StyleLookup :=  'itemCategoriaStyle';
  LabelNome := TText(AItem.FindStyleResource('nametext'));
  LabelTipo := TText(AItem.FindStyleResource('typetext'));

  if Assigned(LabelNome) then
    LabelNome.Text := ACategoria.Nome;

  if Assigned(LabelTipo) then
    LabelTipo.Text := CatToStr(ACategoria.Tipo);
end;

procedure TfrmCategorias.FormShow(Sender: TObject);
begin
  CarregaListaCategorias;
end;

end.
