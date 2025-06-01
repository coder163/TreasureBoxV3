unit frmMainStart;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, scControls, scGPControls, scGPFontControls, Vcl.ExtCtrls,
   VirtualTrees.BaseAncestorVCL, VirtualTrees.BaseTree, VirtualTrees.AncestorVCL, VirtualTrees,
   Vcl.StdCtrls, Vcl.Menus, scModernControls, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
   DynVarsEh, MemTableDataEh,Data.DB, MemTableEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
    System.ImageList, Vcl.ImgList, scExtControls, scAdvancedControls,uCEFInterfaces,
   Entity, Vcl.Buttons,  uCEFChromiumCore, uCEFChromium, Vcl.ComCtrls, Vcl.ToolWin, uCEFWinControl, uCEFWindowParent;

type


  TfrmMain = class(TForm)
    scGPPanel11: TscGPPanel;
    scPageViewer1: TscPageViewer;
    scPageViewerPage1: TscPageViewerPage;
    scPageViewerPage2: TscPageViewerPage;
    scLabel2: TscLabel;
    Splitter1: TSplitter;
    VTS: TVirtualStringTree;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    TreeImages: TImageList;
    PopupMenu1: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    scGPCharGlyphButton1: TscGPCharGlyphButton;
    scGPCharGlyphButton2: TscGPCharGlyphButton;
    scGPCharGlyphButton3: TscGPCharGlyphButton;
    scPageViewerPage3: TscPageViewerPage;
    scLabel3: TscLabel;
    PopupMenu2: TPopupMenu;
    N8: TMenuItem;
    ImageList1: TImageList;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    BoldBtn: TToolButton;
    ItalicBtn: TToolButton;
    UnderlineBtn: TToolButton;
    StrikethroughBtn: TToolButton;
    Separator2: TToolButton;
    AlignLeftBtn: TToolButton;
    AlignCenterBtn: TToolButton;
    AlignRightBtn: TToolButton;
    AlignJustifyBtn: TToolButton;
    Separator3: TToolButton;
    LinkBtn: TToolButton;
    ImageBtn: TToolButton;
    Separator4: TToolButton;
    UnorderedListBtn: TToolButton;
    OrderedListBtn: TToolButton;
    Separator5: TToolButton;
    TextColorBtn: TToolButton;
    FillColorBtn: TToolButton;
    Separator6: TToolButton;
    RemoveFormatBtn: TToolButton;
    Separator7: TToolButton;
    OutdentBtn: TToolButton;
    IndentBtn: TToolButton;
    ToolButton1: TToolButton;
    CopyBtn: TToolButton;
    CutBtn: TToolButton;
    PasteBtn: TToolButton;
    CEFWindowParent1: TCEFWindowParent;
    Chromium1: TChromium;
    Timer1: TTimer;


    procedure FormCreate(Sender: TObject);
    procedure VTSGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
    procedure VTSGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;
      var ImageIndex: TImageIndex);
    procedure N6Click(Sender: TObject);
    procedure scGPCharGlyphButton1Click(Sender: TObject);
    procedure scGPCharGlyphButton2Click(Sender: TObject);
    procedure scGPCharGlyphButton3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure Splitter1Moved(Sender: TObject);
    procedure VTSClick(Sender: TObject);

    procedure Panel2Resize(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
    procedure Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
    procedure Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure VTSContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);


  private
    { Private declarations }
    FMaxTextLength: Integer; // 动态控制显示的最大字数
//    FWebView: TWkeWebView;
    FCanClose : boolean;  // Set to True in TChromium.OnBeforeClose
    FClosing  : boolean;  // Set to True in the CloseQuery event.
  public

    { Public declarations }
    /// <summary>
    ///   向根节点追加节点
    /// </summary>
    /// <param name="StringWrapper">要追加的节点</param>
    function AppendChild(StringWrapper:TStringWrapper): PVirtualNode;


    procedure TraverseFirstLevelChildren(Tree: TVirtualStringTree; ParentNode: PVirtualNode);

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.dfm}
uses
 System.IOUtils,ActiveX ,MSHTML,IdHTTP,System.NetEncoding,
 VirtualTrees.Types,uCEFConstants,uCEFTypes,
  uCEFCommandLine,

