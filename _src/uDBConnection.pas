unit uDBConnection;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option;

type
  TDBConnection = class
  private
    FConnection: TFDConnection;
    procedure SetConnection;
  public
    constructor Create;
    destructor Destroy; override;

    function GetConnection: TFDConnection;
  end;

implementation

uses
  IniFiles;

{ TDBConnection }

constructor TDBConnection.Create;
begin
  inherited Create;
  FConnection := TFDConnection.Create(nil);
  SetConnection;
end;

destructor TDBConnection.Destroy;
begin
  FConnection.Free;
  inherited Destroy;
end;

procedure TDBConnection.SetConnection;
var
  IniFile: TIniFile;
begin
  IniFile := TIniFile.Create(ExtractFilePath(ParamStr(0)) + 'config.ini');
  try
    FConnection.DriverName := 'MySQL';
    FConnection.Params.Values['Database'] := IniFile.ReadString('DATABASE', 'Database', '');
    FConnection.Params.Values['User_Name'] := IniFile.ReadString('DATABASE', 'Username', '');
    FConnection.Params.Values['Server'] := IniFile.ReadString('DATABASE', 'Server', '');
    FConnection.Params.Values['Port'] := IniFile.ReadString('DATABASE', 'Port', '3306');
    FConnection.Params.Values['Password'] := IniFile.ReadString('DATABASE', 'Password', '');
    FConnection.Params.Values['MetaDefCatalog'] := IniFile.ReadString('DATABASE', 'Database', '');
  finally
    IniFile.Free;
  end;
end;

function TDBConnection.GetConnection: TFDConnection;
begin
  Result := FConnection;
end;

end.
