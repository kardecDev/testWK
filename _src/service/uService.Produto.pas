unit uService.Produto;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  uModel.Produto,
  uDAO.Base,
  uDBConnection,
  Data.DB;

type
  TProdutoService = class
  private
    FConnection: TFDConnection;
    FDaoProduto: TBaseDAO<TProduto>;
    procedure CheckDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function FindAll: TDataSet;
    function FindById(const aId: Integer): TProduto;
  end;

implementation

{ TProdutoService }

procedure TProdutoService.CheckDAO;
begin
if not Assigned(FDaoProduto) then
    raise Exception.Create('DAO de produto não inicializado.');
end;

constructor TProdutoService.Create;
begin
  inherited Create;
  FConnection := TDBConnection.GetConnection;
  FDaoProduto := TBaseDAO<TProduto>.Create(FConnection);
end;

destructor TProdutoService.Destroy;
begin
  FDaoProduto.Free;
  inherited Destroy;
end;

function TProdutoService.FindAll: TDataSet;
begin
  Result := FDaoProduto.FindAllAsDataSet;
end;

function TProdutoService.FindById(const aId: Integer): TProduto;
begin
  Result := FDaoProduto.FindById(aId);
end;

end.
