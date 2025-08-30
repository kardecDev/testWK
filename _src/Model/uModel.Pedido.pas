unit uModel.Pedido;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  uModel.PedidoProduto;

type
  [Tabela('pedido_dados_gerais')]
  [Coluna('numero_pedido', true, true, false)]
  [Coluna('data_emissao')]
  [Coluna('codigo_cliente')]
  [Coluna('valor_total')]
  TPedido = class
  private
    FnumeroPedido: Integer;
    FdataEmissao: TDate;
    FcodigoCliente: Integer;
    FvalorTotal: Currency;
    FItens: TObjectList<TPedidoProduto>;
  public
    constructor Create;
    destructor Destroy; override;
  published
    property numero_pedido: Integer read FnumeroPedido write FnumeroPedido;
    property data_emissao: TDate read FdataEmissao write FdataEmissao;
    property codigo_cliente: Integer read FcodigoCliente write FcodigoCliente;
    property valor_total: Currency read FvalorTotal write FvalorTotal;
    property Itens: TObjectList<TPedidoProduto> read FItens write FItens;
  end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
  inherited;
  FItens := TObjectList<TPedidoProduto>.Create;
end;

destructor TPedido.Destroy;
begin
  FItens.Free;
  inherited;
end;

end.
