//can bus transmitter
//can design

module canxmit(cantintf.xmit can_bus);

    logic [127:0]  tempFrame;
    logic 	   crc_en,crc_nxt,crc_en_d,crc_en_d1;
    logic [14:0]   crc,crc_new,crc_d;
    reg   [14:0]   poly = 15'h4599;
    logic 	   sof,rtr,crc_del,ack_slot,ack_del,srr,ide;
    logic [10:0]   id1;
    logic [17:0]   id2;
    logic [1:0]    cf;
    logic [3:0]    datalength;
    logic [63:0]   tran_data;
    logic [6:0]    eof;
    logic [30:0]   framelength;  
    logic          bit_timing_en;
    int i;
    reg bit_timing_en_d;
   ////////////////////////bitstuff variables/////////////////////////////////// 
   	logic [200:0] frame;
	logic [2:0]   count_zero,count_one;
    	logic         bit_stuff_en;
	logic [10:0]  length;
	logic [7:0]   length_crc,length_crc_d;
	logic [20:0]  length_bit;
	logic [20:0]  total_stuff;
  	
	enum {idle,first_bit,z4,one_stuff,o4,zero_stuff,dout_state,exit1}state,state_d,state_dd; 
   /////////////////////////////////////////////////////////////////////////////
reg crc_en_d1_d;
reg [127:0]tempFrame1;
logic [10:0]count_bit,count_wait,wait_time;
enum {IDLE,S0,S1,S2}state1,state_d1,state_d1_dd; 
///////////////////////////// CRC logic ///////////////////////////////////
logic [14:0] crc1,crc_new1,crc_new2,crc_new3,crc_new4;
logic [20:0] count_crc;
reg bit_stuff_en_d;
logic        crc_nxt1,crc_nxt11;

enum {IDLE2,CRC1,CRC2,CRC3} state2,state_d2,state_d2_dd;
//////////////////////////////////////////////////////////////////////////

always @(posedge can_bus.clk)
begin
crc_en_d1_d <= crc_en_d1;
length_crc_d <= length_crc;
end



    always @* begin
	    crc_en_d1 = crc_en_d1_d;
	    length_crc = length_crc_d;
	    tempFrame = tempFrame;
        if (can_bus.startXmit) begin
		can_bus.busy = 1'b1;
            if  ( can_bus.format == 0) begin                                   //11 bit 
                if (can_bus.frameType==0) begin
                    //data frame
                    sof = 1'b0;
                    id1 = can_bus.id[28:18];
                    rtr = 1'b0;
                    cf = 2'b0;
                    datalength = can_bus.datalen[3:0];
		    crc = 15'b0;
		    crc_del = 1'b1;
		    ack_slot = 1'b1;
		    ack_del = 1'b1;
		    eof = 7'b111_1111; 

		    case(datalength)
		    
	  	    0:	begin   
			   tempFrame = {sof,id1,rtr,cf,datalength};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd19;
			end
		    1: begin
                           tran_data[7:0] = can_bus.xmitdata[63:56];	
