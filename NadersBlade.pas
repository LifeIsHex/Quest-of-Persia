unit NadersBlade;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edt1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt2: TEdit;
    lbl21: TLabel;
    edt3: TEdit;
    btn1: TButton;
    lbl3: TLabel;
    procedure btn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function HexToInt(const h: string): longint;
var
  Rt: LongInt;
  i: Byte;
begin
  Rt := 0;
  for i := 1 to Length(h) do
    case h[i] of
      '0'..'9':
        Rt := Rt shl 4 + ord(h[i]) - Ord('0');
      'a'..'f':
        Rt := Rt shl 4 + ord(h[i]) - Ord('a') + 10;
      'A'..'F':
        Rt := Rt shl 4 + ord(h[i]) - Ord('A') + 10;
    else
      begin
        Result := -1;
        Exit;
      end;
    end;
  result := Rt;
end;

function cIntToHex(c: Cardinal; digits: Byte; letter_case: Byte): string;
var
  a: Cardinal;
  r: Byte;
  temp: string;
const
  hUpper = '0123456789ABCDEF';
  hLower = '0123456789abcdef';
begin
  temp := '';
  if c = 0 then
    temp := '0'
  else
  begin
    a := c;
    while a <> 0 do
    begin
      r := a mod 16;
      a := a div 16;
      if letter_case = 0 then
        temp := hUpper[r + 1] + temp
      else
        temp := hLower[r + 1] + temp;
    end;
  end;

  if Length(temp) < digits then
    temp := StringOfChar('0', digits - Length(temp)) + temp;

  Result := temp;
end;

function BytesToString(const Bytes: array of Byte): string;
var
  i: Integer;
begin
  Result := '';
  for i := Low(Bytes) to High(Bytes) do
    Result := Result + Chr(Bytes[i]);
end;

function s004016b0(input: Integer): string;
var
  rBytes: array[0..6] of byte;
begin
  asm
        push    ebx
        mov     eax, input
        mov     ebx, eax
        mov     eax, $04ec4ec4f
        imul    ebx
        sar     edx, 3
        mov     ecx, edx
        SHR     ecx, $01f
        add     ecx, edx
        mov     al, cl
        mov     dl, $01a
        imul    dl
        sub     bl, al
        add     bl, $041
        mov     eax, $04ec4ec4f
        imul    ecx
        sar     edx, 3
        mov     byte ptr ds:[rBytes[0]], bl
        mov     ebx, edx
        SHR     ebx, $01f
        add     ebx, edx
        mov     al, bl
        mov     dl, $01a
        imul    dl
        sub     cl, al
        add     cl, $041
        mov     eax, $04ec4ec4f
        imul    ebx
        sar     edx, 3
        mov     byte ptr ds:[rBytes[1]], cl
        mov     ecx, edx
        SHR     ecx, $01f
        add     ecx, edx
        mov     al, cl
        mov     dl, $01a
        imul    dl
        sub     bl, al
        mov     eax, $04ec4ec4f
        imul    ecx
        sar     edx, 3
        add     bl, $041
        mov     byte ptr ds:[rBytes[2]], bl
        mov     ebx, edx
        SHR     ebx, $01f
        add     ebx, edx
        mov     al, bl
        mov     dl, $01a
        imul    dl
        sub     cl, al
        mov     eax, $04ec4ec4f
        imul    ebx
        add     cl, $041
        sar     edx, 3
        mov     byte ptr ds:[rBytes[3]], cl
        mov     ecx, edx
        SHR     ecx, $01f
        add     ecx, edx
        mov     al, cl
        mov     dl, $01a
        imul    dl
        sub     bl, al
        add     bl, $041
        mov     al, bl
        mov     byte ptr ds:[rBytes[4]], al
        mov     ebx, ecx
        mov     eax, $04ec4ec4f
        imul    ebx
        sar     edx, 3
        mov     ecx, edx
        SHR     ecx, $01f
        add     ecx, edx
        mov     al, cl
        mov     dl, $01a
        imul    dl
        sub     bl, al
        mov     eax, $04ec4ec4f
        imul    ecx
        sar     edx, 3
        add     bl, $041
        mov     eax, edx
        mov     byte ptr ds:[rBytes[5]], bl
        SHR     eax, $01f
        add     eax, edx
        mov     dl, $01a
        imul    dl
        sub     cl, al
        add     cl, $041
        mov     byte ptr ds:[rBytes[6]], cl
        pop     ebx
  end;

  Result := BytesToString(rBytes);
end;

function RandomWord: Word;
begin
  // Random range from 0 to 65535
  Result := Word(Random(65536));
end;

function RandomByte: Byte;
begin
  // Random range from 0 to 255
  Result := Byte(Random(256));
end;

function HexToStr(Value: string): string;
var
  i: Integer;
begin
  i := 1;
  result := '';
  repeat
    result := Result + chr(HexToInt(Copy(Value, i, 2)));
    Inc(i, 2);
  until i > Length(Value);
end;

function UpdateValue(var value: Integer): string;
var
  modResult: Integer;
begin
  modResult := (value mod $1A) + $41;
  value := value div $1A;
  Result := HexToStr(cIntToHex(modResult, 2, 0));
