unit uUtils;

interface
type
  TStringUtil=class

  public
    /// <summary>
    ///   生成UUID
    /// </summary>
    /// <returns>生成好的UUID,例如：04DE86DDC7F8427DBDC42D26C31B2642</returns>
    class function GetUuid():string;
  end;
implementation
uses
  System.SysUtils;
class function TStringUtil.GetUuid():string;
var
  GUID  : TGUID;
  sGUID : string;
begin
  // 生成 GUID
  if CreateGUID(GUID) <> S_OK then
    raise Exception.Create('生成 GUID 失败');
  // 转换为标准字符串格式
  sGUID := GUIDToString(GUID);
  // 移除大括号和连字符
  sGUID := Copy(sGUID, 2, Length(sGUID) - 2);  // 去除首尾的 { 和 }
  Result := StringReplace(sGUID, '-', '', [rfReplaceAll]); // 移除连字符
end;
end.
