unit uEntity;

interface

type
    TStringWrapper = class
    private
        FName   : string;   //名字
        FText   : string;   //文章内容
        FIsDir  : Boolean;  //是否是文件夹
        FLevel  : Integer;  //节点等级
        FUrl    : string;  //如果是文件夹url则为订阅的RSS链接，
        FId     : string;  //当前节点的ID
        FPid    : string;  //当前节点的父节点
    public
       constructor Create(const Name: string; const Text: string; IsDir: Boolean; Level: Integer);
       destructor Destroy; override;
       property Url: string read FUrl write FUrl;
       property Id: string read FId write FId;
       property Pid: string read FPid write FPid;
       property Text: string read FText write FText;
       property Name: string read FName write FName;
       property IsDir: Boolean read FIsDir write FIsDir;
       property Level: Integer read FLevel write FLevel;
    end;

implementation

constructor TStringWrapper.Create(const Name: string; const Text: string; IsDir: Boolean; Level: Integer);
begin
    inherited Create;
    FName  := Name;
    FText  := Text;
    FIsDir := IsDir;
    FLevel := Level;
end;

destructor TStringWrapper.Destroy;
begin
    inherited Destroy;
end;

end.