frmContactAuthor,frmRss;

 procedure TfrmMain.TraverseFirstLevelChildren(Tree: TVirtualStringTree; ParentNode: PVirtualNode);
var
  Child,NodeDataPtr: PVirtualNode;
  Data: TStringWrapper;
begin
  Child := Tree.GetFirstChild(Tree.RootNode); // 第一个顶级节点
  while Assigned(Child) do begin
    // 处理子节点
    Data := TStringWrapper(VTS.GetNodeData(Child)^);
    ShowMessage(Data.Name);
    //获取当前节点的子节点
    NodeDataPtr:= Tree.GetFirstChild(Child)  ;
    //遍历子节点
     while Assigned(NodeDataPtr) do begin
         Data := TStringWrapper(VTS.GetNodeData(NodeDataPtr)^);
         ShowMessage(Data.Name);
         NodeDataPtr := Tree.GetNextSibling(NodeDataPtr); // 移动到下一个兄弟节点
     end;


    Child := Tree.GetNextSibling(Child); // 移动到下一个兄弟节点
  end;
end;

procedure TfrmMain.N5Click(Sender: TObject);
var
  Result: Integer;
begin
  //TODO 删除节点
   Result:=Application.MessageBox('确认删除当前节点么？', '码农宝盒', MB_YESNO or MB_ICONINFORMATION  );
   if Result= IDYES then
      ShowMessage('用户选择了删除')
end;

procedure TfrmMain.N6Click(Sender: TObject);
begin
  //联系作者
  ContactAuthor.ShowModal;
end;



procedure TfrmMain.N8Click(Sender: TObject);
begin
     //添加订阅
   FormRss.ShowModal;
end;

procedure TfrmMain.Panel2Resize(Sender: TObject);
begin
  //重置大小

//    wkeMoveWindow(FWebView, 0, 0,Panel2.Width, Panel2.Height);
end;

procedure TfrmMain.scGPCharGlyphButton1Click(Sender: TObject);
begin
   scPageViewer1.PageIndex := 0;
end;


procedure TfrmMain.scGPCharGlyphButton2Click(Sender: TObject);
begin
    scPageViewer1.PageIndex := 1;
end;

procedure TfrmMain.scGPCharGlyphButton3Click(Sender: TObject);
begin
    scPageViewer1.PageIndex := 2;
end;



procedure TfrmMain.Splitter1Moved(Sender: TObject);
begin
     // 根据 VirtualStringTree 的宽度动态调整最大显示字数
  FMaxTextLength := VTS.Width div 12; // 假设每 10 像素显示一个字符
  VTS.Invalidate; // 重新绘制树控件
end;

procedure TfrmMain.Timer1Timer(Sender: TObject);
begin
     Timer1.Enabled := False;
  // 二次尝试绑定直到成功
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) and not(Chromium1.Initialized) then
    Timer1.Enabled := True
end;

function TfrmMain.AppendChild(StringWrapper:TStringWrapper): PVirtualNode;
var
  Root        : PVirtualNode;
  NewNode     : PVirtualNode;
  NodeDataPtr : ^Pointer;
begin
  NewNode       := VTS.AddChild(nil) ;
  NodeDataPtr   := VTS.GetNodeData(NewNode);
  NodeDataPtr^  := Pointer(StringWrapper);   //绑定数据
  Result        := NewNode;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //TODO 记录VST的状态
  TraverseFirstLevelChildren(VTS,nil);
end;

procedure TfrmMain.Chromium1AfterCreated(Sender: TObject; const browser: ICefBrowser);
begin
  PostMessage(Handle, CEF_AFTERCREATED, 0, 0);
end;

procedure TfrmMain.Chromium1BeforeClose(Sender: TObject; const browser: ICefBrowser);
begin
  FCanClose := True;
  PostMessage(Handle, WM_CLOSE, 0, 0);
end;

procedure TfrmMain.Chromium1LoadEnd(Sender: TObject; const browser: ICefBrowser; const frame: ICefFrame; httpStatusCode: Integer);
var
  TempCode : string;
begin

  if 'file:///index.html'<>  Chromium1.DefaultUrl then begin
    TempCode := 'document.designMode = "on";';
    Chromium1.ExecuteJavaScript(TempCode, 'about:blank');
  end;
end;



