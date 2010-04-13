{:
  @abstract(Tipos comuns aos CLP's da familia Siemens.)
  @author(Fabio Luis Girardi <papelhigienico@gmail.com>)
}
unit S7Types;

{$IFDEF FPC}
{$MODE DELPHI}
{$ENDIF}

interface

uses
  PLCMemoryManager;

type
  PDU = record
    header:PByte;           // pointer to start of PDU (PDU header)
    param:PByte;            // pointer to start of parameters inside PDU
    data:PByte;             // pointer to start of data inside PDU
    udata:PByte;            // pointer to start of data inside PDU
    header_len:Integer;     // header length
    param_len:Integer;      // parameter length
    data_len:Integer;       // data length
    user_data_len:Integer;  // user or result data length
  end;

  //: Identifica um DB da familia S7-300/S7-400
  TS7DB = Record
    DBNum:Cardinal;
    DBArea:TPLCMemoryManager;
  end;
  //: Identifica um conjunto de DB's da familia S7-300/S7-400
  TS7DBs = array of TS7DB;

  //: Representação de um CLP S7-200/300/400 da Siemens.
  TS7CPU=record
    Station,
    Rack,
    Slot:Integer;
    Connected:Boolean;
    Inputs:TPLCMemoryManager;
    Outputs:TPLCMemoryManager;
    DBs:TS7DBs;
    Timers:TPLCMemoryManager;
    Counters:TPLCMemoryManager;
    Memorys:TPLCMemoryManager;
    SMs:TPLCMemoryManager;
  end;

  //: Representação de um conjunto de CLP's S7-200/300/400 da Siemens.
  TS7CPUs = array of TS7CPU;

  //: Identifica o meio de conexão com o CLP.
  TISOTCPConnectionWay = (ISOTCP,ISOTCP_VIA_CP243);

const

  vtS7_200_SysInfo = $03;
  vtS7_200_SM      = $05;
  vtS7_200_AnInput = $06;
  vtS7_200_AnOutput= $07;
  vtS7_200_Counter =  30;
  vtS7_200_Timer   =  31;
  vtS7_200_VM      = $87;


  vtS7_Inputs  = $81;
  vtS7_Outputs = $82;
  vtS7_Flags   = $83;
  vtS7_DB      = $84;
  vtS7_DI      = $85;  //DB Instanciado
  vtS7_Local   = $86;  //not tested
  vtS7_Counter =  28;  //S7 counters
  vtS7_Timer   =  29;  // S7 timers


implementation

end.

