unit Unit2; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, tcp_udpport, ISOTCPDriver, PLCBlock,
  PLCBlockElement, PLCTagNumber;

type

  { TDataModule1 }

  TDataModule1 = class(TDataModule)
    BateladasAProduzir: TPLCTagNumber;
    BateladasProduzidas: TPLCTagNumber;
    BL2Antecipacao_1: TPLCBlockElement;
    BL2Antecipacao_10: TPLCBlockElement;
    BL2Antecipacao_2: TPLCBlockElement;
    BL2Antecipacao_3: TPLCBlockElement;
    BL2Antecipacao_4: TPLCBlockElement;
    BL2Antecipacao_5: TPLCBlockElement;
    BL2Antecipacao_6: TPLCBlockElement;
    BL2Antecipacao_7: TPLCBlockElement;
    BL2Antecipacao_8: TPLCBlockElement;
    BL2Antecipacao_9: TPLCBlockElement;
    BL2CodigoProd_1: TPLCBlockElement;
    BL2CodigoProd_10: TPLCBlockElement;
    BL2CodigoProd_2: TPLCBlockElement;
    BL2CodigoProd_3: TPLCBlockElement;
    BL2CodigoProd_4: TPLCBlockElement;
    BL2CodigoProd_5: TPLCBlockElement;
    BL2CodigoProd_6: TPLCBlockElement;
    BL2CodigoProd_7: TPLCBlockElement;
    BL2CodigoProd_8: TPLCBlockElement;
    BL2CodigoProd_9: TPLCBlockElement;
    BL2Corte_1: TPLCBlockElement;
    BL2Corte_10: TPLCBlockElement;
    BL2Corte_2: TPLCBlockElement;
    BL2Corte_3: TPLCBlockElement;
    BL2Corte_4: TPLCBlockElement;
    BL2Corte_5: TPLCBlockElement;
    BL2Corte_6: TPLCBlockElement;
    BL2Corte_7: TPLCBlockElement;
    BL2Corte_8: TPLCBlockElement;
    BL2Corte_9: TPLCBlockElement;
    BL2VelFinal_1: TPLCBlockElement;
    BL2VelFinal_10: TPLCBlockElement;
    BL2VelFinal_2: TPLCBlockElement;
    BL2VelFinal_3: TPLCBlockElement;
    BL2VelFinal_4: TPLCBlockElement;
    BL2VelFinal_5: TPLCBlockElement;
    BL2VelFinal_6: TPLCBlockElement;
    BL2VelFinal_7: TPLCBlockElement;
    BL2VelFinal_8: TPLCBlockElement;
    BL2VelFinal_9: TPLCBlockElement;
    BL2VelInicial_1: TPLCBlockElement;
    BL2VelInicial_10: TPLCBlockElement;
    BL2VelInicial_2: TPLCBlockElement;
    BL2VelInicial_3: TPLCBlockElement;
    BL2VelInicial_4: TPLCBlockElement;
    BL2VelInicial_5: TPLCBlockElement;
    BL2VelInicial_6: TPLCBlockElement;
    BL2VelInicial_7: TPLCBlockElement;
    BL2VelInicial_8: TPLCBlockElement;
    BL2VelInicial_9: TPLCBlockElement;
    BL3Antecipacao_1: TPLCBlockElement;
    BL3Antecipacao_10: TPLCBlockElement;
    BL3Antecipacao_2: TPLCBlockElement;
    BL3Antecipacao_3: TPLCBlockElement;
    BL3Antecipacao_4: TPLCBlockElement;
    BL3Antecipacao_5: TPLCBlockElement;
    BL3Antecipacao_6: TPLCBlockElement;
    BL3Antecipacao_7: TPLCBlockElement;
    BL3Antecipacao_8: TPLCBlockElement;
    BL3Antecipacao_9: TPLCBlockElement;
    BL3CodigoProd_1: TPLCBlockElement;
    BL3CodigoProd_10: TPLCBlockElement;
    BL3CodigoProd_2: TPLCBlockElement;
    BL3CodigoProd_3: TPLCBlockElement;
    BL3CodigoProd_4: TPLCBlockElement;
    BL3CodigoProd_5: TPLCBlockElement;
    BL3CodigoProd_6: TPLCBlockElement;
    BL3CodigoProd_7: TPLCBlockElement;
    BL3CodigoProd_8: TPLCBlockElement;
    BL3CodigoProd_9: TPLCBlockElement;
    BL3Corte_1: TPLCBlockElement;
    BL3Corte_10: TPLCBlockElement;
    BL3Corte_2: TPLCBlockElement;
    BL3Corte_3: TPLCBlockElement;
    BL3Corte_4: TPLCBlockElement;
    BL3Corte_5: TPLCBlockElement;
    BL3Corte_6: TPLCBlockElement;
    BL3Corte_7: TPLCBlockElement;
    BL3Corte_8: TPLCBlockElement;
    BL3Corte_9: TPLCBlockElement;
    BL3VelFinal_1: TPLCBlockElement;
    BL3VelFinal_10: TPLCBlockElement;
    BL3VelFinal_2: TPLCBlockElement;
    BL3VelFinal_3: TPLCBlockElement;
    BL3VelFinal_4: TPLCBlockElement;
    BL3VelFinal_5: TPLCBlockElement;
    BL3VelFinal_6: TPLCBlockElement;
    BL3VelFinal_7: TPLCBlockElement;
    BL3VelFinal_8: TPLCBlockElement;
    BL3VelFinal_9: TPLCBlockElement;
    BL3VelInicial_1: TPLCBlockElement;
    BL3VelInicial_10: TPLCBlockElement;
    BL3VelInicial_2: TPLCBlockElement;
    BL3VelInicial_3: TPLCBlockElement;
    BL3VelInicial_4: TPLCBlockElement;
    BL3VelInicial_5: TPLCBlockElement;
    BL3VelInicial_6: TPLCBlockElement;
    BL3VelInicial_7: TPLCBlockElement;
    BL3VelInicial_8: TPLCBlockElement;
    BL3VelInicial_9: TPLCBlockElement;
    BL4Antecipacao_1: TPLCBlockElement;
    BL4Antecipacao_10: TPLCBlockElement;
    BL4Antecipacao_2: TPLCBlockElement;
    BL4Antecipacao_3: TPLCBlockElement;
    BL4Antecipacao_4: TPLCBlockElement;
    BL4Antecipacao_5: TPLCBlockElement;
    BL4Antecipacao_6: TPLCBlockElement;
    BL4Antecipacao_7: TPLCBlockElement;
    BL4Antecipacao_8: TPLCBlockElement;
    BL4Antecipacao_9: TPLCBlockElement;
    BL4CodigoProd_1: TPLCBlockElement;
    BL4CodigoProd_10: TPLCBlockElement;
    BL4CodigoProd_2: TPLCBlockElement;
    BL4CodigoProd_3: TPLCBlockElement;
    BL4CodigoProd_4: TPLCBlockElement;
    BL4CodigoProd_5: TPLCBlockElement;
    BL4CodigoProd_6: TPLCBlockElement;
    BL4CodigoProd_7: TPLCBlockElement;
    BL4CodigoProd_8: TPLCBlockElement;
    BL4CodigoProd_9: TPLCBlockElement;
    BL4Corte_1: TPLCBlockElement;
    BL4Corte_10: TPLCBlockElement;
    BL4Corte_2: TPLCBlockElement;
    BL4Corte_3: TPLCBlockElement;
    BL4Corte_4: TPLCBlockElement;
    BL4Corte_5: TPLCBlockElement;
    BL4Corte_6: TPLCBlockElement;
    BL4Corte_7: TPLCBlockElement;
    BL4Corte_8: TPLCBlockElement;
    BL4Corte_9: TPLCBlockElement;
    BL4VelFinal_1: TPLCBlockElement;
    BL4VelFinal_10: TPLCBlockElement;
    BL4VelFinal_2: TPLCBlockElement;
    BL4VelFinal_3: TPLCBlockElement;
    BL4VelFinal_4: TPLCBlockElement;
    BL4VelFinal_5: TPLCBlockElement;
    BL4VelFinal_6: TPLCBlockElement;
    BL4VelFinal_7: TPLCBlockElement;
    BL4VelFinal_8: TPLCBlockElement;
    BL4VelFinal_9: TPLCBlockElement;
    BL4VelInicial_1: TPLCBlockElement;
    BL4VelInicial_10: TPLCBlockElement;
    BL4VelInicial_2: TPLCBlockElement;
    BL4VelInicial_3: TPLCBlockElement;
    BL4VelInicial_4: TPLCBlockElement;
    BL4VelInicial_5: TPLCBlockElement;
    BL4VelInicial_6: TPLCBlockElement;
    BL4VelInicial_7: TPLCBlockElement;
    BL4VelInicial_8: TPLCBlockElement;
    BL4VelInicial_9: TPLCBlockElement;
    Codigo1: TPLCBlockElement;
    Codigo10: TPLCBlockElement;
    Codigo11: TPLCBlockElement;
    Codigo12: TPLCBlockElement;
    Codigo13: TPLCBlockElement;
    Codigo14: TPLCBlockElement;
    Codigo15: TPLCBlockElement;
    Codigo16: TPLCBlockElement;
    Codigo17: TPLCBlockElement;
    Codigo18: TPLCBlockElement;
    Codigo19: TPLCBlockElement;
    Codigo2: TPLCBlockElement;
    Codigo20: TPLCBlockElement;
    Codigo21: TPLCBlockElement;
    Codigo22: TPLCBlockElement;
    Codigo23: TPLCBlockElement;
    Codigo24: TPLCBlockElement;
    Codigo25: TPLCBlockElement;
    Codigo26: TPLCBlockElement;
    Codigo27: TPLCBlockElement;
    Codigo28: TPLCBlockElement;
    Codigo29: TPLCBlockElement;
    Codigo3: TPLCBlockElement;
    Codigo30: TPLCBlockElement;
    Codigo31: TPLCBlockElement;
    Codigo32: TPLCBlockElement;
    Codigo4: TPLCBlockElement;
    Codigo5: TPLCBlockElement;
    Codigo6: TPLCBlockElement;
    Codigo7: TPLCBlockElement;
    Codigo8: TPLCBlockElement;
    Codigo9: TPLCBlockElement;
    Comando1: TPLCBlockElement;
    Comando10: TPLCBlockElement;
    Comando2: TPLCBlockElement;
    Comando3: TPLCBlockElement;
    Comando4: TPLCBlockElement;
    Comando5: TPLCBlockElement;
    Comando6: TPLCBlockElement;
    Comando7: TPLCBlockElement;
    Comando8: TPLCBlockElement;
    Comando9: TPLCBlockElement;
    ComandosProvisorios: TPLCBlock;
    DadosProd1DBD102: TPLCBlockElement;
    DadosProd1DBD106: TPLCBlockElement;
    DadosProd1DBD110: TPLCBlockElement;
    DadosProd1DBD114: TPLCBlockElement;
    DadosProd1DBD118: TPLCBlockElement;
    DadosProd1DBD122: TPLCBlockElement;
    DadosProd1DBD126: TPLCBlockElement;
    DadosProd1DBD130: TPLCBlockElement;
    DadosProd1DBD22: TPLCBlockElement;
    DadosProd1DBD26: TPLCBlockElement;
    DadosProd1DBD30: TPLCBlockElement;
    DadosProd1DBD34: TPLCBlockElement;
    DadosProd1DBD38: TPLCBlockElement;
    DadosProd1DBD42: TPLCBlockElement;
    DadosProd1DBD46: TPLCBlockElement;
    DadosProd1DBD50: TPLCBlockElement;
    DadosProd1DBD54: TPLCBlockElement;
    DadosProd1DBD58: TPLCBlockElement;
    DadosProd1DBD62: TPLCBlockElement;
    DadosProd1DBD66: TPLCBlockElement;
    DadosProd1DBD70: TPLCBlockElement;
    DadosProd1DBD74: TPLCBlockElement;
    DadosProd1DBD78: TPLCBlockElement;
    DadosProd1DBD82: TPLCBlockElement;
    DadosProd1DBD86: TPLCBlockElement;
    DadosProd1DBD90: TPLCBlockElement;
    DadosProd1DBD94: TPLCBlockElement;
    DadosProd1DBD98: TPLCBlockElement;
    DadosProducao1: TPLCBlock;
    DadosProducao2: TPLCTagNumber;
    Destino1: TPLCBlockElement;
    Destino10: TPLCBlockElement;
    Destino11: TPLCBlockElement;
    Destino12: TPLCBlockElement;
    Destino13: TPLCBlockElement;
    Destino14: TPLCBlockElement;
    Destino15: TPLCBlockElement;
    Destino16: TPLCBlockElement;
    Destino17: TPLCBlockElement;
    Destino18: TPLCBlockElement;
    Destino2: TPLCBlockElement;
    Destino3: TPLCBlockElement;
    Destino4: TPLCBlockElement;
    Destino5: TPLCBlockElement;
    Destino6: TPLCBlockElement;
    Destino7: TPLCBlockElement;
    Destino8: TPLCBlockElement;
    Destino9: TPLCBlockElement;
    DestinoCasc1: TPLCTagNumber;
    DestinoCasc2: TPLCTagNumber;
    DestinoCasc3: TPLCTagNumber;
    DestinoCasc4: TPLCTagNumber;
    DestinoCasc5: TPLCTagNumber;
    DestinoCasc6: TPLCTagNumber;
    DestinoCasc7: TPLCTagNumber;
    DestinoCasc8: TPLCTagNumber;
    Destinos: TPLCBlock;
    Dosados: TPLCBlock;
    DB37_DBW: TPLCTagNumber;
    Dosado1: TPLCBlockElement;
    Dosado10: TPLCBlockElement;
    Dosado11: TPLCBlockElement;
    Dosado12: TPLCBlockElement;
    Dosado13: TPLCBlockElement;
    Dosado14: TPLCBlockElement;
    Dosado15: TPLCBlockElement;
    Dosado16: TPLCBlockElement;
    Dosado17: TPLCBlockElement;
    Dosado18: TPLCBlockElement;
    Dosado19: TPLCBlockElement;
    Dosado2: TPLCBlockElement;
    Dosado20: TPLCBlockElement;
    Dosado21: TPLCBlockElement;
    Dosado22: TPLCBlockElement;
    Dosado23: TPLCBlockElement;
    Dosado24: TPLCBlockElement;
    Dosado25: TPLCBlockElement;
    Dosado26: TPLCBlockElement;
    Dosado27: TPLCBlockElement;
    Dosado28: TPLCBlockElement;
    Dosado29: TPLCBlockElement;
    Dosado3: TPLCBlockElement;
    Dosado30: TPLCBlockElement;
    Dosado31: TPLCBlockElement;
    Dosado32: TPLCBlockElement;
    Dosado4: TPLCBlockElement;
    Dosado5: TPLCBlockElement;
    Dosado6: TPLCBlockElement;
    Dosado7: TPLCBlockElement;
    Dosado8: TPLCBlockElement;
    Dosado9: TPLCBlockElement;
    DosandoBL1: TPLCBlock;
    DosandoBL2: TPLCBlock;
    DosandoBL20: TPLCBlockElement;
    DosandoBL212: TPLCBlockElement;
    DosandoBL216: TPLCBlockElement;
    DosandoBL24: TPLCBlockElement;
    DosandoBL28: TPLCBlockElement;
    DosandoBombas: TPLCBlock;
    DosBL10: TPLCBlockElement;
    DosBL112: TPLCBlockElement;
    DosBL116: TPLCBlockElement;
    DosBL14: TPLCBlockElement;
    DosBL18: TPLCBlockElement;
    DosBombas0: TPLCBlockElement;
    DosBombas12: TPLCBlockElement;
    DosBombas16: TPLCBlockElement;
    DosBombas20: TPLCBlockElement;
    DosBombas24: TPLCBlockElement;
    DosBombas28: TPLCBlockElement;
    DosBombas32: TPLCBlockElement;
    DosBombas36: TPLCBlockElement;
    DosBombas4: TPLCBlockElement;
    DosBombas40: TPLCBlockElement;
    DosBombas44: TPLCBlockElement;
    DosBombas48: TPLCBlockElement;
    DosBombas52: TPLCBlockElement;
    DosBombas56: TPLCBlockElement;
    DosBombas8: TPLCBlockElement;
    DosCodReceita: TPLCBlockElement;
    Flags01: TPLCBlock;
    Flags01_b1: TPLCBlockElement;
    Flags01_b10: TPLCBlockElement;
    Flags01_b11: TPLCBlockElement;
    Flags01_b12: TPLCBlockElement;
    Flags01_b13: TPLCBlockElement;
    Flags01_b14: TPLCBlockElement;
    Flags01_b15: TPLCBlockElement;
    Flags01_b16: TPLCBlockElement;
    Flags01_b2: TPLCBlockElement;
    Flags01_b3: TPLCBlockElement;
    Flags01_b4: TPLCBlockElement;
    Flags01_b5: TPLCBlockElement;
    Flags01_b6: TPLCBlockElement;
    Flags01_b7: TPLCBlockElement;
    Flags01_b8: TPLCBlockElement;
    Flags01_b9: TPLCBlockElement;
    Flags02: TPLCBlock;
    Flags02b1: TPLCBlockElement;
    Flags02b10: TPLCBlockElement;
    Flags02b11: TPLCBlockElement;
    Flags02b12: TPLCBlockElement;
    Flags02b13: TPLCBlockElement;
    Flags02b14: TPLCBlockElement;
    Flags02b15: TPLCBlockElement;
    Flags02b16: TPLCBlockElement;
    Flags02b17: TPLCBlockElement;
    Flags02b18: TPLCBlockElement;
    Flags02b19: TPLCBlockElement;
    Flags02b2: TPLCBlockElement;
    Flags02b20: TPLCBlockElement;
    Flags02b21: TPLCBlockElement;
    Flags02b22: TPLCBlockElement;
    Flags02b23: TPLCBlockElement;
    Flags02b24: TPLCBlockElement;
    Flags02b25: TPLCBlockElement;
    Flags02b26: TPLCBlockElement;
    Flags02b3: TPLCBlockElement;
    Flags02b4: TPLCBlockElement;
    Flags02b5: TPLCBlockElement;
    Flags02b6: TPLCBlockElement;
    Flags02b7: TPLCBlockElement;
    Flags02b8: TPLCBlockElement;
    Flags02b9: TPLCBlockElement;
    Flags03: TPLCBlock;
    Flags03b0: TPLCBlockElement;
    Flags03b1: TPLCBlockElement;
    Flags03b10: TPLCBlockElement;
    Flags03b11: TPLCBlockElement;
    Flags03b12: TPLCBlockElement;
    Flags03b13: TPLCBlockElement;
    Flags03b14: TPLCBlockElement;
    Flags03b2: TPLCBlockElement;
    Flags03b3: TPLCBlockElement;
    Flags03b4: TPLCBlockElement;
    Flags03b5: TPLCBlockElement;
    Flags03b6: TPLCBlockElement;
    Flags03b7: TPLCBlockElement;
    Flags03b8: TPLCBlockElement;
    Flags03b9: TPLCBlockElement;
    Flags04: TPLCBlock;
    Flags04b0: TPLCBlockElement;
    Flags04b1: TPLCBlockElement;
    Flags04b10: TPLCBlockElement;
    Flags04b11: TPLCBlockElement;
    Flags04b12: TPLCBlockElement;
    Flags04b13: TPLCBlockElement;
    Flags04b14: TPLCBlockElement;
    Flags04b2: TPLCBlockElement;
    Flags04b3: TPLCBlockElement;
    Flags04b4: TPLCBlockElement;
    Flags04b5: TPLCBlockElement;
    Flags04b6: TPLCBlockElement;
    Flags04b7: TPLCBlockElement;
    Flags04b8: TPLCBlockElement;
    Flags04b9: TPLCBlockElement;
    Flags05: TPLCBlock;
    Flags05w0: TPLCBlockElement;
    Flags05w10: TPLCBlockElement;
    Flags05w100: TPLCBlockElement;
    Flags05w102: TPLCBlockElement;
    Flags05w104: TPLCBlockElement;
    Flags05w106: TPLCBlockElement;
    Flags05w108: TPLCBlockElement;
    Flags05w110: TPLCBlockElement;
    Flags05w112: TPLCBlockElement;
    Flags05w114: TPLCBlockElement;
    Flags05w116: TPLCBlockElement;
    Flags05w118: TPLCBlockElement;
    Flags05w12: TPLCBlockElement;
    Flags05w120: TPLCBlockElement;
    Flags05w122: TPLCBlockElement;
    Flags05w124: TPLCBlockElement;
    Flags05w126: TPLCBlockElement;
    Flags05w128: TPLCBlockElement;
    Flags05w130: TPLCBlockElement;
    Flags05w132: TPLCBlockElement;
    Flags05w134: TPLCBlockElement;
    Flags05w136: TPLCBlockElement;
    Flags05w138: TPLCBlockElement;
    Flags05w14: TPLCBlockElement;
    Flags05w140: TPLCBlockElement;
    Flags05w142: TPLCBlockElement;
    Flags05w144: TPLCBlockElement;
    Flags05w146: TPLCBlockElement;
    Flags05w148: TPLCBlockElement;
    Flags05w150: TPLCBlockElement;
    Flags05w152: TPLCBlockElement;
    Flags05w154: TPLCBlockElement;
    Flags05w156: TPLCBlockElement;
    Flags05w158: TPLCBlockElement;
    Flags05w16: TPLCBlockElement;
    Flags05w160: TPLCBlockElement;
    Flags05w162: TPLCBlockElement;
    Flags05w164: TPLCBlockElement;
    Flags05w166: TPLCBlockElement;
    Flags05w168: TPLCBlockElement;
    Flags05w170: TPLCBlockElement;
    Flags05w172: TPLCBlockElement;
    Flags05w174: TPLCBlockElement;
    Flags05w176: TPLCBlockElement;
    Flags05w178: TPLCBlockElement;
    Flags05w18: TPLCBlockElement;
    Flags05w180: TPLCBlockElement;
    Flags05w182: TPLCBlockElement;
    Flags05w184: TPLCBlockElement;
    Flags05w186: TPLCBlockElement;
    Flags05w188: TPLCBlockElement;
    Flags05w190: TPLCBlockElement;
    Flags05w192: TPLCBlockElement;
    Flags05w194: TPLCBlockElement;
    Flags05w196: TPLCBlockElement;
    Flags05w198: TPLCBlockElement;
    Flags05w2: TPLCBlockElement;
    Flags05w20: TPLCBlockElement;
    Flags05w200: TPLCBlockElement;
    Flags05w202: TPLCBlockElement;
    Flags05w204: TPLCBlockElement;
    Flags05w206: TPLCBlockElement;
    Flags05w208: TPLCBlockElement;
    Flags05w210: TPLCBlockElement;
    Flags05w212: TPLCBlockElement;
    Flags05w214: TPLCBlockElement;
    Flags05w216: TPLCBlockElement;
    Flags05w218: TPLCBlockElement;
    Flags05w22: TPLCBlockElement;
    Flags05w220: TPLCBlockElement;
    Flags05w24: TPLCBlockElement;
    Flags05w26: TPLCBlockElement;
    Flags05w28: TPLCBlockElement;
    Flags05w30: TPLCBlockElement;
    Flags05w32: TPLCBlockElement;
    Flags05w34: TPLCBlockElement;
    Flags05w36: TPLCBlockElement;
    Flags05w38: TPLCBlockElement;
    Flags05w4: TPLCBlockElement;
    Flags05w40: TPLCBlockElement;
    Flags05w42: TPLCBlockElement;
    Flags05w44: TPLCBlockElement;
    Flags05w46: TPLCBlockElement;
    Flags05w48: TPLCBlockElement;
    Flags05w50: TPLCBlockElement;
    Flags05w52: TPLCBlockElement;
    Flags05w54: TPLCBlockElement;
    Flags05w56: TPLCBlockElement;
    Flags05w58: TPLCBlockElement;
    Flags05w6: TPLCBlockElement;
    Flags05w60: TPLCBlockElement;
    Flags05w62: TPLCBlockElement;
    Flags05w64: TPLCBlockElement;
    Flags05w66: TPLCBlockElement;
    Flags05w68: TPLCBlockElement;
    Flags05w70: TPLCBlockElement;
    Flags05w72: TPLCBlockElement;
    Flags05w74: TPLCBlockElement;
    Flags05w76: TPLCBlockElement;
    Flags05w78: TPLCBlockElement;
    Flags05w8: TPLCBlockElement;
    Flags05w80: TPLCBlockElement;
    Flags05w82: TPLCBlockElement;
    Flags05w84: TPLCBlockElement;
    Flags05w86: TPLCBlockElement;
    Flags05w88: TPLCBlockElement;
    Flags05w90: TPLCBlockElement;
    Flags05w92: TPLCBlockElement;
    Flags05w94: TPLCBlockElement;
    Flags05w96: TPLCBlockElement;
    Flags05w98: TPLCBlockElement;
    Flags06: TPLCBlock;
    Flags06w222: TPLCBlockElement;
    Flags06w224: TPLCBlockElement;
    Flags06w226: TPLCBlockElement;
    Flags06w228: TPLCBlockElement;
    Flags06w230: TPLCBlockElement;
    Flags06w232: TPLCBlockElement;
    Flags06w234: TPLCBlockElement;
    Flags06w236: TPLCBlockElement;
    Flags06w238: TPLCBlockElement;
    Flags06w240: TPLCBlockElement;
    Flags06w242: TPLCBlockElement;
    Flags06w244: TPLCBlockElement;
    Flags06w246: TPLCBlockElement;
    Flags06w248: TPLCBlockElement;
    Flags06w250: TPLCBlockElement;
    Flags06w252: TPLCBlockElement;
    Flags06w254: TPLCBlockElement;
    Flags06w256: TPLCBlockElement;
    Flags06w258: TPLCBlockElement;
    Flags06w260: TPLCBlockElement;
    Flags06w262: TPLCBlockElement;
    Flags06w264: TPLCBlockElement;
    Flags06w266: TPLCBlockElement;
    Flags06w268: TPLCBlockElement;
    Flags06w270: TPLCBlockElement;
    Flags06w272: TPLCBlockElement;
    Flags06w274: TPLCBlockElement;
    Flags06w276: TPLCBlockElement;
    Flags06w278: TPLCBlockElement;
    Flags06w280: TPLCBlockElement;
    Flags06w282: TPLCBlockElement;
    Flags06w284: TPLCBlockElement;
    Flags06w286: TPLCBlockElement;
    Flags06w288: TPLCBlockElement;
    Flags06w290: TPLCBlockElement;
    Flags06w292: TPLCBlockElement;
    Flags06w294: TPLCBlockElement;
    Flags06w296: TPLCBlockElement;
    Flags06w298: TPLCBlockElement;
    Flags06w300: TPLCBlockElement;
    Flags06w302: TPLCBlockElement;
    Flags06w304: TPLCBlockElement;
    Flags06w306: TPLCBlockElement;
    Flags06w308: TPLCBlockElement;
    Flags06w310: TPLCBlockElement;
    Flags06w312: TPLCBlockElement;
    Flags06w314: TPLCBlockElement;
    Flags06w316: TPLCBlockElement;
    Flags06w318: TPLCBlockElement;
    Flags06w320: TPLCBlockElement;
    Flags06w322: TPLCBlockElement;
    Flags06w324: TPLCBlockElement;
    Flags06w326: TPLCBlockElement;
    Flags06w328: TPLCBlockElement;
    Flags06w330: TPLCBlockElement;
    Flags06w332: TPLCBlockElement;
    Flags06w334: TPLCBlockElement;
    Flags06w336: TPLCBlockElement;
    Flags06w338: TPLCBlockElement;
    Flags06w340: TPLCBlockElement;
    Flags06w342: TPLCBlockElement;
    Flags06w344: TPLCBlockElement;
    Flags06w346: TPLCBlockElement;
    Flags06w348: TPLCBlockElement;
    Flags06w350: TPLCBlockElement;
    Flags06w352: TPLCBlockElement;
    Flags06w354: TPLCBlockElement;
    Flags06w356: TPLCBlockElement;
    Flags06w358: TPLCBlockElement;
    Flags06w360: TPLCBlockElement;
    Flags06w362: TPLCBlockElement;
    Flags_From_MB70_to_MB73: TPLCBlock;
    Flags_From_MB97_to_MB99: TPLCBlock;
    IB0: TPLCBlockElement;
    IB1: TPLCBlockElement;
    IB10: TPLCBlockElement;
    IB11: TPLCBlockElement;
    IB12: TPLCBlockElement;
    IB13: TPLCBlockElement;
    IB14: TPLCBlockElement;
    IB15: TPLCBlockElement;
    IB16: TPLCBlockElement;
    IB17: TPLCBlockElement;
    IB18: TPLCBlockElement;
    IB19: TPLCBlockElement;
    IB2: TPLCBlockElement;
    IB20: TPLCBlockElement;
    IB21: TPLCBlockElement;
    IB22: TPLCBlockElement;
    IB23: TPLCBlockElement;
    IB24: TPLCBlockElement;
    IB25: TPLCBlockElement;
    IB256: TPLCBlockElement;
    IB257: TPLCBlockElement;
    IB258: TPLCBlockElement;
    IB259: TPLCBlockElement;
    IB26: TPLCBlockElement;
    IB260: TPLCBlockElement;
    IB261: TPLCBlockElement;
    IB262: TPLCBlockElement;
    IB263: TPLCBlockElement;
    IB264: TPLCBlockElement;
    IB265: TPLCBlockElement;
    IB266: TPLCBlockElement;
    IB267: TPLCBlockElement;
    IB268: TPLCBlockElement;
    IB269: TPLCBlockElement;
    IB27: TPLCBlockElement;
    IB270: TPLCBlockElement;
    IB271: TPLCBlockElement;
    IB28: TPLCBlockElement;
    IB29: TPLCBlockElement;
    IB3: TPLCBlockElement;
    IB30: TPLCBlockElement;
    IB31: TPLCBlockElement;
    IB32: TPLCBlockElement;
    IB33: TPLCBlockElement;
    IB34: TPLCBlockElement;
    IB35: TPLCBlockElement;
    IB36: TPLCBlockElement;
    IB37: TPLCBlockElement;
    IB4: TPLCBlockElement;
    IB402: TPLCBlockElement;
    IB403: TPLCBlockElement;
    IB404: TPLCBlockElement;
    IB405: TPLCBlockElement;
    IB406: TPLCBlockElement;
    IB407: TPLCBlockElement;
    IB408: TPLCBlockElement;
    IB409: TPLCBlockElement;
    IB410: TPLCBlockElement;
    IB411: TPLCBlockElement;
    IB5: TPLCBlockElement;
    IB6: TPLCBlockElement;
    IB7: TPLCBlockElement;
    IB8: TPLCBlockElement;
    IB9: TPLCBlockElement;
    InputBytes_From_IB0_to_IB37: TPLCBlock;
    InputBytes_From_IB256_to_IB271: TPLCBlock;
    InputBytes_From_IB402_to_IB411: TPLCBlock;
    Inversores: TPLCBlock;
    Inversores22: TPLCBlockElement;
    Inversores24: TPLCBlockElement;
    Inversores26: TPLCBlockElement;
    Inversores28: TPLCBlockElement;
    Inversores30: TPLCBlockElement;
    ISOTCPDriver1: TISOTCPDriver;
    MB70: TPLCBlockElement;
    MB71: TPLCBlockElement;
    MB72: TPLCBlockElement;
    MB73: TPLCBlockElement;
    MB93: TPLCTagNumber;
    MB97: TPLCBlockElement;
    MB98: TPLCBlockElement;
    MB99: TPLCBlockElement;
    FlagsAlarmeNivel: TPLCTagNumber;
    MOINHOS: TPLCBlock;
    MOINHOS0: TPLCBlockElement;
    MOINHOS10: TPLCBlockElement;
    MOINHOS12: TPLCBlockElement;
    MOINHOS14: TPLCBlockElement;
    MOINHOS16: TPLCBlockElement;
    MOINHOS18: TPLCBlockElement;
    MOINHOS2: TPLCBlockElement;
    MOINHOS20: TPLCBlockElement;
    MOINHOS22: TPLCBlockElement;
    MOINHOS24: TPLCBlockElement;
    MOINHOS26: TPLCBlockElement;
    MOINHOS28: TPLCBlockElement;
    MOINHOS30: TPLCBlockElement;
    MOINHOS32: TPLCBlockElement;
    MOINHOS34: TPLCBlockElement;
    MOINHOS36: TPLCBlockElement;
    MOINHOS38: TPLCBlockElement;
    MOINHOS4: TPLCBlockElement;
    MOINHOS40: TPLCBlockElement;
    MOINHOS42: TPLCBlockElement;
    MOINHOS44: TPLCBlockElement;
    MOINHOS46: TPLCBlockElement;
    MOINHOS6: TPLCBlockElement;
    MOINHOS8: TPLCBlockElement;
    MW102: TPLCTagNumber;
    MW104: TPLCTagNumber;
    MW90: TPLCTagNumber;
    MW100: TPLCTagNumber;
    ParamBL2: TPLCBlock;
    ParamBL3: TPLCBlock;
    ParamBL4: TPLCBlock;
    Peso1: TPLCBlockElement;
    Peso10: TPLCBlockElement;
    Peso11: TPLCBlockElement;
    Peso12: TPLCBlockElement;
    Peso13: TPLCBlockElement;
    Peso14: TPLCBlockElement;
    Peso15: TPLCBlockElement;
    Peso16: TPLCBlockElement;
    Peso17: TPLCBlockElement;
    Peso18: TPLCBlockElement;
    Peso19: TPLCBlockElement;
    Peso2: TPLCBlockElement;
    Peso20: TPLCBlockElement;
    Peso21: TPLCBlockElement;
    Peso22: TPLCBlockElement;
    Peso23: TPLCBlockElement;
    Peso24: TPLCBlockElement;
    Peso25: TPLCBlockElement;
    Peso26: TPLCBlockElement;
    Peso27: TPLCBlockElement;
    Peso28: TPLCBlockElement;
    Peso29: TPLCBlockElement;
    Peso3: TPLCBlockElement;
    Peso30: TPLCBlockElement;
    Peso31: TPLCBlockElement;
    Peso32: TPLCBlockElement;
    Peso4: TPLCBlockElement;
    Peso5: TPLCBlockElement;
    Peso6: TPLCBlockElement;
    Peso7: TPLCBlockElement;
    Peso8: TPLCBlockElement;
    Peso9: TPLCBlockElement;
    PesoSiloExp1: TPLCBlockElement;
    PesoSiloExp10: TPLCBlockElement;
    PesoSiloExp11: TPLCBlockElement;
    PesoSiloExp12: TPLCBlockElement;
    PesoSiloExp13: TPLCBlockElement;
    PesoSiloExp14: TPLCBlockElement;
    PesoSiloExp15: TPLCBlockElement;
    PesoSiloExp16: TPLCBlockElement;
    PesoSiloExp2: TPLCBlockElement;
    PesoSiloExp3: TPLCBlockElement;
    PesoSiloExp4: TPLCBlockElement;
    PesoSiloExp5: TPLCBlockElement;
    PesoSiloExp6: TPLCBlockElement;
    PesoSiloExp7: TPLCBlockElement;
    PesoSiloExp8: TPLCBlockElement;
    PesoSiloExp9: TPLCBlockElement;
    Processo: TPLCBlock;
    Processo120: TPLCBlockElement;
    Processo124: TPLCBlockElement;
    Processo128: TPLCBlockElement;
    Processo132: TPLCBlockElement;
    Processo136: TPLCBlockElement;
    Processo140: TPLCBlockElement;
    Processo144: TPLCBlockElement;
    Processo148: TPLCBlockElement;
    Processo152: TPLCBlockElement;
    Processo156: TPLCBlockElement;
    Processo160: TPLCBlockElement;
    Processo164: TPLCBlockElement;
    Processo168: TPLCBlockElement;
    Processo172: TPLCBlockElement;
    Processo176: TPLCBlockElement;
    QB0: TPLCBlockElement;
    QB1: TPLCBlockElement;
    QB10: TPLCBlockElement;
    QB11: TPLCBlockElement;
    QB12: TPLCBlockElement;
    QB13: TPLCBlockElement;
    QB14: TPLCBlockElement;
    QB15: TPLCBlockElement;
    QB16: TPLCBlockElement;
    QB17: TPLCBlockElement;
    QB18: TPLCBlockElement;
    QB19: TPLCBlockElement;
    QB2: TPLCBlockElement;
    QB20: TPLCBlockElement;
    QB21: TPLCBlockElement;
    QB22: TPLCBlockElement;
    QB23: TPLCBlockElement;
    QB24: TPLCBlockElement;
    QB25: TPLCBlockElement;
    QB26: TPLCBlockElement;
    QB27: TPLCBlockElement;
    QB28: TPLCBlockElement;
    QB29: TPLCBlockElement;
    QB3: TPLCBlockElement;
    QB30: TPLCBlockElement;
    QB31: TPLCBlockElement;
    QB32: TPLCBlockElement;
    QB33: TPLCBlockElement;
    QB34: TPLCBlockElement;
    QB35: TPLCBlockElement;
    QB36: TPLCBlockElement;
    QB37: TPLCBlockElement;
    QB38: TPLCBlockElement;
    QB39: TPLCBlockElement;
    QB4: TPLCBlockElement;
    QB40: TPLCBlockElement;
    QB41: TPLCBlockElement;
    QB42: TPLCBlockElement;
    QB43: TPLCBlockElement;
    QB44: TPLCBlockElement;
    QB45: TPLCBlockElement;
    QB46: TPLCBlockElement;
    QB47: TPLCBlockElement;
    QB48: TPLCBlockElement;
    QB49: TPLCBlockElement;
    QB5: TPLCBlockElement;
    QB50: TPLCBlockElement;
    QB6: TPLCBlockElement;
    QB7: TPLCBlockElement;
    QB8: TPLCBlockElement;
    QB9: TPLCBlockElement;
    RecCodigoReceita160: TPLCBlockElement;
    RecCodProd1: TPLCBlockElement;
    RecCodProd10: TPLCBlockElement;
    RecCodProd11: TPLCBlockElement;
    RecCodProd12: TPLCBlockElement;
    RecCodProd13: TPLCBlockElement;
    RecCodProd14: TPLCBlockElement;
    RecCodProd15: TPLCBlockElement;
    RecCodProd16: TPLCBlockElement;
    RecCodProd17: TPLCBlockElement;
    RecCodProd18: TPLCBlockElement;
    RecCodProd19: TPLCBlockElement;
    RecCodProd2: TPLCBlockElement;
    RecCodProd20: TPLCBlockElement;
    RecCodProd21: TPLCBlockElement;
    RecCodProd22: TPLCBlockElement;
    RecCodProd23: TPLCBlockElement;
    RecCodProd24: TPLCBlockElement;
    RecCodProd25: TPLCBlockElement;
    RecCodProd26: TPLCBlockElement;
    RecCodProd27: TPLCBlockElement;
    RecCodProd28: TPLCBlockElement;
    RecCodProd29: TPLCBlockElement;
    RecCodProd3: TPLCBlockElement;
    RecCodProd30: TPLCBlockElement;
    RecCodProd31: TPLCBlockElement;
    RecCodProd32: TPLCBlockElement;
    RecCodProd4: TPLCBlockElement;
    RecCodProd5: TPLCBlockElement;
    RecCodProd6: TPLCBlockElement;
    RecCodProd7: TPLCBlockElement;
    RecCodProd8: TPLCBlockElement;
    RecCodProd9: TPLCBlockElement;
    Receita: TPLCBlock;
    RecPeso1: TPLCBlockElement;
    RecPeso10: TPLCBlockElement;
    RecPeso11: TPLCBlockElement;
    RecPeso12: TPLCBlockElement;
    RecPeso13: TPLCBlockElement;
    RecPeso14: TPLCBlockElement;
    RecPeso15: TPLCBlockElement;
    RecPeso16: TPLCBlockElement;
    RecPeso17: TPLCBlockElement;
    RecPeso18: TPLCBlockElement;
    RecPeso19: TPLCBlockElement;
    RecPeso2: TPLCBlockElement;
    RecPeso20: TPLCBlockElement;
    RecPeso21: TPLCBlockElement;
    RecPeso22: TPLCBlockElement;
    RecPeso23: TPLCBlockElement;
    RecPeso24: TPLCBlockElement;
    RecPeso25: TPLCBlockElement;
    RecPeso26: TPLCBlockElement;
    RecPeso27: TPLCBlockElement;
    RecPeso28: TPLCBlockElement;
    RecPeso29: TPLCBlockElement;
    RecPeso3: TPLCBlockElement;
    RecPeso30: TPLCBlockElement;
    RecPeso31: TPLCBlockElement;
    RecPeso32: TPLCBlockElement;
    RecPeso4: TPLCBlockElement;
    RecPeso5: TPLCBlockElement;
    RecPeso6: TPLCBlockElement;
    RecPeso7: TPLCBlockElement;
    RecPeso8: TPLCBlockElement;
    RecPeso9: TPLCBlockElement;
    RecRes1_1: TPLCBlockElement;
    RecRes1_10: TPLCBlockElement;
    RecRes1_11: TPLCBlockElement;
    RecRes1_12: TPLCBlockElement;
    RecRes1_13: TPLCBlockElement;
    RecRes1_14: TPLCBlockElement;
    RecRes1_15: TPLCBlockElement;
    RecRes1_16: TPLCBlockElement;
    RecRes1_17: TPLCBlockElement;
    RecRes1_18: TPLCBlockElement;
    RecRes1_19: TPLCBlockElement;
    RecRes1_2: TPLCBlockElement;
    RecRes1_20: TPLCBlockElement;
    RecRes1_21: TPLCBlockElement;
    RecRes1_22: TPLCBlockElement;
    RecRes1_23: TPLCBlockElement;
    RecRes1_24: TPLCBlockElement;
    RecRes1_25: TPLCBlockElement;
    RecRes1_26: TPLCBlockElement;
    RecRes1_27: TPLCBlockElement;
    RecRes1_28: TPLCBlockElement;
    RecRes1_29: TPLCBlockElement;
    RecRes1_3: TPLCBlockElement;
    RecRes1_30: TPLCBlockElement;
    RecRes1_31: TPLCBlockElement;
    RecRes1_32: TPLCBlockElement;
    RecRes1_4: TPLCBlockElement;
    RecRes1_5: TPLCBlockElement;
    RecRes1_6: TPLCBlockElement;
    RecRes1_7: TPLCBlockElement;
    RecRes1_8: TPLCBlockElement;
    RecRes1_9: TPLCBlockElement;
    RecRes2_1: TPLCBlockElement;
    RecRes2_10: TPLCBlockElement;
    RecRes2_11: TPLCBlockElement;
    RecRes2_12: TPLCBlockElement;
    RecRes2_13: TPLCBlockElement;
    RecRes2_14: TPLCBlockElement;
    RecRes2_15: TPLCBlockElement;
    RecRes2_16: TPLCBlockElement;
    RecRes2_17: TPLCBlockElement;
    RecRes2_18: TPLCBlockElement;
    RecRes2_19: TPLCBlockElement;
    RecRes2_2: TPLCBlockElement;
    RecRes2_20: TPLCBlockElement;
    RecRes2_21: TPLCBlockElement;
    RecRes2_22: TPLCBlockElement;
    RecRes2_23: TPLCBlockElement;
    RecRes2_24: TPLCBlockElement;
    RecRes2_25: TPLCBlockElement;
    RecRes2_26: TPLCBlockElement;
    RecRes2_27: TPLCBlockElement;
    RecRes2_28: TPLCBlockElement;
    RecRes2_29: TPLCBlockElement;
    RecRes2_3: TPLCBlockElement;
    RecRes2_30: TPLCBlockElement;
    RecRes2_31: TPLCBlockElement;
    RecRes2_32: TPLCBlockElement;
    RecRes2_4: TPLCBlockElement;
    RecRes2_5: TPLCBlockElement;
    RecRes2_6: TPLCBlockElement;
    RecRes2_7: TPLCBlockElement;
    RecRes2_8: TPLCBlockElement;
    RecRes2_9: TPLCBlockElement;
    RecTolerancia1: TPLCBlockElement;
    RecTolerancia10: TPLCBlockElement;
    RecTolerancia11: TPLCBlockElement;
    RecTolerancia12: TPLCBlockElement;
    RecTolerancia13: TPLCBlockElement;
    RecTolerancia14: TPLCBlockElement;
    RecTolerancia15: TPLCBlockElement;
    RecTolerancia16: TPLCBlockElement;
    RecTolerancia17: TPLCBlockElement;
    RecTolerancia18: TPLCBlockElement;
    RecTolerancia19: TPLCBlockElement;
    RecTolerancia2: TPLCBlockElement;
    RecTolerancia20: TPLCBlockElement;
    RecTolerancia21: TPLCBlockElement;
    RecTolerancia22: TPLCBlockElement;
    RecTolerancia23: TPLCBlockElement;
    RecTolerancia24: TPLCBlockElement;
    RecTolerancia25: TPLCBlockElement;
    RecTolerancia26: TPLCBlockElement;
    RecTolerancia27: TPLCBlockElement;
    RecTolerancia28: TPLCBlockElement;
    RecTolerancia29: TPLCBlockElement;
    RecTolerancia3: TPLCBlockElement;
    RecTolerancia30: TPLCBlockElement;
    RecTolerancia31: TPLCBlockElement;
    RecTolerancia32: TPLCBlockElement;
    RecTolerancia4: TPLCBlockElement;
    RecTolerancia5: TPLCBlockElement;
    RecTolerancia6: TPLCBlockElement;
    RecTolerancia7: TPLCBlockElement;
    RecTolerancia8: TPLCBlockElement;
    RecTolerancia9: TPLCBlockElement;
    Reserva1: TPLCBlockElement;
    Reserva10: TPLCBlockElement;
    Reserva11: TPLCBlockElement;
    Reserva12: TPLCBlockElement;
    Reserva13: TPLCBlockElement;
    Reserva14: TPLCBlockElement;
    Reserva15: TPLCBlockElement;
    Reserva16: TPLCBlockElement;
    Reserva17: TPLCBlockElement;
    Reserva18: TPLCBlockElement;
    Reserva19: TPLCBlockElement;
    Reserva2: TPLCBlockElement;
    Reserva20: TPLCBlockElement;
    Reserva21: TPLCBlockElement;
    Reserva22: TPLCBlockElement;
    Reserva23: TPLCBlockElement;
    Reserva24: TPLCBlockElement;
    Reserva25: TPLCBlockElement;
    Reserva26: TPLCBlockElement;
    Reserva27: TPLCBlockElement;
    Reserva28: TPLCBlockElement;
    Reserva29: TPLCBlockElement;
    Reserva3: TPLCBlockElement;
    Reserva30: TPLCBlockElement;
    Reserva31: TPLCBlockElement;
    Reserva32: TPLCBlockElement;
    Reserva4: TPLCBlockElement;
    Reserva5: TPLCBlockElement;
    Reserva6: TPLCBlockElement;
    Reserva7: TPLCBlockElement;
    Reserva8: TPLCBlockElement;
    Reserva9: TPLCBlockElement;
    Saidas: TPLCBlock;
    SE1_1: TPLCBlockElement;
    SE1_10: TPLCBlockElement;
    SE1_11: TPLCBlockElement;
    SE1_12: TPLCBlockElement;
    SE1_13: TPLCBlockElement;
    SE1_14: TPLCBlockElement;
    SE1_15: TPLCBlockElement;
    SE1_16: TPLCBlockElement;
    SE1_17: TPLCBlockElement;
    SE1_18: TPLCBlockElement;
    SE1_19: TPLCBlockElement;
    SE1_2: TPLCBlockElement;
    SE1_20: TPLCBlockElement;
    SE1_21: TPLCBlockElement;
    SE1_3: TPLCBlockElement;
    SE1_4: TPLCBlockElement;
    SE1_5: TPLCBlockElement;
    SE1_6: TPLCBlockElement;
    SE1_7: TPLCBlockElement;
    SE1_8: TPLCBlockElement;
    SE1_9: TPLCBlockElement;
    SE2_1: TPLCBlockElement;
    SE2_2: TPLCBlockElement;
    SE2_3: TPLCBlockElement;
    SE2_4: TPLCBlockElement;
    SiloExpedicao: TPLCBlock;
    SiloExpedicao2: TPLCBlock;
    SPPesoSiloExp: TPLCBlock;
    TagTempoAvulso1: TPLCTagNumber;
    TagTempoAvulso2: TPLCTagNumber;
    TagTempoAvulso3: TPLCTagNumber;
    TagTempoAvulso4: TPLCTagNumber;
    TagTempoAvulso5: TPLCTagNumber;
    TCP_UDPPort1: TTCP_UDPPort;
    TempoEstabBL1: TPLCTagNumber;
    TempoEstabBL2: TPLCTagNumber;
    TempoProducao1: TPLCBlockElement;
    TempoProducao2: TPLCBlockElement;
    TempoProducao3: TPLCBlockElement;
    TempoProducao4: TPLCBlockElement;
    Temporizador1: TPLCBlockElement;
    Temporizador2: TPLCBlockElement;
    Temporizador3: TPLCBlockElement;
    Temporizador4: TPLCBlockElement;
    Temporizadores: TPLCBlock;
    TemposProducao: TPLCBlock;
    TLimpDestinos: TPLCBlock;
    TLimpDestinos0: TPLCBlockElement;
    TLimpDestinos10: TPLCBlockElement;
    TLimpDestinos12: TPLCBlockElement;
    TLimpDestinos14: TPLCBlockElement;
    TLimpDestinos16: TPLCBlockElement;
    TLimpDestinos18: TPLCBlockElement;
    TLimpDestinos2: TPLCBlockElement;
    TLimpDestinos20: TPLCBlockElement;
    TLimpDestinos22: TPLCBlockElement;
    TLimpDestinos24: TPLCBlockElement;
    TLimpDestinos26: TPLCBlockElement;
    TLimpDestinos28: TPLCBlockElement;
    TLimpDestinos30: TPLCBlockElement;
    TLimpDestinos32: TPLCBlockElement;
    TLimpDestinos34: TPLCBlockElement;
    TLimpDestinos36: TPLCBlockElement;
    TLimpDestinos38: TPLCBlockElement;
    TLimpDestinos4: TPLCBlockElement;
    TLimpDestinos40: TPLCBlockElement;
    TLimpDestinos42: TPLCBlockElement;
    TLimpDestinos44: TPLCBlockElement;
    TLimpDestinos46: TPLCBlockElement;
    TLimpDestinos48: TPLCBlockElement;
    TLimpDestinos50: TPLCBlockElement;
    TLimpDestinos52: TPLCBlockElement;
    TLimpDestinos54: TPLCBlockElement;
    TLimpDestinos56: TPLCBlockElement;
    TLimpDestinos58: TPLCBlockElement;
    TLimpDestinos6: TPLCBlockElement;
    TLimpDestinos60: TPLCBlockElement;
    TLimpDestinos62: TPLCBlockElement;
    TLimpDestinos64: TPLCBlockElement;
    TLimpDestinos66: TPLCBlockElement;
    TLimpDestinos68: TPLCBlockElement;
    TLimpDestinos70: TPLCBlockElement;
    TLimpDestinos72: TPLCBlockElement;
    TLimpDestinos74: TPLCBlockElement;
    TLimpDestinos8: TPLCBlockElement;
    Tolerancia1: TPLCBlockElement;
    Tolerancia10: TPLCBlockElement;
    Tolerancia11: TPLCBlockElement;
    Tolerancia12: TPLCBlockElement;
    Tolerancia13: TPLCBlockElement;
    Tolerancia14: TPLCBlockElement;
    Tolerancia15: TPLCBlockElement;
    Tolerancia16: TPLCBlockElement;
    Tolerancia17: TPLCBlockElement;
    Tolerancia18: TPLCBlockElement;
    Tolerancia19: TPLCBlockElement;
    Tolerancia2: TPLCBlockElement;
    Tolerancia20: TPLCBlockElement;
    Tolerancia21: TPLCBlockElement;
    Tolerancia22: TPLCBlockElement;
    Tolerancia23: TPLCBlockElement;
    Tolerancia24: TPLCBlockElement;
    Tolerancia25: TPLCBlockElement;
    Tolerancia26: TPLCBlockElement;
    Tolerancia27: TPLCBlockElement;
    Tolerancia28: TPLCBlockElement;
    Tolerancia29: TPLCBlockElement;
    Tolerancia3: TPLCBlockElement;
    Tolerancia30: TPLCBlockElement;
    Tolerancia31: TPLCBlockElement;
    Tolerancia32: TPLCBlockElement;
    Tolerancia4: TPLCBlockElement;
    Tolerancia5: TPLCBlockElement;
    Tolerancia6: TPLCBlockElement;
    Tolerancia7: TPLCBlockElement;
    Tolerancia8: TPLCBlockElement;
    Tolerancia9: TPLCBlockElement;
    VariaveisProcesso: TPLCBlock;
    VarProc1: TPLCBlockElement;
    VarProc10: TPLCBlockElement;
    VarProc11: TPLCBlockElement;
    VarProc12: TPLCBlockElement;
    VarProc13: TPLCBlockElement;
    VarProc14: TPLCBlockElement;
    VarProc15: TPLCBlockElement;
    VarProc16: TPLCBlockElement;
    VarProc17: TPLCBlockElement;
    VarProc18: TPLCBlockElement;
    VarProc19: TPLCBlockElement;
    VarProc2: TPLCBlockElement;
    VarProc20: TPLCBlockElement;
    VarProc21: TPLCBlockElement;
    VarProc3: TPLCBlockElement;
    VarProc4: TPLCBlockElement;
    VarProc5: TPLCBlockElement;
    VarProc6: TPLCBlockElement;
    VarProc7: TPLCBlockElement;
    VarProc8: TPLCBlockElement;
    VarProc9: TPLCBlockElement;
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  DataModule1: TDataModule1; 

implementation

{$R *.lfm}

end.

