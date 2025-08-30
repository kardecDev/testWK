unit uView.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ComCtrls,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.Grids, Vcl.DBGrids;

type
  TfPedido = class(TForm)
    cdsItensPedido: TClientDataSet;
    dsItensPedido: TDataSource;
    pnlTopo: TPanel;
    lblTitulo: TLabel;
    pnlCabecalhoPedido: TPanel;
    lblNúmeroPedido: TLabel;
    edtNúmeroPedido: TEdit;
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
    Edit1: TEdit;
    btnAdicionarItem: TBitBtn;
    dbgItensPedido: TDBGrid;
    pnlRodape: TPanel;
    lblTotalPedido: TLabel;
    edtTotalPedido: TEdit;
    btnCarregar: TBitBtn;
    btnCancelar: TBitBtn;
    BitBtn3: TBitBtn;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fPedido: TfPedido;

implementation

{$R *.dfm}

end.
