unit uDAO.Base;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  uModel.Attributes,
  System.Rtti,
  System.TypInfo,
  Data.DB,
  System.Classes,
  FireDAC.Stan.Param;


type
  TBaseDAO<T: class, constructor> = class
  private
    FConnection: TFDConnection;
    FTableName: string;
    FPrimaryKeyName: string;
    FPrimaryKeyProperty: TRttiProperty;
  protected
    function GetTableName: string;
    procedure GetPrimaryInfo;
    function BuildInsertSQL: string;
    function BuildUpdateSQL(const aObject: T): string;
    procedure SetPropertyFromField(const aField: TField; const aProp: TRttiProperty; const aObject: TObject);
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    function Insert(const aObject: T): Boolean;
    function Update(const aObject: T): Boolean;
    function Delete(const aId: Integer): Boolean;
    function FindById(const aId: Integer): T;
    function FindAll: TObjectList<T>;
    function FindAllAsDataSet: TDataSet;

  end;

implementation

uses
  FireDAC.Comp.DataSet;

{ TBaseDAO<T> }

constructor TBaseDAO<T>.Create(aConnection: TFDConnection);
begin
  inherited Create;
  FConnection := aConnection;
  FTableName := GetTableName;
  GetPrimaryInfo;
end;

destructor TBaseDAO<T>.Destroy;
begin
  inherited Destroy;
end;

function TBaseDAO<T>.GetTableName: string;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LAttr: TCustomAttribute;
begin
  Result := '';
  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(T.ClassInfo);
    for LAttr in LType.GetAttributes do
    begin
      if LAttr is TabelaAttribute then
      begin
        Result := (LAttr as TabelaAttribute).nome;
        Exit;
      end;
    end;
  finally
    LContext.Free;
  end;
end;

procedure TBaseDAO<T>.GetPrimaryInfo;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LAttr: TCustomAttribute;
begin
  FPrimaryKeyName := '';
  FPrimaryKeyProperty := nil;

  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(T.ClassInfo);
    for LProp in LType.GetProperties do
    begin
      for LAttr in LProp.GetAttributes do
      begin
        if (LAttr is ColunaAttribute) and (LAttr as ColunaAttribute).IsPrimaryKey then
        begin
          FPrimaryKeyName := (LAttr as ColunaAttribute).nome;
          FPrimaryKeyProperty := LProp;
          Exit;
        end;
      end;
    end;
  finally
    LContext.Free;
  end;
end;

procedure TBaseDAO<T>.SetPropertyFromField(const aField: TField; const aProp: TRttiProperty; const aObject: TObject);
begin
  if not aField.IsNull then
  begin
    case aProp.PropertyType.TypeKind of
      tkInteger, tkInt64:
        aProp.SetValue(aObject, TValue.From<Integer>(aField.AsInteger));
      tkFloat:
        aProp.SetValue(aObject, TValue.From<Double>(aField.AsFloat));
      tkString, tkLString, tkWString, tkUString:
        aProp.SetValue(aObject, TValue.From<string>(aField.AsString));
      tkDynArray:
        if aProp.PropertyType.Name = 'TBytes' then
          aProp.SetValue(aObject, TValue.From<TBytes>(aField.AsBytes))
        else
          aProp.SetValue(aObject, TValue.From<Variant>(aField.AsVariant));
      tkEnumeration:
        aProp.SetValue(aObject, TValue.From<Integer>(aField.AsInteger));
      else
        aProp.SetValue(aObject, TValue.From<Variant>(aField.AsVariant));
    end;
  end;
end;

function TBaseDAO<T>.BuildInsertSQL: string;
var
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LAttr: TCustomAttribute;
  LFields: TStringList;
  LValues: TStringList;
begin
  LFields := TStringList.Create;
  LValues := TStringList.Create;
  try
    LContext := TRttiContext.Create;
    LType := LContext.GetType(T.ClassInfo);
    for LProp in LType.GetProperties do
    begin
      for LAttr in LProp.GetAttributes do
      begin
        if (LAttr is ColunaAttribute) and not (LAttr as ColunaAttribute).IsAutoIncrement then
        begin
          LFields.Add((LAttr as ColunaAttribute).nome);
          LValues.Add(':' + (LAttr as ColunaAttribute).nome);
        end;
      end;
    end;

    Result := Format('INSERT INTO %s (%s) VALUES (%s)', [FTableName, LFields.CommaText, LValues.CommaText]);
  finally
    LFields.Free;
    LValues.Free;
    LContext.Free;
  end;
