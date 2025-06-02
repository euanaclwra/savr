unit uFrmCategorias;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Layouts,
  FMX.ListBox, FMX.Objects, uCategoria, System.Generics.Collections, uCategoriaDAO;

type
  TfrmCategorias = class(TForm)
    txtCategorias: TText;
    lbCategorias: TListBox;
    lbItem: TListBoxItem;
    StyleBook1: TStyleBook;
    procedure FormShow(Sender: TObject);
  private
    procedure CarregaListaCategorias;
  public
    { Public declarations }
  end;

var
  frmCategorias: TfrmCategorias;

implementation

{$R *.fmx}

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
        Item.Text := Categoria.Nome;
        Item.Parent := lbCategorias;
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

procedure TfrmCategorias.FormShow(Sender: TObject);
begin
  CarregaListaCategorias;
end;

end.