procedure TfrmMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := FCanClose;
  if not(FClosing) then begin
      FClosing := True;
      Visible  := False;
      Chromium1.CloseBrowser(True);
      CEFWindowParent1.Free;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  scPageViewer1.PageIndex := 0;
  //清空现有节点
  VTS.Clear;
  FMaxTextLength := VTS.Width div 12;
  FCanClose      := False;
  FClosing       := False;
  Chromium1.DefaultURL := 'file:///index.html';
  //TODO 读取配置文件反序列化为树
end;



procedure TfrmMain.FormShow(Sender: TObject);
begin
  if not(Chromium1.CreateBrowser(CEFWindowParent1)) then
      MessageBox(Handle, 'CEF加载失败！', '码农宝典', MB_ICONWARNING or MB_OK);

end;

procedure TfrmMain.VTSClick(Sender: TObject);
var
  Node: PVirtualNode;
  Data: TStringWrapper;
  Html: TStringBuilder;
begin
  // 获取当前焦点节点
  Node := VtS.FocusedNode;
  if Assigned(Node) then begin
    Data := TStringWrapper(VtS.GetNodeData(Node)^);
    if Assigned(Data) and (not Data.IsDir) then begin
      Html:=TStringBuilder.Create('<script src="./theme/script/lib/prism/prism.js" ></script>');
      html.Append('<script src="./theme/script/lib/clipboard2.0.4.js" ></script>') ;
      html.Append('<link href="./theme/script/lib/prism/prism.css" rel="stylesheet"/>') ;

      html.Append('<link rel="stylesheet" href="./theme/default.css">') ;
      Html.Append('<div id="go-top"><a href="#">&nbsp;</a></div><div id="content">') ;
      html.Append(Data.Text+'</div>');
      Chromium1.LoadString(Html.ToString);
      html.Free;
    end;

  end;
  //TODO 如果点击的是文件夹并且是没有子节点的情况下需要加载
end;



procedure TfrmMain.VTSGetImageIndex(Sender: TBaseVirtualTree; Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex; var Ghosted: Boolean;var ImageIndex: TImageIndex);
var
  Data : TStringWrapper;
begin
  if (Kind in [ikNormal, ikSelected]) then begin
    if (Sender.NodeParent[Node] = nil) and ( VTS.Expanded[Node]) then           //根节点展开
      ImageIndex:=0
    else if (Sender.NodeParent[Node] = nil) and (not VTS.Expanded[Node]) then   //根节点合并
      ImageIndex := 2
    else begin
      Data := TStringWrapper(Sender.GetNodeData(Node)^);
      if Assigned(Data) and Data.IsDir and (VTS.Expanded[Node]) then             //文件夹、展开
        ImageIndex := 0
      else  if Assigned(Data) and  Data.IsDir and (not VTS.Expanded[Node]) then  //文件夹、合并
        ImageIndex := 2
       else                                                   //文件
        ImageIndex := 1;
    end;
  end;
end;

procedure TfrmMain.VTSGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType; var CellText: string);
var
    Data : TStringWrapper;
begin
    Data := TStringWrapper(Sender.GetNodeData(Node)^);
    if Assigned(Data) then begin
      CellText := Data.Name;

      if Length(CellText) > Self.FMaxTextLength then
        CellText := Copy(CellText, 1, Self.FMaxTextLength) + '...';
    end;

end;

procedure TfrmMain.VTSContextPopup(Sender: TObject; MousePos: TPoint; var Handled: Boolean);
var
  Node: PVirtualNode;
  Data: TStringWrapper;
  ScreenPos: TPoint;
begin
  Node := VTS.GetNodeAt(MousePos.X, MousePos.Y);  // 使用事件自带的鼠标坐标
  ScreenPos := VTS.ClientToScreen(MousePos);      // 转换为屏幕坐标

  if Assigned(Node) then
  begin
    Data := TStringWrapper(VTS.GetNodeData(Node)^);
    if Data.IsDir then
    begin
      VTS.Selected[Node] := True;  // 先选中节点
      PopupMenu1.Popup(ScreenPos.X, ScreenPos.Y);
    end
    else
      PopupMenu2.Popup(ScreenPos.X, ScreenPos.Y);
  end
  else
    PopupMenu2.Popup(ScreenPos.X, ScreenPos.Y);
end;
end.
