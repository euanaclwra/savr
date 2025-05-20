unit uEditMoeda;

interface

uses
  System.SysUtils, System.Classes, FMX.Edit, FMX.Types, FMX.Controls;

type
  TEditMoeda = class(TEdit)
  private
    FInChange: Boolean;
    procedure HandleTyping(Sender: TObject);
    procedure FormatarTextoComoMoeda;
  protected
    procedure DoEnter; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

procedure Register;

implementation

{ TEditMoeda }

procedure Register;
begin
  RegisterComponents('Savr', [TEditMoeda]);
end;

constructor TEditMoeda.Create(AOwner: TComponent);
begin
  inherited;
  KeyboardType := TVirtualKeyboardType.NumberPad;
  FilterChar := '0123456789';
  OnTyping := HandleTyping;
end;

procedure TEditMoeda.DoEnter;
begin
  inherited;
  SelectAll;
end;

procedure TEditMoeda.HandleTyping(Sender: TObject);
begin
  if not FInChange then
    FormatarTextoComoMoeda;
end;

procedure TEditMoeda.FormatarTextoComoMoeda;
var
  TextoLimpo: string;
  V: Currency;
begin
  FInChange := True;
  try
    TextoLimpo := Text.Replace('R$', '', [rfReplaceAll]);
    TextoLimpo := TextoLimpo.Replace('.', '', [rfReplaceAll]);
    TextoLimpo := TextoLimpo.Replace(',', '', [rfReplaceAll]);
    TextoLimpo := Trim(TextoLimpo);

    if TextoLimpo = '' then
      TextoLimpo := '0';

    if TryStrToCurr(TextoLimpo, V) then
      Text := FormatFloat('"R$" #,##0.00', V / 100)
    else
      Text := 'R$ 0,00';

    CaretPosition := Length(Text);
  finally
    FInChange := False;
  end;
end;

end.

