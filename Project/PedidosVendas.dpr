program PedidosVendas;

uses
  Vcl.Forms,
  PedidosVenda in '..\Views\PedidosVenda.pas' {FrmPedidoVenda},
  PedidoController in '..\Controllers\PedidoController.pas',
  Model in '..\Models\Model.pas',
  dmConexao in '..\Controllers\dmConexao.pas' {dtmConexao: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPedidoVenda, FrmPedidoVenda);
  Application.CreateForm(TdtmConexao, dtmConexao);
  Application.Run;
end.
