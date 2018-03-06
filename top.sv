// A very simple top level for the can transmitter
//
`timescale 1ns/10ps

`include "cant_idef.svh"

import cantidef::*;

`include "cant_intf.svh"
`include "ahbif.svh"

`include "tmm.svhp"

`include "canxmit.sv"
`include "arbitrator.sv"

`include "ahb.sv"


module top();

import uvm_pkg::*;
import tmm::*;

reg clk,rst;

AHBIF    atb(clk,rst);
cantintf ci0(clk,rst);
AHBIF    ai0(clk,rst);
cantintf ci1(clk,rst);
AHBIF    ai1(clk,rst);
cantintf ci2(clk,rst);
AHBIF    ai2(clk,rst);
cantintf ci3(clk,rst);
AHBIF    ai3(clk,rst);
cantintf ci4(clk,rst);
AHBIF    ai4(clk,rst);
cantintf ci5(clk,rst);
AHBIF    ai5(clk,rst);
cantintf ci6(clk,rst);
AHBIF    ai6(clk,rst);
cantintf ci7(clk,rst);
AHBIF    ai7(clk,rst);

initial begin
  clk=0;
  repeat(2000000) begin
    #5 clk=~clk;
  end
  $display("Used up the clocks");
  $finish;
end

initial begin
  rst=0;
  @(posedge(clk)) #1;
  rst=1;
  repeat(3) @(posedge(clk)) #1;
  rst=0;
end

initial begin
    #0;
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf0",ci0);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF0",ai0);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf1",ci1);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF1",ai1);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf2",ci2);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF2",ai2);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf3",ci3);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF3",ai3);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf4",ci4);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF4",ai4);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf5",ci5);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF5",ai5);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf6",ci6);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF6",ai6);
    uvm_config_db #(virtual cantintf)::set(null, "*", "cantintf7",ci7);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",     "AHBIF7",ai7);
    uvm_config_db #(virtual AHBIF)::set   (null,"*",    "AHBIFtb",atb);
    run_test("t1");
    $display("Test came back to me");
    #100;
    $finish;


end

initial begin
  $dumpfile("mm.vpd");
  $dumpvars(9,top);
end


canxmit c0(ci0.xmit);
ahb a0(ai0.AHBM,ai0.AHBS,ci0.tox);
canxmit c1(ci1.xmit);
ahb a1(ai1.AHBM,ai1.AHBS,ci1.tox);
canxmit c2(ci2.xmit);
ahb a2(ai2.AHBM,ai2.AHBS,ci2.tox);
canxmit c3(ci3.xmit);
ahb a3(ai3.AHBM,ai3.AHBS,ci3.tox);
canxmit c4(ci4.xmit);
ahb a4(ai4.AHBM,ai4.AHBS,ci4.tox);
canxmit c5(ci5.xmit);
ahb a5(ai5.AHBM,ai5.AHBS,ci5.tox);
canxmit c6(ci6.xmit);
ahb a6(ai6.AHBM,ai6.AHBS,ci6.tox);
canxmit c7(ci7.xmit);
ahb a7(ai7.AHBM,ai7.AHBS,ci7.tox);
arbitrator arb(
    ai0.AHBMa,ai0.AHBSa,
    ai1.AHBMa,ai1.AHBSa,
    ai2.AHBMa,ai2.AHBSa,
    ai3.AHBMa,ai3.AHBSa,
    ai4.AHBMa,ai4.AHBSa,
    ai5.AHBMa,ai5.AHBSa,
    ai6.AHBMa,ai6.AHBSa,
    ai7.AHBMa,ai7.AHBSa,
    atb.AHBMa,atb.AHBSa);




endmodule : top
