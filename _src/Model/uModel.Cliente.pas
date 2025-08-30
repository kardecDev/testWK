unit uModel.Cliente;

interface

uses
  System.SysUtils,
  uModel.Attributes;

type
  [Tabela('clientes')]
  TCliente = class
  private
    Fcodigo: Integer;
    Fnome: String;
    Fcidade: String;
    Fuf: String;
  published
    [Coluna('codigo', true, true, false)]
    property codigo: Integer read Fcodigo write Fcodigo;
    [Coluna('nome')]
    property nome: String read Fnome write Fnome;
    [Coluna('cidade')]
    property cidade: String read Fcidade write Fcidade;
    [Coluna('uf')]
    property uf: String read Fuf write Fuf;
  end;

implementation

end.
