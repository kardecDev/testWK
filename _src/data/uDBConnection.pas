unit uDBConnection;

interface

uses
  System.SysUtils,
  FireDAC.Comp.Client,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.UI.Intf,
  FireDAC.Phys.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.Phys,
  FireDAC.VCLUI.Wait,
  FireDAC.Phys.MySQLDef,
  FireDAC.Phys.MySQL,
  FireDAC.DApt;

type
  TDBConnection = class
  private
    class var FConnection: TFDConnection; // Variável de classe para a única instância
    class procedure SetConnection; static;
    class procedure ReleaseConnection; static;
  public
    class function GetConnection: TFDConnection; static;
  end;

implementation

uses
  IniFiles, Vcl.Dialogs;

{ TDBConnection }

class procedure TDBConnection.SetConnection;
var
  IniFile: TIniFile;
begin
  if Assigned(FConnection) and FConnection.Connected then
    Exit;

  if not Assigned(FConnection) then
    FConnection := TFDConnection.Create(nil);

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

  if not FConnection.Connected then
    FConnection.Connected := True;
end;

class procedure TDBConnection.ReleaseConnection;
begin
  if Assigned(FConnection) then
  begin
    FConnection.Connected := False;
    FConnection.Free;
    FConnection := nil;
  end;
end;

class function TDBConnection.GetConnection: TFDConnection;
begin
  if not Assigned(FConnection) then
    SetConnection;

  if not FConnection.Connected then
    FConnection.Connected := True;

  Result := FConnection;
end;

initialization
  // Optional: You can add an initialization section to create the connection eagerly
finalization
  TDBConnection.ReleaseConnection; // Ensures connection is properly closed when the app exits
end.
