unit uView.Pesquisa;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, System.Generics.Collections,System.StrUtils;

type
  TfPesquisa = class(TForm)
    pnlBottom: TPanel;
    btnFechar: TBitBtn;
    dbgDados: TDBGrid;
    dsDados: TDataSource;
    mtDados: TFDMemTable;
    pnlHeader: TPanel;
    gpbFiltro: TGroupBox;
    EdtPesquisa: TEdit;
    procedure btnFecharClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure EdtPesquisaChange(Sender: TObject);
    procedure dbgDadosTitleClick(Column: TColumn);

  private
    { Private declarations }
    FSelectedCODIGO: Integer;
    FFilterField: string;
    procedure AtualizarFiltro;
  public
    { Public declarations }

    procedure CarregarDataSet(const ADataSet: TFDDataset);
    property SelectedCodigo: Integer read FSelectedCodigo;
  end;

var
  fPesquisa: TfPesquisa;

implementation

uses
   uLib.FireDACUtils, System.Rtti;

{$R *.dfm}

{ TfPesquisa }

procedure TfPesquisa.AtualizarFiltro;
var
  LFilterText: string;
begin
  LFilterText := Trim(EdtPesquisa.Text);

  if LFilterText = '' then
  begin
    mtDados.Filter := '';
    mtDados.Filtered := False;
  end
  else
  begin
    mtDados.Filter := FFilterField + ' LIKE ' + QuotedStr('%' + LFilterText + '%');
    mtDados.Filtered := True;
  end;
end;

procedure TfPesquisa.btnFecharClick(Sender: TObject);
begin
  ModalResult := mrClose;
end;

procedure TfPesquisa.CarregarDataSet(const ADataSet: TFDDataset);
begin
  if not Assigned(ADataSet) then
  begin
    ShowMessage('Nenhum dado para exibir.');
    Exit;
  end;

  if not ADataSet.Active then
    ADataSet.Open;

  mtDados.Filtered := False;

  if ADataSet.FieldCount > 0 then
  begin
    mtDados.CloneCursor(TFDDataset(ADataSet), True, True);

    if FFilterField = '' then
    begin
      FFilterField := mtDados.FieldDefs[0].Name;
      gpbFiltro.Caption := 'Pesquisar por: ' + FFilterField;
    end;
  end
  else
  begin
    if mtDados.Active then
      mtDados.Close;
    FFilterField := '';
    gpbFiltro.Caption := 'Nenhum registro para pesquisar.';
  end;
end;

procedure TfPesquisa.dbgDadosTitleClick(Column: TColumn);
begin
  FFilterField := Column.FieldName;
  gpbFiltro.Caption := 'Pesquisar por: ' + FFilterField;
  edtPesquisa.Clear;
  AtualizarFiltro;
  edtPesquisa.SetFocus;
end;

procedure TfPesquisa.EdtPesquisaChange(Sender: TObject);
begin
  AtualizarFiltro;
end;

procedure TfPesquisa.FormCreate(Sender: TObject);
begin
  FSelectedCodigo := 0;
  FFilterField := '';
end;

procedure TfPesquisa.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = VK_RETURN then
  begin
    if not mtDados.IsEmpty then
    begin
      FSelectedCodigo := dsDados.DataSet.FieldByName('codigo').AsInteger;
      ModalResult := mrOK;
    end;
  end;
end;

end.
