unit udest;
//--ORDER from TDC -----------------------------------------------------------
/// ShipID: string[15] unique ID kapal sender / receiver

//-----------------------------------------------------------------------//
(*
   C_REC_ORDER             = 10;
    TRecOrder = record
      OrderID        : byte;
      OrderByteParam : byte;
    end;

{1. Select Radar
   OrderID        :
      OrdID_select_radar_type = 1;
   OrderByteParam :
      // DA_MTI, DA_LIN, DA_LOG, WM_NON_MTI, WM_MTI;
 }

{2. F O C
   OrderID        :
      OrdID_FOC_plus          = 6;
      OrdID_FOC_minus         = 7;
   OrderByteParam :
      // datum_number.
}
*)
//-----------------------------------------------------------------------//
(*
   C_REC_ORDER_XY          = 11;
    TRectOrderXY = record
      PC    : TPacketCheck;
      OrderID   : byte;
      OrderType : byte;
      X, Y      : double;
    end;

{ 2. Inter Consol Marker

     TRectOrderXY = record
      OrderID   : byte;      // start_ICM, update_icm, end_icm    = 2, 3, 4
      OrderType : byte       // icm 1, 2, 3
      X, Y      : double;
    end;
}
{ 3. D A T U M
   TRectOrderXY = record
      OrderID   : byte;      // init_datum                      =  5
      OrderType : byte;       // datum_number, 1-5
      X, Y      : double;
   end;
}
{  8. WIPE
    TRecOrderXY = record
      OrderID  : byte;      // WIPE                                 = 13
      OrderType: byte       // 1 kiri, 2 kiri, 1 kanan, 2 kanan
      X, Y     : double;
    end;
}
{ 16. SetIdent Atas Air
    TRectOrderXY = record
      OrderID   : byte;     // ident_atas_air
      OrderType : byte      // track symbol, convert to char
      TrackID   : word;     // encoded ship tid & tracknumber
      X, Y      : double;   //
    end;
}
{ 17. Initiate ESM FIX
   TRectOrderXY = record
      OrderID   : byte;      // init_esm_fix
      OrderType : byte;      // init_esm_fix, 1-5
      X, Y      : double;
   end;
}

*)

//-----------------------------------------------------------------------//
(*
  C_REC_TRACK_ORDER       = 12;
    TRecTrackOrder = record
      PC    : TPacketCheck;
      OrderID  : byte;
      OrderType: byte;
      TrackID  : word;
      X, Y     : double;
    end;

{ 5. Set Ident Bawah Air
    TRecTrackOrder = record
      OrderID  : byte;      // ident_bawah_air    =                 = 8
      OrderType: byte       // track symbol, convert to char
      TrackID  : word;      // encoded ship tid & tracknumber
      X, Y     : double;
    end;
}
{ 6. AssignTorpedo
     belum jelas, status masih pending
    TRecTrackOrder = record
      OrderID  : byte;      // assign_tor , deassign_tor          = 9, 10
      OrderType: byte       // MK44, A244
      TrackID  : word;      // reserve
      X, Y     : double;
    end;
}
{ 7. Assign ASRL / asrock
    TRecTrackOrder = record
      OrderID  : byte;      // assign_asrl , deassign_asrl        = 11, 12
      OrderType: byte       //
      TrackID  : word;      // reserve
      X, Y     : double;
    end;
}

{  9. Init RAM     (atas air)
    TRecTrackOrder = record
      OrderID  : byte;      // init_ram atas air                        17
      OrderType: byte       // track symbol, convert to char
      TrackID  : word;      // encoded ship tid & tracknumber
      X, Y     : double;
    end;
}

{ 10. Assign RAM
    TRecTrackOrder = record
      OrderID  : byte;      // assign_ram
      OrderType: byte       // track symbol, convert to char
      TrackID  : word;      // encoded ship tid & tracknumber
      X, Y     : double;
    end;
}
{ 11. SetIdent Atas Air
    TRecTrackOrder = record
      OrderID   : byte;      // ident_atas_air
      OrderType: byte       // track symbol, convert to char
      TrackID  : word;      // encoded ship tid & tracknumber
      X, Y      : double;    //
    end;
}
{ 14. Init RAM     (udara)
    TRecTrackOrder = record
      OrderID  : byte;      // init_ram udara
      OrderType: byte       // track symbol, convert to char
      TrackID  : word;      // encoded ship tid & tracknumber
      X, Y     : double;
    end;
}

{ 15. Asign RAM
    TRecTrackOrder = record
      OrderID  : byte;      // assign_ram
      OrderType: byte       // track_id
      TrackID  : word;      // track symbol, convert to char
      X, Y     : double;
    end;
}


  *)
