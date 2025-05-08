unit uMain;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.TabControl,
  FMX.Controls.Presentation, FMX.MultiView, FMX.Objects, FMX.StdCtrls,
  FMX.Layouts, FMX.Ani;

type
  TfrmMain = class(TForm)
    tbcMain: TTabControl;
    StyleBook1: TStyleBook;
    itm_home: TTabItem;
    itm_config: TTabItem;
    mtvMenu: TMultiView;
    btnConfig: TSpeedButton;
    btnHome: TSpeedButton;
    imgConfig: TImage;
    imgHome: TImage;
    btnSair: TSpeedButton;
    imgSair: TImage;
    txtHome: TText;
    txtConfig: TText;
    txtSair: TText;
    procedure btnSairClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

{$R *.fmx}

procedure TfrmMain.btnSairClick(Sender: TObject);
begin
  Application.Terminate;
end;

end.
