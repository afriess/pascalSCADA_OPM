{$i language.inc}
{$IFDEF PORTUGUES}
{:
  @abstract(Implementação dos editores de algumas propriedades de componentes
            do PascalSCADA.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
}
{$ELSE}
{:
  @abstract(Implements some property editors of PascalSCADA.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
}
{$ENDIF}
unit scadapropeditor;

{$IFDEF FPC}
{$MODE Delphi}
{$ENDIF}

{$I delphiver.inc}

interface

uses
  Classes, SysUtils, SerialPort, PLCBlockElement,

  {$IF defined(WIN32) or defined(WIN64) OR defined(WINCE)}
  Windows,
  {$ELSE}
  Unix,
  {$IFEND}
  
  {$IFDEF FPC}
    PropEdits;
  {$ELSE}
    Types,
    //Delphi 6 ou superior
    {$IF defined(DELPHI6_UP)}
      DesignIntf, DesignEditors;
    {$ELSE}
      //demais versoes do delphi
      DsgnIntf;
    {$IFEND}
  {$ENDIF}

type
  {$IFDEF PORTUGUES}
  //: Editor da propriedade TSerialPortDriver.COMPort
  {$ELSE}
  //: Property editor of TSerialPortDriver.COMPort property.
  {$ENDIF}
  TPortPropertyEditor = class(TStringProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    function  GetValue: string; override;
    procedure GetValues(Proc: TGetStrProc); override;
    procedure SetValue(const Value: string); override;
  end;

  {$IFDEF PORTUGUES}
  //: Editor da propriedade TPLCBlockElement.Index
  {$ELSE}
  //: Property editor of TPLCBlockElement.Index property.
  {$ENDIF}
  TElementIndexPropertyEditor = class(TIntegerProperty)
  public
    function  GetAttributes: TPropertyAttributes; override;
    procedure GetValues(Proc: TGetStrProc); override;
  end;

implementation

function  TPortPropertyEditor.GetAttributes: TPropertyAttributes;
begin
   if GetComponent(0) is TSerialPortDriver then
      Result := [paValueList{$IFDEF FPC}, paPickList{$ELSE}
                 {$IFDEF DELPHI2005_UP}, paReadOnly,
                 paValueEditable{$ENDIF}{$ENDIF}];
end;

function  TPortPropertyEditor.GetValue: string;
begin
   Result := GetStrValue;
end;

procedure TPortPropertyEditor.GetValues(Proc: TGetStrProc);
{$IF defined(WIN32) or defined(WIN64)}
var
  c:Integer;
  dcbstring, comname:String;
  d:DCB;
begin
  Proc('(none)');
  for c:=1 to 255 do begin
     comname := 'COM'+IntToStr(c);
     dcbstring := comname+': baud=1200 parity=N data=8 stop=1';
     if BuildCommDCB(PChar(dcbstring),d) then
        Proc(comname);
  end;
{$IFEND}
{$IFDEF UNIX}
var
   c, d:Integer;
   pname:String;
begin
   Proc('(none)');
   for d:=0 to High(PortPrefix) do
      {$IFDEF SunOS}
      for c:=Ord('a') to ord('z') do begin
         pname:=PortPrefix[d]+Char(c);
      {$ELSE}
      for c:=0 to 255 do begin
         pname:=PortPrefix[d]+IntToStr(c);
      {$ENDIF}
         if FileExists('/dev/'+pname) then
            Proc(pname);
      end;
{$ENDIF}
{$IFDEF WINCE}
begin
  //ToDo
{$ENDIF}
end;

procedure TPortPropertyEditor.SetValue(const Value: string);
begin
   SetStrValue(Value);
   if GetComponent(0) is TSerialPortDriver then
      TSerialPortDriver(GetComponent(0)).Active := false;
end;

//editores de propriedades de BlinkWith
function  TElementIndexPropertyEditor.GetAttributes: TPropertyAttributes;
begin
   if GetComponent(0) is TPLCBlockElement then
      Result := [paValueList{$IFNDEF FPC}{$IFDEF DELPHI2005_UP}, paReadOnly,
                 paValueEditable{$ENDIF}{$ENDIF}];
end;

procedure TElementIndexPropertyEditor.GetValues(Proc: TGetStrProc);
var
   i:Integer;
begin
   if (GetComponent(0) is TPLCBlockElement) and (TPLCBlockElement(GetComponent(0)).PLCBlock <> nil) then
      for i := 0 to Integer(TPLCBlockElement(GetComponent(0)).PLCBlock.Size)-1 do begin
          Proc(IntToStr(i));
      end;
end;


{function  TComponentNameEditorEx.GetAttributes: TPropertyAttributes;
begin
  Result := [paMultiSelect];
end;}


end.

