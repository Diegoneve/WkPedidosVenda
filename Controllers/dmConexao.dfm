object dtmConexao: TdtmConexao
  Height = 514
  Width = 613
  object FQuery: TFDQuery
    SQL.Strings = (
      'SELECT pp.NumeroPedido'
      '     , pp.CodigoProduto'
      #9'  , pp.Quantidade'
      #9'  , pp.ValorUnitario'
      #9'  , pp.ValorTotal '
      '  FROM pedidosprodutos pp;')
    Left = 32
    Top = 16
  end
  object FDPhysMySQLDriverLink1: TFDPhysMySQLDriverLink
    VendorLib = 'C:\Users\diego\Desktop\TesteWK2024\Exec\libmysql.dll'
    Left = 504
    Top = 160
  end
  object DataSource1: TDataSource
    DataSet = FQuery
    Left = 32
    Top = 88
  end
  object FDTransaction1: TFDTransaction
    Left = 288
    Top = 24
  end
  object DataSource2: TDataSource
    Left = 32
    Top = 160
  end
  object conexao2: TFDConnection
    Params.Strings = (
      'Database=wk_teste'
      'ConnectionDef=MySQL80')
    Connected = True
    LoginPrompt = False
    Left = 504
    Top = 96
  end
  object qryProdutos: TFDQuery
    DetailFields = 'descricao;PrecoVenda'
    Connection = conexao2
    SQL.Strings = (
      'SELECT descricao'
      '     , PrecoVenda'
      '  from produtos'
      ' WHERE codigo = :codigo')
    Left = 42
    Top = 264
    ParamData = <
      item
        Name = 'CODIGO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsProdutos: TDataSource
    DataSet = qryProdutos
    Left = 42
    Top = 328
  end
  object cdsProdutos: TClientDataSet
    Aggregates = <>
    MasterSource = dsProdutos
    PacketRecords = 0
    Params = <>
    Left = 40
    Top = 392
    object cdsProdutosCodigo: TIntegerField
      FieldName = 'Codigo'
    end
    object cdsProdutosDescricao: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object cdsProdutosPrecoVenda: TFloatField
      FieldName = 'PrecoVenda'
    end
    object cdsProdutosCodigoProduto: TIntegerField
      FieldName = 'CodigoProduto'
    end
    object cdsProdutosQuantidade: TIntegerField
      FieldName = 'Quantidade'
    end
    object cdsProdutosValorUnitario: TFloatField
      FieldName = 'ValorUnitario'
    end
    object cdsProdutosValorTotal: TFloatField
      FieldName = 'ValorTotal'
    end
  end
  object qryCliente: TFDQuery
    DetailFields = 'descricao;PrecoVenda'
    Connection = conexao2
    SQL.Strings = (
      'SELECT codigo'
      '     , nome'
      '     , cidade'
      '     , uf'
      '  from clientes'
      ' WHERE codigo = :codcliente')
    Left = 146
    Top = 272
    ParamData = <
      item
        Name = 'CODCLIENTE'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsCliente: TDataSource
    DataSet = qryProdutos
    Left = 146
    Top = 336
  end
  object cdsCliente: TClientDataSet
    Aggregates = <>
    MasterSource = dsCliente
    PacketRecords = 0
    Params = <>
    Left = 144
    Top = 392
    object IntegerField1: TIntegerField
      FieldName = 'Codigo'
    end
    object StringField1: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FloatField1: TFloatField
      FieldName = 'PrecoVenda'
    end
    object IntegerField2: TIntegerField
      FieldName = 'CodigoProduto'
    end
    object IntegerField3: TIntegerField
      FieldName = 'Quantidade'
    end
    object FloatField2: TFloatField
      FieldName = 'ValorUnitario'
    end
    object FloatField3: TFloatField
      FieldName = 'ValorTotal'
    end
  end
  object qryPedidos: TFDQuery
    Connection = conexao2
    SQL.Strings = (
      'SELECT P.Codigo'
      '     , P.Descricao'
      '     , PP.Quantidade'
      '     , PP.ValorUnitario'
      '     , PP.ValorTotal'
      '     , C.Nome'
      '  FROM produtos P'
      '  JOIN pedidosprodutos   PP ON (PP.CodigoProduto = P.Codigo)'
      
        '  JOIN pedidodadosgerais PG ON (PG.NumeroPedido = PP.NumeroPedid' +
        'o)'
      '  JOIN clientes          C  ON (C.Codigo = PG.CodigoCliente)'
      ' WHERE PP.NumeroPedido = :NumeroPedido')
    Left = 256
    Top = 272
    ParamData = <
      item
        Name = 'NUMEROPEDIDO'
        DataType = ftInteger
        ParamType = ptInput
        Value = Null
      end>
  end
  object dsPedidos: TDataSource
    DataSet = qryPedidos
    Left = 250
    Top = 336
  end
  object cdsPedidos: TClientDataSet
    Aggregates = <>
    MasterSource = dsPedidos
    PacketRecords = 0
    Params = <>
    Left = 248
    Top = 400
    object IntegerField4: TIntegerField
      FieldName = 'Codigo'
    end
    object StringField2: TStringField
      FieldName = 'Descricao'
      Size = 100
    end
    object FloatField4: TFloatField
      FieldName = 'PrecoVenda'
    end
    object IntegerField5: TIntegerField
      FieldName = 'CodigoProduto'
    end
    object IntegerField6: TIntegerField
      FieldName = 'Quantidade'
    end
    object FloatField5: TFloatField
      FieldName = 'ValorUnitario'
    end
    object FloatField6: TFloatField
      FieldName = 'ValorTotal'
    end
  end
end