end;

function Random_Serial(PLen, Mode: Integer): string;
var
  char: string;
begin
  if Mode > 6 then
  begin
    Result := 'Error : PLen > 6 .';
    exit;
  end;

  Randomize;
  case Mode of
    0:
      char := '1234657890';
    1:
      char := '1234657890abcdefghijklmnopqrstuvwxyz';
    2:
      char := '1234657890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    3:
      char := 'abcdefghijklmnopqrstuvwxyz';
    4:
      char := 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    5:
      char := 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ';
    6:
      char := '1234657890ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  end;

  result := '';
  repeat
    result := result + char[Random(Length(char)) + 1];
  until (Length(result) = PLen)
end;

function GetDriveSerialNumber(Drive: char): Cardinal;
var
  OldErrorMode: Integer;
  NotUsed: DWord;
  VolFlags: DWord;
  No: DWord;
begin
  OldErrorMode := SetErrorMode(SEM_FAILCRITICALERRORS);
  try
    GetVolumeInformation(PChar(Drive + ':\'), nil, 0, @No, NotUsed, VolFlags, nil, 0);
    Result := Integer(No);
  finally
    SetErrorMode(OldErrorMode);
  end;
end;

procedure Generate_Serial;
var
  b_1, b_2, b_3: Integer;
  i: Integer;
  cValue_1: Integer;
  cValue_2: Integer;
  tmp_1: Integer;
  tmp_2: Integer;
  dSerial: Integer;
  bRandom: dword;
  sTmp: array[0..1] of string;
  sn, reg_code, activation: string;
begin
  cValue_1 := 14231;
  cValue_2 := 3971;

  // bRandom:= RandomWord;
  // bRandom := RandomByte;
  bRandom := strtoint(random_serial(4, 0));

  tmp_1 := (cValue_1 * bRandom) + $15278405;
  tmp_2 := (cValue_2 * bRandom) + $14F65C74;

  for i := 1 to 7 do
  begin
    sTmp[0] := sTmp[0] + UpdateValue(tmp_2);
    sTmp[1] := sTmp[1] + UpdateValue(tmp_1);
  end;

  sn := sTmp[0] + sTmp[1];

  asm
        XOR     edx, edx
        XOR     eax, eax

@loop:
        mov     ecx, sn
        movsx   ecx, byte ptr ds:[ecx + eax]
        add     eax, 2
        add     edx, ecx
        cmp     eax, $0e
        jl      @loop
        lea     eax, dword ptr ds:[edx + 5]
        cdq
        mov     edi, $01a
        idiv    edi
        add     dl, $041
        mov     b_1, edx
  end;

  sn := sn + HexToStr(cIntToHex(b_1, 2, 0));

  dSerial := GetDriveSerialNumber('c') shr 1;

  reg_code := s004016b0(dSerial);
  reg_code := reg_code + s004016b0((bRandom * $18AD) + $115F8301);

  b_1 := 0;

  asm
        XOR     edx, edx
        XOR     eax, eax

@loop:
        mov     ecx, reg_code
        movsx   ecx, byte ptr ds:[ecx + eax]
        add     eax, 2
        add     edx, ecx
        cmp     eax, $0e
        jl      @loop
        lea     eax, dword ptr ds:[edx + 5]
        cdq
        mov     edi, $01a
        idiv    edi
        add     dl, $041
        mov     b_1, edx
  end;
  reg_code := reg_code + HexToStr(cIntToHex(b_1, 2, 0));

  b_1 := 0;

  b_1 := bRandom * $875D;
  asm
        mov     eax, dSerial
        cdq
        sub     eax, edx
        sar     eax, 1
        mov     b_2, eax
  end;
  b_2 := b_1 + b_2 + $06a2cd7f;

  activation := s004016b0(b_2);

  b_1 := 0;
  b_2 := 0;

  b_2 := bRandom * $741E;
  asm
        mov     edi, dSerial
        mov     esi, b_2
        mov     eax, $055555556
        imul    edi
        mov     eax, edx
        SHR     eax, $01f
        add     esi, edx
        mov     b_3, esi
        mov     b_1, eax
  end;

  b_3 := b_1 + b_3 + $609CC74;
  activation := activation + s004016b0(b_3);

  b_3 := 0;

  asm
        XOR     edx, edx
        XOR     eax, eax

@loop:
        mov     ecx, activation
        movsx   ecx, byte ptr ds:[ecx + eax]
        add     eax, 2
        add     edx, ecx
        cmp     eax, $0e
        jl      @loop
        lea     eax, dword ptr ds:[edx + 5]
        cdq
        mov     edi, $01a
        idiv    edi
        add     dl, $041
        mov     b_3, edx
  end;

  activation := activation + HexToStr(cIntToHex(b_3, 2, 0));

  Form1.edt1.Text := Pchar(sn);
  Form1.edt2.Text := Pchar(reg_code);
  Form1.edt3.Text := Pchar(activation);
end;

procedure TForm1.btn1Click(Sender: TObject);
begin
  Generate_Serial;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Generate_Serial;
end;

end.

