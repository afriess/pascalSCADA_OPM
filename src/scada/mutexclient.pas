﻿{$i ../common/language.inc}
{$IFDEF PORTUGUES}
{:
  @abstract(Unit que implementa um mutex de rede.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
}
{$ELSE}
{:
  @abstract(Unit that implements a network mutex.)
  @author(Fabio Luis Girardi <fabio@pascalscada.com>)
}
{$ENDIF}
unit MutexClient;

{$IFDEF FPC}
{$mode delphi}
{$ENDIF}

{$I ../common/delphiver.inc}
interface

uses
  Classes, SysUtils, ExtCtrls, CommPort, commtypes, socket_types, CrossEvent,
  syncobjs
  {$IF defined(WIN32) or defined(WIN64)} //delphi or lazarus over windows
    {$IFDEF FPC}
    , WinSock2,
    {$ELSE}
    , WinSock,
    {$ENDIF}
    sockets_w32_w64
  {$ELSE}
  {$IF defined(FPC) AND (defined(UNIX) or defined(WINCE))}
  , Sockets {$IFDEF UNIX}  , sockets_unix, netdb, Unix{$ENDIF}
            {$IFDEF WINCE} , sockets_wince {$ENDIF}
            {$IFDEF FDEBUG}, LCLProc{$ENDIF}
  {$IFEND}
  {$IFEND};

type

  { TMutexClientThread }

  TMutexClientThread = class(TCrossThread)
  private
    fConnectionBroken: TNotifyEvent;
    FOwnMutex:Boolean;
    fServerHasBeenFinished: TNotifyEvent;
    FSocket:Tsocket;
    FEnd:TCrossEvent;
    FSocketMutex:TCriticalSection;
  private
    procedure ConnectionIsGone;
  protected
    //called when client got the mutex
    procedure SetIntoServerMutexBehavior; virtual;
    //called when the client leaves the mutex.
    procedure SetOutServerMutexBehavior; virtual;
    //check for ping commmands when client owns the mutex.
    procedure Execute; override;
    //called when server sends a quit command.
    procedure ServerHasBeenFinished; virtual;
  public
    constructor Create(CreateSuspended: Boolean; aSocket: Tsocket);
    destructor Destroy; override;
    //try enter on server mutex.
    function TryEnter:Boolean;
    //leave the server mutex.
    procedure Leave;
    //send a quit command to server.
    procedure DisconnectFromServer; virtual;
    //wait the client thread ends.
    procedure WaitEnd;
  published
    property onServerHasBeenFinished:TNotifyEvent read fServerHasBeenFinished write fServerHasBeenFinished;
    property onConnectionBroken:TNotifyEvent read fConnectionBroken write fConnectionBroken;
  end;

  { TMutexClient }

  TMutexClient = class(TComponent)
  private
    FActive,
    FActiveLoaded,
    FConnected: Boolean;
    FPort: Word;
    FServerHost:String;
    FSocket: TSocket;
    FConnectionStatusThread:TMutexClientThread;
    procedure Connect;
    procedure Disconnect;
    procedure setActive(AValue: Boolean);
    procedure SetPort(AValue: Word);
    procedure SetServerHost(AValue: String);
  protected
    procedure Loaded; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    function    TryEnter:Boolean;
    procedure   Leave;
  published
    property Active:Boolean read FActive write setActive stored true default false;
    property Host:String read FServerHost write SetServerHost stored true nodefault;
    property Port:Word read FPort write SetPort stored true default 52321;
  end;

implementation

uses hsstrings;

{ TMutexClientThread }

procedure TMutexClientThread.ConnectionIsGone;
begin
  if Assigned(fConnectionBroken) then
    fConnectionBroken(Self);
end;

procedure TMutexClientThread.SetIntoServerMutexBehavior;
begin
  FOwnMutex:=true;
end;

procedure TMutexClientThread.SetOutServerMutexBehavior;
begin
  FOwnMutex:=False;
end;

procedure TMutexClientThread.Execute;
var
  serverrequest,
  request:Byte;
  commresult: TIOResult;
  incRetries: Boolean;
  StillActive: Boolean;
begin
  FEnd.ResetEvent;
  while (not Terminated) do begin
    if FOwnMutex then begin
      FSocketMutex.Enter;
      repeat
        if socket_recv(FSocket,@serverrequest,1,0,5)>=1 then begin
          case serverrequest of
            21:
              SetIntoServerMutexBehavior;
            20, 30, 31, 32:
              SetOutServerMutexBehavior;
            253:
              ServerHasBeenFinished;
            255: begin
              request:=254;
              socket_send(FSocket,@request,1,0,5000);
            end;
          end;
        end else begin
          if not CheckConnection(commresult,incRetries,StillActive,FSocket,nil) then begin
            Synchronize(ConnectionIsGone);
            Break;
          end;
        end;
      until GetNumberOfBytesInReceiveBuffer(FSocket)<=0;
      FSocketMutex.Leave;
    end;

    Sleep(1);
  end;
  FEnd.SetEvent;
end;

procedure TMutexClientThread.DisconnectFromServer;
var
  request, response:Byte;
begin
  FSocketMutex.Enter;
  request:=253;//try enter on mutex
  socket_send(FSocket,@request,1,0,5000);
  FSocketMutex.Leave;
  Terminate;
end;

procedure TMutexClientThread.WaitEnd;
begin
  while not (FEnd.WaitFor(10)=wrSignaled) do
    CheckSynchronize();
end;

procedure TMutexClientThread.ServerHasBeenFinished;
begin
  Terminate;
end;

constructor TMutexClientThread.Create(CreateSuspended: Boolean; aSocket: Tsocket
  );
begin
  inherited Create(CreateSuspended);
  FSocketMutex:=TCriticalSection.Create;
  FEnd:=TCrossEvent.Create(nil,true,false,'');
  FSocket:=aSocket;
end;

destructor TMutexClientThread.Destroy;
begin
  FSocketMutex.Destroy;
  FEnd.Destroy;
  inherited Destroy;
end;

function TMutexClientThread.TryEnter: Boolean;
var
  request, response:Byte;
begin
  Result:=False;
  FSocketMutex.Enter;
  try
    request:=2;//try enter on mutex
    if socket_send(FSocket,@request,1,0,5000)>=1 then begin
      repeat
        if socket_recv(FSocket,@response,1,0,5000)>=1 then begin
          case response of
            20: begin
              Result:=false;
              SetOutServerMutexBehavior;
            end;
            21: begin
              Result:=true;
              SetIntoServerMutexBehavior;
            end;
            253: begin
              Result:=false;
              ServerHasBeenFinished;
              break;
            end;
            255: begin
              request:=254;
              socket_send(FSocket,@request,1,0,5000)
            end;
          end;
        end else begin
          //if the program is at this line,
          //is because it send the request,
          //but don´t received a response (timeout)
          //so, release the mutex sending
          //a release command.
          request:=3; //leave mutex command.
          socket_send(FSocket,@request,1,0,5000);
        end;
      until GetNumberOfBytesInReceiveBuffer(FSocket)<=0;
    end;
  finally
    FSocketMutex.Leave;
  end;
end;

procedure TMutexClientThread.Leave;
var
  request, response:Byte;
begin
  FSocketMutex.Enter;
  try
    request:=3;//try enter on mutex
    if socket_send(FSocket,@request,1,0,5000)>=1 then begin
      repeat
        if socket_recv(FSocket,@response,1,0,5000)>=1 then begin
          case response of
            30, 31, 32:
              SetOutServerMutexBehavior;
            253: begin
              ServerHasBeenFinished;
              break;
            end;
            255: begin
              request:=254;
              socket_send(FSocket,@request,1,0,5000)
            end;
          end;
        end;
      until GetNumberOfBytesInReceiveBuffer(FSocket)<=0;
    end;
  finally
    FSocketMutex.Leave;
  end;
end;

{ TMutexClient }

procedure TMutexClient.Connect;
var
{$IF defined(FPC) and defined(UNIX)}
  ServerAddr:THostEntry;
  channel:sockaddr_in;
{$IFEND}

{$IF defined(FPC) and defined(WINCE)}
  channel:sockaddr_in;
{$IFEND}

{$IF defined(WIN32) or defined(WIN64)}
  ServerAddr:PHostEnt;
  channel:sockaddr_in;
{$IFEND}

  flag:Integer;
  socketOpen:boolean;
begin

  if FConnected then exit;

  socketOpen:=false;

  try
    //##########################################################################
    // RESOLUCAO DE NOMES SOBRE WINDOWS 32/64 BITS.
    // NAME RESOLUTION OVER WINDOWS 32/64 BITS.
    //##########################################################################
    {$IF defined(WIN32) or defined(WIN64)}
      //se esta usando FPC ou um Delphi abaixo da versao 2009, usa a versão
      //ansistring, caso seja uma versao delphi 2009 ou superior
      //usa a versao unicode.
      //
      //if the name resolution is being done using FPC or Delphi 2009 or older
      //uses the ansistring version, otherwise uses the unicode version.
      {$IF defined(FPC) OR (not defined(DELPHI2009_UP))}
      ServerAddr := GetHostByName(PAnsiChar(FServerHost));
      {$ELSE}
      ServerAddr := GetHostByName(PAnsiChar(AnsiString(FServerHost)));
      {$IFEND}
      if ServerAddr=nil then begin
        //PActive:=false;
        //RefreshLastOSError;
        exit;
      end;
    {$IFEND}

    //##########################################################################
    // RESOLUCAO DE NOMES SOBRE LINUX/FREEBSD e outros.
    // NAME RESOLUTION OVER LINUX/FREEBSD and others.
    //##########################################################################
    {$IF defined(FPC) and defined(UNIX)}
      if not GetHostByName(FServerHost,ServerAddr) then begin
        ServerAddr.Addr:=StrToHostAddr(FServerHost);
        if ServerAddr.Addr.s_addr=0 then begin
          //PActive:=false;
          //RefreshLastOSError;
          exit;
        end;
      end;
    {$IFEND}

    //##########################################################################
    // CRIA O SOCKET
    // CREATE THE SOCKET.
    //##########################################################################

    {$IF defined(FPC) AND (defined(UNIX) or defined(WINCE))}
    //UNIX and WINDOWS CE
    FSocket := fpSocket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    if FSocket<0 then begin
      //PActive:=false;
      //RefreshLastOSError;
      exit;
    end;
    {$ELSE}
    //WINDOWS
    FSocket :=   Socket(PF_INET, SOCK_STREAM, IPPROTO_TCP);

    if FSocket=INVALID_SOCKET then begin
      //PActive:=false;
      //RefreshLastOSError;
      exit;
    end;
    {$IFEND}

    socketOpen:=true;

    //##########################################################################
    //SETA O MODO DE OPERACAO DE NAO BLOQUEIO DE CHAMADA.
    //SET THE NON-BLOCKING OPERATING MODE OF THE SOCKET
    //##########################################################################
    setblockingmode(FSocket,MODE_NONBLOCKING);

    //##########################################################################
    //SETA AS OPCOES DO SOCKET
    //OPCOES DE TIMEOUT IRÃO SER FEITAS USANDO SELECT/FPSELECT
    //POIS ESTAS OPÇÕES NÃO SAO SUPORTADAS POR ALGUNS SISTEMAS OPERACIONAIS
    //
    //SOCKET OPTIONS
    //TIMEOUT OPTIONS ARE MADE USING SELECT/FPSELECT, BECAUSE THIS OPTIONS
    //AREN'T SUPPORTED BY SOME OSes LIKE WINDOWS CE
    //##########################################################################
    flag:=1;
    //UNIX AND WINDOWS CE
    {$IF defined(FPC) AND (defined(UNIX) or defined(WINCE))}
    fpsetsockopt(FSocket, IPPROTO_TCP, TCP_NODELAY,  @flag,           sizeof(Integer));
    {$IFEND}
    //WINDOWS
    {$IF defined(WIN32) or defined(WIN64)}
    setsockopt  (FSocket, IPPROTO_TCP, TCP_NODELAY, PAnsiChar(@flag), sizeof(Integer));
    {$IFEND}

    //##########################################################################
    //CONFIGURA E ENDERECO QUE O SOCKET VAI CONECTAR
    //SETS THE TARGET ADDRESS TO SOCKET CONNECT
    //##########################################################################
    channel.sin_family      := AF_INET;      //FAMILY
    channel.sin_port        := htons(FPort); //PORT NUMBER

    {$IF defined(FPC) AND defined(UNIX)}
    channel.sin_addr.S_addr := longword(htonl(LongInt(ServerAddr.Addr.s_addr)));
    {$IFEND}

    {$IF defined(FPC) AND defined(WINCE)}
    channel.sin_addr := StrToNetAddr(FHostName);
    {$IFEND}

    {$IF defined(WIN32) OR defined(WIN64)}
    channel.sin_addr.S_addr := PInAddr(Serveraddr.h_addr^).S_addr;
    {$IFEND}

    if connect_with_timeout(FSocket,@channel,sizeof(channel),2000)<>0 then begin
      //PActive:=false;
      //RefreshLastOSError;
      exit;
    end;
    FConnected:=true;
    FConnectionStatusThread:=TMutexClientThread.Create(true, FSocket);

    //after setup the thread, wake up it.
    FConnectionStatusThread.WakeUp;
  finally
    if socketOpen and (not FConnected) then
      CloseSocket(FSocket);
  end;
end;

procedure TMutexClient.Disconnect;
begin
  if FConnected then begin
    if FConnectionStatusThread<>nil then begin
      FConnectionStatusThread.DisconnectFromServer;
      FConnectionStatusThread.WaitEnd;
      FConnectionStatusThread.Destroy;
    end;
    FConnectionStatusThread:=nil;
    CloseSocket(FSocket);
    FConnected:=false;
  end;
end;

procedure TMutexClient.setActive(AValue: Boolean);
begin
  if [csLoading,csReading]*ComponentState<>[] then begin
    FActiveLoaded:=AValue;
    exit;
  end;

  if [csDesigning]*ComponentState<>[] then begin
    FActive:=AValue;
    exit;
  end;

  if AValue then
    Connect
  else
    Disconnect;

  FActive:=AValue;
end;

procedure TMutexClient.SetPort(AValue: Word);
begin
  if FActive then
    raise exception.Create(SimpossibleToChangeWhenActive);

  if (AValue<1) or (AValue>65535) then
    raise exception.Create(SimpossibleToChangeWhenActive);

  if FPort=AValue then Exit;

  FPort:=AValue;
end;

procedure TMutexClient.SetServerHost(AValue: String);
begin
  if FActive then
    raise exception.Create(SimpossibleToChangeWhenActive);

  if FServerHost=AValue then Exit;
  FServerHost:=AValue;
end;

procedure TMutexClient.Loaded;
begin
  inherited Loaded;
  setActive(FActiveLoaded);
end;

constructor TMutexClient.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FPort:=51342;
  FActive:=false;
  FConnected:=false;
  FActiveLoaded:=false;
end;

destructor TMutexClient.Destroy;
begin

  setActive(false);
  inherited Destroy;
end;

function TMutexClient.TryEnter: Boolean;
var
  request, response:Byte;
begin
  Result:=False;
  if FActive then begin
    //if not connected, connect
    if not FConnected then
      Connect;

    //if still disconnected, exit.
    if not FConnected then exit;

    if FConnectionStatusThread=nil then exit;

    Result:=FConnectionStatusThread.TryEnter;
  end;
end;

procedure TMutexClient.Leave;
var
  request, response:Byte;
begin
  if FActive then begin
    //if not connected, connect
    if not FConnected then
      Connect;

    //if still disconnected, exit.
    if not FConnected then exit;

    if FConnectionStatusThread=nil then exit;

    FConnectionStatusThread.Leave;
  end;
end;

end.
