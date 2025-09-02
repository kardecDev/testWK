unit uService.Pedido;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  uDAO.Base,
  uDAO.Pedido,
  uModel.Pedido,
  uModel.PedidoProduto,
  uModel.Cliente,
  uModel.Produto,
  uDBConnection;

type
  TPedidoService = class
  private
    FConnection: TFDConnection;
    FDaoPedido: TBaseDAO<TPedido>;
    FDaoPedidoProduto: TBaseDAO<TPedidoProduto>;
    FDaoPedidoEspecializado: TPedidoDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function Salvar(aPedido: TPedido; aItens: TObjectList<TPedidoProduto>): Boolean;
    function Excluir(const aNumero_Pedido: Integer): Boolean;
    function CalcularValorTotal(aItens: TObjectList<TPedidoProduto>): Currency;
    function CarregarPedidoPorNumeroPedido(const aNumero_Pedido: Integer): TPedido;
    function CarregarItensDoPedido(const aNumero_Pedido: Integer): TObjectList<TPedidoProduto>;
  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create;
begin
  inherited Create;
  FConnection := TDBConnection.GetConnection;
  FDaoPedido := TBaseDAO<TPedido>.Create(FConnection);
  FDaoPedidoProduto := TBaseDAO<TPedidoProduto>.Create(FConnection);
  FDaoPedidoEspecializado := TPedidoDAO.Create(FConnection);
end;

destructor TPedidoService.Destroy;
begin
  FDaoPedido.Free;
  FDaoPedidoProduto.Free;
  FDaoPedidoEspecializado.Free;
  inherited Destroy;
end;

function TPedidoService.CalcularValorTotal(aItens: TObjectList<TPedidoProduto>): Currency;
var
  LItem: TPedidoProduto;
begin
  Result := 0;
  for LItem in aItens do
  begin
    Result := Result + LItem.vlr_total;
  end;
end;

function TPedidoService.Salvar(aPedido: TPedido; aItens: TObjectList<TPedidoProduto>): Boolean;
var
  LItem: TPedidoProduto;
begin
  FConnection.StartTransaction;
  try
    if aPedido.numero_pedido = 0 then
      FDaoPedido.Insert(aPedido)
    else
      FDaoPedido.Update(aPedido);

    // Apaga os itens antigos usando o DAO especializado
    if aPedido.numero_pedido > 0 then
       FDaoPedidoEspecializado.ExcluirItensPedido(aPedido.numero_pedido);

    // Insere os novos itens
    for LItem in aItens do
    begin
      LItem.numero_pedido := aPedido.numero_pedido;
      FDaoPedidoProduto.Insert(LItem);
    end;

    FConnection.Commit;
    Result := True;
  except
    FConnection.Rollback;
    Result := False;
  end;
end;

function TPedidoService.CarregarItensDoPedido(
  const aNumero_Pedido: Integer): TObjectList<TPedidoProduto>;
begin
  // A responsabilidade do Service é orquestrar.
  // Ele chama o DAO para buscar os dados e os retorna para o Controller.
  Result := FDaoPedidoEspecializado.CarregarItensDoPedido(aNumero_Pedido);
end;

function TPedidoService.CarregarPedidoPorNumeroPedido(const aNumero_Pedido: Integer): TPedido;
begin
  // Delega a responsabilidade para o DAO especializado
 Result := FDaoPedidoEspecializado.CarregarPedidoPorNumeroPedido(aNumero_Pedido);
end;

function TPedidoService.Excluir(const aNumero_Pedido: Integer): Boolean;
begin
  FConnection.StartTransaction;
  try
    // Delega a exclusão para o DAO especializado
    FDaoPedidoEspecializado.ExcluirItensPedido(aNumero_Pedido);
    FDaoPedidoEspecializado.ExcluirPedido(aNumero_Pedido);
    FConnection.Commit;
    Result := True;
  except
    FConnection.Rollback;
    Result := False;
  end;
end;

end.
