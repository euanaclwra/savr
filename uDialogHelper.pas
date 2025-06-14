unit uDialogHelper;

interface
uses
  System.SysUtils, System.UITypes, FMX.DialogService;

type
  TDialogHelper = class
  public
    class procedure Confirmar(const Msg: String; const OnConfirm: TProc);
  end;

implementation

class procedure TDialogHelper.Confirmar(const Msg: string; const OnConfirm: TProc);
begin
    TDialogService.MessageDialog(Msg,
    TMsgDlgType.mtConfirmation,
    [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo],
    TMsgDlgBtn.mbNo,
    0,
    procedure(const AResult: TModalResult)
    begin
      if AResult = mrYes then
        OnConfirm();
    end);
end;

end.
