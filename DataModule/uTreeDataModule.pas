{*******************************************************}
{   @author       ��Ҷ��                                }
{   @date         2025��5��29��                         }
{   @deprecated   ���ڵ�����ݿ����			              }
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
     ///  ����ID��ѯĳ���ڵ�����
     /// </summary>
     /// <param name="Id">��ǰ�ڵ�ID</param>
     /// <returns>��ǰ�ڵ�</returns>
    function FindById(Id: string): TStringWrapper;
     /// <summary>
     ///  ��ѯĳ�����ڵ��µ������ӽڵ�
     /// </summary>
     /// <param name="Pid">���ڵ�ID</param>
     /// <returns>�����ӽڵ��б�</returns>
    function FindByPid(Pid: string): TList<TStringWrapper>;

     /// <summary>
     ///  ��ӽڵ�
     /// </summary>
     /// <param name="StringWrapper">��Ҫ��ӵĽڵ�����</param>
     /// <returns>�ɹ�����True</returns>
    function Insert(StringWrapper: TStringWrapper): Boolean;

     /// <summary>
     ///  ɾ���ڵ�
     /// </summary>
     /// <param name="Id">�ڵ��ID</param>
     /// <returns>ɾ���ɹ�����True</returns>
    function DelById(Id: string): Boolean;
     /// <summary>
     ///  ���ݵȼ���ѯ�ڵ�
     /// </summary>
     /// <param name="Level">�ȼ�Ĭ��Ϊ0</param>
     /// <returns>�ڵ��б�</returns>
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
      //��ȡ��ѯ�������ݣ�����װ�ɽṹ�壬���뼯��
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
      //��ȡ��ѯ�������ݣ�����װ�ɽṹ�壬���뼯��
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

