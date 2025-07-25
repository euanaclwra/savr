unit uFrmDialog;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  FMX.Types, FMX.Controls, FMX.Forms, FMX.Graphics, FMX.Dialogs, FMX.Objects,
  FMX.Controls.Presentation, FMX.StdCtrls, FMX.Effects;

type
  TConfirmCallback = reference to procedure;

  TfrmDialog = class(TForm)
    iconConfirm: TImage;
    iconSuccess: TImage;
    titleMessage: TText;
    txtMessage: TText;
    btnOk: TSpeedButton;
    StyleBook1: TStyleBook;
    btnYes: TSpeedButton;
    btnNo: TSpeedButton;
    rtBackground: TRectangle;
    fxShadowBackground: TShadowEffect;
    procedure btnYesClick(Sender: TObject);
    procedure btnNoClick(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
  private

  public
    class function ShowConfirmDialog(Msg: String): Boolean;
    class procedure ShowSuccessDialog(Msg: String);
  end;

var
  frmDialog: TfrmDialog;

implementation

{$R *.fmx}

procedure TfrmDialog.btnNoClick(Sender: TObject);
begin
  ModalResult := mrNone;
end;

procedure TfrmDialog.btnOkClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

procedure TfrmDialog.btnYesClick(Sender: TObject);
begin
  ModalResult := mrYes;
end;

class function TfrmDialog.ShowConfirmDialog(Msg: String): Boolean;
var
  Dialog: TfrmDialog;
begin
  Dialog := TfrmDialog.Create(nil);

  try
    // Ativa os elementos visuais de confirma��o
    Dialog.btnNo.Visible := True;
    Dialog.btnYes.Visible := True;
    Dialog.iconConfirm.Visible := True;
    Dialog.iconSuccess.Visible := False;
    Dialog.btnOk.Visible := False;

    // Define o t�tulo e o texto da mensagem
    Dialog.titleMessage.Text := 'Espere!';
    Dialog.txtMessage.Text := Msg;

    // Exibe o pop-up
    Result := Dialog.ShowModal = mrYes;
  finally
    Dialog.DisposeOf;
  end;
end;

class procedure TfrmDialog.ShowSuccessDialog(Msg: string);
var
  Dialog: TfrmDialog;
begin
  Dialog := TfrmDialog.Create(nil);

  // Ativa os elementos visuais de sucesso
  Dialog.btnNo.Visible := False;
  Dialog.btnYes.Visible := False;
  Dialog.iconConfirm.Visible := False;
  Dialog.iconSuccess.Visible := True;
  Dialog.btnOk.Visible := True;

  // Define o t�tulo e o texto da mensagem
  Dialog.titleMessage.Text := 'Sucesso!';
  Dialog.txtMessage.Text := Msg;

  // Exibe o pop-up
  Dialog.Show;
end;

end.
