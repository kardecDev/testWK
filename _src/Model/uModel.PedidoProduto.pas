unit uModel.PedidoProduto;

interface

uses
  System.SysUtils,
  uModel.Attributes;

type
  [Tabela('pedido_produtos')]
  TPedidoProduto = class
  private
    FidProduto: Integer;
    FnumeroPedido: Integer;
    FcodigoProduto: Integer;
    Fquantidade: Currency;
    FvlrUnitario: Currency;
    FvlrTotal: Currency;
    FDescricao: String;
  published
    [Coluna('id_produto', true, false, false)]
    property id_produto: Integer read FidProduto write FidProduto;
    [Coluna('numero_pedido')]
    property numero_pedido: Integer read FnumeroPedido write FnumeroPedido;
    [Coluna('codigo_produto')]
    property codigo_produto: Integer read FcodigoProduto write FcodigoProduto;
    [Coluna('quantidade')]
    property quantidade: Currency read Fquantidade write Fquantidade;
    [Coluna('vlr_unitario')]
    property vlr_unitario: Currency read FvlrUnitario write FvlrUnitario;
    [Coluna('vlr_total')]
    property vlr_total: Currency read FvlrTotal write FvlrTotal;
    property Descricao: string read FDescricao write FDescricao;
  end;

implementation

end.
