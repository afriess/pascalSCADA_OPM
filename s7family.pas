{:
  @abstract(Implmentação do protocolo ISOTCP.)
  Este driver é baseado no driver ISOTCP da biblioteca
  LibNODAVE de ...
  @author(Fabio Luis Girardi <papelhigienico@gmail.com>)
}
unit s7family;

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}

interface

uses
  classes, sysutils, ProtocolDriver, S7Types, Tag, ProtocolTypes, CrossEvent,
  commtypes;

type
  {: Driver IsoTCP. Baseado na biblioteca LibNodave de ...

  Para endereçar uma memória basta escrever na propriedade MemReadFunction a
  soma o tipo com a área da váriavel (ver tabelas abaixo).

  Tipo de dado:
  @table(
    @rowHead( @cell(Tipo de dado)                  @cell(Valor) )
    @row(     @cell(Byte, 8 bits, unsignaled)      @cell(1)     )
    @row(     @cell(Word, 16 bits, unsignaled)     @cell(2)     )
    @row(     @cell(ShortInt, 16 bits, signaled)   @cell(3)     )
    @row(     @cell(Integer, 32 bits, signaled)    @cell(4)     )
    @row(     @cell(DWord, 32 bits, unsignaled)    @cell(5)     )
    @row(     @cell(Float, 32 bits)                @cell(6)     )
  )

  Area:
  @table(
    @rowHead( @cell(Area)                       @cell(Valor) )
    @row(     @cell(Inputs, Entradas)           @cell(10)     )
    @row(     @cell(Outputs, Saidas)            @cell(20)     )
    @row(     @cell(Flags ou M's)               @cell(30)     )
    @row(     @cell(DB e VM no S7-200 )         @cell(40)     )
    @row(     @cell(Counter, S7 300/400)        @cell(50)     )
    @row(     @cell(Timer, S7 300/400)          @cell(60)     )

    @row(     @cell(Special Memory, SM, S7-200) @cell(70)     )
    @row(     @cell(Entrada analógica, S7-200)  @cell(80)     )
    @row(     @cell(Saida analógica, S7-200)    @cell(90)    )
    @row(     @cell(Counter, S7-200)            @cell(100)    )
    @row(     @cell(Timer, S7-200)              @cell(110)    )
  )

  Logo para acessar um byte das entradas, basta colocar na propriedade
  MemReadFunction o valor 10+1 = 11, para acessar a MD100 (DWord) basta
  colocar o valor 30+5 = 35.

  }

  TSiemensProtocolFamily = class(TProtocolDriver)
  protected
    function GetTagInfo(tagobj:TTag):TTagRec;
  protected
    PDUIn,PDUOut:Integer;
    FCPUs:TS7CPUs;
    function  initAdapter:Boolean; virtual;
    function  disconnectAdapter:Boolean; virtual;
    function  connectPLC(var CPU:TS7CPU):Boolean; virtual;
    function  disconnectPLC(var CPU:TS7CPU):Boolean; virtual;
    function  exchange(var CPU:TS7CPU; var msgOut:BYTES; var msgIn:BYTES; IsWrite:Boolean):Boolean; virtual;
    procedure sendMessage(var msgOut:BYTES); virtual;
    function  getResponse(var msgIn:BYTES):Integer; virtual;
    procedure listReachablePartners; virtual;
  protected
    function  SwapBytesInWord(W:Word):Word;
    procedure Send(var msg:BYTES); virtual;
    procedure PrepareToSend(var msg:BYTES); virtual;
  protected
    procedure AddParam(var MsgOut:BYTES; const param:BYTES); virtual;
    procedure InitiatePDUHeader(var MsgOut:BYTES; PDUType:Integer); virtual;
    function  NegotiatePDUSize(var CPU:TS7CPU):Boolean; virtual;
    function  SetupPDU(var msg:BYTES; MsgTypeOut:Boolean; out PDU:TPDU):Integer; virtual;
    procedure PrepareReadRequest(var msgOut:BYTES); virtual;
    procedure AddToReadRequest(var msgOut:BYTES; iArea, iDBnum, iStart, iByteCount:Integer); virtual;
  protected
    procedure DoAddTag(TagObj:TTag); override;
    procedure DoDelTag(TagObj:TTag); override;
    procedure DoTagChange(TagObj:TTag; Change:TChangeType; oldValue, newValue:Integer); override;
    procedure DoScanRead(Sender:TObject; var NeedSleep:Integer); override;
    procedure DoGetValue(TagRec:TTagRec; var values:TScanReadRec); override;
    function  DoWrite(const tagrec:TTagRec; const Values:TArrayOfDouble; Sync:Boolean):TProtocolIOResult; override;
    function  DoRead (const tagrec:TTagRec; var   Values:TArrayOfDouble; Sync:Boolean):TProtocolIOResult; override;
    procedure RunPLC(CPU:TS7CPU);
    procedure StopPLC(CPU:TS7CPU);
    procedure CopyRAMToROM(CPU:TS7CPU);
    procedure CompressMemory(CPU:TS7CPU);
  public
    constructor Create(AOwner:TComponent); override;
  published
    property ReadSomethingAlways;
  end;

implementation

uses math, syncobjs, PLCTagNumber, PLCBlock, PLCString, hsstrings,
     PLCMemoryManager;

////////////////////////////////////////////////////////////////////////////////
// CONSTRUTORES E DESTRUTORES
////////////////////////////////////////////////////////////////////////////////

constructor TSiemensProtocolFamily.Create(AOwner:TComponent);
begin
  inherited Create(AOwner);
  PDUIn:=0;
  PDUOut:=0;
end;

////////////////////////////////////////////////////////////////////////////////
// Funcoes da interface
////////////////////////////////////////////////////////////////////////////////

function  TSiemensProtocolFamily.initAdapter:Boolean;
begin

end;

function  TSiemensProtocolFamily.disconnectAdapter:Boolean;
begin

end;

function  TSiemensProtocolFamily.connectPLC(var CPU:TS7CPU):Boolean;
begin

end;

function  TSiemensProtocolFamily.disconnectPLC(var CPU:TS7CPU):Boolean;
begin

end;

function TSiemensProtocolFamily.exchange(var CPU:TS7CPU; var msgOut:BYTES; var msgIn:BYTES; IsWrite:Boolean):Boolean;
var
  pduo:TPDU;
  res:Integer;
begin
  res := SetupPDU(msgOut, true, pduo);
  if res<>0 then  begin
    Result:=False;
    exit;
  end;
  inc(CPU.PDUId);
  PPDUHeader(pduo.header)^.number:=SwapBytesInWord(CPU.PDUId);
  Result := true;
end;

procedure TSiemensProtocolFamily.sendMessage(var msgOut:BYTES);
begin

end;

function  TSiemensProtocolFamily.getResponse(var msgIn:BYTES):Integer;
begin

end;

function  TSiemensProtocolFamily.SwapBytesInWord(W:Word):Word;
var
  bl, bh:Byte;
begin
  bl := W mod $100;
  bh := W div $100;
  Result:=(bl*$100)+bh;
end;

procedure TSiemensProtocolFamily.Send(var msg:BYTES);
begin

end;

procedure TSiemensProtocolFamily.PrepareToSend(var msg:BYTES);
begin

end;

function  TSiemensProtocolFamily.NegotiatePDUSize(var CPU:TS7CPU):Boolean;
var
  param, Msg, msgIn:BYTES;
  pdu:TPDU;
  res:Integer;
begin
  Result := false;
  SetLength(param,8);
  SetLength(msg, PDUOut+10+8);

  param[0] := $F0;
  param[1] := 0;
  param[2] := 0;
  param[3] := 1;
  param[4] := 0;
  param[5] := 1;
  param[6] := 3;
  param[7] := $C0;

  InitiatePDUHeader(msg,1);
  AddParam(Msg,param);
  if exchange(CPU,Msg,msgIn,false) then begin
    res := SetupPDU(msgIn, true, pdu);
    if res=0 then begin
      CPU.MaxPDULen:=((pdu.param+6)^)*256+((pdu.param+7)^);
      Result := true;
    end;
  end;
end;

function  TSiemensProtocolFamily.SetupPDU(var msg:BYTES; MsgTypeOut:Boolean; out PDU:TPDU):Integer;
var
  position:Integer;
begin
  if MsgTypeOut then
    position:=PDUOut
  else
    position:=PDUIn;

  Result := 0;

  PDU.header:=@msg[position];
  PDU.header_len:=10;
  if PPDUHeader(PDU.header)^.PDUHeadertype in [2,3] then begin
    PDU.header_len:=12;
    Result:=SwapBytesInWord(PPDUHeader(PDU.header)^.Error);
  end;

  PDU.param:=@msg[position+PDU.header_len];
  PDU.param_len:=SwapBytesInWord(PPDUHeader(PDU.header)^.param_len);

  PDU.data:=@msg[position + PDU.header_len + PDU.param_len];
  PDU.data_len:=SwapBytesInWord(PPDUHeader(PDU.header)^.data_len);

  PDU.udata:=nil;
  PDU.user_data_len:=0
end;

procedure TSiemensProtocolFamily.PrepareReadRequest(var msgOut:BYTES);
var
  param:BYTES;
begin
  SetLength(param, 2);

  param[0] := S7FuncRead;
  param[1] := 0;
  InitiatePDUHeader(msgOut,1);
  AddParam(msgOut, param);

  SetLength(param,0);
end;

procedure TSiemensProtocolFamily.AddToReadRequest(var msgOut:BYTES; iArea, iDBnum, iStart, iByteCount:Integer);
var
  param:BYTES;
  p:PS7Req;
begin
  SetLength(param, 12);
  param[00] := $12;
  param[01] := $0a;
  param[02] := $10;
  param[03] := $02; //1=single bit, 2=byte, 4=word
  param[04] := $00; //comprimento do pedido
  param[05] := $00; //comprimento do pedido
  param[06] := $00; //numero Db
  param[07] := $00; //numero Db
  param[08] := $00; //area code;
  param[09] := $00; //start address in bits
  param[10] := $00; //start address in bits
  param[11] := $00; //start address in bits

  p := PS7Req(@param[00]);

  with TS7Req(p) do begin
    header[0]:=$12;
    header[1]:=$0A;
    header[2]:=$10;

    case iArea of
      vtS7_200_AnInput, vtS7_200_AnOutput:
        WordLen:=4;

      vtS7_Counter,
      vtS7_Timer
      vtS7_200_Counter,
      vtS7_200_Timer:
        WordLen:=iArea;
    end;

    ReqLength   :=SwapBytesInWord(iByteCount);
    DBNumber    :=SwapBytesInWord(iDBnum);
    Area        :=iArea;
    StartAddress:=SwapBytesInWord(iStart);
    Bit         :=0;
  end;

  AddParam(msgOut, param);

  SetLength(param, 0);
end;

procedure TSiemensProtocolFamily.AddParam(var MsgOut:BYTES; const param:BYTES);
var
  pdu:TPDU;
  paramlen, extra:Integer;
  res:integer;
begin
  res := SetupPDU(MsgOut, true, pdu);
  paramlen := SwapBytesInWord(PPDUHeader(pdu.header)^.param_len);

  extra := ifthen(PPDUHeader(pdu.header)^.PDUHeadertype in [2,3], 2, 0);

  if Length(MsgOut)<(PDUOut+10+extra+paramlen) then begin
    SetLength(MsgOut,(PDUOut+10+extra+paramlen));
    res := SetupPDU(MsgOut, true, pdu);
    paramlen := SwapBytesInWord(PPDUHeader(pdu.header)^.param_len);
  end;

  Move(param[0], (pdu.param + paramlen)^, Length(param));
  PPDUHeader(pdu.header)^.param_len:=SwapBytesInWord(paramlen + Length(param));
end;

procedure TSiemensProtocolFamily.InitiatePDUHeader(var MsgOut:BYTES; PDUType:Integer);
var
  pduh:PPDUHeader;
  extra:integer;
begin
  extra := ifthen(PDUType in [2,3], 2, 0);

  if Length(MsgOut)<(PDUOut+10+extra) then
    SetLength(MsgOut,(PDUOut+10+extra));

  pduh:=@MsgOut[PDUOut];
  with pduh^ do begin
    P:=$32;
    PDUHeadertype:=PDUType;
    a:=0;
    b:=0;
    number:=0;
    param_len:=0;
    data_len:=0;
    //evita escrever se ão foi alocado.
    if extra=2 then begin
      Error:=0;
    end;
  end;
end;

procedure TSiemensProtocolFamily.listReachablePartners;
begin

end;

////////////////////////////////////////////////////////////////////////////////
// FUNCOES DE MANIPULAÇAO DO DRIVER
////////////////////////////////////////////////////////////////////////////////

procedure TSiemensProtocolFamily.DoAddTag(TagObj:TTag);
var
  plc, db:integer;
  tr:TTagRec;
  foundplc, founddb:Boolean;
  area, datatype, datasize:Integer;
begin
  tr:=GetTagInfo(tag);
  foundplc:=false;

  for plc := 0 to High(FCPUs) do
    if (FCPUs[plc].Slot=Tr.Slot) AND (FCPUs[plc].Rack=Tr.Hack) AND (FCPUs[plc].Station=Tr.Station) then begin
      foundplc:=true;
      break;
    end;

  if not foundplc then begin
    plc:=Length(FCPUs);
    SetLength(FCPUs,plc+1);
    with FCPUs[plc] do begin
      Slot:=Tr.Slot;
      Rack:=Tr.Hack;
      Station :=Tr.Station;
      Inputs  :=TPLCMemoryManager.Create;
      Outputs :=TPLCMemoryManager.Create;
      AnInput :=TPLCMemoryManager.Create;
      AnOutput:=TPLCMemoryManager.Create;
      Timers  :=TPLCMemoryManager.Create;
      Counters:=TPLCMemoryManager.Create;
      Flags   :=TPLCMemoryManager.Create;
      SMs     :=TPLCMemoryManager.Create;
    end;
  end;

  area     := tr.ReadFunction div 10;
  datatype := tr.ReadFunction mod 10;

  case datatype of
    1:
      datasize:=1;
    2,3:
      datasize:=2;
    4,5,6:
      datasize:=4;
  end;

  case area of
    1:
      FCPUs[plc].Inputs.AddAddress(tr.Address,tr.Size,datasize);
    2:
      FCPUs[plc].Outputs.AddAddress(tr.Address,tr.Size,datasize);
    3:
      FCPUs[plc].Flags.AddAddress(tr.Address,tr.Size,datasize);
    4: begin
      if tr.File_DB<=0 then
        tr.File_DB:=1;

      founddb:=false;
      for db:=0 to high(FCPUs[plc].DBs) do
        if FCPUs[plc].DBs[db].DBNum=tr.File_DB then begin
          founddb:=true;
          break;
        end;

      if not founddb then begin
        db:=Length(FCPUs[plc].DBs);
        SetLength(FCPUs[plc].DBs, db+1);
        FCPUs[plc].DBs[db]:=TPLCMemoryManager.Create;
      end;

      FCPUs[plc].DBs[db].AddAddress(tr.Address,tr.Size,datasize);
    end;
    5,10:
      FCPUs[plc].Counters.AddAddress(tr.Address,tr.Size,datasize);
    6,11:
      FCPUs[plc].Timers.AddAddress(tr.Address,tr.Size,datasize);
    7:
      FCPUs[plc].SMs.AddAddress(tr.Address,tr.Size,datasize);
    8:
      FCPUs[plc].AnInput.AddAddress(tr.Address,tr.Size,datasize);
    9:
      FCPUs[plc].AnOutput.AddAddress(tr.Address,tr.Size,datasize);
  end;

  Inherited DoAddTag(TagObj);
end;

procedure TSiemensProtocolFamily.DoDelTag(TagObj:TTag);
var
  plc, db:integer;
  tr:TTagRec;
  foundplc, founddb:Boolean;
  area, datatype, datasize:Integer;
begin
  tr:=GetTagInfo(tag);
  foundplc:=false;

  for plc := 0 to High(FCPUs) do
    if (FCPUs[plc].Slot=Tr.Slot) AND (FCPUs[plc].Rack=Tr.Hack) AND (FCPUs[plc].Station=Tr.Station) then begin
      foundplc:=true;
      break;
    end;

  if not foundplc then exit;

  area     := tr.ReadFunction div 10;
  datatype := tr.ReadFunction mod 10;

  case datatype of
    1:
      datasize:=1;
    2,3:
      datasize:=2;
    4,5,6:
      datasize:=4;
  end;

  case area of
    1: begin
      FCPUs[plc].Inputs.RemoveAddress(tr.Address,tr.Size,datasize);
    end;
    2:
      FCPUs[plc].Outputs.RemoveAddress(tr.Address,tr.Size,datasize);
    3:
      FCPUs[plc].Flags.RemoveAddress(tr.Address,tr.Size,datasize);
    4: begin
      if tr.File_DB<=0 then
        tr.File_DB:=1;

      founddb:=false;
      for db:=0 to high(FCPUs[plc].DBs) do
        if FCPUs[plc].DBs[db].DBNum=tr.File_DB then begin
          founddb:=true;
          break;
        end;

      if not founddb then exit;

      FCPUs[plc].DBs[db].RemoveAddress(tr.Address,tr.Size,datasize);
    end;
    5,10:
      FCPUs[plc].Counters.RemoveAddress(tr.Address,tr.Size,datasize);
    6,11:
      FCPUs[plc].Timers.RemoveAddress(tr.Address,tr.Size,datasize);
    7:
      FCPUs[plc].SMs.RemoveAddress(tr.Address,tr.Size,datasize);
    8:
      FCPUs[plc].AnInput.RemoveAddress(tr.Address,tr.Size,datasize);
    9:
      FCPUs[plc].AnOutput.RemoveAddress(tr.Address,tr.Size,datasize);
  end;
  Inherited DoDelTag(TagObj);
end;

procedure TSiemensProtocolFamily.DoTagChange(TagObj:TTag; Change:TChangeType; oldValue, newValue:Integer);
begin
  DoDelTag(TagObj);
  DoAddTag(TagObj);
  inherited DoTagChange(TagObj, Change, oldValue, newValue);
end;

procedure TSiemensProtocolFamily.DoScanRead(Sender:TObject; var NeedSleep:Integer);
begin

end;

procedure TSiemensProtocolFamily.DoGetValue(TagRec:TTagRec; var values:TScanReadRec);
begin

end;

function  TSiemensProtocolFamily.DoWrite(const tagrec:TTagRec; const Values:TArrayOfDouble; Sync:Boolean):TProtocolIOResult;
begin

end;

function  TSiemensProtocolFamily.DoRead (const tagrec:TTagRec; var   Values:TArrayOfDouble; Sync:Boolean):TProtocolIOResult;
begin

end;

procedure TSiemensProtocolFamily.RunPLC(CPU:TS7CPU);
var
  paramToRun, msgout, msgin:BYTES;
begin
  SetLength(paramToRun,20);
  paramToRun[00]:=$28;
  paramToRun[01]:=0;
  paramToRun[02]:=0;
  paramToRun[03]:=0;
  paramToRun[04]:=0;
  paramToRun[05]:=0;
  paramToRun[06]:=0;
  paramToRun[07]:=$FD;
  paramToRun[08]:=0;
  paramToRun[09]:=0;
  paramToRun[10]:=9;
  paramToRun[11]:=$50; //P
  paramToRun[12]:=$5F; //_
  paramToRun[13]:=$50; //P
  paramToRun[14]:=$52; //R
  paramToRun[15]:=$4F; //O
  paramToRun[16]:=$47; //G
  paramToRun[17]:=$52; //R
  paramToRun[18]:=$41; //A
  paramToRun[19]:=$4D; //M

  InitiatePDUHeader(msgout, 1);
  AddParam(msgout, paramToRun);

  if not exchange(CPU,msgout,msgin,false) then
    raise Exception.Create('Falha ao tentar colocar a CPU em Run!');

end;

procedure TSiemensProtocolFamily.StopPLC(CPU:TS7CPU);
begin

end;

procedure TSiemensProtocolFamily.CopyRAMToROM(CPU:TS7CPU);
begin

end;

procedure TSiemensProtocolFamily.CompressMemory(CPU:TS7CPU);
begin

end;

function  TSiemensProtocolFamily.GetTagInfo(tagobj:TTag):TTagRec;
begin
  if Tag is TPLCTagNumber then begin
    with Result do begin
      Hack:=TPLCTagNumber(TagObj).PLCHack;
      Slot:=TPLCTagNumber(TagObj).PLCSlot;
      Station:=TPLCTagNumber(TagObj).PLCStation;
      File_DB:=TPLCTagNumber(TagObj).MemFile_DB;
      Address:=TPLCTagNumber(TagObj).MemAddress;
      SubElement:=TPLCTagNumber(TagObj).MemSubElement;
      Size:=1;
      OffSet:=0;
      ReadFunction:=TPLCTagNumber(TagObj).MemReadFunction;
      WriteFunction:=TPLCTagNumber(TagObj).MemWriteFunction;
      ScanTime:=TPLCTagNumber(TagObj).RefreshTime;
      CallBack:=nil;
    end;
    exit;
  end;

  if Tag is TPLCBlock then begin
    with Result do begin
      Hack:=TPLCBlock(TagObj).PLCHack;
      Slot:=TPLCBlock(TagObj).PLCSlot;
      Station:=TPLCBlock(TagObj).PLCStation;
      File_DB:=TPLCBlock(TagObj).MemFile_DB;
      Address:=TPLCBlock(TagObj).MemAddress;
      SubElement:=TPLCBlock(TagObj).MemSubElement;
      Size:=TPLCBlock(TagObj).Size;
      OffSet:=0;
      ReadFunction:=TPLCBlock(TagObj).MemReadFunction;
      WriteFunction:=TPLCBlock(TagObj).MemWriteFunction;
      ScanTime:=TPLCBlock(TagObj).RefreshTime;
      CallBack:=nil;
    end;
    exit;
  end;

  if Tag is TPLCString then begin
    with Result do begin
      Hack:=TPLCString(TagObj).PLCHack;
      Slot:=TPLCString(TagObj).PLCSlot;
      Station:=TPLCString(TagObj).PLCStation;
      File_DB:=TPLCString(TagObj).MemFile_DB;
      Address:=TPLCString(TagObj).MemAddress;
      SubElement:=TPLCString(TagObj).MemSubElement;
      Size:=TPLCString(TagObj).StringSize;
      OffSet:=0;
      ReadFunction:=TPLCString(TagObj).MemReadFunction;
      WriteFunction:=TPLCString(TagObj).MemWriteFunction;
      ScanTime:=TPLCString(TagObj).RefreshTime;
      CallBack:=nil;
    end;
    exit;
  end;
  raise Exception.Create(SinvalidTag);
end;

end.