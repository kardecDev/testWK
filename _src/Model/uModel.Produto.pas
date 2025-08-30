unit uModel.Produto;

interface

uses
  System.SysUtils;

type
  [Tabela('produtos')]
  [Coluna('codigo', true, true, false)]
  [Coluna('descricao')]
  [Coluna('preco_venda')]
  TProduto = class
  private
    Fcodigo: Integer;
    Fdescricao: String;
    FprecoVenda: Currency;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property descricao: String read Fdescricao write Fdescricao;
    property preco_venda: Currency read FprecoVenda write FprecoVenda;
  end;

implementation

end.
