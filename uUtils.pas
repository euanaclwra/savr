unit uUtils;

interface
  uses
    SysUtils, Vcl.Controls, Vcl.Forms, FMX.Edit, Vcl.Graphics,
    FMX.Objects, FMX.Types;

  type
    TDataType = (Texto, Inteiro, Moeda, Data);
    function ValidarDados(AValue:String; AType:TDataType): Boolean;
    function StrToBool(AText:String): Boolean;
    function CurrencyToFloat(AValue:String): Double;
    procedure ExibirMensagemErro(ACampo: TEdit);
implementation

function CurrencyToFloat(AValue:String): Double;
begin
  var
    CleanText: string;
  begin
    CleanText := StringReplace(AValue, 'R$', '', [rfReplaceAll]);
    CleanText := StringReplace(CleanText, '.', '', [rfReplaceAll]);
    CleanText := StringReplace(CleanText, ' ', '', [rfReplaceAll]);

    Result := StrToFloatDef(CleanText, 0);
  end;
end;

function StrToBool(AText:String): Boolean;
begin
  Result := SameText(Trim(AText), 'Sim');
end;

function ValidarDados(AValue:String; AType:TDataType): Boolean;
var
  IntegerNumber: Integer;
  DoubleNumber: Double;
  ValidDate: TDateTime;
begin
  Result := False;

  case AType of
    Texto:
      Result := Trim(AValue) <> '';
    Inteiro:
      Result := TryStrToInt(AValue, IntegerNumber);
    Moeda:
      Result := CurrencyToFloat(AValue) > 0;
    Data:
      Result := TryStrToDate(AValue, ValidDate);
  end;
end;

procedure ExibirMensagemErro(ACampo: TEdit);
var
   TxtError: TText;
begin
  if Assigned(ACampo.TagObject) and (ACampo.TagObject is TText) then
    TxtError := TText(ACampo.TagObject)
  else
  begin
    TxtError := TText.Create(ACampo.Owner);
    TxtError.Parent := ACampo.Parent;
    ACampo.TagObject := TxtError;

    TxtError.TextSettings.Font.Family := 'Montserrat';
    TxtError.TextSettings.Font.Size := 10;
    TxtError.TextSettings.FontColor := $FF952727;
  end;

  TxtError.Text := 'Opa! Digite um valor válido...';
  TxtError.Position.X := ACampo.Position.X;
  TxtError.Position.Y := ACampo.Position.Y + ACampo.Height + 5;
  TxtError.Height := 20;
  TxtError.Width := ACampo.Width;
  TxtError.HorzTextAlign := TTextAlign.Leading;
  TxtError.Visible := True;
end;

end.
