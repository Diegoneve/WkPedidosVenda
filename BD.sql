/* Tabela de Clientes
2. Campos da tabela de clientes (Código, Nome, Cidade, UF) */
CREATE TABLE Clientes (
    Codigo INT AUTO_INCREMENT PRIMARY key,
    Nome VARCHAR(100) NOT NULL,
    Cidade VARCHAR(100),
    UF CHAR(2)
);
/* Tabela de Produtos
3. Campos da tabela de produtos (Código, Descrição, Preço de venda) */
CREATE TABLE Produtos (
    Codigo INT AUTO_INCREMENT PRIMARY KEY,
    Descricao VARCHAR(100) NOT NULL,
    PrecoVenda DECIMAL(10, 2) NOT NULL
);

/* Tabela de Pedidos
  14. Campos da tabela de pedidos dados gerais (Número pedido, Data emissão, Código cliente, Valor total) */  
CREATE TABLE PedidosDadosGerais(
    NumeroPedido INT PRIMARY KEY AUTO_INCREMENT,
    DataEmissao DATETIME NOT NULL,
    CodigoCliente INT NOT NULL,
    ValorTotal DECIMAL(10, 2),
    FOREIGN KEY (CodigoCliente) REFERENCES Clientes(Codigo)
);

/* Tabela de Produtos do Pedido
   15. Campos da tabela de pedidos produtos (Autoincrem, Número pedido, Código produto, Quantidade, Vir. Unitário, Vir. Total) 
   17. O pedido deve possuir número sequencial crescente
   18. A chave primária da tabela de dados gerais do pedido deve ser (Número pedido), não podendo haver duplicidade entre os registros gravados
   19. A chave primária da tabela de produtos deve ser (autoincrem), pois pode existir repetição de produtos 
*/
CREATE TABLE PedidosProdutos (
    Id INT PRIMARY KEY AUTO_INCREMENT,
    NumeroPedido INT NOT NULL,
    CodigoProduto INT NOT NULL,
    Quantidade INT NOT NULL,
    ValorUnitario DECIMAL(10, 2) NOT NULL,
    ValorTotal DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (NumeroPedido) REFERENCES Pedidos(NumeroPedido),
    FOREIGN KEY (CodigoProduto) REFERENCES Produtos(Codigo)
);