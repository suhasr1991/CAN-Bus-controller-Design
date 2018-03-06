module ahb(AHBIF.AHBM master,AHBIF.AHBS slave,cantintf.tox can_bus);

	/*modport AHBS( input HCLK, input HRESET,
        input HSEL, input HADDR,
        input HWRITE, input HTRANS,
        input HSIZE, input HBURST, input HWDATA, 
        output HREADY,
        output HRESP, output HRDATA);

	modport AHBM( input HCLK, input HRESET,
        input mHGRANT, output mHBUSREQ, 
        input mHREADY,input mHRESP, output HPROT,
        input mHRDATA,output mHTRANS, output mHADDR,
        output mHWRITE, output mHWDATA, output mHSIZE, output mHBURST);	*/

	reg   [10:0]count;
	reg [31:0]DH,DL,CMD,ID,ST_BUSY;	
	reg [31:0]MDH,MDL,MCMD,MID,BM_BASE,BM_BASE_d,BM_STATUS,MADDR,MDATA,LINK;
	enum {IDLE,ZERO,ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,TEN0,TEN,ELE,TWE,THI,FORT,FIFT}state,state_d;
	enum {idle,zero,one,two,three,four}state1,state_d1;

	always	@* begin

				DH = DH;
				DL = DL;
				CMD = CMD;
				ID  = ID;
				ST_BUSY = ST_BUSY;	
				can_bus.startXmit  = 1'b0;
				can_bus.quantaDiv  = can_bus.quantaDiv;
				can_bus.propQuanta = can_bus.propQuanta;
				can_bus.seg1Quanta = can_bus.seg1Quanta;
				can_bus.datalen    = can_bus.datalen;
				can_bus.format     = can_bus.format;
				can_bus.frameType  = can_bus.frameType;
				can_bus.id         = can_bus.id;
				slave.HRDATA     = slave.HRDATA; 
		   		state_d=state;	
		case (state) 
			IDLE: begin
						master.mHBUSREQ = 1'b0;
					if (slave.HWRITE==1 && slave.HTRANS==2 ) begin
						if (slave.HADDR[15:0]==16'hff04) begin
							state_d = ZERO;
						end else begin
							state_d = IDLE;
						end
			      		end else begin
						state_d = IDLE;
	    			        end
		      	      end

 		        ZERO: begin 
						master.mHBUSREQ = 1'b0;
					if (slave.HADDR[15:0]==16'hff00) begin
						can_bus.startXmit  = 1'b0;
						state_d = ONE;	
					end else begin
						state_d = ZERO;
						DL = slave.HWDATA;
					end					
		              end

			ONE:  begin
						master.mHBUSREQ = 1'b0;
					if (slave.HADDR[15:0]==16'hff08) begin
						can_bus.startXmit  = 1'b0;
						state_d = TWO;	
					end else begin
						state_d = ONE;
						DH = slave.HWDATA;
					end	
			      end
			TWO:  begin
						master.mHBUSREQ = 1'b0;
					if (slave.HADDR[15:0]==16'hff0C) begin
						can_bus.startXmit  = 1'b0;
						state_d = THREE;	
					end else begin
						CMD = slave.HWDATA;
						state_d = TWO;
					end	
			      end
			THREE: begin
						master.mHBUSREQ = 1'b0;
					if (slave.HADDR[15:0]==16'hff10) begin
						can_bus.startXmit  = 1'b0;
						state_d = FOUR;	
					end else begin
						ID = slave.HWDATA;
						state_d = THREE;
					end	
			       end
			FOUR: begin
						master.mHBUSREQ = 1'b0;
					ST_BUSY            = slave.HWDATA;
					can_bus.startXmit  = 1'b1;
					can_bus.xmitdata   = {DH,DL};
					can_bus.quantaDiv  = CMD[31:24];
					can_bus.propQuanta = CMD[23:18];
					can_bus.seg1Quanta = CMD[17:12];
					can_bus.datalen    = CMD[11:8];
					can_bus.format     = CMD[7];
					can_bus.frameType  = CMD[6:5];
					can_bus.id         = ID[31:3];

					state_d = FIVE;
			       end

			 FIVE: begin
						master.mHBUSREQ = 1'b0;
					//master.mHWDATA = {BM_STATUS,0};
					if (slave.HWRITE==0) begin
						case(slave.HADDR[15:0])
							16'hff00: //DH 
						       		begin	
							       		slave.HRDATA = DH; 
									can_bus.startXmit = 1'b0;
								//	state_d = FIVE;
								end
							16'hff04: //DL
								begin
									slave.HRDATA = DL;
									can_bus.startXmit = 1'b0;
								//	state_d = FIVE;
								end
							16'hff08: //CMD
								begin
									slave.HRDATA = CMD; 
									can_bus.startXmit = 1'b0;
								//	state_d = FIVE;
								end
							16'hff0c: //ID
								begin
									slave.HRDATA  = ID;		
									can_bus.startXmit = 1'b0;
								//	state_d = FIVE;
								end
							16'hff10: //ST_BUSY
								begin
									//$display("slave.HWRITE:%b",slave.HWRITE);
									//$display("time=%t",$time);	
									//$display("slave.HADDR[15:0]:%b",slave.HADDR);
									//$display("ff10 state");
									slave.HRDATA[31:0] = {31'b000_0000_0000_0000_0000_0000_0000_0000,can_bus.busy};
									//$display("slave.HRDATA:%b",slave.HRDATA);
									can_bus.startXmit  = 1'b0;
								//	state_d = FIVE;
								end
							16'hff18: 
								begin
									slave.HRDATA[31:0] = BM_STATUS;
									state_d = SEVEN;
								end
						
						endcase
							BM_BASE = 0;
							state_d = FIVE;
					end else if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR[15:0]==16'hff04) begin
						state_d = ZERO;
					end else if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR[15:0]==16'hff14) begin
						state_d = SIX;	
					end else begin
						state_d = IDLE;
					end

			       end
		       SIX:   begin//7
					//if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR[15:0]==16'hff18) begin
					if (slave.HADDR[15:0]==16'hff18) begin
						state_d = SEVEN;
					end else if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR[15:0]==16'hff04) begin
						state_d = ZERO;
					end else begin
			     			BM_BASE = slave.HWDATA;
						state_d = SIX;
						master.mHBUSREQ = 1'b0;
					end
			      end

		      SEVEN:  begin//8
			      		BM_STATUS = 1;
					master.mHBUSREQ = 1'b1;
					state_d = EIGHT;
		      	      end
		      EIGHT:  begin//9
					if (master.mHGRANT==1) begin
						if (slave.HWRITE==0 && slave.HADDR[15:0]==16'hff18) begin
							slave.HRDATA = BM_STATUS;
							state_d = NINE;
						end else begin
							slave.HRDATA = slave.HRDATA;
						end

					end else begin
						state_d = EIGHT;
					end
		     	      end
		      NINE:   begin//TEN
		      			//$display("BM_BASE_d:",BM_BASE_d);
					master.mHADDR = BM_BASE;
					master.mHTRANS = 2;
					master.mHWRITE = 0;
					state_d = TEN0;	
			      end
		      TEN0:   begin//ELEVEN
					state_d = TEN;
		      	      end
		      TEN:    begin//TWELVE
		    			if (count==0) begin
						MDH  = master.mHRDATA;
						state_d = NINE;
					end else if (count==1) begin
						MDL  = master.mHRDATA;
						state_d = NINE;
					end else if (count==2) begin
						MCMD = master.mHRDATA;
						state_d = NINE;
					end else if (count==3) begin
						MID  = master.mHRDATA;
						state_d = NINE;
					end else if (count==4) begin
						MADDR = master.mHRDATA;
						state_d = NINE;
					end else if (count==5) begin
						MDATA = master.mHRDATA;
						state_d = NINE;
					end else begin
						LINK = master.mHRDATA;
						state_d = TWE;
					end
		      	      end

			ELE:   begin//THIRTEEH
					//master.mHWRITE = 0;
					master.mHBUSREQ = 0;

					//$display("HWDATA=%h",master.mHWDATA);
					if (LINK == 0) begin
						BM_STATUS = 0;
						master.mHTRANS = 0;
						//slave.HRDATA = BM_STATUS;
						state_d = FIVE;
						BM_BASE = 0;	
					end else begin	
						BM_BASE = LINK;
						state_d = SEVEN;
					end

			       end

			TWE:   begin//14
				//	master.mHBUSREQ = 0;
					can_bus.startXmit  = 1'b1;
					can_bus.xmitdata   = {MDH,MDL};
					can_bus.quantaDiv  = MCMD[31:24];
					can_bus.propQuanta = MCMD[23:18];
					can_bus.seg1Quanta = MCMD[17:12];
					can_bus.datalen    = MCMD[11:8];
					can_bus.format     = MCMD[7];
					can_bus.frameType  = MCMD[6:5];
					can_bus.id         = MID[31:3];
					state_d = THI;
			       end				
			THI:   begin//15
					master.mHBUSREQ = 0;
					if (can_bus.busy) begin
						state_d = THI;
							
					end else begin
						state_d = FORT;
					end
			       end

			FORT:  begin//16
					master.mHBUSREQ = 0;
					state_d = FIFT;
					master.mHWRITE = 1;
					master.mHADDR  = MADDR; 
			       end
			FIFT: begin//17	
					master.mHBUSREQ = 0;
					master.mHWRITE = 0;
					master.mHWDATA = MDATA;	
					state_d = ELE;
			      end

		endcase
	end

	always @(posedge slave.HCLK) begin
		if(slave.HRESET) begin
			state  <= #1 IDLE;	
			state1 <= #1 idle;
			count <= #1 0;
			BM_BASE_d <= #1 0;
		end else begin
			state  <= #1 state_d;
			state1 <= #1 state_d1;
			BM_BASE_d <= #1 BM_BASE;

			if (state==TEN) begin
				count   <=#1  count + 1;
				BM_BASE <=#1  BM_BASE + 4; 
			end
			else begin 
				BM_BASE <= #1 BM_BASE;
				count <= #1 count;
			end	
			if (state==TWE) begin
				count<= #1 0;
			end	
			
	
		end
	end
	

endmodule
