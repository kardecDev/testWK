program testWK;

uses
  Vcl.Forms,
  uView.Pedido in 'View\uView.Pedido.pas' {fPedido},
  uModel.Cliente in 'Model\uModel.Cliente.pas',
  uModel.Produto in 'Model\uModel.Produto.pas',
  uModel.Pedido in 'Model\uModel.Pedido.pas',
  uModel.PedidoProduto in 'Model\uModel.PedidoProduto.pas',
  uModel.Attributes in 'DAO\uModel.Attributes.pas',
  uDAO.Base in 'DAO\uDAO.Base.pas',
  uService.Pedido in 'service\uService.Pedido.pas',
  uController.Pedido in 'Controller\uController.Pedido.pas',
  uDBConnection in 'data\uDBConnection.pas',
  Vcl.Themes,
  Vcl.Styles,
  uService.Cliente in 'service\uService.Cliente.pas',
  uService.Produto in 'service\uService.Produto.pas',
  uLib.FireDACUtils in 'utils\uLib.FireDACUtils.pas',
  uView.Pesquisa in 'View\uView.Pesquisa.pas' {fPesquisa},
  uDAO.Pedido in 'dao\uDAO.Pedido.pas',
  uFDMemTableHelper in 'utils\uFDMemTableHelper.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Pedido de Vendas';
  Application.CreateForm(TfPedido, fPedido);
  Application.Run;
end.
