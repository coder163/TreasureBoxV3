program TreasureBox;

uses
  uCEFApplication,
  Vcl.Forms,
  uEntity in 'Domain\uEntity.pas',
  frmMainStart in 'frmMainStart.pas' {frmMain},
  frmContactAuthor in 'Forms\frmContactAuthor.pas' {ContactAuthor},
  frmRss in 'Forms\frmRss.pas' {FormRss},
  uTreeDataModule in 'DataModule\uTreeDataModule.pas',
  uSqlConfig in 'Config\uSqlConfig.pas',
  uUtils in 'Utils\uUtils.pas';

{$R *.res}

procedure CreateGlobalCEFApp;

begin
  GlobalCEFApp                  := TCefApplication.Create;

  GlobalCEFApp.AddCustomCommandLine('disable-spell-checking', '');   //TODO 这个没生效

  GlobalCEFApp.AddCustomCommandLine('lang', 'zh-CN')
  //GlobalCEFApp.LogFile          := 'cef.log';
  //GlobalCEFApp.LogSeverity      := LOGSEVERITY_VERBOSE;
end;
begin
  CreateGlobalCEFApp;
  if GlobalCEFApp.StartMainProcess then begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TContactAuthor, ContactAuthor);
  Application.CreateForm(TFormRss, FormRss);
  Application.Run;
  end;
  DestroyGlobalCEFApp;

end.
