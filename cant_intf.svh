// A simple interface object for the can transmitter
//


interface cantintf(input reg clk, input reg rst);
//reg clk,rst;
reg [7:0] quantaDiv;
reg [5:0] propQuanta,seg1Quanta;
reg [63:0] xmitdata; // data in. Assume big endian byte order
reg startXmit;  // begin a transmission
reg busy;       // The can transmitter is busy, (Like a stop flag)
reg [3:0] datalen; // 0-8 are valid
reg [28:0] id; // use the upper 11 bits in 11 bit mode
reg format; // 0=11 bit 1=29 bit
xmitFrameType frameType;

reg dout;   // the data out
reg ddrive; // drive the output signal
reg din;    // the result of driving the bus

modport xmit(input clk, input rst, input quantaDiv, input propQuanta,
    input seg1Quanta,input xmitdata,input startXmit,output busy,
    input datalen, input id, input format, input frameType,
    output dout, output ddrive, input din);

modport tox(output quantaDiv,output propQuanta, output seg1Quanta,
    output xmitdata, output startXmit, input busy,
    output datalen, output id, output format, output frameType);

// Some variables for debug use
reg oops;
    
    
endinterface : cantintf


