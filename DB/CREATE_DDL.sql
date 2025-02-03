/* Tabela de Clientes
2. Campos da tabela de clientes (Código, Nome, Cidade, UF) */
CREATE TABLE Clientes (
    Codigo int auto_increment primary key,
    Nome   varchar(100) not null,
    Cidade varchar(100),
    UF     char(2)
);
/* Tabela de Produtos
3. Campos da tabela de produtos (Código, Descrição, Preço de venda) 
19. A chave primária da tabela de produtos deve ser (autoincrem), pois pode existir repetição de produtos */
CREATE TABLE Produtos (
    Codigo     int auto_increment primary key,
    Descricao  varchar(100) not null,
    PrecoVenda decimal(10, 2) not null
);

/* Tabela de Dados Gerais do Pedido
  14. Campos da tabela de pedidos dados gerais (Número pedido, Data emissão, Código cliente, Valor total) 
  18. A chave primária da tabela de dados gerais do pedido deve ser (Número pedido), não podendo haver duplicidade entre os registros gravados */  
CREATE TABLE PedidoDadosGerais(
    NumeroPedido  int auto_increment primary key,
    DataEmissao   DATETIME NOT NULL,
    CodigoCliente INT NOT NULL,
    ValorTotal    DECIMAL(10, 2),
    FOREIGN KEY (CodigoCliente) REFERENCES Clientes(Codigo)
);

/* Tabela de Produtos do Pedido
   15. Campos da tabela de pedidos produtos (Autoincrem, Número pedido, Código produto, Quantidade, Vir. Unitário, Vir. Total) 
   17. O pedido deve possuir número sequencial crescente      
*/
CREATE TABLE PedidosProdutos (
    Id            int auto_increment primary key,
    NumeroPedido  int not null,
    CodigoProduto int not null,
    Quantidade    int not null,
    ValorUnitario decimal(10, 2) not null,
    ValorTotal    decimal(10, 2) not null,
    foreign key (NumeroPedido)  references PedidoDadosGerais(NumeroPedido),
    foreign key (CodigoProduto) references Produtos(Codigo)
);

/* 21. Criar índices necessários nas tabelas de dados gerais do pedido e produtos do pedido

-- Índices para PedidoDadosGerais */
CREATE INDEX idx_codigo_cliente ON PedidoDadosGerais(CodigoCliente);
CREATE INDEX idx_data_emissao ON PedidoDadosGerais(DataEmissao);

-- Índices para PedidosProdutos
CREATE INDEX idx_numero_pedido ON PedidosProdutos(NumeroPedido);
CREATE INDEX idx_codigo_produto ON PedidosProdutos(CodigoProduto);
CREATE INDEX idx_numero_pedido_codigo_produto ON PedidosProdutos(NumeroPedido, CodigoProduto);

/*
SHOW TABLES;
SHOW INDEX FROM PedidoDadosGerais;
SHOW INDEX FROM PedidosProdutos;
*/