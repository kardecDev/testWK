unit uView.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids,
  //
  System.Generics.Collections, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  // imports
  uController.Pedido,
  uModel.Cliente,
  uModel.Produto,
  uFDMemTableHelper;


type
  TfPedido = class(TForm)
    dsItensPedido: TDataSource;
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    pnlCabecalhoPedido: TPanel;
    lblN�meroPedido: TLabel;
    edtNumeroPedido: TEdit;
    lblDataEmissao: TLabel;
    dtpDataEmissao: TDateTimePicker;
    Label1: TLabel;
    edtCodigoCliente: TEdit;
    edtNomeCliente: TEdit;
    btnBuscarCliente: TBitBtn;
    pnlAdicionarProduto: TPanel;
    lblProduto: TLabel;
    edtCodigoProduto: TEdit;
    edtDescricaoProduto: TEdit;
    btnBuscarProduto: TBitBtn;
    lblQuantidade: TLabel;
    edtQuantidade: TEdit;
    lblValorUnitario: TLabel;
    edtValorUnitario: TEdit;
    btnAdicionarItem: TBitBtn;
    dbgItensPedido: TDBGrid;
    pnlRodape: TPanel;
    lblTotalPedido: TLabel;
    edtTotalPedido: TEdit;
    btnCarregar: TBitBtn;
    btnCancelar: TBitBtn;
    btn_GrvarPedido: TBitBtn;
    mtItensPedido: TFDMemTable;
    mtItensPedidoid_produto: TIntegerField;
    mtItensPedidonumero_pedido: TIntegerField;
    mtItensPedidocodigo_produto: TIntegerField;
    mtItensPedidovlr_unitario: TCurrencyField;
    mtItensPedidovlr_total: TCurrencyField;
    mtItensPedidoquantidade: TFloatField;
    mtItensPedidodescricao: TStringField;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btn_GrvarPedidoClick(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btnAdicionarItemClick(Sender: TObject);
    procedure dbgItensPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtCodigoProdutoExit(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnCarregarClick(Sender: TObject);
    procedure btnBuscarClienteClick(Sender: TObject);
    procedure btnBuscarProdutoClick(Sender: TObject);
    procedure edtCodigoProdutoChange(Sender: TObject);
  private
    { Private declarations }
    FController : TPedidoController;
    function fnc_estado_btn: boolean;
    procedure prc_checa_btn;
    procedure LimparCamposProduto;
    procedure AtualizarValorTotal;
    procedure ValidarProduto(Sender: TObject);
    procedure ValidarCliente(Sender: TObject);
    procedure CarregarDadosDaTela;
  public
    { Public declarations }
  end;

var
  fPedido: TfPedido;

implementation

uses
   uView.Pesquisa;
{$R *.dfm}

{ TfPedido }

procedure TfPedido.AtualizarValorTotal;
begin
  edtTotalPedido.Text := FormatFloat('R$ #,##0.00', FController.Pedido.valor_total);
end;

procedure TfPedido.btn_GrvarPedidoClick(Sender: TObject);
var
  LIdPedido, LIdCliente: Integer;
begin
  // 1. Coletar os dados do formul�rio e atribuir ao modelo no Controller
  if not TryStrToInt(edtNumeroPedido.Text, LIdPedido) then
    LIdPedido := 0;
  FController.Pedido.numero_pedido := LIdPedido;

  if not TryStrToInt(edtCodigoCliente.Text, LIdCliente) then
    LIdCliente := 0;
  FController.Pedido.codigo_cliente := LIdCliente;

  FController.Pedido.data_emissao := dtpDataEmissao.Date;

  // 2. Chamar o m�todo de persist�ncia no Controller
  if FController.SalvarPedido then
  begin
    ShowMessage('Pedido salvo com sucesso!');
    CarregarDadosDaTela;
  end
  else
  begin
    ShowMessage('Falha ao salvar o pedido.');
  end;
  prc_checa_btn;
end;

procedure TfPedido.btnAdicionarItemClick(Sender: TObject);
var
  LIdProduto: Integer;
  LQuantidade: Currency;
  LValorUnitario: Currency;
  LDescricao: String;

begin
  // Tenta converter os valores dos campos
  if (TryStrToInt(edtCodigoProduto.Text, LIdProduto)) and
     (TryStrToCurr(edtQuantidade.Text, LQuantidade)) and
     (TryStrToCurr(edtValorUnitario.Text, LValorUnitario)) then
  begin
    LDescricao := edtDescricaoProduto.text;
    // Chama o m�todo do Controller para adicionar o item
    FController.AdicionarItem(LIdProduto, LDescricao, LQuantidade, LValorUnitario);

    // A chamada a seguir, agora com o helper corrigido, ir� abrir a tabela se ela estiver fechada.
    TFDMemTableHelper.BindList(TObjectList<TObject>(FController.ItensPedido), mtItensPedido);


    // Recalcula o valor total do pedido
    AtualizarValorTotal;
    // Limpa os campos de produto para o pr�ximo item
    LimparCamposProduto;
  end
  else
  begin
    ShowMessage('Por favor, preencha os campos de produto corretamente.');
  end;
end;

procedure TfPedido.btnBuscarClienteClick(Sender: TObject);
var
  LPesquisaForm: TfPesquisa;
begin
  LPesquisaForm := TfPesquisa.Create(self);
  try
    // Agora o formul�rio de pesquisa recebe um TDataSet
    LPesquisaForm.CarregarDataSet(TFDDataSet(FController.FindAllClientes));
    if LPesquisaForm.ShowModal = mrOK then
    begin
      edtCodigoCliente.Text := IntToStr(LPesquisaForm.SelectedCodigo);
      edtCodigoClienteExit(nil);
    end;
  finally
    LPesquisaForm.Free;
  end;
end;

procedure TfPedido.btnBuscarProdutoClick(Sender: TObject);
var
  LPesquisaForm: TfPesquisa;
begin
  LPesquisaForm := TfPesquisa.Create(self);
  try
    LPesquisaForm.CarregarDataSet(TFDDataset(FController.FindAllProdutos));
    if LPesquisaForm.ShowModal = mrOK then
    begin
      edtCodigoProduto.Text := IntToStr(LPesquisaForm.SelectedCodigo);
      edtCodigoProdutoExit(nil);
    end;
  finally
    LPesquisaForm.Free;
  end;
end;

procedure TfPedido.btnCancelarClick(Sender: TObject);
var
  LIdPedidoStr: string;
  LIdPedido: Integer;
begin
  LIdPedidoStr := '';
  // Solicita o ID do pedido que o usu�rio deseja cancelar/excluir
  if InputQuery('Cancelar Pedido', 'Digite o N�mero do pedido que deseja cancelar:', LIdPedidoStr) then
  begin
    // Tenta converter a entrada do usu�rio para um n�mero
    if TryStrToInt(LIdPedidoStr, LIdPedido) then
    begin
      // Chama o Controller para excluir o pedido
      if FController.ExcluirPedido(LIdPedido) then
      begin
        ShowMessage('Pedido ' + LIdPedidoStr + ' cancelado (exclu�do) com sucesso!');
        // Prepara o formul�rio para um novo pedido ap�s o sucesso
        FController.NovoPedido;
        CarregarDadosDaTela;
      end
      else
      begin
        ShowMessage('Falha ao cancelar o pedido. Verifique se o N�mero do pedido est� correto.');
      end;
    end
    else
    begin
      ShowMessage('N�mero do pedido do pedido inv�lido.');
    end;
  end;
end;

procedure TfPedido.btnCarregarClick(Sender: TObject);
var
  LIdPedidoStr: string;
  LIdPedido: Integer;
begin
  LIdPedidoStr := '';
  // Solicita o ID do pedido ao usu�rio em uma caixa de di�logo
  if InputQuery('Carregar Pedido', 'Digite o N�mero do Pedido do pedido:', LIdPedidoStr) then
  begin
    // Tenta converter a entrada do usu�rio para um n�mero
    if TryStrToInt(LIdPedidoStr, LIdPedido) then
    begin
      // Chama o Controller para carregar o pedido
      FController.CarregarPedido(LIdPedido);

      // Preenche o formul�rio com os dados do pedido carregado
      CarregarDadosDaTela;


      // Verifica se o pedido foi realmente encontrado
      if FController.Pedido.numero_pedido = 0 then
      begin
        ShowMessage('Pedido n�o encontrado.');
        FController.NovoPedido;
        CarregarDadosDaTela;
      end;
    end
    else
    begin
      ShowMessage('ID do pedido inv�lido.');
    end;
  end;
end;

procedure TfPedido.dbgItensPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  LIndex: Integer;
begin
  //L�gica para excluir um item.
  if Key = VK_DELETE then
  begin
    // Verifica se o ClientDataSet n�o est� vazio e se h� um registro ativo
    if not mtItensPedido.IsEmpty then
    begin
      // Obt�m o �ndice do registro atual (RecNo � 1-based, nossa lista � 0-based)
      LIndex := mtItensPedido.RecNo - 1;

      // Exclui o item no Controller usando o �ndice correto
      if MessageDlg('Tem certeza que deseja remover o produto: ' + mtItensPedido.FieldByName('CODIGO_PRODUTO').AsString + ' da lista de itens do pedido ?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
      begin
        FController.ExcluirItem(LIndex);
      end;
      // Atualiza o ClientDataSet a partir da lista
      TFDMemTableHelper.BindList(TObjectList<TObject>(FController.ItensPedido), mtItensPedido);

      // Atualiza o valor total no rodap�
      AtualizarValorTotal;
    end;
  end;

  // L�gica para EDITAR um item
  if (Key = VK_RETURN) and not mtItensPedido.IsEmpty then
  begin
    // Preenche os campos de edi��o com os dados da linha selecionada
    edtCodigoProduto.Text := mtItensPedido.FieldByName('codigo_produto').AsString;
    edtDescricaoProduto.Text := 'Nome do Produto'; // Este campo ainda n�o est� no ClientDataSet
    edtQuantidade.Text := mtItensPedido.FieldByName('quantidade').AsString;
    edtValorUnitario.Text := mtItensPedido.FieldByName('vlr_unitario').AsString;

    // Remove o item da lista (para que ele possa ser adicionado novamente com as altera��es)
    FController.ExcluirItem(mtItensPedido.RecNo - 1);

    // Atualiza o ClientDataSet e o valor total
    TFDMemTableHelper.BindList(TObjectList<TObject>(FController.ItensPedido), mtItensPedido);
    AtualizarValorTotal;
  end;
end;

procedure TfPedido.edtCodigoClienteChange(Sender: TObject);
begin
  prc_checa_btn;
end;

procedure TfPedido.edtCodigoClienteExit(Sender: TObject);
begin
  prc_checa_btn;
  ValidarCliente(Sender);
end;

procedure TfPedido.edtCodigoProdutoChange(Sender: TObject);
begin
  if trim(edtCodigoProduto.Text)=EmptyStr then
     edtNomeCliente.clear;
end;

procedure TfPedido.edtCodigoProdutoExit(Sender: TObject);
begin
  ValidarProduto(Sender);
end;

function TfPedido.fnc_estado_btn: boolean;
var
 estado : boolean;
begin
  estado := false;
  if (edtCodigoCliente.Text = EmptyStr) then
     estado := true;
  result := estado;
end;

procedure TfPedido.FormActivate(Sender: TObject);
begin
  prc_checa_btn;
end;

procedure TfPedido.FormCreate(Sender: TObject);
begin
  FController := TPedidoController.Create;
 // Apenas configura a liga��o entre o DataSource e a MemTable
  dsItensPedido.DataSet := mtItensPedido;
  dbgItensPedido.DataSource := dsItensPedido;
  // Prepara o Controller para um novo pedido.
  FController.NovoPedido;
end;

procedure TfPedido.FormDestroy(Sender: TObject);
begin
  FController.Free;
end;

procedure TfPedido.FormShow(Sender: TObject);
begin
  prc_checa_btn;
end;

procedure TfPedido.LimparCamposProduto;
begin
  edtCodigoProduto.Clear;
  edtDescricaoProduto.Clear;
  edtQuantidade.Clear;
  edtValorUnitario.Clear;
end;

procedure TfPedido.prc_checa_btn;
begin
  btnCarregar.Visible := fnc_estado_btn;
  btnCancelar.Visible := fnc_estado_btn;
end;

procedure TfPedido.CarregarDadosDaTela;
begin
  // Carrega os dados do cabe�alho do pedido do Controller
  edtNumeroPedido.Text := IntToStr(FController.Pedido.numero_pedido);
  dtpDataEmissao.Date := FController.Pedido.data_emissao;
  edtCodigoCliente.Text := IntToStr(FController.Pedido.codigo_cliente);

  // Preenche o nome do cliente se o c�digo for v�lido
  if FController.Pedido.codigo_cliente > 0 then
  begin
    ValidarCliente(nil);
  end;

  // Vincula a lista de itens do controller ao ClientDataSet
  // O Controller ainda gerencia uma lista de objetos, e a View a utiliza.
  TFDMemTableHelper.BindList(TObjectList<TObject>(FController.ItensPedido), mtItensPedido);

  AtualizarValorTotal;
end;

procedure TfPedido.ValidarCliente(Sender: TObject);
var
  LIdCliente: Integer;
  LCliente: TCliente;
begin
  if not (trim(edtCodigoCliente.Text) = EmptyStr) then
  begin
    if TryStrToInt(edtCodigoCliente.Text, LIdCliente) then
    begin
      LCliente := FController.BuscarClientePorId(LIdCliente);
      if Assigned(LCliente) then
      begin
        edtNomeCliente.Text := LCliente.nome;
        LCliente.Free;
      end
      else
      begin
        ShowMessage('Cliente n�o encontrado.');
        edtCodigoCliente.Clear;
        edtNomeCliente.Clear;
        edtCodigoCliente.SetFocus;
      end;
    end
    else
    begin
      ShowMessage('C�digo do cliente inv�lido.');
      edtCodigoCliente.Clear;
      edtNomeCliente.Clear;
      edtCodigoCliente.SetFocus;
    end;
  end
  else
  begin
    edtCodigoCliente.Clear;
    edtNomeCliente.Clear;
  end;
end;

procedure TfPedido.ValidarProduto(Sender: TObject);
var
  LIdProduto: Integer;
  LProduto: TProduto;
begin
  if not (trim(edtCodigoProduto.Text) = EmptyStr) then
  begin
    if TryStrToInt(edtCodigoProduto.Text, LIdProduto) then
    begin
      LProduto := FController.BuscarProdutoPorId(LIdProduto);
      if Assigned(LProduto) then
      begin
        edtDescricaoProduto.Text := LProduto.descricao;
        edtValorUnitario.Text := FloatToStr(LProduto.preco_venda);
        LProduto.Free;
      end
      else
      begin
        ShowMessage('Produto n�o encontrado.');
        LimparCamposProduto;
        edtCodigoProduto.SetFocus;
      end;
    end
    else
    begin
      ShowMessage('Codigo do produto inv�lido.');
      LimparCamposProduto;
      edtCodigoProduto.SetFocus;
    end;
  end;
end;

end.
