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

/* 
   always @* begin
		
		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s0.HWDATA   = arbm.mHWDATA;
					s0.HWRITE   = arbm.mHWRITE;
					s0.HTRANS   = arbm.mHTRANS;
					//$display("s0.HRDATA:%b",s0.HRDATA);
					//$display("time=%t",$time);
					if(m0.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m0.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m0.mHADDR;
						arbs.HWRITE 	= m0.mHWRITE;
						arbs.HWDATA 	= m0.mHWDATA;
						arbs.HTRANS 	= m0.mHTRANS;
						arbm.mHRDATA 	= s0.HRDATA;
						s0.HADDR 	= arbm.mHADDR;
						s0.HWDATA 	= arbm.mHWDATA;
						s0.HWRITE 	= arbm.mHWRITE;

						m0.mHGRANT = 1;

					end
					else begin
						m0.mHGRANT = 0;
					end
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s1.HADDR;
					arbm.mHRDATA = s1.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s1.HWDATA   = arbm.mHWDATA;
					s1.HWRITE   = arbm.mHWRITE;
					s1.HTRANS   = arbm.mHTRANS;

					if(m1.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m1.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m1.mHADDR;
						arbs.HWRITE 	= m1.mHWRITE;
						arbs.HWDATA 	= m1.mHWDATA;
						arbs.HTRANS 	= m1.mHTRANS;
						arbm.mHRDATA 	= s1.HRDATA;
						s1.HADDR 	= arbm.mHADDR;
						s1.HWDATA 	= arbm.mHWDATA;
						s1.HWRITE 	= arbm.mHWRITE;

						m1.mHGRANT = 1;

					end
					else begin
						m1.mHGRANT = 0;
					end
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s2.HADDR;
					arbm.mHRDATA = s2.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s2.HWDATA   = arbm.mHWDATA;
					s2.HWRITE   = arbm.mHWRITE;
					s2.HTRANS   = arbm.mHTRANS;
					
					
					if(m2.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m2.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m2.mHADDR;
						arbs.HWRITE 	= m2.mHWRITE;
						arbs.HWDATA 	= m2.mHWDATA;
						arbs.HTRANS 	= m2.mHTRANS;
						arbm.mHRDATA 	= s2.HRDATA;
						s2.HADDR 	= arbm.mHADDR;
						s2.HWDATA 	= arbm.mHWDATA;
						s2.HWRITE 	= arbm.mHWRITE;

						m2.mHGRANT = 1;

					end
					else begin
						m2.mHGRANT = 0;
					end
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s3.HADDR;
					arbm.mHRDATA = s3.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s3.HWDATA   = arbm.mHWDATA;
					s3.HWRITE   = arbm.mHWRITE;
					s3.HTRANS   = arbm.mHTRANS;

					if(m3.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m3.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m3.mHADDR;
						arbs.HWRITE 	= m3.mHWRITE;
						arbs.HWDATA 	= m3.mHWDATA;
						arbs.HTRANS 	= m3.mHTRANS;
						arbm.mHRDATA 	= s3.HRDATA;
						s3.HADDR 	= arbm.mHADDR;
						s3.HWDATA 	= arbm.mHWDATA;
						s3.HWRITE 	= arbm.mHWRITE;

						m3.mHGRANT = 1;

					end
					else begin
						m3.mHGRANT = 0;
					end

				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s4.HADDR;
					arbm.mHRDATA = s4.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s4.HWDATA   = arbm.mHWDATA;
					s4.HWRITE   = arbm.mHWRITE;
					s4.HTRANS   = arbm.mHTRANS;

					if(m4.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m4.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m4.mHADDR;
						arbs.HWRITE 	= m4.mHWRITE;
						arbs.HWDATA 	= m4.mHWDATA;
						arbs.HTRANS 	= m4.mHTRANS;
						arbm.mHRDATA 	= s4.HRDATA;
						s4.HADDR 	= arbm.mHADDR;
						s4.HWDATA 	= arbm.mHWDATA;
						s4.HWRITE 	= arbm.mHWRITE;

						m4.mHGRANT = 1;

					end
					else begin
						m4.mHGRANT = 0;
					end

				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s5.HADDR;
					arbm.mHRDATA = s5.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s5.HWDATA   = arbm.mHWDATA;
					s5.HWRITE   = arbm.mHWRITE;
					s5.HTRANS   = arbm.mHTRANS;

					if(m5.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m5.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m5.mHADDR;
						arbs.HWRITE 	= m5.mHWRITE;
						arbs.HWDATA 	= m5.mHWDATA;
						arbs.HTRANS 	= m5.mHTRANS;
						arbm.mHRDATA 	= s5.HRDATA;
						s5.HADDR 	= arbm.mHADDR;
						s5.HWDATA 	= arbm.mHWDATA;
						s5.HWRITE 	= arbm.mHWRITE;

						m5.mHGRANT = 1;

					end
					else begin
						m5.mHGRANT = 0;
					end

				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s6.HADDR;
					arbm.mHRDATA = s6.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s6.HWDATA   = arbm.mHWDATA;
					s6.HWRITE   = arbm.mHWRITE;
					s6.HTRANS   = arbm.mHTRANS;

					if(m6.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m6.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m6.mHADDR;
						arbs.HWRITE 	= m6.mHWRITE;
						arbs.HWDATA 	= m6.mHWDATA;
						arbs.HTRANS 	= m6.mHTRANS;
						arbm.mHRDATA 	= s6.HRDATA;
						s6.HADDR 	= arbm.mHADDR;
						s6.HWDATA 	= arbm.mHWDATA;
						s6.HWRITE 	= arbm.mHWRITE;

						m6.mHGRANT = 1;

					end
					else begin
						m6.mHGRANT = 0;
					end
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s7.HADDR;
					arbm.mHRDATA = s7.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s7.HWDATA   = arbm.mHWDATA;
					s7.HWRITE   = arbm.mHWRITE;
					s7.HTRANS   = arbm.mHTRANS;

					if(m7.mHBUSREQ) begin
						arbs.HSEL 	= 1'b1;
						m7.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m7.mHADDR;
						arbs.HWRITE 	= m7.mHWRITE;
						arbs.HWDATA 	= m7.mHWDATA;
						arbs.HTRANS 	= m7.mHTRANS;
						arbm.mHRDATA 	= s7.HRDATA;
						s7.HADDR 	= arbm.mHADDR;
						s7.HWDATA 	= arbm.mHWDATA;
						s7.HWRITE 	= arbm.mHWRITE;

						m7.mHGRANT = 1;

					end
					else begin
						m7.mHGRANT = 0;
					end

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
				end
				
		endcase 
		
	end
*/
/*
	else begin
					s0.HADDR = arbm.mHADDR[15:0];
					arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s0.HWDATA   = arbm.mHWDATA;
					s0.HWRITE   = arbm.mHWRITE;
					s0.HTRANS   = arbm.mHTRANS;

		end

 */
	
	always@(*) begin
		nextstate = state;
		case(state) 
			ns0 : begin
				if(m0.mHBUSREQ) begin
					m0.mHGRANT = 1;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns0;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;

					nextstate = ns1;
				end
			end
			ns1 : begin
				if(m1.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 1;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns1;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns2;
				end
			end
			ns2 : begin
				if(m2.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 1;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns2;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns3;
				end
			end
			ns3 : begin
				  if(m3.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 1;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns3;

				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns4;
				end
			end
			ns4 : begin
				if(m4.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 1;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns4;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns5;
				end
			end
			ns5 : begin
				if(m5.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 1;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns5;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns6;
				end
			end
			ns6 : begin
				if(m6.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 1;
					m7.mHGRANT = 0;
					nextstate = ns6;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns7;
				end
			end
			ns7 : begin
				if(m7.mHBUSREQ) begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 1;
					nextstate = ns7;
				end
				else begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns0;
				end
			end
			default: begin
					m0.mHGRANT = 0;
					m1.mHGRANT = 0;
					m2.mHGRANT = 0;
					m3.mHGRANT = 0;
					m4.mHGRANT = 0;
					m5.mHGRANT = 0;
					m6.mHGRANT = 0;
					m7.mHGRANT = 0;
					nextstate = ns0;
				 end
	
		endcase
	end
	
	always @*
	begin
		if(m0.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m0.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m0.mHADDR;
						arbs.HWRITE 	= m0.mHWRITE;
						arbs.HWDATA 	= m0.mHWDATA;
						arbs.HTRANS 	= m0.mHTRANS;
						arbm.mHRDATA 	= s0.HRDATA;
						s0.HADDR 	= arbm.mHADDR;
						s0.HWDATA 	= arbm.mHWDATA;
						s0.HWRITE 	= arbm.mHWRITE;	
		end 
		else if(m1.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m1.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m1.mHADDR;
						arbs.HWRITE 	= m1.mHWRITE;
						arbs.HWDATA 	= m1.mHWDATA;
						arbs.HTRANS 	= m1.mHTRANS;
						arbm.mHRDATA 	= s1.HRDATA;
						s1.HADDR 	= arbm.mHADDR;
						s1.HWDATA 	= arbm.mHWDATA;
						s1.HWRITE 	= arbm.mHWRITE;
		end 
		else if(m2.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m2.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m2.mHADDR;
						arbs.HWRITE 	= m2.mHWRITE;
						arbs.HWDATA 	= m2.mHWDATA;
						arbs.HTRANS 	= m2.mHTRANS;
						arbm.mHRDATA 	= s2.HRDATA;
						s2.HADDR 	= arbm.mHADDR;
						s2.HWDATA 	= arbm.mHWDATA;
						s2.HWRITE 	= arbm.mHWRITE;
		end else if(m3.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m3.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m3.mHADDR;
						arbs.HWRITE 	= m3.mHWRITE;
						arbs.HWDATA 	= m3.mHWDATA;
						arbs.HTRANS 	= m3.mHTRANS;
						arbm.mHRDATA 	= s3.HRDATA;
						s3.HADDR 	= arbm.mHADDR;
						s3.HWDATA 	= arbm.mHWDATA;
						s3.HWRITE 	= arbm.mHWRITE;
		end else if(m4.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m4.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m4.mHADDR;
						arbs.HWRITE 	= m4.mHWRITE;
						arbs.HWDATA 	= m4.mHWDATA;
						arbs.HTRANS 	= m4.mHTRANS;
						arbm.mHRDATA 	= s4.HRDATA;
						s4.HADDR 	= arbm.mHADDR;
						s4.HWDATA 	= arbm.mHWDATA;
						s4.HWRITE 	= arbm.mHWRITE;
		end else if(m5.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m5.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m5.mHADDR;
						arbs.HWRITE 	= m5.mHWRITE;
						arbs.HWDATA 	= m5.mHWDATA;
						arbs.HTRANS 	= m5.mHTRANS;
						arbm.mHRDATA 	= s5.HRDATA;
						s5.HADDR 	= arbm.mHADDR;
						s5.HWDATA 	= arbm.mHWDATA;
						s5.HWRITE 	= arbm.mHWRITE;


		end else if(m6.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m6.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m6.mHADDR;
						arbs.HWRITE 	= m6.mHWRITE;
						arbs.HWDATA 	= m6.mHWDATA;
						arbs.HTRANS 	= m6.mHTRANS;
						arbm.mHRDATA 	= s6.HRDATA;
						s6.HADDR 	= arbm.mHADDR;
						s6.HWDATA 	= arbm.mHWDATA;
						s6.HWRITE 	= arbm.mHWRITE;
		end else if(m7.mHGRANT == 1) begin
						arbs.HSEL 	= 1'b1;
						m7.mHRDATA 	= arbs.HRDATA;
						arbs.HADDR 	= m7.mHADDR;
						arbs.HWRITE 	= m7.mHWRITE;
						arbs.HWDATA 	= m7.mHWDATA;
						arbs.HTRANS 	= m7.mHTRANS;
						arbm.mHRDATA 	= s7.HRDATA;
						s7.HADDR 	= arbm.mHADDR;
						s7.HWDATA 	= arbm.mHWDATA;
						s7.HWRITE 	= arbm.mHWRITE;
		end else begin
		case(arbm.mHADDR[31:16]) 
		16'hf000:	begin
					s0.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s0.HADDR;
					arbm.mHRDATA = s0.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s0.HWDATA   = arbm.mHWDATA;
					s0.HWRITE   = arbm.mHWRITE;
					s0.HTRANS   = arbm.mHTRANS;
					//$display("s0.HRDATA:%b",s0.HRDATA);
					//$display("time=%t",$time);
					
				end
		16'hf001:	begin
					s1.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s1.HADDR;
					arbm.mHRDATA = s1.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s1.HWDATA   = arbm.mHWDATA;
					s1.HWRITE   = arbm.mHWRITE;
					s1.HTRANS   = arbm.mHTRANS;

					
				end
		16'hf002:	begin
					s2.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s2.HADDR;
					arbm.mHRDATA = s2.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s2.HWDATA   = arbm.mHWDATA;
					s2.HWRITE   = arbm.mHWRITE;
					s2.HTRANS   = arbm.mHTRANS;
					
					
					
				end
		16'hf003:	begin
					s3.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s3.HADDR;
					arbm.mHRDATA = s3.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
					arbs.HSEL 	= 1'b1;
				 	s3.HWDATA   = arbm.mHWDATA;
					s3.HWRITE   = arbm.mHWRITE;
					s3.HTRANS   = arbm.mHTRANS;

					

				end
		16'hf004:	begin
					s4.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s4.HADDR;
					arbm.mHRDATA = s4.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s4.HWDATA   = arbm.mHWDATA;
					s4.HWRITE   = arbm.mHWRITE;
					s4.HTRANS   = arbm.mHTRANS;

					

				end
		16'hf005:	begin
					s5.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s5.HADDR;
					arbm.mHRDATA = s5.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s5.HWDATA   = arbm.mHWDATA;
					s5.HWRITE   = arbm.mHWRITE;
					s5.HTRANS   = arbm.mHTRANS;

					

				end
		16'hf006:	begin
					s6.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s6.HADDR;
					arbm.mHRDATA = s6.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s6.HWDATA   = arbm.mHWDATA;
					s6.HWRITE   = arbm.mHWRITE;
					s6.HTRANS   = arbm.mHTRANS;

					
				end
		16'hf007:	begin
					s7.HADDR = arbm.mHADDR[15:0];
					//arbs.HADDR = s7.HADDR;
					arbm.mHRDATA = s7.HRDATA;
					arbs.HWDATA = arbm.mHWDATA;
				 	s7.HWDATA   = arbm.mHWDATA;
					s7.HWRITE   = arbm.mHWRITE;
					s7.HTRANS   = arbm.mHTRANS;

					
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
				end
				
		endcase 
		end	

	end

	always @(posedge arbm.HCLK) 
	begin
		if(arbm.HRESET) 
			begin
				state <= #1 ns0;
			end
		else
			begin
				state <= #1 nextstate;

			end		
	
	end


endmodule
