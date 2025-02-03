unit PedidosVenda;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys, FireDAC.VCLUI.Wait,
  Data.DB, FireDAC.Comp.Client, FireDAC.Comp.DataSet, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.Grids, FireDAC.Phys.MySQL, FireDAC.Phys.MySQLDef,
  Vcl.DBGrids, Vcl.Mask, Vcl.DBCtrls, PedidoController, Model,
  System.Generics.Collections, IniFiles, dmConexao, Math;

type
  TFrmPedidoVenda = class(TForm)
    edtCodCliente: TEdit;
    edtNomeCliente: TEdit;
    Panel1: TPanel;
    lblTotal: TLabel;
    CodProduto: TLabel;
    Quantidade: TLabel;
    ValorUnit: TLabel;
    CodCliente: TLabel;
    NomeCliente: TLabel;
    btnGravarPedido: TButton;
    btnSair: TButton;
    gridProdutos: TStringGrid;
    edCodProduto: TEdit;
    edQuantidade: TEdit;
    edValorUnit: TEdit;
    btnInserirPedido: TButton;
    btnCarregarPedido: TButton;
    btnCancelarPedido: TButton;
    tDialogs: TTaskDialog;
    procedure FormCreate(Sender: TObject);
    procedure btnCancelarPedidoClick(Sender: TObject);
    procedure btnSairClick(Sender: TObject);
    procedure AtualizarTotal;
    procedure btnInserirPedidoClick(Sender: TObject);
    procedure btnGravarPedidoClick(Sender: TObject);
    procedure btnCarregarPedidoClick(Sender: TObject);
    procedure dbProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RemoverProdutoSelecionado;
    procedure EditaProdutoSelecionado;
    function BuscaDescricaoProduto(CodProd :Integer) : string;
    function BuscaCliente(CodCliente :Integer) : string;
    function BuscaPedidos(NumPedido : Integer) : Boolean;  
    procedure edValorUnitKeyPress(Sender: TObject; var Key: Char);
    procedure edValorUnitExit(Sender: TObject);
    procedure AjustarSGProdutos(StringGrid: TStringGrid);
    procedure gridProdutosDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure edtCodClienteExit(Sender: TObject);    
    procedure Alertas(titulo, menssagem : string);        
    procedure LimpaGrid(Grid: TStringGrid);
    procedure CarregarGrid;
//    procedure LimpaCampos;
  private
    { Private declarations }
    FClientes : TClientes;
    FProdutos : TList<TPedidosProdutos>;
    FController: TPedidosController;                  
  public
    { Public declarations }
  end;

var
  FrmPedidoVenda: TFrmPedidoVenda;

implementation
{$R *.dfm}

//Uses 
//  dmConexao;

{ TPedidoVenda }

procedure TFrmPedidoVenda.AjustarSGProdutos(StringGrid: TStringGrid);
var
  i, j, tamanho : Integer;
begin
  for i := 0 to StringGrid.ColCount -1 do
  begin
    tamanho := StringGrid.Canvas.TextWidth(StringGrid.Cells[i,0]) + 10;

    for j := 1 to StringGrid.ColCount -1 do
      tamanho := Max(tamanho, StringGrid.Canvas.TextWidth(StringGrid.Cells[i, j]) + 10);
    StringGrid.ColWidths[i] := tamanho;
  end;    
end;

procedure TFrmPedidoVenda.Alertas(titulo, menssagem: string);
begin
  tDialogs.Caption := titulo;
  tDialogs.Text  := menssagem;
  tDialogs.CommonButtons := [tcbOk];
  tDialogs.Execute;
end;

procedure TFrmPedidoVenda.AtualizarTotal;
Var
  Total : Double;
  Produto : TPedidosProdutos;
begin
  Total := 0;
  for Produto in FProdutos do
    Total := Total + Produto.ValorTotal;
    
  lblTotal.Caption := Format('Total do Pedido: R$ %2.f', [Total]);
end;

procedure TFrmPedidoVenda.btnCancelarPedidoClick(Sender: TObject);
Var
 NumeroPedido : Integer;
begin
  NumeroPedido := StrToInt(InputBox('Cancelar Pedido', 'Informe o Número do Pedido:', ''));
  
  FController.CancelarPedido(NumeroPedido);
  
  ShowMessage('Pedido Cancelado com Sucesso!');

  AtualizarTotal;
end;

