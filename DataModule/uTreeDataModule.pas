{*******************************************************}
{   @author       侯叶飞                                }
{   @date         2025年5月29日                         }
{   @deprecated   树节点的数据库操作			              }
{*******************************************************}
unit uTreeDataModule;

interface

uses
  System.Generics.Collections, FireDAC.Comp.Client, uEntity;

type
  TTreeDataModule = class
  private
    FQuery: TFDQuery;
    function DB2Role(Query: TFDQuery):TStringWrapper;
  public
    constructor Create();
     /// <summary>
     ///  根据ID查询某个节点数据
     /// </summary>
     /// <param name="Id">当前节点ID</param>
     /// <returns>当前节点</returns>
    function FindById(Id: string): TStringWrapper;
     /// <summary>
     ///  查询某个父节点下的所有子节点
     /// </summary>
     /// <param name="Pid">父节点ID</param>
     /// <returns>返回子节点列表</returns>
    function FindByPid(Pid: string): TList<TStringWrapper>;

     /// <summary>
     ///  添加节点
     /// </summary>
     /// <param name="StringWrapper">需要添加的节点数据</param>
     /// <returns>成功返回True</returns>
    function Insert(StringWrapper: TStringWrapper): Boolean;

     /// <summary>
     ///  删除节点
     /// </summary>
     /// <param name="Id">节点的ID</param>
     /// <returns>删除成功返回True</returns>
    function DelById(Id: string): Boolean;
     /// <summary>
     ///  根据等级查询节点
     /// </summary>
     /// <param name="Level">等级默认为0</param>
     /// <returns>节点列表</returns>
    function FindNodesWithLevel(Level: Integer = 0): TList<TStringWrapper>;
  end;

implementation

uses
  uSqlConfig,uUtils,System.SysUtils;
{ TTreeDataModule }

constructor TTreeDataModule.Create;
begin
  FQuery := TConnection.Build.GetQuery;
end;

function TTreeDataModule.DelById(Id: string): Boolean;
begin

end;

function TTreeDataModule.FindById(Id: string): TStringWrapper;
begin

end;

function TTreeDataModule.FindByPid(Pid: string): TList<TStringWrapper>;
var
  List:TList<TStringWrapper>;
begin
  List:=TList<TStringWrapper>.Create;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := 'select * from tree_node where pid=:pid' ;
  FQuery.ParamByName('pid').AsString := Pid;
  try
   FQuery.Open();
      while not FQuery.Eof do   begin
      //读取查询到的数据，并封装成结构体，存入集合
      List.Add(DB2Role(FQuery));
      FQuery.Next;
    end;
  finally
     FQuery.Close;
  end;
 Result:=List;

end;

function TTreeDataModule.DB2Role(Query: TFDQuery):TStringWrapper;
var
  StringWrapper:TStringWrapper;
begin
   StringWrapper      := TStringWrapper.Create();
   StringWrapper.Id   := Query.FieldByName('id').AsString;
   StringWrapper.Name := Query.FieldByName('title').AsString;
   StringWrapper.Url  := Query.FieldByName('url').AsString;
   StringWrapper.Level:= Query.FieldByName('level').AsInteger;
   StringWrapper.Pid  := Query.FieldByName('pid').AsString;
   StringWrapper.IsDir :=FQuery.FieldByName('is_dir').AsBoolean       ;
   Result:=StringWrapper   ;
end;
function TTreeDataModule.FindNodesWithLevel(Level: Integer): TList<TStringWrapper>;
var
  List:TList<TStringWrapper>;
begin
  List:=TList<TStringWrapper>.Create;
  FQuery.SQL.Clear;
  FQuery.SQL.Text := 'select * from tree_node where level=:level' ;
  FQuery.ParamByName('level').AsString := level.ToString;
  try
   FQuery.Open();
      while not FQuery.Eof do   begin
      //读取查询到的数据，并封装成结构体，存入集合
      List.Add(DB2Role(FQuery));
      FQuery.Next;
    end;
  finally
     FQuery.Close;
  end;
 Result:=List;


end;

function TTreeDataModule.Insert(StringWrapper: TStringWrapper): Boolean;
begin
   Result:=False;
   FQuery.SQL.Clear;
   try
     FQuery.SQL.Add('INSERT INTO tree_node(id,title,url, pid,level,is_dir') ;
     FQuery.SQL.Add(' )VALUES (') ;
     FQuery.SQL.Add(':id,:title,:url, :pid,:level,:is_dir');
     FQuery.SQL.Add(')');
     FQuery.ParamByName('Id').AsString         := StringWrapper.Id;
     FQuery.ParamByName('title').AsString      := StringWrapper.Name;
     FQuery.ParamByName('url').AsString        := StringWrapper.url;
     FQuery.ParamByName('level').AsString      := inttostr(StringWrapper.level);
     FQuery.ParamByName('pid').AsString        := StringWrapper.Pid;
     FQuery.ParamByName('is_dir').AsBoolean        := StringWrapper.IsDir;
     FQuery.ExecSQL;
     Result:= FQuery.RowsAffected>0;
   finally
    FQuery.Close;
   end;
end;

end.

