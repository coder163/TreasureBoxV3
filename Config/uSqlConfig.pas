{*******************************************************}
{   @author       ��Ҷ��                                }
{   @date         2025��5��29��                         }
{   @deprecated   ����ģʽ������Connection����Ψһ      }
{*******************************************************}
unit uSqlConfig;

interface
uses
  FireDAC.Comp.Client, FireDAC.Phys.SQLite, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.DApt, FireDAC.Comp.DataSet,firedac.Stan.Def,FireDAC.VCLUI.Wait,
  Firedac.Stan.Async;

type
    TConnection=class
      private
         class var  FInstance:TConnection;        //��̬˽�г�Ա
         class var FLock: TObject;
         var
            FConnection : TFDConnection;            //˽��һ�����Ӷ���
            FQuery      : TFDQuery;
         constructor Create();                    //˽�й��캯��
      public
        class function Build: TConnection;        //��д����Ĺ�������
           //�ͷŵĺ���
         destructor Destroy;override;
         function GetQuery():TFDQuery;  //�������Ӷ���
    end;
implementation


{ TConnection }

class function TConnection.Build: TConnection;
begin
   try
      TMonitor.Enter(FLock); //�����ٽ���
      //�ж�FInstance �Ƿ�Ϊnull,
      if not Assigned(FInstance)  then begin
        FInstance:=TConnection.Create;
      end;
   finally
     TMonitor.Exit(FLock); //�뿪�ٽ���
   end;

  Result:=FInstance;
end;

constructor TConnection.Create;
begin
  //��װ(����)Connection
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'SQLite';
  FConnection.Params.Add('Database=./FDB/Tree.db');
  FConnection.Connected:=True;
  //����Query
  FQuery := TFDQuery.Create(nil);
  FQuery.Connection := FConnection;

end;


destructor TConnection.Destroy;
begin
  FConnection.Free;
  FQuery.Free;
  inherited;
end;

function TConnection.GetQuery: TFDQuery;
begin
    Result:= FQuery;
end;

initialization
  TConnection.FLock := TObject.Create;   //FLock����TConnection�ľ�̬��Ա
finalization
  TConnection.FInstance.Free;           //�ͷ�
  TConnection.FLock.Free;
end.
