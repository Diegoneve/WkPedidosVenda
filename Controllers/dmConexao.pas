unit dmConexao;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client, FireDAC.UI.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, Datasnap.DBClient;

type
  TdtmConexao = class(TDataModule)
    FQuery: TFDQuery;
    FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink;
    DataSource1: TDataSource;
    FDTransaction1: TFDTransaction;
    DataSource2: TDataSource;
    conexao2: TFDConnection;
    qryProdutos: TFDQuery;
    dsProdutos: TDataSource;
    cdsProdutos: TClientDataSet;
    cdsProdutosCodigo: TIntegerField;
    cdsProdutosDescricao: TStringField;
    cdsProdutosPrecoVenda: TFloatField;
    cdsProdutosCodigoProduto: TIntegerField;
    cdsProdutosQuantidade: TIntegerField;
    cdsProdutosValorUnitario: TFloatField;
    cdsProdutosValorTotal: TFloatField;
    qryCliente: TFDQuery;
    dsCliente: TDataSource;
    cdsCliente: TClientDataSet;
    IntegerField1: TIntegerField;
    StringField1: TStringField;
    FloatField1: TFloatField;
    IntegerField2: TIntegerField;
    IntegerField3: TIntegerField;
    FloatField2: TFloatField;
    FloatField3: TFloatField;
    qryPedidos: TFDQuery;
    dsPedidos: TDataSource;
    cdsPedidos: TClientDataSet;
    IntegerField4: TIntegerField;
    StringField2: TStringField;
    FloatField4: TFloatField;
    IntegerField5: TIntegerField;
    IntegerField6: TIntegerField;
    FloatField5: TFloatField;
    FloatField6: TFloatField;
    function ConectarBanco: Boolean;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dtmConexao: TdtmConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

function TdtmConexao.ConectarBanco: Boolean;
begin
  result := False;
  try
    conexao2.Connected := True;
    result := conexao2.Connected;
  except
    on E: Exception do
  end;
end;

end.