procedure TFrmPedidoVenda.btnCarregarPedidoClick(Sender: TObject);
var
  NumeroPedido,
  NLinha, i  : Integer;
  Pedido: TPedidoDadosGerais;
  Produto : TPedidosProdutos;
begin
  LimpaGrid(gridProdutos);
  
  NumeroPedido := StrToInt(InputBox('Carregar Pedido', 'Informe o número do pedido:', ''));
  Pedido  := nil;
  Produto := nil;
  FProdutos.Clear;
  try
    // Carrega o pedido
    FController.CarregarPedido(NumeroPedido, Pedido, FProdutos);

    if Assigned(Pedido) then
    begin            
      NLinha := gridProdutos.RowCount;   
  
      for i := 0 to FProdutos.Count do
      begin    
        gridProdutos.RowCount := NLinha + i;
        gridProdutos.Cells[0, NLinha - 1] := Pedido.NumeroPedido; //Produto.CodigoProduto.ToString;
        gridProdutos.Cells[1, NLinha - 1] := BuscaDescricaoProduto(Produto.CodigoProduto); // Puxar do banco se necessário
        gridProdutos.Cells[2, NLinha - 1] := Produto.Quantidade.ToString;
        gridProdutos.Cells[3, NLinha - 1] := FormatFloat('0.00', Produto.ValorUnitario);
        gridProdutos.Cells[4, NLinha - 1] := FormatFloat('0.00', Produto.ValorTotal);  
      end;

      AjustarSGProdutos(gridProdutos);
      
      edtCodCliente.Text := Pedido.CodigoCliente.ToString;
//      edtCodCliente.OnExit(Self);
      
      AtualizarTotal;
    end
    else
    begin
      Alertas('Atenção!', 'Pedido não encontrado!');
      edtCodCliente.SetFocus;
    end;
  finally
    Pedido.Free;
  end;
end;

procedure TFrmPedidoVenda.btnGravarPedidoClick(Sender: TObject);
var
  Pedido: TPedidoDadosGerais;
  Total : String;
begin
  if edtCodCliente.Text = '' then
    raise Exception.Create('Informe o cliente antes de gravar o pedido!');

  // Cria o pedido
  Pedido := TPedidoDadosGerais.Create;
  try
    Pedido.DataEmissao := Now;
    Pedido.CodigoCliente := StrToInt(edtCodCliente.Text);    
    Total := StringReplace(lblTotal.Caption, 'Total do Pedido: R$ ','',[rfReplaceAll]);    
    Pedido.ValorTotal := StrToFloat(Total);

    // Grava no banco
    FController.GravarPedido(Pedido, FProdutos);
    ShowMessage('Pedido gravado com sucesso!');
  finally
    Pedido.Free;
  end;
end;

procedure TFrmPedidoVenda.btnInserirPedidoClick(Sender: TObject);
Var
  Produto : TPedidosProdutos;  
  NLinha : Integer;
  Descricao : String;
begin
  // Simula entrada de produto (pode ser expandido para abrir outra janela de entrada)
  Produto:= TPedidosProdutos.Create;
  Produto.CodigoProduto := StrToInt(edCodProduto.Text); //StrToInt(InputBox('Código do Produto', 'Informe o código:', ''));
  Produto.Quantidade    := StrToInt(edQuantidade.Text); //StrToInt(InputBox('Quantidade', 'Informe a quantidade:', '1'));
  Produto.ValorUnitario := StrToFloat(edValorUnit.Text);  //StrToFloat(InputBox('Valor Unitário', 'Informe o valor unitário:', '0.00'));
  Produto.ValorTotal := Produto.Quantidade * Produto.ValorUnitario;
  
  // Adiciona à lista de produtos
  FProdutos.Add(Produto);

  Descricao := BuscaDescricaoProduto(Produto.CodigoProduto);
    
  // Adiciona ao grid
  NLinha := gridProdutos.RowCount;
  gridProdutos.RowCount := NLinha + 1;
  gridProdutos.Cells[0, NLinha - 1] := Produto.CodigoProduto.ToString;
  gridProdutos.Cells[1, NLinha - 1] := Descricao; // Puxar do banco se necessário
  gridProdutos.Cells[2, NLinha - 1] := Produto.Quantidade.ToString;
  gridProdutos.Cells[3, NLinha - 1] := FormatFloat('0.00', Produto.ValorUnitario);
  gridProdutos.Cells[4, NLinha - 1] := FormatFloat('0.00', Produto.ValorTotal);

  AtualizarTotal;
  AjustarSGProdutos(gridProdutos);  
