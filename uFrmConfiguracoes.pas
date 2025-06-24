unit uFrmConfiguracoes;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Layouts, uFrmConfigUsuario,
  uFrmConfigRenda;

type
  TfrmConfiguracoes = class(TForm)
    txtConfiguracoes: TText;
    ltConfig: TLayout;
    btnUsuario: TSpeedButton;
    txtUsuario: TText;
    imgUsuario: TImage;
    lnUsuario: TLine;
    imgArrowUsuario: TImage;
    btnRenda: TSpeedButton;
    txtRenda: TText;
    imgRenda: TImage;
    Line1: TLine;
    imgArrowRenda: TImage;
    procedure btnUsuarioClick(Sender: TObject);
    procedure btnRendaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmConfiguracoes: TfrmConfiguracoes;

implementation

{$R *.fmx}

procedure TfrmConfiguracoes.btnRendaClick(Sender: TObject);
begin
  frmConfigRenda.Show;
end;

procedure TfrmConfiguracoes.btnUsuarioClick(Sender: TObject);
begin
  frmConfigUsuario.Show;
end;

end.
