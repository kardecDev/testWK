unit uService.Cliente;

interface

uses
  System.SysUtils,
  System.Generics.Collections,
  FireDAC.Comp.Client,
  uModel.Cliente,
  uDAO.Base,
  uDBConnection,
  Data.DB;

type
  TClienteService = class
  private
    FConnection: TFDConnection;
    FDaoCliente: TBaseDAO<TCliente>;
    procedure CheckDAO;
  public
    constructor Create;
    destructor Destroy; override;

    function FindAll: TDataSet;
    function FindById(const aId: Integer): TCliente;
  end;

implementation

{ TClienteService }

procedure TClienteService.CheckDAO;
begin
  if not Assigned(FDaoCliente) then
    raise Exception.Create('DAO de cliente não inicializado.');
end;

constructor TClienteService.Create;
begin
  inherited Create;
  FConnection := TDBConnection.GetConnection;
  FDaoCliente := TBaseDAO<TCliente>.Create(FConnection);
end;

destructor TClienteService.Destroy;
begin
  FDaoCliente.Free;
  inherited Destroy;
end;

function TClienteService.FindById(const aId: Integer): TCliente;
begin
 Result := FDaoCliente.FindById(aId);
end;

function TClienteService.FindAll: TDataSet;
begin
  Result := FDaoCliente.FindAllAsDataSet;
end;

end.
