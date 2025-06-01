{*******************************************************}
{   @author       侯叶飞                                }
{   @date         2025年5月29日                         }
{   @deprecated   单例模式，保持Connection对象唯一      }
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
         class var  FInstance:TConnection;        //静态私有成员
         class var FLock: TObject;
         var
            FConnection : TFDConnection;            //私有一个连接对象
            FQuery      : TFDQuery;
         constructor Create();                    //私有构造函数
      public
        class function Build: TConnection;        //编写对外的公开函数
           //释放的函数
         destructor Destroy;override;
         function GetQuery():TFDQuery;  //返回连接对象
    end;
implementation


{ TConnection }

class function TConnection.Build: TConnection;
begin
   try
      TMonitor.Enter(FLock); //进入临界区
      //判断FInstance 是否为null,
      if not Assigned(FInstance)  then begin
        FInstance:=TConnection.Create;
      end;
   finally
     TMonitor.Exit(FLock); //离开临界区
   end;

  Result:=FInstance;
end;

constructor TConnection.Create;
begin
  //组装(配置)Connection
  FConnection := TFDConnection.Create(nil);
  FConnection.DriverName := 'SQLite';
  FConnection.Params.Add('Database=./FDB/Tree.db');
  FConnection.Connected:=True;
  //创建Query
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
  TConnection.FLock := TObject.Create;   //FLock它是TConnection的静态成员
finalization
  TConnection.FInstance.Free;           //释放
  TConnection.FLock.Free;
end.
