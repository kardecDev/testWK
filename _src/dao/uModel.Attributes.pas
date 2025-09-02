unit uModel.Attributes;

interface

uses
  System.SysUtils,
  System.Rtti;

type
  TabelaAttribute = class(TCustomAttribute)
  private
    Fnome: string;
  public
    constructor Create(const aNome: string);
    property nome: string read Fnome;
  end;

  ColunaAttribute = class(TCustomAttribute)
  private
    Fnome: string;
    FisPrimaryKey: Boolean;
    FisAutoIncrement: Boolean;
    FisReadOnly: Boolean;
  public
    constructor Create(const aNome: string; aIsPrimaryKey: Boolean = False;
      aIsAutoIncrement: Boolean = False; aIsReadOnly: Boolean = False);
    property nome: string read Fnome;
    property IsPrimaryKey: Boolean read FisPrimaryKey;
    property IsAutoIncrement: Boolean read FisAutoIncrement;
    property IsReadOnly: Boolean read FisReadOnly;
  end;

implementation

{ TabelaAttribute }

constructor TabelaAttribute.Create(const aNome: string);
begin
  Fnome := aNome;
end;

{ ColunaAttribute }

constructor ColunaAttribute.Create(const aNome: string; aIsPrimaryKey,
  aIsAutoIncrement, aIsReadOnly: Boolean);
begin
  Fnome := aNome;
  FisPrimaryKey := aIsPrimaryKey;
  FisAutoIncrement := aIsAutoIncrement;
  FisReadOnly := aIsReadOnly;
end;

end.
