unit uService.Pedido;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  uDAO.Base,
  uModel.Pedido,
  uModel.PedidoProduto,
  uModel.Cliente,
  uModel.Produto;

type
  TPedidoService = class
  private
    FConnection: TFDConnection;
    FDaoPedido: TBaseDAO<TPedido>;
    FDaoPedidoProduto: TBaseDAO<TPedidoProduto>;
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    function Salvar(aPedido: TPedido; aItens: TObjectList<TPedidoProduto>): Boolean;
    function CarregarPorId(const aId: Integer): TObjectList<TObject>;
    function Excluir(const aId: Integer): Boolean;
    function CalcularValorTotal(aItens: TObjectList<TPedidoProduto>): Currency;
  end;

implementation

{ TPedidoService }

constructor TPedidoService.Create(aConnection: TFDConnection);
begin
  inherited Create;
  FConnection := aConnection;
  FDaoPedido := TBaseDAO<TPedido>.Create(FConnection);
  FDaoPedidoProduto := TBaseDAO<TPedidoProduto>.Create(FConnection);
end;

destructor TPedidoService.Destroy;
begin
  FDaoPedido.Free;
  FDaoPedidoProduto.Free;
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

    // Apaga os itens antigos para evitar duplicidade
    FDaoPedidoProduto.Delete(aPedido.numero_pedido); // Este método precisa ser ajustado para excluir por ID do pedido

    // Insere os novos itens com a chave estrangeira correta
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

function TPedidoService.CarregarPorId(const aId: Integer): TObjectList<TObject>;
var
  LPedido: TPedido;
  LQuery: TFDQuery;
  LItem: TPedidoProduto;
begin
  Result := TObjectList<TObject>.Create;
  try
    LPedido := FDaoPedido.FindById(aId);
    if Assigned(LPedido) then
    begin
      Result.Add(LPedido);

      LQuery := TFDQuery.Create(nil);
      try
        LQuery.Connection := FConnection;
        LQuery.SQL.Text := 'SELECT * FROM pedido_produtos WHERE numero_pedido = :id';
        LQuery.ParamByName('id').AsInteger := aId;
        LQuery.Open;

        while not LQuery.EOF do
        begin
          LItem := TPedidoProduto.Create;
          LItem.id_produto      := LQuery.FieldByName('id_produto').AsInteger;
          LItem.numero_pedido   := LQuery.FieldByName('numero_pedido').AsInteger;
          LItem.codigo_produto  := LQuery.FieldByName('codigo_produto').AsInteger;
          LItem.quantidade      := LQuery.FieldByName('quantidade').AsCurrency;
          LItem.vlr_unitario    := LQuery.FieldByName('vlr_unitario').AsCurrency;
          LItem.vlr_total        := LQuery.FieldByName('vlr_total').AsCurrency;
          Result.Add(LItem);
          LQuery.Next;
        end;
      finally
        LQuery.Free;
      end;
    end;
  except
    Result.Free;
    Result := nil;
  end;
end;

function TPedidoService.Excluir(const aId: Integer): Boolean;
var
  LCommand: TFDCommand;
begin
  FConnection.StartTransaction;
  try
    LCommand := TFDCommand.Create(nil);
    try
      LCommand.Connection := FConnection;
      // Apaga os itens do pedido
      LCommand.CommandText.Text := 'DELETE FROM pedido_produtos WHERE numero_pedido = :id';
      LCommand.ParamByName('id').AsInteger := aId;
      LCommand.Execute;

      // Apaga o cabeçalho do pedido
      LCommand.CommandText.Text := 'DELETE FROM PEDIDOS WHERE ID_PEDIDO = :id';
      LCommand.ParamByName('id').AsInteger := aId;
      LCommand.Execute;
    finally
      LCommand.Free;
    end;
    FConnection.Commit;
    Result := True;
  except
    FConnection.Rollback;
    Result := False;
  end;
end;

end.
