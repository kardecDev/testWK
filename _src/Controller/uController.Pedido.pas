unit uController.Pedido;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  uModel.Pedido,
  uModel.PedidoProduto,
  uService.Pedido,
  uDBConnection;

type
  TPedidoController = class
  private
    FService: TPedidoService;
    FPedido: TPedido;
    FItensPedido: TObjectList<TPedidoProduto>;
    FDBConnection: TDBConnection;
  public
    constructor Create;
    destructor Destroy; override;

    // M�todos para o estado do pedido
    procedure NovoPedido;
    procedure CarregarPedido(const aId: Integer);

    // M�todos de manipula��o do grid (itens do pedido)
    procedure AdicionarItem(const aIdProduto: Integer; const aQuantidade: Currency; const aVlrUnitario: Currency);
    procedure ExcluirItem(const aIndice: Integer);

    // M�todos para persist�ncia (comunica��o com a camada de servi�o)
    function SalvarPedido: Boolean;
    function ExcluirPedido(const aId: Integer): Boolean;

    // Propriedades para a View
    property Pedido: TPedido read FPedido;
    property ItensPedido: TObjectList<TPedidoProduto> read FItensPedido;
  end;

implementation

uses
  uModel.Cliente,
  uModel.Produto;

{ TPedidoController }

constructor TPedidoController.Create;
begin
  inherited Create;
  FDBConnection := TDBConnection.Create;
  FService := TPedidoService.Create(FDBConnection);
  FItensPedido := TObjectList<TPedidoProduto>.Create;
  FPedido := TPedido.Create;
end;

destructor TPedidoController.Destroy;
begin
  FService.Free;
  FItensPedido.Free;
  FPedido.Free;
  inherited Destroy;
end;

procedure TPedidoController.NovoPedido;
begin
  FPedido.Free;
  FPedido := TPedido.Create;

  FItensPedido.Clear;
end;

procedure TPedidoController.CarregarPedido(const aId: Integer);
var
  LListaObjetos: TObjectList<TObject>;
  LObjeto: TObject;
begin
  LListaObjetos := FService.CarregarPorId(aId);
  if Assigned(LListaObjetos) and (LListaObjetos.Count > 0) then
  begin
    FItensPedido.Clear;
    // O primeiro objeto � o cabe�alho do pedido
    FPedido := LListaObjetos[0] as TPedido;

    // Os demais s�o os itens
    for LObjeto in LListaObjetos do
    begin
      if LObjeto is TPedidoProduto then
      begin
        FItensPedido.Add(LObjeto as TPedidoProduto);
      end;
    end;
  end;
end;

procedure TPedidoController.AdicionarItem(const aIdProduto: Integer; const aQuantidade: Currency; const aVlrUnitario: Currency);
var
  LItem: TPedidoProduto;
begin
  LItem := TPedidoProduto.Create;
  LItem.codigo_produto := aIdProduto;
  LItem.quantidade := aQuantidade;
  LItem.vlr_unitario := aVlrUnitario;
  LItem.vlr_total := aQuantidade * aVlrUnitario;
  FItensPedido.Add(LItem);
end;

procedure TPedidoController.ExcluirItem(const aIndice: Integer);
begin
  if (aIndice >= 0) and (aIndice < FItensPedido.Count) then
  begin
    FItensPedido.Delete(aIndice);
  end;
end;

function TPedidoController.SalvarPedido: Boolean;
begin
  // A l�gica de salvar � passada para a camada de servi�o
  Result := FService.Salvar(FPedido, FItensPedido);
end;

function TPedidoController.ExcluirPedido(const aId: Integer): Boolean;
begin
  // A l�gica de excluir � passada para a camada de servi�o
  Result := FService.Excluir(aId);
end;

end.