//			   crc_en_d = 1'b1;	
			   crc_en_d1 = 1'b1;	   
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[7:0]};
			   length_crc = 8'd27;
		       end

		    2: begin
                           tran_data[15:0] = can_bus.xmitdata[63:48];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[15:0]};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd35;
		       end

		    3: begin
                           tran_data[23:0] = can_bus.xmitdata[63:40];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[23:0]};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd43;
		       end
		    4: begin
                           tran_data[31:0] = can_bus.xmitdata[63:32];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[31:0]};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd51;
		       end
		    5: begin
                           tran_data[39:0] = can_bus.xmitdata[63:24];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[39:0]};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd59;
		       end
		    6: begin
                           tran_data[47:0] = can_bus.xmitdata[63:16];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[47:0]};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd67;
		       end
		    7: begin
                           tran_data[55:0] = can_bus.xmitdata[63:8];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[55:0]};
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd75;
		       end
		    8: begin
                           tran_data[63:0] = can_bus.xmitdata[63:0];
			   crc_en_d1 = 1'b1;		   
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[63:0]};
			   // $display("------------------------------------------------------------------------------id:%b",can_bus.id);
			   length_crc = 8'd83;
		       end
		    endcase		    
                   //crc_en = 1'b1;
                end
                else if (can_bus.frameType==1) begin			
		    sof = 1'b0;
                    id1 = can_bus.id[28:18];
                    rtr = 1'b1;
                    cf = 2'b0;
                    datalength = can_bus.datalen[3:0];
		    crc = 15'b0;
		    crc_del = 1'b1;
		    ack_slot = 1'b1;
		    eof = 7'b111_1111; 

		    tempFrame = {sof,id1,rtr,cf,datalength};
		    length_crc = 8'd19;
                    crc_en_d1 = 1'b1;
                end
                else if (can_bus.frameType==2) begin
                     //error frame 
                    crc_en_d1 = 1'b1;
                end
                else begin
                    //overload frame
                end
            end
            else begin                                                          //29 bit
                if (can_bus.frameType==0) begin
                    //data frame
                    sof = 1'b0;
                    id1 = can_bus.id[28:18];
		    id2 = can_bus.id[17:0];
                    rtr = 1'b0;
                    cf = 2'b0;
                    datalength = can_bus.datalen[3:0];
		    crc = 15'b0;
		    crc_del = 1'b1;
		    ack_slot = 1'b1;
		    eof = 7'b111_1111; 
		    
		    srr = 1'b1;
		    ide = 1'b0;

		    case(datalength)
		    
	  	    0:	begin   
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd39;
			end
		    1: begin
                           tran_data[7:0] = can_bus.xmitdata[63:56];	
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[7:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd47;
		       end

		    2: begin
                           tran_data[15:0] = can_bus.xmitdata[63:48];
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[15:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd55;
		       end

		    3: begin
                           tran_data[23:0] = can_bus.xmitdata[63:40];
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[23:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd63;
		       end
		    4: begin
                           tran_data[31:0] = can_bus.xmitdata[63:32];
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[31:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd71;
		       end
		    5: begin
                           tran_data[39:0] = can_bus.xmitdata[63:24];
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[39:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd79;
		       end
		    6: begin
                           tran_data[47:0] = can_bus.xmitdata[63:16];
			   
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[47:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd87;
		       end
		    7: begin
                           tran_data[55:0] = can_bus.xmitdata[63:8];
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[55:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd95;
		       end
		    8: begin
                           tran_data[63:0] = can_bus.xmitdata[63:0];
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[63:0]}; 
			   crc_en_d1 = 1'b1;		   
			   length_crc = 8'd103;
		       end
		    endcase	
                end
                else if (can_bus.frameType==1) begin			//29 bit 
		    sof = 1'b0;
                    id1 = can_bus.id[28:18];
		    id2 = can_bus.id[17:0];
                    rtr = 1'b1;
                    cf = 2'b0;
                    datalength = can_bus.datalen[3:0];
		    crc = 15'b0;
		    crc_del = 1'b1;
		    ack_slot = 1'b1;
		    eof = 7'b111_1111; 
		    
		    srr = 1'b1;
		    ide = 1'b0;
		    
		    tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength}; 
		    length_crc = 8'd39;
                    crc_en_d1 = 1'b1;
                end
            end
        end
        else begin
		if((state1 == S0) && (count_bit > framelength))
		begin
			can_bus.busy = 0;
		end
		
        end


	
		crc_new3 = crc_new3;
		bit_stuff_en = bit_stuff_en_d;
		state_d2 = state_d2_dd;
		case(state2)
			IDLE2 : begin
					state_d2 = crc_en_d1 ? CRC1 : IDLE2;
					crc_new2 = 0;
					crc_new3 = 0;
				end

			CRC1:   begin
					if (count_crc <= length_crc ) begin
						crc_nxt1 = tempFrame[length_crc - count_crc  ] ^ crc_new1[14];
						crc_new2 =  crc_new1 << 1;
						if (crc_nxt1) begin
							crc_new3 =  (crc_new2 ^ 15'h4599);
						end else begin
							crc_new3 =  crc_new2;
						end
						state_d2 = CRC1;
					end else begin
						state_d2  = CRC2;
						crc_en_d1 =  1'b0;
					end
				end

			CRC2 : begin
					bit_stuff_en = 1'b1;
					state_d2 = CRC3;	
			       end
			       CRC3 : begin
					state_d2 = IDLE2;	
					bit_stuff_en = 1'b0;
					end       
		endcase






    end
  

    always @(posedge can_bus.clk) begin
        if (can_bus.rst) begin
            crc <= #1 0;
	    crc_new <= #1 0;
	    crc_en <= #1 0;
	    crc_en_d <= #1 0;
            tempFrame1 <= #1 0;

	    //////////////bitstuff reset/////////////////
	    state <= #1 idle;
	    count_zero <= #1 0;
	    count_one <=#1 0 ;
	    frame <= #1 0;
	    framelength <= #1 0;
	    length <= #1 5'b00000;
	    length_bit <= #1 0; 
	    total_stuff <= #1 0; 
	    ////crc////
	    crc_new1 <= #1 0;
	    count_crc <= #1 0;	

	    ///bit timing//
	    state1 <= #1 IDLE;
       	    count_bit <= #1 0;
	    count_wait <= #1 0;
	    can_bus.dout <= #1 1'b1;
	    //bit timing end
	    
        end
        else begin
            //
            crc <= #1 crc_new;
	    crc_en <= #1 crc_en_d;
	    length_bit <= #1 length_crc + 5'd15;
    	    bit_timing_en_d <= #1 bit_timing_en;

	    ///crc///
	    		state2 <= #1 state_d2;		
			crc_en <= #1 crc_en_d1;
			crc_new1  <= #1 crc_new3;
			bit_stuff_en_d <= #1 bit_stuff_en;
			state_d2_dd <= #1 state_d2;


			if ((state_d2 == CRC1) && (count_crc <= length_crc )) begin
				count_crc <=  count_crc + 1'b1;	
			end else begin
				count_crc <=  0;
			end
			
			if (state_d2 == CRC2) begin
				tempFrame1 <= {tempFrame,crc_new3};
			end 
	    
	    
	    
	    //crc_end////
	    //
	    ///////////////bitstuff sequential logic/////////////////
	    state <= #1 state_d;
	    state_dd <= #1 state_d;
			if (state_d == z4) begin
				count_zero <= #1 count_zero + 1'b1;
				count_one <= #1 1'b0;
				
				if (count_zero < 6) begin			
					frame <= #1 {frame,tempFrame1[length_bit-length]};
				end else begin
					frame <= #1 frame;
				end
			end
			else if (state_d == o4) begin
				count_one <= #1 count_one + 1'b1;
				count_zero <= #1 1'b0;
				
				if (count_one < 6) begin			
					frame <= #1 {frame,tempFrame1[length_bit-length]};
				end else begin
					frame <= #1 frame;
				end
			end
			else if (state_d == zero_stuff) begin 
				count_one <= #1 1;
				frame <= #1 {frame,1'b0,tempFrame1[length_bit-length]};	
				total_stuff <= #1 total_stuff + 1'b1;
			end
			else if (state_d == one_stuff) begin
				count_zero <= #1 1;
				frame <= #1 {frame,1'b1,tempFrame1[length_bit-length]};	
				total_stuff <= #1 total_stuff + 1'b1;
			end

			if (state_d == z4 | state_d==o4 | state_d==zero_stuff |state_d==one_stuff | state_d==first_bit ) begin
				if (length <= length_bit) begin
					length <=#1 length + 1'b1;
				end
				else begin
					length <= #1 0;
				end
			end else begin
				length <=#1 length;
			end
			if (state_d==dout_state) begin
				count_zero <= #1 0;
				count_one  <= #1 0;
				length     <= #1 0;
				frame      <= #1 {frame,1'b1,1'b1,1'b1,7'b111_1111};
				framelength <= #1 length_bit + total_stuff + 5'd10;
			end 

			if (state_d1==S0) begin
				total_stuff <= #1 0;
			end



		///bit timing//
			state1 <= #1 state_d1;
			state_d1_dd <= #1 state_d1;	
			if (state_d1 == S1) begin
				count_wait <= #1 count_wait + 1'b1;
			end else if (state_d1 == S0) begin
				count_wait <= #1 0;
			end

			if (state_d1 == S0) begin
				count_bit <= #1 count_bit + 1'b1;
				wait_time <= #1 (can_bus.quantaDiv * (1 + 2*(can_bus.seg1Quanta) + can_bus.propQuanta));
				if (count_bit <= framelength) begin	
					can_bus.dout <= frame[framelength - count_bit-1'b1];
				end
			end else if (state_d1 == IDLE) begin
				count_bit <= #1 0;
				can_bus.dout <= 1'b1;
			end	
		//bit timing end
        end
    end


   	always @ * begin
		state_d = state_dd;
	 	bit_timing_en = bit_timing_en_d;	
		case(state) 
		idle: begin
					state_d = bit_stuff_en ? first_bit : idle;	  
		      end
		first_bit: begin
					state_d = tempFrame1[length_bit-length] ? o4 : z4;		//check first bit of tempframe if zero goto z4
			   end
		z4: begin
				if (length==length_bit + 1) begin						
					state_d = dout_state;					
				end
				else begin
					  if (count_zero == 5 && tempFrame1[length_bit-length]==0) begin            
						state_d  = one_stuff;	
					  end
					  else if (tempFrame1[length_bit-length]==0) begin 		
						state_d  = z4;
					  end
					  else if (tempFrame1[length_bit-length]==1) begin
						state_d = o4;
					  end
				end
		    end
	        one_stuff: begin
				
					if (length==length_bit + 1) begin	
						state_d = dout_state;
					end else begin
						if (tempFrame1[length_bit-length]) begin
							state_d = o4;
						end else begin
							state_d = z4;
						end
					end
		       end
		o4: begin
			if (length==length_bit+1) begin
		          	state_d = dout_state;	
			end
			else begin
				if (count_one==5 && tempFrame1[length_bit-length]==1) begin   
					state_d  = zero_stuff;
			  	end else if (tempFrame1[length_bit-length]== 1) begin
					state_d = o4;	
			  	end
		   	  	else if (tempFrame1[length_bit-length]==0) begin
					state_d = z4;
	        		end	
		        end
		    end
	        zero_stuff: begin    //5
						if (length==length_bit+1) begin	
							state_d = dout_state;
						end
						else begin
							if (tempFrame1[length_bit-length]) begin
								state_d = o4;
							end
							else begin
								state_d = z4;
							end
							
						end

							
			    end
		dout_state: begin
					state_d = exit1;
					bit_timing_en = 1'b1;	
		      	    end

		exit1 :	begin
				
					state_d = idle;
					bit_timing_en = 1'b0;	
										
			end	
		endcase
		
	end

////////////////////////////////////bit timing////////////////////////////////////

////////////////////////////////////////////////////////////////////////////////

   	always @ * begin

		state_d1 =  state_d1_dd;	
		case (state1)
			IDLE:  begin
			
			            state_d1 = bit_timing_en ? S0 : IDLE;	
			       end
		        S0:    begin

				    if (count_bit <= framelength) begin
					//can_bus.dout = frame[framelength - count_bit];
				   	state_d1     = S1;
				    end
				    else begin
					frame         = 0;
				  	state_d1 = IDLE; 
				    end
			       end
	       		S1:    begin
				    if (count_wait == (wait_time -1'b1)) begin
				        state_d1 = S0;
	        		    end else begin
				        state_d1 = S1;
				    end	
			       end	
		endcase	


	end

endmodule
