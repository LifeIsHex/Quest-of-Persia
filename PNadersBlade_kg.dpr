program PNadersBlade_kg;

uses
  Forms,
  NadersBlade in 'NadersBlade.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
