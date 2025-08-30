program testWK;

uses
  Vcl.Forms,
  uView.Pedido in 'View\uView.Pedido.pas' {FormViewPedido},
  uModel.Cliente in 'Model\uModel.Cliente.pas',
  uModel.Produto in 'Model\uModel.Produto.pas',
  uModel.Pedido in 'Model\uModel.Pedido.pas',
  uModel.PedidoProduto in 'Model\uModel.PedidoProduto.pas',
  uModel.Attributes in 'Model\uModel.Attributes.pas',
  uDAO.Base in 'Model\uDAO.Base.pas',
  uService.Pedido in 'service\uService.Pedido.pas',
  uController.Pedido in 'Controller\uController.Pedido.pas',
  uDBConnection in 'uDBConnection.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormViewPedido, FormViewPedido);
  Application.Run;
end.
