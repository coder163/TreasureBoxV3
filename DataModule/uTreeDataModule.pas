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
  uSqlConfig;
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
begin

end;

function TTreeDataModule.FindNodesWithLevel(Level: Integer): TList<TStringWrapper>;
begin

end;

function TTreeDataModule.Insert(StringWrapper: TStringWrapper): Boolean;
begin

end;

end.

