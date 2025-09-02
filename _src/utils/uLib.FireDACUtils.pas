unit uLib.FireDACUtils;

interface

uses
  System.SysUtils, System.Generics.Collections, Data.DB, FireDAC.Comp.Client,
  FireDAC.Comp.DataSet, System.Rtti, System.TypInfo;

type
  TFireDACHelper = class
  public
    class procedure BindList(const AList: TObjectList<TObject>; const ADataSet: TFDMemTable);
  end;

implementation

uses FireDAC.Stan.Intf;

function RttiTypeToFieldType(const ARttiType: TRttiType): TFieldType;
begin
  if (ARttiType.TypeKind = TTypeKind.tkInteger) then
    Result := ftInteger
  else if (ARttiType.TypeKind = TTypeKind.tkFloat) then
    Result := ftFloat
  else if (ARttiType.TypeKind = TTypeKind.tkString) or (ARttiType.TypeKind = TTypeKind.tkLString) or (ARttiType.TypeKind = TTypeKind.tkWString) then
    Result := ftString
  else if (ARttiType.TypeKind = TTypeKind.tkChar) then
    Result := ftString
  else if (ARttiType.TypeKind = TTypeKind.tkEnumeration) and (ARttiType.ToString = 'TDateTime') then
    Result := ftDateTime
  else
    Result := ftUnknown; // Tipo de dado desconhecido
end;


class procedure TFireDACHelper.BindList(const AList: TObjectList<TObject>; const ADataSet: TFDMemTable);
var
  LContext: TRttiContext;
  LType: TRttiType;
  LFieldDef: TFieldDef;
  LInstance: TObject;
  LProp: TRttiProperty;
  LFieldType: TFieldType;
begin
  ADataSet.Close;
  ADataSet.FieldDefs.Clear;

  if (AList = nil) or (AList.Count = 0) then
  begin
    Exit;
  end;

  LInstance := AList[0];
  LContext := TRttiContext.Create;
  LType := LContext.GetType(LInstance.ClassInfo);

  // Cria as definições de campo com base nas propriedades do objeto
  for LProp in LType.GetProperties do
  begin
    LFieldType := RttiTypeToFieldType(LProp.PropertyType);
    if LFieldType <> ftUnknown then
      ADataSet.FieldDefs.Add(LProp.Name, LFieldType, 0, False);
  end;

  // Abre o dataset com os campos definidos
  ADataSet.CreateDataSet;
  ADataSet.EmptyDataSet;

  // Preenche o dataset com os dados da lista
  for LInstance in AList do
  begin
    ADataSet.Append;
    for LProp in LType.GetProperties do
    begin
      try
        ADataSet.FieldByName(LProp.Name).AsVariant := LProp.GetValue(LInstance).AsVariant;
      except
        // Ignora campos que não puderam ser preenchidos, como métodos RTTI ou propriedades sem valor.
      end;
    end;
    ADataSet.Post;
  end;
end;

end.
