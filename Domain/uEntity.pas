unit uEntity;

interface

type
    TStringWrapper = class
    private
        FName   : string;   //����
        FText   : string;   //��������
        FIsDir  : Boolean;  //�Ƿ����ļ���
        FLevel  : Integer;  //�ڵ�ȼ�
        FUrl    : string;  //������ļ���url��Ϊ���ĵ�RSS���ӣ�
        FId     : string;  //��ǰ�ڵ��ID
        FPid    : string;  //��ǰ�ڵ�ĸ��ڵ�
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

