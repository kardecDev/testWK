unit uDAO.Pedido;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  uModel.PedidoProduto,
  uModel.Pedido,
   System.Generics.Collections;

type
  TPedidoDAO = class
  private
    FConnection: TFDConnection;
  public
    constructor Create(aConnection: TFDConnection);
    destructor Destroy; override;

    function CarregarPedidoPorNumeroPedido(const aNumero_Pedido: Integer): TPedido;
    function ExcluirItensPedido(const aNumero_Pedido: Integer): Boolean;
    function ExcluirPedido(const aNumero_Pedido: Integer): Boolean;
    function CarregarItensDoPedido(const aNumero_Pedido: Integer): TObjectList<TPedidoProduto>;
  end;

implementation

uses
  FireDAC.Comp.DataSet;

{ TPedidoDAO }

function TPedidoDAO.CarregarItensDoPedido(
  const aNumero_Pedido: Integer): TObjectList<TPedidoProduto>;
var
  LQuery: TFDQuery;
  LItem: TPedidoProduto;
begin
  Result := TObjectList<TPedidoProduto>.Create(True);
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Text := 'SELECT * FROM pedido_produtos WHERE numero_pedido = :numero_pedido';
    LQuery.ParamByName('numero_pedido').AsInteger := aNumero_Pedido;
    LQuery.Open;

    while not LQuery.Eof do
    begin
      // Mapeamento dos dados do DataSet para o objeto de modelo
      LItem := TPedidoProduto.Create;
      LItem.id_produto := LQuery.FieldByName('id_produto').AsInteger;
      LItem.numero_pedido := LQuery.FieldByName('numero_pedido').AsInteger;
      LItem.codigo_produto := LQuery.FieldByName('codigo_produto').AsInteger;
      LItem.quantidade := LQuery.FieldByName('quantidade').AsCurrency;
      LItem.vlr_unitario := LQuery.FieldByName('vlr_unitario').AsCurrency;
      LItem.vlr_total := LQuery.FieldByName('vlr_total').AsCurrency;

      Result.Add(LItem);
      LQuery.Next;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

constructor TPedidoDAO.Create(aConnection: TFDConnection);
begin
  inherited Create;
  FConnection := aConnection;
end;

destructor TPedidoDAO.Destroy;
begin
  inherited Destroy;
end;

function TPedidoDAO.CarregarPedidoPorNumeroPedido(const aNumero_Pedido: Integer): TPedido;
var
  LQuery: TFDQuery;
begin
  Result := nil;
  LQuery := TFDQuery.Create(nil);
  try
    LQuery.Connection := FConnection;
    LQuery.SQL.Text := 'SELECT * FROM pedido_dados_gerais WHERE numero_pedido = :numero_pedido';
    LQuery.ParamByName('numero_pedido').AsInteger := aNumero_Pedido;
    LQuery.Open;

    if not LQuery.Eof then
    begin
      //Mapeia os campos do TDataSet para o objeto TPedido
      Result := TPedido.Create;
      Result.numero_pedido := LQuery.FieldByName('numero_pedido').AsInteger;
      Result.codigo_cliente := LQuery.FieldByName('codigo_cliente').AsInteger;
      Result.data_emissao := LQuery.FieldByName('data_emissao').AsDateTime;
      Result.valor_total := LQuery.FieldByName('valor_total').AsCurrency;
    end;
  finally
    FreeAndNil(LQuery);
  end;
end;

function TPedidoDAO.ExcluirItensPedido(const aNumero_Pedido: Integer): Boolean;
var
  LCommand: TFDCommand;
begin
  LCommand := TFDCommand.Create(nil);
  try
    LCommand.Connection := FConnection;
    LCommand.CommandText.Text := 'DELETE FROM pedido_produtos WHERE numero_pedido = :id';
    LCommand.ParamByName('id').AsInteger := aNumero_Pedido;
    LCommand.Execute;
    Result := True;
  finally
    LCommand.Free;
  end;
end;

function TPedidoDAO.ExcluirPedido(const aNumero_Pedido: Integer): Boolean;
var
  LCommand: TFDCommand;
begin
  LCommand := TFDCommand.Create(nil);
  try
    LCommand.Connection := FConnection;
    LCommand.CommandText.Text := 'DELETE FROM pedido_dados_gerais WHERE numero_pedido = :id';
    LCommand.ParamByName('id').AsInteger := aNumero_Pedido;
    LCommand.Execute;
    Result := True;
  finally
    LCommand.Free;
  end;
end;

end.
