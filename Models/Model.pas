unit Model;

interface
type
  TClientes = class
  public
    Codigo: Integer;
    Nome: string;
    Cidade: string;
    UF: string;
  end;
  TProdutos = class
  public
    Codigo: Integer;
    Descricao: string;
    PrecoVenda: Double;
  end;
  TPedidoDadosGerais = class
  public
    NumeroPedido: Integer;
    DataEmissao: TDateTime;
    CodigoCliente: Integer;
    ValorTotal: Double;
  end;
  TPedidosProdutos = class
  public
    Id: Integer;
    NumeroPedido: Integer;
    CodigoProduto: Integer;
    Quantidade: Integer;
    ValorUnitario: Double;
    ValorTotal: Double;
  end;
implementation

end.