end;

procedure TFrmPedidoVenda.btnSairClick(Sender: TObject);
begin
  FrmPedidoVenda.Close;  
end;                                                                                                
                                                     
function TFrmPedidoVenda.BuscaCliente(CodCliente: Integer): string;
Var 
  Cliente : TClientes;  
begin
  if dmConexao.dtmConexao.ConectarBanco then   
  begin
    dmConexao.dtmConexao.qryCliente.Close;
    dmConexao.dtmConexao.qryCliente.ParamByName('codcliente').AsInteger := CodCliente;
    dmConexao.dtmConexao.qryCliente.Open;

    if dmConexao.dtmConexao.qryCliente.IsEmpty then 
      Result := ''
    else
    begin
      Cliente.Nome   := dmConexao.dtmConexao.qryCliente.FieldByName('nome').Value;
      Cliente.Cidade := dmConexao.dtmConexao.qryCliente.FieldByName('cidade').Value;
      Cliente.UF     := dmConexao.dtmConexao.qryCliente.FieldByName('uf').Value;       
      
      Result := Cliente.Nome;
    end;
  end;  
end;

function TFrmPedidoVenda.BuscaDescricaoProduto(CodProd: Integer): string;
Var
  Produto : TProdutos;
begin  
  if dmConexao.dtmConexao.ConectarBanco then   
  begin
    dmConexao.dtmConexao.qryProdutos.Close;
    dmConexao.dtmConexao.qryProdutos.ParamByName('codigo').AsInteger := CodProd;
    dmConexao.dtmConexao.qryProdutos.Open;

    if dmConexao.dtmConexao.qryProdutos.IsEmpty then 
      Result := ''
    else
    begin
      Produto.Descricao  := dmConexao.dtmConexao.qryProdutos.FieldByName('descricao').Value;
      Produto.PrecoVenda := dmConexao.dtmConexao.qryProdutos.FieldByName('PrecoVenda').Value; 
      
      Result := Produto.Descricao;
    end;
  end;  
end;

function TFrmPedidoVenda.BuscaPedidos(NumPedido: Integer): Boolean;
begin
  if dmConexao.dtmConexao.ConectarBanco then   
  begin
    dmConexao.dtmConexao.qryPedidos.Close;
    dmConexao.dtmConexao.qryPedidos.ParamByName('NumeroPedido').AsInteger := NumPedido;
    dmConexao.dtmConexao.qryPedidos.Open;

    if dmConexao.dtmConexao.qryCliente.IsEmpty then 
      Result := False
    else
    begin
      Cliente.Nome   := dmConexao.dtmConexao.qryPedidos.FieldByName('nome').Value;
      Cliente.Cidade := dmConexao.dtmConexao.qryPedidos.FieldByName('cidade').Value;
      Cliente.UF     := dmConexao.dtmConexao.qryPedidos.FieldByName('uf').Value;       
      
      Result := True;
    end;
  end;  

end;

procedure TFrmPedidoVenda.CarregarGrid;
Var
  Produto : TPedidosProdutos;  
  NLinha, i  : Integer;
begin                
  NLinha := gridProdutos.RowCount;   
  
  for i := 0 to FProdutos.Count do
  begin    
    gridProdutos.RowCount := NLinha + i;
    gridProdutos.Cells[0, NLinha - 1] := Produto.CodigoProduto.ToString;
    gridProdutos.Cells[1, NLinha - 1] := BuscaDescricaoProduto(Produto.CodigoProduto); // Puxar do banco se necessário
    gridProdutos.Cells[2, NLinha - 1] := Produto.Quantidade.ToString;
    gridProdutos.Cells[3, NLinha - 1] := FormatFloat('0.00', Produto.ValorUnitario);
    gridProdutos.Cells[4, NLinha - 1] := FormatFloat('0.00', Produto.ValorTotal);  
  end;

  AjustarSGProdutos(gridProdutos);
end;

procedure TFrmPedidoVenda.dbProdutosKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case key of
    VK_RETURN: //Enter para Editar
      EditaProdutoSelecionado;

    VK_DELETE: //Delete para remover
      RemoverProdutoSelecionado;
  end; 
end;
  
procedure TFrmPedidoVenda.EditaProdutoSelecionado;
var
  NovaQuantidade: Integer;
  NovoValorUnitario: Double;
