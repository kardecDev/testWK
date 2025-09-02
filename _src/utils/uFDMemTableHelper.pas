unit uFDMemTableHelper;

interface

uses
  Data.DB, FireDAC.Comp.DataSet, System.Generics.Collections, System.Rtti, System.SysUtils,
  FireDAC.Comp.Client;

type
  TFDMemTableHelper = class
  public
    class procedure BindList(const AList: TObjectList<TObject>; const ADataSet: TFDMemTable);
  end;

implementation

uses
  System.Classes;

{ TFDMemTableHelper }

class procedure TFDMemTableHelper.BindList(const AList: TObjectList<TObject>; const ADataSet: TFDMemTable);
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LObject: TObject;
  LFieldDefItem: TCollectionItem;
  LFieldDef: TFieldDef;
begin
  ADataSet.DisableControls;
  try
    // Se a estrutura do dataset ainda não foi criada, fazemos isso agora
    if ADataSet.FieldDefs.Count = 0 then
    begin
      // A estrutura só pode ser criada se houver pelo menos um item na lista
      if not ((AList = nil) or (AList.Count = 0)) then
      begin
        LContext := TRttiContext.Create;
        try
          LObject := AList.First;
          LType := LContext.GetType(LObject.ClassInfo);

          for LProp in LType.GetProperties do
          begin
            case LProp.PropertyType.TypeKind of
              tkInteger, tkInt64: ADataSet.FieldDefs.Add(LProp.Name, ftInteger, 0, False);
              tkFloat: ADataSet.FieldDefs.Add(LProp.Name, ftFloat, 0, False);
              tkString, tkLString, tkWString, tkUString: ADataSet.FieldDefs.Add(LProp.Name, ftString, 50, False);
              tkDynArray: if LProp.PropertyType.Name = 'TBytes' then ADataSet.FieldDefs.Add(LProp.Name, ftBytes, 0, False);
              tkEnumeration: ADataSet.FieldDefs.Add(LProp.Name, ftInteger, 0, False);
            end;
          end;
          ADataSet.CreateDataSet;
        finally
          LContext.Free;
        end;
      end
      else
      begin
        // Se a lista está vazia, não podemos criar a estrutura, então saímos
        // O dataset será aberto logo a seguir
        Exit;
      end;
    end;

    // A partir daqui, o dataset já tem estrutura.
    // Garante que o dataset esteja aberto antes de qualquer operação
    if not ADataSet.Active then
      ADataSet.Open;

    ADataSet.EmptyDataSet; // Limpa o conteúdo para recarregar

    // Se a lista estiver vazia após a criação da estrutura, não há mais nada a fazer
    if (AList = nil) or (AList.Count = 0) then
      Exit;

    // Popula o dataset com os dados da lista
    LContext := TRttiContext.Create;
    try
      LObject := AList.First;
      LType := LContext.GetType(LObject.ClassInfo);

      for LObject in AList do
      begin
        ADataSet.Append;
        for LFieldDefItem in ADataSet.FieldDefs do
        begin
          LFieldDef := TFieldDef(LFieldDefItem);
          LProp := LType.GetProperty(LFieldDef.Name);
          if Assigned(LProp) then
          begin
            ADataSet.FieldByName(LFieldDef.Name).AsVariant := LProp.GetValue(LObject).AsVariant;
          end;
        end;
        ADataSet.Post;
      end;
    finally
      LContext.Free;
    end;

  finally
    ADataSet.EnableControls;
  end;
end;

end.
