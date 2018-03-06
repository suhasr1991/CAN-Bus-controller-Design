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
	enum {IDLE,ZERO,ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,TEN0,TEN,ELE,TWE,THI,FORT}state,state_d;
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
					if (slave.HWRITE==1 && slave.HTRANS==2 ) begin
						if (slave.HADDR==32'hf000_ff04) begin
							state_d = ZERO;
						end else begin
							state_d = IDLE;
						end
			      		end else begin
						state_d = IDLE;
	    			        end
		      	      end

 		        ZERO: begin 
					if (slave.HADDR==32'hf000_ff00) begin
						DL = slave.HWDATA;
						can_bus.startXmit  = 1'b0;
						state_d = ONE;	
					end else begin
						state_d = ZERO;
					end					
		              end

			ONE:  begin
					if (slave.HADDR==32'hf000_ff08) begin
						DH = slave.HWDATA;
						can_bus.startXmit  = 1'b0;
						state_d = TWO;	
					end else begin
						state_d = ONE;
					end	
			      end
			TWO:  begin
					if (slave.HADDR==32'hf000_ff0C) begin
						CMD = slave.HWDATA;
						can_bus.startXmit  = 1'b0;
						state_d = THREE;	
					end else begin
						state_d = TWO;
					end	
			      end
			THREE: begin
					if (slave.HADDR==32'hf000_ff10) begin
						ID = slave.HWDATA;
						can_bus.startXmit  = 1'b0;
						state_d = FOUR;	
					end else begin
						state_d = THREE;
					end	
			       end
			FOUR: begin
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
					//master.mHWDATA = {BM_STATUS,0};
					if (slave.HWRITE==0) begin
						case(slave.HADDR)
							32'hf000_ff00: //DH 
						       		begin	
							       		slave.HRDATA = DH; 
									can_bus.startXmit = 1'b0;
								end
							32'hf000_ff04: //DL
								begin
									slave.HRDATA = DL;
									can_bus.startXmit = 1'b0;
								end
							32'hf000_ff08: //CMD
								begin
									slave.HRDATA = CMD; 
									can_bus.startXmit = 1'b0;
								end
							32'hf000_ff0c: //ID
								begin
									slave.HRDATA  = ID;		
									can_bus.startXmit = 1'b0;
								end
							32'hf000_ff10: //ST_BUSY
								begin
									slave.HRDATA[31:0] = {31'b000_0000_0000_0000_0000_0000_0000_0000,can_bus.busy};
									can_bus.startXmit  = 1'b0;
								end
							32'hf000_ff18: 
								begin
									slave.HRDATA[31:0] = BM_STATUS;
								end
		
						endcase

						state_d = FIVE;
					end else if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR==32'hf000_ff04) begin
						state_d = ZERO;
					end else if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR==32'hf000_ff14) begin
						state_d = SIX;	
					end else begin
						state_d = IDLE;
					end

			       end
		       SIX:   begin
					if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR==32'hf000_ff18) begin
			     			BM_BASE = slave.HWDATA;
						state_d = SEVEN;
					end else if (slave.HWRITE==1 && slave.HTRANS==2 && slave.HADDR==32'hf000_ff04) begin
						state_d = ZERO;
					end else begin
						state_d = IDLE;
					end
			      end

		      SEVEN:  begin
			      		BM_STATUS = 1;
					master.mHBUSREQ = 1'b1;
					state_d = EIGHT;
		      	      end
		      EIGHT:  begin
					if (master.mHGRANT==1) begin
						if (slave.HWRITE==0 && slave.HADDR==32'hf000_ff18) begin
							slave.HRDATA = BM_STATUS;
						end else begin
							slave.HRDATA = slave.HRDATA;
						end

						state_d = NINE;
					end else begin
						state_d = EIGHT;
					end
		     	      end
		      NINE:   begin//A
		      			//$display("BM_BASE_d:",BM_BASE_d);
					master.mHADDR = BM_BASE;
					master.mHTRANS = 2;
					master.mHWRITE = 0;
					state_d = TEN0;	
			      end
		      TEN0:   begin//B
					state_d = TEN;
		      	      end
		      TEN:    begin//C
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

			ELE:   begin
					master.mHWDATA = MDATA;	
					master.mHWRITE = 0;
					//$display("HWDATA=%h",master.mHWDATA);
					if (LINK == 0) begin
						BM_STATUS = 0;
						master.mHTRANS = 0;
						//slave.HRDATA = BM_STATUS;
						state_d = FIVE;	
					end else begin	
						BM_BASE = LINK;
						state_d = NINE;
					end

			       end

			TWE:   begin
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
			THI:   begin
					if (can_bus.busy) begin
						state_d = THI;	
					end else begin
						state_d = FORT;
					end
			       end

			FORT:  begin
					master.mHWRITE = 1;
					master.mHADDR  = MADDR; 
					state_d = ELE;
			       end
		endcase
	end

	always @(posedge slave.HCLK) begin
		if(slave.HRESET) begin
			state  <= IDLE;	
			state1 <= idle;
			count <= 0;
			BM_BASE_d <= 0;
		end else begin
			state  <= state_d;
			state1 <= state_d1;
			BM_BASE_d <= BM_BASE;

			if (state==TEN) begin
				count   <= count + 1;
				BM_BASE <= BM_BASE + 4; 
			end	
			if (state==TWE) begin
				count<= 0;
			end	
			
	
		end
	end
	

endmodule
