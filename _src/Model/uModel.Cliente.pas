unit uModel.Cliente;

interface

uses
  System.SysUtils;

type
  [Tabela('clientes')]
  [Coluna('codigo', true, true, false)]
  [Coluna('nome')]
  [Coluna('cidade')]
  [Coluna('uf')]
  TCliente = class
  private
    Fcodigo: Integer;
    Fnome: String;
    Fcidade: String;
    Fuf: String;
  published
    property codigo: Integer read Fcodigo write Fcodigo;
    property nome: String read Fnome write Fnome;
    property cidade: String read Fcidade write Fcidade;
    property uf: String read Fuf write Fuf;
  end;

implementation

end.
