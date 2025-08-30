program testWK;

uses
  Vcl.Forms,
  uView.Pedido in 'View\uView.Pedido.pas' {FormViewPedido},
  uModel.Cliente in 'Model\uModel.Cliente.pas',
  uModel.Produto in 'Model\uModel.Produto.pas',
  uModel.Pedido in 'Model\uModel.Pedido.pas',
  uModel.PedidoProduto in 'Model\uModel.PedidoProduto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormViewPedido, FormViewPedido);
  Application.Run;
end.