begin
 if dtmConexao.FQuery.IsEmpty then
   Exit;

  // Pergunta os novos valores
  NovaQuantidade := StrToIntDef(InputBox('Editar Produto', 'Digite a nova quantidade:', dtmConexao.FQuery.FieldByName('Quantidade').AsString), -1);
  NovoValorUnitario := StrToFloatDef(InputBox('Editar Produto', 'Digite o novo valor unitário:', dtmConexao.FQuery.FieldByName('ValorUnitario').AsString), -1);

  // Valida os valores
  if (NovaQuantidade > 0) and (NovoValorUnitario > 0) then
  begin
    dtmConexao.FQuery.Edit;
    dtmConexao.FQuery.FieldByName('Quantidade').AsInteger := NovaQuantidade;
    dtmConexao.FQuery.FieldByName('ValorUnitario').AsFloat := NovoValorUnitario;
    dtmConexao.FQuery.FieldByName('ValorTotal').AsFloat := NovaQuantidade * NovoValorUnitario;
    dtmConexao.FQuery.Post;
  end
  else
    ShowMessage('Valores inválidos! Tente novamente.');
end;

procedure TFrmPedidoVenda.edtCodClienteExit(Sender: TObject);
begin
  if edtCodCliente.Text <> '' then
  begin
    if BuscaCliente(StrToInt(edtCodCliente.Text)) = '' then
      ShowMessage('Código do Cliente, inválido!')
    else   
      edtNomeCliente.Text := BuscaCliente(StrToInt(edtCodCliente.Text));
  end;
end;

procedure TFrmPedidoVenda.edValorUnitExit(Sender: TObject);
var
  Valor: Double;
begin
  Valor := StrToFloat(edValorUnit.Text);
  edValorUnit.Text := FormatFloat('#,##0.00', Valor);
end;

procedure TFrmPedidoVenda.edValorUnitKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9', ',']) then
    Key := #0;
end;

procedure TFrmPedidoVenda.FormCreate(Sender: TObject);
Var
  FDConnection : TFDConnection; 
  Conexao : TFDConnection;
begin
  edValorUnit.Text := '0,00';
  
  try                                          
    if not Assigned(dmConexao.dtmConexao) then
      dmConexao.dtmConexao :=  dmConexao.TdtmConexao.Create(Self);
      
//    if dmConexao.dtmConexao.ConectarBanco then    
//      ShowMessage('Banco Conectado');
      
//    if conexao2.Connected then
//      conexao2.Connected := True;

//    FDConnection := conexao2;
    FController := TPedidosController.Create(dmConexao.dtmConexao.conexao2);
//    Conexao.FQuery.Open; // Abre a consulta e preenche o DBGrid    
//    ShowMessage('Conexão estabelecida com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao conectar: ' + E.Message);
  end;
  
  FProdutos   := TList<TPedidosProdutos>.Create;
  

 // Configuração do Grid
  LimpaGrid(gridProdutos);
  
  AtualizarTotal;
  AjustarSGProdutos(gridProdutos);
end;

procedure TFrmPedidoVenda.gridProdutosDragDrop(Sender, Source: TObject; X,
  Y: Integer);
begin
  if gridProdutos.Cells[1, 1] <> '' then
  begin
    btnCancelarPedido.Enabled := True;
    btnGravarPedido.Enabled := True;
  end
  else
    begin
    btnCancelarPedido.Enabled := False;
    btnGravarPedido.Enabled := False;
  end;
end;

procedure TFrmPedidoVenda.LimpaGrid(Grid: TStringGrid);
begin
  Grid.RowCount := 2;
  Grid.FixedRows := 1;
  Grid.ColCount := 5;
  Grid.Cells[0, 0] := 'Código';
  Grid.Cells[1, 0] := 'Descrição';
  Grid.Cells[2, 0] := 'Quantidade';
  Grid.Cells[3, 0] := 'Valor Unitário';
  Grid.Cells[4, 0] := 'Valor Total';       
end;

procedure TFrmPedidoVenda.RemoverProdutoSelecionado;
begin
 if dtmConexao.FQuery.IsEmpty then 
   Exit;

 if MessageDlg('Deseja remover o produto selecionado?', TMsgDlgType.mtConfirmation, [mbYes, mbNo],0) = mrYes then
   dtmConexao.FQuery.Delete;
end;

end.