end;

function TBaseDAO<T>.BuildUpdateSQL(const aObject: T): string;
var
  LSQL: string;
  LContext: TRttiContext;
  LType: TRttiType;
  LAttr: TCustomAttribute;
  LProp: TRttiProperty;
  LTableName: string;
  LSetClause: string;
  LWhereClause: string;
begin
  LContext := TRttiContext.Create;
  try
    LType := LContext.GetType(T.ClassInfo);

    // 1. Obtém o nome da tabela do TabelaAttribute
    for LAttr in LType.GetAttributes do
      if LAttr is TabelaAttribute then
      begin
        LTableName := (LAttr as TabelaAttribute).nome;
        break; // Sai do laço após encontrar o atributo
      end;

    // 2. Fallback: Se não encontrar o atributo, usa a regra de pluralização
    if LTableName = '' then
      LTableName := LType.Name.Replace('T', '', [rfIgnoreCase, rfReplaceAll]) + 's';

    LSetClause := '';
    LWhereClause := '';

    // 3. Constrói as cláusulas SET e WHERE
    for LProp in LType.GetProperties do
    begin
      for LAttr in LProp.GetAttributes do
      begin
        if LAttr is ColunaAttribute then
        begin
          if (LAttr as ColunaAttribute).IsPrimaryKey then
          begin
            LWhereClause := Format('%s = :%s', [(LAttr as ColunaAttribute).nome, (LAttr as ColunaAttribute).nome]);
          end
          else if not (LAttr as ColunaAttribute).IsReadOnly and not (LAttr as ColunaAttribute).IsAutoIncrement then
          begin
            if LSetClause <> '' then
              LSetClause := LSetClause + ', ';
            LSetClause := LSetClause + Format('%s = :%s', [(LAttr as ColunaAttribute).nome, (LAttr as ColunaAttribute).nome]);
          end;
        end;
      end;
    end;

    // 4. Constrói e retorna a string SQL final
    Result := Format('UPDATE %s SET %s WHERE %s', [LTableName, LSetClause, LWhereClause]);
  finally
    LContext.Free;
  end;
end;
function TBaseDAO<T>.Insert(const aObject: T): Boolean;
var
  LSQL: string;
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LAttr: TCustomAttribute;
  LCommand: TFDCommand;
  LQuery: TFDQuery;
begin
  Result := False;
  LSQL := BuildInsertSQL;

  LCommand := TFDCommand.Create(nil);
  try
    LCommand.Connection := FConnection;
    LCommand.CommandText.Text := LSQL;

    LContext := TRttiContext.Create;
    LType := LContext.GetType(T.ClassInfo);
    for LProp in LType.GetProperties do
    begin
      for LAttr in LProp.GetAttributes do
      begin
        if (LAttr is ColunaAttribute) and not (LAttr as ColunaAttribute).IsAutoIncrement then
        begin
          LCommand.ParamByName((LAttr as ColunaAttribute).nome).Value := LProp.GetValue(aObject as TObject).AsVariant;
        end;
      end;
    end;

    LCommand.Execute;
    Result := True;

    if LType.HasAttribute(TabelaAttribute) then
    begin
      for LProp in LType.GetProperties do
      begin
        for LAttr in LProp.GetAttributes do
        begin
          if (LAttr is ColunaAttribute) and (LAttr as ColunaAttribute).IsAutoIncrement then
          begin
            LQuery := TFDQuery.Create(nil);
            try
              LQuery.Connection := FConnection;
              LQuery.SQL.Text := 'SELECT LAST_INSERT_ID()';
              LQuery.Open;
              if not LQuery.IsEmpty then
              begin
                LProp.SetValue(aObject as TObject, TValue.From<Integer>(LQuery.Fields[0].AsInteger));
              end;
            finally
              LQuery.Free;
            end;
          end;
        end;
      end;
    end;

  finally
    LCommand.Free;
  end;
end;


function TBaseDAO<T>.Update(const aObject: T): Boolean;
var
  LSQL: string;
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LAttr: TCustomAttribute;
  LCommand: TFDCommand;
  LPrimaryKeyValue: TValue;
