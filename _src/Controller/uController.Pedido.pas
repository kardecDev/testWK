unit uController.Pedido;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  Data.DB,
  System.Rtti,
  //Models
  uModel.Pedido,
  uModel.PedidoProduto,
  uModel.Cliente,
  uModel.Produto,
  //Services
  uService.Pedido,
  uService.Cliente,
  uService.Produto,
  uDBConnection;

type
  TPedidoController = class
  private
    FConnection: TDBConnection;
    FService: TPedidoService;
    FClienteService: TClienteService;
    FProdutoService: TProdutoService;
    FPedido: TPedido;
    FItensPedido: TObjectList<TPedidoProduto>;
  public
    constructor Create;
    destructor Destroy; override;

    // Métodos para o estado do pedido
    procedure NovoPedido;
    function CarregarPedido(const aNumero_Pedido: Integer): Boolean;

    // Métodos de manipulação do grid (itens do pedido)
    procedure AdicionarItem(const aIdProduto: Integer; const aQuantidade: Currency; const aVlrUnitario: Currency);
    procedure ExcluirItem(const aIndice: Integer);

    // Métodos para persistência (comunicação com a camada de serviço)
    function SalvarPedido: Boolean;
    function ExcluirPedido(const aId: Integer): Boolean;

    // Métodos para a busca de dados na camada de serviço
    function FindAllClientes: TDataSet;
    function FindAllProdutos: TDataSet;

    // Busca cliente e produto por ID
    function BuscarProdutoPorId(const aId: Integer): TProduto;
    function BuscarClientePorId(const aId: Integer): TCliente;

    // Propriedades para a View
    property Pedido: TPedido read FPedido;
    property ItensPedido: TObjectList<TPedidoProduto> read FItensPedido;
  end;

implementation

uses
  Vcl.Dialogs;

{ TPedidoController }

constructor TPedidoController.Create;
begin
  inherited Create;
  FService := TPedidoService.Create;
  FClienteService := TClienteService.Create;
  FProdutoService := TProdutoService.Create;
  FPedido := TPedido.Create;
  FItensPedido := TObjectList<TPedidoProduto>.Create;
end;

destructor TPedidoController.Destroy;
begin
  FService.Free;
  FClienteService.Free;
  FProdutoService.Free;
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

function TPedidoController.CarregarPedido(const aNumero_Pedido: Integer): Boolean;
begin
  // Tenta carregar o objeto TPedido completo do Service
  FPedido := FService.CarregarPedidoPorNumeroPedido(aNumero_Pedido);

  // Verifica se o pedido foi encontrado
  Result := Assigned(FPedido);

  if Result then
  begin
    // Se o pedido existe, carrega a lista de itens
    FItensPedido := FService.CarregarItensDoPedido(FPedido.numero_pedido);
  end
  else
  begin
    // Se o pedido não foi encontrado, cria um novo pedido vazio
    FreeAndNil(FPedido);
    FPedido := TPedido.Create;
    FItensPedido.clear;
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
  FPedido.valor_total := FService.CalcularValorTotal(FItensPedido) ;
end;

procedure TPedidoController.ExcluirItem(const aIndice: Integer);
begin
  if (aIndice >= 0) and (aIndice < FItensPedido.Count) then
  begin
    FItensPedido.Delete(aIndice);
  end;
  FPedido.valor_total := FService.CalcularValorTotal(FItensPedido);
end;

function TPedidoController.BuscarClientePorId(const aId: Integer): TCliente;
begin
  Result := FClienteService.FindById(aId);
end;

function TPedidoController.BuscarProdutoPorId(const aId: Integer): TProduto;
begin
  Result := FProdutoService.FindById(aId);
end;

function TPedidoController.SalvarPedido: Boolean;
begin
  Result := FService.Salvar(FPedido, FItensPedido);
end;

function TPedidoController.ExcluirPedido(const aId: Integer): Boolean;
begin
  Result := FService.Excluir(aId);
end;

function TPedidoController.FindAllClientes: TDataSet;
begin
  Result := FClienteService.FindAll;
end;

function TPedidoController.FindAllProdutos: TDataSet;
begin
  Result := FProdutoService.FindAll;
end;

end.
