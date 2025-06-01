unit frmRss;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
   scControls, scGPExtControls, scGPDBControls, scGPControls, PythonEngine,
   SyncObjs;
type
  TFormRss = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    EdtUrl: TEdit;
    EdtTitle: TEdit;
    Button1: TButton;
    scGPActivityBar1: TscGPActivityBar;
    PythonEngine1: TPythonEngine;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure PythonEngine1BeforeLoad(Sender: TObject);
  private
    { Private declarations }
    FLock: TCriticalSection;
  public
    { Public declarations }
  
  end;
    TMyThread = class(TThread)
  private
    FEngine: TPythonEngine;
    FPythonLock: TCriticalSection;
    FThreadNum: Integer;
  protected
    procedure Execute; override;
  public
    constructor Create(AEngine: TPythonEngine; ALock: TCriticalSection; AThreadNum: Integer);
  end;
var
  FormRss: TFormRss;

implementation

{$R *.dfm}
 uses
  System.Threading, System.IOUtils,
  VirtualTrees.Types, VarPyth,
  frmMainStart,uEntity;
constructor TMyThread.Create(AEngine: TPythonEngine; ALock: TCriticalSection; AThreadNum: Integer);
begin
  inherited Create(False);
  FEngine := AEngine;
  FPythonLock := ALock;
  FThreadNum := AThreadNum;
  FreeOnTerminate := True;
end;


procedure TMyThread.Execute;
var
  PyResult  : Variant;
  PyModule  : Variant;
begin
  try
    FPythonLock.Acquire;

    try

     TThread.Synchronize(nil,procedure begin
        // 禁用按钮并激活加载指示器
      FormRss.Button1.Enabled := False;
      FormRss.scGPActivityBar1.Active := True;

     end) ;
      try
//       GetPythonEngine().ExecString('import sys; sys.path.append("D:/workspace-delphi/P4D/bin/")'); // 路径改成你的 mymodule.py 所在目录
        GetPythonEngine().ExecString('import sys; sys.path.append("./Script")');
        pymodule := Import('feedparserscript');
        pyresult := pymodule.get_rss_entries(FormRss.EdtUrl.Text);
        TThread.Synchronize(nil,procedure
        var
          I             : Integer;
          Entry         : Variant;
          StringWrapper : TStringWrapper;
          CurrentNode   : PVirtualNode ;
          NewNode       : PVirtualNode;
          NodeDataPtr   : ^Pointer;
        begin
            CurrentNode:= frmMain.AppendChild(TStringWrapper.Create(FormRss.EdtTitle.Text,'',True,0) );
            for i := 0 to VarPyth.Len(PyResult) - 1 do begin
              Entry := PyResult.GetItem(i);           // 获取Python列表元素
              StringWrapper := TStringWrapper.create(VarToStr(Entry.GetItem('title')),VarToStr(Entry.GetItem('summary')),false,1);
              NewNode       := frmMain.VTS.AddChild(CurrentNode) ;
              NodeDataPtr   := frmMain.VTS.GetNodeData(NewNode);
              NodeDataPtr^  := Pointer(StringWrapper);   //绑定数据

            end;
        end);
      finally
        TThread.Synchronize(nil,procedure begin
            FormRss.scGPActivityBar1.Active:=False;
            FormRss.Button1.Enabled := true;
            if VarPyth.Len(PyResult) <=0 then begin
              Application.MessageBox('解析失败。', '码农宝盒', MB_ICONINFORMATION);
            end;
        end);

      end;
    finally
      FPythonLock.Release;

    end;
  except
    on E: Exception do
      Application.MessageBox(PChar('出现了异常：'+ E.Message), '码农宝盒', MB_ICONINFORMATION);
      //FormRss.Memo1.Lines.add(PChar('Thread exception: ' + E.ClassName + ': ' + E.Message));
  end;
end;

// 修改后的按钮点击事件
procedure TFormRss.Button1Click(Sender: TObject);
begin
  if Trim(EdtUrl.Text) = '' then
  begin
    // 可选：提示用户输入URL
     Application.MessageBox('请输入RSS链接。', '码农宝盒', MB_ICONINFORMATION);
    Exit;
  end;
  PythonEngine1.Py_Initialize;
  TMyThread.Create(PythonEngine1, FLock, 0);
end;

procedure TFormRss.Button2Click(Sender: TObject);
begin
  if not Button1.Enabled then
    Application.MessageBox('对不起请求未结束，请等待请求结束', '码农宝盒', MB_OK or MB_ICONWARNING  )
  else
    Close
end;

procedure TFormRss.FormCreate(Sender: TObject);
begin
  FLock := TCriticalSection.Create;

end;

procedure TFormRss.FormDestroy(Sender: TObject);
begin
  FLock.Free;
end;

procedure TFormRss.PythonEngine1BeforeLoad(Sender: TObject);
var
  PythonHome : string;
begin
  PythonHome:=ExtractFilePath(Application.ExeName)+'python310';
  PythonEngine1.DllPath    := PythonHome;
  PythonEngine1.DllName    :='python310.dll';
  PythonEngine1.APIVersion := 1013;
  PythonEngine1.SetPythonHome(PythonHome);
//  PythonEngine1.LoadDll;
   // 添加初始化脚本
  PythonEngine1.InitScript.Add('import sys');
  PythonEngine1.InitScript.Add('sys.path.append(r"' + PythonHome + '\Lib")');
  PythonEngine1.InitScript.Add('sys.path.append(r"' + PythonHome + '\DLLs")')

   // 配置编码环境变量
//  SetEnvironmentVariable('PYTHONUTF8', '1');

end;

end.