begin
  Result := False;
  LSQL := BuildUpdateSQL(aObject);
  LCommand := TFDCommand.Create(nil);
  try
    LCommand.Connection := FConnection;
    LCommand.CommandText.Text := LSQL;

    LContext := TRttiContext.Create;
    try
      LType := LContext.GetType(T.ClassInfo);
      for LProp in LType.GetProperties do
      begin
        for LAttr in LProp.GetAttributes do
        begin
          if LAttr is ColunaAttribute then
          begin
            // Vincula o parâmetro para a chave primária
            if (LAttr as ColunaAttribute).IsPrimaryKey then
            begin
              LCommand.ParamByName((LAttr as ColunaAttribute).nome).Value := LProp.GetValue(aObject as TObject).AsVariant;
            end
            // Vincula o parâmetro para as outras colunas
            else if not (LAttr as ColunaAttribute).IsReadOnly then
            begin
              LCommand.ParamByName((LAttr as ColunaAttribute).nome).Value := LProp.GetValue(aObject as TObject).AsVariant;
            end;
          end;
        end;
      end;
      LCommand.Execute;
      Result := True;
    finally
      LContext.Free;
    end;
  finally
    LCommand.Free;
  end;
end;

function TBaseDAO<T>.Delete(const aId: Integer): Boolean;
var
  LSQL: string;
  LCommand: TFDCommand;
begin
  Result := False;
  if FPrimaryKeyName = '' then
    Exit;

  LSQL := Format('DELETE FROM %s WHERE %s = :id', [FTableName, FPrimaryKeyName]);

  LCommand := TFDCommand.Create(nil);
  try
    LCommand.Connection := FConnection;
    LCommand.CommandText.Text := LSQL;
    LCommand.ParamByName('id').AsInteger := aId;
    LCommand.Execute;
    Result := True;
  finally
    LCommand.Free;
  end;
end;


function TBaseDAO<T>.FindById(const aId: Integer): T;
var
  LSQL: string;
  LQuery: TFDQuery;
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LAttr: TCustomAttribute;
begin
  Result := nil;
  if FPrimaryKeyName = '' then
    Exit;

  LSQL := Format('SELECT * FROM %s WHERE %s = :id', [FTableName, FPrimaryKeyName]);

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Text := LSQL;
    LQuery.ParamByName('id').AsInteger := aId;
    LQuery.Open;

    if not LQuery.IsEmpty then
    begin
      Result := T.Create;
      LContext := TRttiContext.Create;
      LType := LContext.GetType(T.ClassInfo);
      for LProp in LType.GetProperties do
      begin
        for LAttr in LProp.GetAttributes do
        begin
          if LAttr is ColunaAttribute then
          begin
            SetPropertyFromField(LQuery.FieldByName((LAttr as ColunaAttribute).nome), LProp, Result as TObject);
          end;
        end;
      end;
    end;
  finally
    LQuery.Free;
  end;
end;

function TBaseDAO<T>.FindAll: TObjectList<T>;
var
  LSQL: string;
  LQuery: TFDQuery;
  LContext: TRttiContext;
  LType: TRttiType;
  LProp: TRttiProperty;
  LAttr: TCustomAttribute;
  LObject: T;
begin
  Result := TObjectList<T>.Create;
  LSQL := Format('SELECT * FROM %s', [FTableName]);

  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Text := LSQL;
    LQuery.Open;

    LContext := TRttiContext.Create;
    LType := LContext.GetType(T.ClassInfo);

    while not LQuery.EOF do
    begin
      LObject := T.Create;
      for LProp in LType.GetProperties do
      begin
        for LAttr in LProp.GetAttributes do
        begin
          if LAttr is ColunaAttribute then
          begin
            SetPropertyFromField(LQuery.FieldByName((LAttr as ColunaAttribute).nome), LProp, LObject as TObject);
          end;
        end;
      end;
      Result.Add(LObject);
      LQuery.Next;
    end;
  finally
    LQuery.Free;
  end;
end;

function TBaseDAO<T>.FindAllAsDataSet: TDataSet;
var
  LQuery: TFDQuery;
begin
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Text := 'SELECT * FROM ' + GetTableName;
    LQuery.Open;
    Result := TFDMemTable.Create(nil);
    TFDMemTable(Result).CloneCursor(LQuery, True, True);
  finally
    LQuery.Free;
  end;
end;

end.
