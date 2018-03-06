// These are the definitions for classes in the can transmitter test bench
//
    import cantidef::*;

class Sr extends uvm_sequence_item;
reg busy;
endclass : Sr

typedef enum { Si_ignore,Si_reset,Si_setmem,Si_wreg,Si_slvbusy,Si_wbmbusy,Si_expStartBM,
    Si_expStart,Si_waitclk} Si_cmds;

class Si extends uvm_sequence_item;
`uvm_object_utils(Si)
//reg do_reset;
//int waitclks;
//reg setmem;         // indicates we should set a memory location
//reg wbmbusy;        //
//reg wreg;
Si_cmds cmd;        // A unified command enumeration
int ccode;          // a general command code...
reg [31:0] dbase;   // The register base address...
reg [31:0] memaddr,memdata;
rand reg [7:0] quantaDiv;
rand reg [5:0] propQuanta,seg1Quanta;
rand reg [63:0] xmitdata; // data in. Assume big endian byte order
rand reg [3:0] datalen; // 0-8 are valid
rand reg [28:0] id; // use the upper 11 bits in 11 bit mode
rand reg format; // 0=11 bit 1=29 bit
reg [31:0] caddr,cdata;
rand cantidef::xmitFrameType frameType;
  
  function new(string name="cant");
    super.new(name);
    cmd=Si_ignore;
  endfunction : new
  
  function string pdata();
    return $sformatf("qd %d pq %d s1 %d xd %h id %h for %d ft %h",
        this.quantaDiv,this.propQuanta,this.seg1Quanta,this.xmitdata,this.id,this.format,this.frameType);
  endfunction : pdata
  
  function reg cmp(Si a);
    return a.quantaDiv==quantaDiv && a.propQuanta==propQuanta && a.seg1Quanta == seg1Quanta &&
        a.xmitdata == xmitdata && a.id==id && a.format == format && a.frameType == frameType;
  
  endfunction : cmp

  function Si cpy(Si src);
//    src.do_reset = this.do_reset;
//    src.waitclks = this.waitclks;
//    src.setmem = this.setmem;
//    src.wbmbusy = this.wbmbusy;
//    src.wreg = this.wreg;
    src.cmd = this.cmd;
    src.memaddr = this.memaddr; src.memdata=this.memdata;
    src.quantaDiv = this.quantaDiv;
    src.propQuanta = this.propQuanta; src.seg1Quanta = this.seg1Quanta;
    src.xmitdata = this.xmitdata;
    src.datalen = this.datalen;
    src.id = this.id;
    src.format = this.format;
    src.caddr = this.caddr; src.cdata=this.cdata;
    src.frameType = this.frameType;
    src.ccode = this.ccode;
    return src;
  endfunction : cpy
  
endclass : Si

class DBIT extends uvm_sequence_item;
`uvm_object_utils(DBIT)

  reg dout;
  reg ddrive;
  reg din;

  function new(string name = "DBIT");
    super.new(name);
  endfunction : new

endclass : DBIT

typedef enum logic [1:0] { D0,D1,DA,DX } Ebit;

class EXPframe;
    Ebit fdata[404];    // biggest frameType
    string dname[404]; // string names for each bit
    int flen;
    
    function new();
      flen=0;
    endfunction : new

endclass : EXPframe

class Ri;
    reg [1:0] addr;
    reg [31:0] value;
    reg write;
endclass : Ri