(*
  C_REC_ORDER_ASSIGNMENT  = 13;
    TRecOrderAssignment = record           //13
      PC    : TPacketCheck;
      OrderID    : byte;
      DetectedUID: string[15];
      TrackUID   : string[15];
    end;
 *)

(*
  C_REC_SET_TRACKNUM      = 14;
    TRecSetTrackNumber = record           //14
      PC    : TPacketCheck;
      OrderID    : byte;
      TrackNumber: byte;
      ShipTID    : byte;
    end;
 *)
(*

  C_REC_FIRE_CONTROL      = 15;
    TRecFireControlOrder = record        //15
      PC    : TPacketCheck;
      OrderID    : byte;
      FC_number  : byte;
      FC_command : byte;
      TrackUID   : string[15];
      TrackNumber: byte;
      Ship_TID   : byte;
      X, Y       : double;
    end;
{   12. Assign FC 1 - FC 4 QEK TDC 2 KIRI
    TRecFireControlOrder = record
      OrderID    : byte;       // Assign_FC // deassign_FC
      FC_number  : byte;       // FC_number,  1 - 4
      FC_command : byte;       // RATO, RSTO,  break_track, open_fire, hold_fire
      TrackUID   : string[15];    // track UID
      TrackNumber: byte;          // pake track number aja ??
      Ship_TID   : byte;          // track number yg akan di set FC
      X, Y       : double;
    end;
}
{  18. WCC Fire Control
    TRecFireControlOrder = record
      OrderID    : byte;       // Assign_FC // deassign_FC
      FC_number  : byte;       // FC_number,  1 - 4
      FC_command : byte;       // STO, SBS, ATO, SBA, RATO, RSTO,  break_track, open_fire, hold_fire
      TrackUID   : string[15];    // track UID
      TrackNumber: byte;          // pake track number aja ??
      Ship_TID   : byte;          // track number yg akan di set FC
      X, Y       : double;
    end;
}
//------------------------------------------------------------------------------
//------------------------------------------------------------------------------

  C_REC_GUN1_CONTROL      = 16;
    TRecGunControl1 = record                                //16
      PC    : TPacketCheck;
      OrderID     : byte;   //
      AssignedTo  : byte;   // assign ke FC mana
      FireMode    : byte;   // (SINGLE, BURST)
      Bullet1     : byte;   // (PARPROX, IMPACT)
      ControlMode : byte;   // (remote, local)
      IsBlind     : boolean;// lg blind ato ga
      InRange     : boolean;// masuk jarak tembak ato ga
    end;


  C_REC_GUN2_CONTROL      = 17;
    TRecGunControl23 = record                                //17
      PC    : TPacketCheck;
      OrderID     : byte;   // firing gun2, firing gun 3
      Gun_number  : byte;   // (gun2, gun3)
      AssignedTo  : byte;   // assign ke FC mana
      Bullet1     : byte;   // (PARPROX, IMPACT)
      Bullet2     : byte;   // (HE_TRACER, PRE_FRAG)
      IsSync      : boolean;// sync weapon (weapon udah mengarah k target ato belum)
      IsBlind     : boolean;// lg blind ato ga
      InRange     : boolean;// masuk jarak tembak ato ga
    end;


(* ini bukan comment biasa. jangan dihapus. *)
(* From LPD *)


{  Assign Track To Detected Object

}
                                                              {14, 15, reserved}
//------------------------------------------------------------------------------
(**  From QEK TDC 1 KANAN **)
//------------------------------------------------------------------------------

{  19. Gun Control
  TRecGunControl1 = record
      ID      : Word;                        //16
      Pass    : array[0..2] of char;
      ShipID  : string[15];

      OrderID     : byte;   // g tw bwt apa
      AssignedTo  : byte;   // assign ke FC mana
      FireMode    : byte;   // (SINGLE, BURST)
      Bullet1     : byte;   // PARPROX, IMPACT
      ControlMode : byte;   // (remote, local)
      IsBlind     : boolean;// lg blind ato ga
      InRange     : boolean;// masuk jarak tembak ato ga
    end;

    TRecGunControl23 = record
      ID      : Word;                        //17
      Pass    : array[0..2] of char;
      ShipID  : string[15];

      OrderID     : byte;   // g tw bwt apa
      Gun_number  : byte;   // (gun2, gun3)
      AssignedTo  : byte;   // assign ke FC mana
      Bullet1     : byte;   // (PARPROX, IMPACT)
      Bullet2     : byte;   // (HE_TRACER, PRE_FRAG)
      IsSync      : boolean;// sync weapon (weapon udah mengarah k target ato belum)
      IsBlind     : boolean;// lg blind ato ga
      InRange     : boolean;// masuk jarak tembak ato ga
  end;
}

const

//  PORT= '2120';
  BUFFER_SIZE= 1024 * 1024 * 20;
  PACKET_PASS= 'SKL';
  REC_POSITION = 2;


  OrdID_select_radar_type = 1;
  OrdID_start_ICM         = 2;
  OrdID_update_ICM        = 3;
  OrdID_end_ICM           = 4;
  OrdID_init_datum        = 5;
  OrdID_FOC_plus          = 6;
  OrdID_FOC_minus         = 7;
  OrdID_ident_bawah_air   = 8;
  OrdID_assign_tor        = 9;
  OrdID_deassign_tor      = 10;
  OrdID_assign_asrl       = 11;
  OrdID_deassign_asrl     = 12;
  OrdID_WIPE              = 13;
  //14
  //15
  OrdID_init_ram_atas_air     = 16;
  OrdID_assign_ram_atas_air   = 17;
  OrdID_ident_atas_air        = 18;
  OrdID_assign_FC             = 19;
  OrdID_deassign_FC           = 20;
  OrdID_assign_SSM            = 21;
  OrdID_deassign_SSM          = 22;
  OrdID_init_ram_udara        = 23;
  OrdID_assign_ram_udara      = 24;
  OrdID_ident_udara           = 25;
  OrdID_init_esm_fix          = 26; 
  OrdID_fire_gun2       = 90;
  OrdID_fire_gun3       = 91;

type
  OrdType_ICM = (icm1, icm2, icm3);
  OrdType_datum_number = (datum_number1, datum_number2, datum_number3, datum_number4, datum_number5);
  OrdType_torpedo = (MK44, A244);
  OrdType_wipe = (kiri_1, kiri_2, kanan_1, kanan_2);
  OrdType_FC_number = (FC1, FC2, FC3, FC4);
  OrdType_FC_command = (STO, SBS, ATO, SBA, RATO, RSTO,  break_track, open_fire, hold_fire);

  OrdType_GunNumber = (Gun1, Gun2, Gun3);
  OrdType_BulletType1 = (PARPROX, IMPACT);
  OrdType_BulletType2 = (HE_TRACER, PRE_FRAG);
  OrdType_FireMode = (SINGLE_FIRE, BURST_FIRE);
  OrdType_ControlMode = (LOCAL, REMOTE);

implementation

end.

