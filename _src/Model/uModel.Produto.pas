unit uModel.Produto;

interface

uses
  System.SysUtils,
  uModel.Attributes;

type
  [Tabela('produtos')]
  TProduto = class
  private
    Fcodigo: Integer;
    Fdescricao: String;
    FprecoVenda: Currency;
  published
    [Coluna('codigo', true, true, false)]
    property codigo: Integer read Fcodigo write Fcodigo;
    [Coluna('descricao')]
    property descricao: String read Fdescricao write Fdescricao;
    [Coluna('preco_venda')]
    property preco_venda: Currency read FprecoVenda write FprecoVenda;
  end;

implementation

end.
