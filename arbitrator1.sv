module arbitrator(AHBIF.AHBMa m0, AHBIF.AHBSa s0,
	   AHBIF.AHBMa m1, AHBIF.AHBSa s1,
	   AHBIF.AHBMa m2, AHBIF.AHBSa s2,
	   AHBIF.AHBMa m3, AHBIF.AHBSa s3,
	   AHBIF.AHBMa m4, AHBIF.AHBSa s4,
	   AHBIF.AHBMa m5, AHBIF.AHBSa s5,
	   AHBIF.AHBMa m6, AHBIF.AHBSa s6,
	   AHBIF.AHBMa m7, AHBIF.AHBSa s7,
	   AHBIF.AHBMa arbm, AHBIF.AHBSa arbs);
enum {ns0,ns1,ns2,ns3,ns4,ns5,ns6,ns7,ns8}state,nextstate;

 
   always @* begin

	   nextstate = state;

	   case(state)

	   ns0: begin
		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					$display("s0.HRDATA:%b",s0.HRDATA);
					$display("time=%t",$time);
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns1: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s0.HWDATA   = arbm.mHWDATA;
		s0.HWRITE   = arbm.mHWRITE;
		s0.HTRANS   = arbm.mHTRANS;

		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end
	ns2: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s1.HWDATA   = arbm.mHWDATA;
		s1.HWRITE   = arbm.mHWRITE;
		s1.HTRANS   = arbm.mHTRANS;

		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns3: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s2.HWDATA   = arbm.mHWDATA;
		s2.HWRITE   = arbm.mHWRITE;
		s2.HTRANS   = arbm.mHTRANS;

		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns4: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s3.HWDATA   = arbm.mHWDATA;
		s3.HWRITE   = arbm.mHWRITE;
		s3.HTRANS   = arbm.mHTRANS;
		
		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns5: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s4.HWDATA   = arbm.mHWDATA;
		s4.HWRITE   = arbm.mHWRITE;
		s4.HTRANS   = arbm.mHTRANS;

		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns6: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s5.HWDATA   = arbm.mHWDATA;
		s5.HWRITE   = arbm.mHWRITE;
		s5.HTRANS   = arbm.mHTRANS;

		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns7: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s6.HWDATA   = arbm.mHWDATA;
		s6.HWRITE   = arbm.mHWRITE;
		s6.HTRANS   = arbm.mHTRANS;

		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end

	ns8: begin

		arbs.HWDATA = arbm.mHWDATA;
	 	s7.HWDATA   = arbm.mHWDATA;
		s7.HWRITE   = arbm.mHWRITE;
		s7.HTRANS   = arbm.mHTRANS;
		
		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					nextstate = ns1; 
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbs.HWDATA = arbm.mHWDATA;
					nextstate = ns2;
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					nextstate = ns3;
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					nextstate = ns4;
				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					nextstate = ns5;
				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					nextstate = ns6;
				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					nextstate = ns7;
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					nextstate = ns8;
				end
		default:	begin
					s0.HADDR = 0;
					s1.HADDR = 0;
					s2.HADDR = 0;
					s3.HADDR = 0;
					s4.HADDR = 0;
					s5.HADDR = 0;
					s6.HADDR = 0;
					s7.HADDR = 0;
					arbs.HADDR = 0;
					nextstate = ns0;
				end
				
		endcase 
	end
	endcase
   end

	always @(posedge arbm.HCLK) 
	begin
		if(arbm.HRESET) 
			begin
				state <= ns0;
			end
		else
			begin
				state <= nextstate;

			end		
	
	end


endmodule
