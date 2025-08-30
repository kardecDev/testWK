unit uModel.PedidoProduto;

interface

uses
  System.SysUtils;

type
  [Tabela('pedido_produtos')]
  [Coluna('id_produto', true, false, false)]
  [Coluna('numero_pedido')]
  [Coluna('codigo_produto')]
  [Coluna('quantidade')]
  [Coluna('vlr_unitario')]
  [Coluna('vlr_total')]
  TPedidoProduto = class
  private
    FidProduto: Integer;
    FnumeroPedido: Integer;
    FcodigoProduto: Integer;
    Fquantidade: Currency;
    FvlrUnitario: Currency;
    FvlrTotal: Currency;
  published
    property id_produto: Integer read FidProduto write FidProduto;
    property numero_pedido: Integer read FnumeroPedido write FnumeroPedido;
    property codigo_produto: Integer read FcodigoProduto write FcodigoProduto;
    property quantidade: Currency read Fquantidade write Fquantidade;
    property vlr_unitario: Currency read FvlrUnitario write FvlrUnitario;
    property vlr_total: Currency read FvlrTotal write FvlrTotal;
  end;

implementation

end.
