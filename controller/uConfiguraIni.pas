unit uConfiguraIni;

interface

uses
  IniFiles, System.SysUtils, Vcl.Forms;

type
  TConfiguraIni = class
  public
    class var FArquivo : TIniFile;
    class procedure SetValorIni(aLocal, aSessao, aSubSessao, aValor: String);
    class function GetValorIni(aLocal, aSessao, aSubSessao: String):String;
  end;

implementation

{ TConfiguraIni }

class function TConfiguraIni.GetValorIni(aLocal, aSessao, aSubSessao: String): String;
begin
  try
    FArquivo := TIniFile.Create(aLocal);
    Result   := FArquivo.ReadString(aSessao, aSubSessao, EmptyStr);
  finally
    FreeAndNil(FArquivo);
  end;
end;

class procedure TConfiguraIni.SetValorIni(aLocal, aSessao, aSubSessao, aValor: String);
begin
  try
    FArquivo := TIniFile.Create(aLocal);
    FArquivo.WriteString(aSessao,aSubSessao,aValor);
  finally
    FreeAndNil(FArquivo);
  end;
end;

end.
