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

    // Métodos para o estado do pedido
    procedure NovoPedido;
    procedure CarregarPedido(const aId: Integer);

    // Métodos de manipulação do grid (itens do pedido)
    procedure AdicionarItem(const aIdProduto: Integer; const aQuantidade: Currency; const aVlrUnitario: Currency);
    procedure ExcluirItem(const aIndice: Integer);

    // Métodos para persistência (comunicação com a camada de serviço)
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
    // O primeiro objeto é o cabeçalho do pedido
    FPedido := LListaObjetos[0] as TPedido;

    // Os demais são os itens
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
  // A lógica de salvar é passada para a camada de serviço
  Result := FService.Salvar(FPedido, FItensPedido);
end;

function TPedidoController.ExcluirPedido(const aId: Integer): Boolean;
begin
  // A lógica de excluir é passada para a camada de serviço
  Result := FService.Excluir(aId);
end;

end.
