unit uUtils;

interface
type
  TStringUtil=class

  public
    /// <summary>
    ///   ����UUID
    /// </summary>
    /// <returns>���ɺõ�UUID,���磺04DE86DDC7F8427DBDC42D26C31B2642</returns>
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
  // ���� GUID
  if CreateGUID(GUID) <> S_OK then
    raise Exception.Create('���� GUID ʧ��');
  // ת��Ϊ��׼�ַ�����ʽ
  sGUID := GUIDToString(GUID);
  // �Ƴ������ź����ַ�
  sGUID := Copy(sGUID, 2, Length(sGUID) - 2);  // ȥ����β�� { �� }
  Result := StringReplace(sGUID, '-', '', [rfReplaceAll]); // �Ƴ����ַ�
end;
end.
