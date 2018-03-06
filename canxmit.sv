//can bus transmitter
//can design

module canxmit(cantintf.xmit can_bus);

    logic [127:0]  tempFrame;
    logic 	   crc_en,crc_nxt,crc_en_d;
    logic [14:0]   crc,crc_new,crc_d;
    logic [14:0]   poly = 15'h4599;
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
  	
   ////////////////////////bitstuff variables/////////////////////////////////// 
   	logic [200:0] frame;
	logic [2:0]   count_zero,count_one;
    	logic         bit_stuff_en;
	logic [10:0]  length;
	logic [7:0]   length_crc;
	logic [20:0]  length_bit;
	logic [20:0]  total_stuff;
  	
	enum {idle,first_bit,z4,one_stuff,o4,zero_stuff,dout_state}state,state_d; 
	logic [10:0]count_bit,count_wait,wait_time;
	enum {IDLE,S0,S1,S2}state1,state_d1; 
   /////////////////////////////////////////////////////////////////////////////

    always @* begin
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
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd19;
			end
		    1: begin
                           tran_data[7:0] = can_bus.xmitdata[63:56];	
			   crc_en_d = 1'b1;		   
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[7:0]};
			   length_crc = 8'd27;
		       end

		    2: begin
                           tran_data[15:0] = can_bus.xmitdata[63:48];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[15:0]};
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd35;
		       end

		    3: begin
                           tran_data[23:0] = can_bus.xmitdata[63:40];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[23:0]};
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd43;
		       end
		    4: begin
                           tran_data[31:0] = can_bus.xmitdata[63:32];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[31:0]};
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd51;
		       end
		    5: begin
                           tran_data[39:0] = can_bus.xmitdata[63:24];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[39:0]};
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd59;
		       end
		    6: begin
                           tran_data[47:0] = can_bus.xmitdata[63:16];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[47:0]};
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd67;
		       end
		    7: begin
                           tran_data[55:0] = can_bus.xmitdata[63:8];
			   tempFrame = {sof,id1,rtr,cf,datalength,tran_data[55:0]};
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd75;
		       end
		    8: begin
                           tran_data[63:0] = can_bus.xmitdata[63:0];
			   crc_en_d = 1'b1;		   
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
                    crc_en_d = 1'b1;
                end
                else if (can_bus.frameType==2) begin
                     //error frame 
             	        
                     
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

		    //$display("--------------------------------------id1:%b",id1);
		    //$display("--------------------------------------id1:%b",id2);
		   
		//$display("------------------------------------------------------------------------------id:%b",can_bus.id);
		    case(datalength)
		    
	  	    0:	begin   
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd39;
			end
		    1: begin
                           tran_data[7:0] = can_bus.xmitdata[63:56];	
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[7:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd47;
		       end

		    2: begin
                           tran_data[15:0] = can_bus.xmitdata[63:48];
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[15:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd55;
		       end

		    3: begin
                           tran_data[23:0] = can_bus.xmitdata[63:40];
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[23:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd63;
			   
			   /*$display("--------inside3------------------------------id1:%b",id1);
	      	           $display("---------------indide3-----------------------id1:%b",id2);
		   
                   	   $display("--------------inside3--------------------------------------------------------id:%b",can_bus.id);
	      	           $display("---------------indide3-----------------------tempFrame:%b",tempFrame[62:0]);*/
		       end
		    4: begin
                           tran_data[31:0] = can_bus.xmitdata[63:32];
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[31:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd71;
		       end
		    5: begin
                           tran_data[39:0] = can_bus.xmitdata[63:24];
		    	   tempFrame = {sof,id1,srr,ide,id2,rtr,cf,datalength,tran_data[39:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd79;
		       end
		    6: begin
                           tran_data[47:0] = can_bus.xmitdata[63:16];
			   //$display("can id:%b",can_bus.id);
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[47:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd87;
		       end
		    7: begin
                           tran_data[55:0] = can_bus.xmitdata[63:8];
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[55:0]}; 
			   crc_en_d = 1'b1;		   
			   length_crc = 8'd95;
		       end
		    8: begin
                           tran_data[63:0] = can_bus.xmitdata[63:0];
		    	   tempFrame = {sof,id1,srr,1'b0,id2,rtr,cf,datalength,tran_data[63:0]}; 
			   crc_en_d = 1'b1;		   
			   // $display("------------------------------------------------------------------------------id:%b",can_bus.id);
			   length_crc = 8'd103;
		       end
		    endcase	














                    //crc_en_d = 1'b1;
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
                    crc_en_d = 1'b1;
                end
            end
        end
        else begin
            //if no xmit then what ......wait.....
		if((state1 == S0) && (count_bit > framelength))
		begin
			can_bus.busy = 0;
		end
        end


	//////////////////////////////////crc block//////////////////////////////
	
	if (crc_en_d) begin
	        //$display("crc_en_d:%d, time=%t",crc_en_d,$time);	
		crc_new = crc;
           	//$display("tempFrame:%b",tempFrame);	    	
            	
            	for (i=length_crc; i>=0; i=i-1) begin
                       
			crc_nxt = tempFrame[i] ^ crc_new[14];
			crc_new[14:1] = crc_new[13:0];
		        crc_new[0]=0;
                	
				if (crc_nxt) begin
     					crc_new[14:0] = (crc_new[14:0] ^  15'h4599);
			   
                        	end
			        else begin
                        	        crc_new = crc_new;
                        
                        	end
            	end
	    	
		//$display("crc:%h",crc_new);
		crc_en_d = 1'b0;	  
	        tempFrame = {tempFrame,crc_new};
           	//$display("tempFrame:%b",tempFrame);	    	
	        crc = crc_new;
		bit_stuff_en = 1'b1;
        end




	/////////////////////////////////////////////////////////////////////////
        
    end
   
    always @(posedge can_bus.clk) begin
        if (can_bus.rst) begin
            //reset whatever to be reset
            crc <= #1 0;
	    crc_new <= #1 0;
	    crc_en <= #1 0;
	    crc_en_d <= #1 0;
            tempFrame <= #1 0;
	    //crc_en <= #1 '0;
	    //can_bus.busy <= #1 0;
	    bit_stuff_en <= #1 0;

	    //////////////bitstuff reset/////////////////
	    //
	     
	    state <= #1 idle;
	    count_zero <= #1 0;
	    count_one <=#1 0 ;
	    frame <= #1 0;
	    framelength <= #1 0;
	    length <= #1 5'b00000;
	    length_bit <= #1 0; 
	    total_stuff <= #1 0; 
	    
        end
        else begin
            //
            crc <= #1 crc_new;
	    crc_en <= #1 crc_en_d;
	    length_bit <= #1 length_crc + 5'd15;

	    ///////////////bitstuff sequential logic/////////////////
	    state <= #1 state_d;
	    //$display("frame: %b",frame);
			if (state_d == z4) begin
				count_zero <= #1 count_zero + 1'b1;
				count_one <= #1 1'b0;
				
				if (count_zero < 6) begin			
					frame <= #1 {frame,tempFrame[length_bit-1'b1]};
					tempFrame  <= #1 tempFrame << 1'b1;
				end else begin
					frame <= #1 frame;
					tempFrame <= #1 tempFrame;
				end
			end
			else if (state_d == o4) begin
				count_one <= #1 count_one + 1'b1;
				count_zero <= #1 1'b0;
				
				if (count_one < 6) begin			
					frame <= #1 {frame,tempFrame[length_bit-1'b1]};
					tempFrame  <= #1 tempFrame << 1'b1;
				end else begin
					frame <= #1 frame;
					tempFrame <= #1 tempFrame;
				end
			end
			else if (state_d == zero_stuff) begin 
				count_one <= #1 1;
				frame <= #1 {frame,1'b0,tempFrame[length_bit-1'b1]};	
				tempFrame  <= #1 tempFrame << 1'b1;
				total_stuff <= #1 total_stuff + 1'b1;
			end
			else if (state_d == one_stuff) begin
				count_zero <= #1 1;
				frame <= #1 {frame,1'b1,tempFrame[length_bit-1'b1]};	
				tempFrame  <= #1 tempFrame << 1'b1;
				total_stuff <= #1 total_stuff + 1'b1;
			end

			if (state_d == z4 | state_d==o4 | state_d==zero_stuff |state_d==one_stuff ) begin
				if (length < length_bit) begin
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
	
        end
    end


   	always @ * begin
	 	
		case(state) 
		idle: begin
					state_d = bit_stuff_en ? first_bit : idle;	  
		      end
		first_bit: begin
					state_d = tempFrame[length_bit-1'b1] ? o4 : z4;		//check first bit of tempframe if zero goto z4
			   end
		z4: begin
				if (length==length_bit) begin						
					state_d = dout_state;					
				end
				else begin
					  if (count_zero == 5 && tempFrame[length_bit-1'b1]==0) begin            
						state_d  = one_stuff;	
					  end
					  else if (tempFrame[length_bit-1'b1]==0) begin 		
					
						state_d  = z4;
					  end
					  else if (tempFrame[length_bit-1'b1]==1) begin
						state_d = o4;
					  end
				end
		    end
	        one_stuff: begin
				
					if (length==length_bit) begin	
						state_d = dout_state;
					end else begin
						if (tempFrame[length_bit-1'b1]) begin
							state_d = o4;
						end else begin
							state_d = z4;
						end
					end
		       end
		o4: begin
			if (length==length_bit) begin
		          	state_d = dout_state;	
			end
			else begin
				if (count_one==5 && tempFrame[length_bit-1'b1]==1) begin   
					state_d  = zero_stuff;
			  	end else if (tempFrame[length_bit-1'b1]== 1) begin
					state_d = o4;	
			  	end
		   	  	else if (tempFrame[length_bit-1'b1]==0) begin
					state_d = z4;
	        		end	
		        end
		    end
	        zero_stuff: begin    //5
						
						if (length==length_bit) begin	
							state_d = dout_state;
						end
						else begin
							if (tempFrame[length_bit-1'b1]) begin
								state_d = o4;
							end
							else begin
								state_d = z4;
							end
							
						end

							
			    end
		dout_state: begin
						bit_stuff_en = 1'b0;
					//$display("frame: %b",frame);
					state_d = idle;
					//framelength = 54;
				        //$display("framelength:%d",framelength);
					bit_timing_en = 1'b1;	
		      	    end
		endcase
		
	end

////////////////////////////////////bit timing////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////
	always @(posedge can_bus.clk) begin
		if (can_bus.rst) begin
			state1 <= #1 IDLE;
			count_bit <= #1 0;
			count_wait <= #1 0;
			wait_time  <= #1 0;
			can_bus.dout <= #1 1;
		end else begin
			state1 <= #1 state_d1;
			
			if (state_d1 == S1) begin
				count_wait <= #1 count_wait + 1'b1;
			end else if (state_d1 == S0) begin
				count_wait <= #1 0;
			end

			if (state_d1 == S0) begin
				total_stuff <= #1 0;
				count_bit <= #1 count_bit + 1'b1;
			end else if (state_d1 == IDLE) begin
				count_bit <= #1 0;
			end	
		end
	end


   	always @ * begin
		case (state1)
			IDLE:  begin
			            state_d1 = bit_timing_en ? S0 : IDLE;	
			       end
		        S0:    begin

				    if (count_bit <= framelength) begin
					can_bus.dout = frame[framelength - count_bit];
					//$display("dout:%b , time: %t",can_bus.dout,$time);
				   	wait_time    = (can_bus.quantaDiv * (1 + 2*(can_bus.seg1Quanta) + can_bus.propQuanta));
				   	state_d1     = S1;
					//$display("count_bit:%d",count_bit);
					//$display("dout:%b, state_d1:%d",can_bus.dout,state_d1);
				    end
				    else begin
					//can_bus.busy  = 1'b0;
					bit_timing_en = 1'b0;
					frame         = 0;
					tempFrame     = 0;
				  	state_d1 = IDLE; 
				    end
			       end
	       		S1:    begin
				    if (count_wait == (wait_time -1'b1)) begin
					//$display("in s1 wait count:%d",count_wait);
				        state_d1 = S0;
	        		    end else begin
				        state_d1 = S1;
				    end	
			       end	
		endcase	


	end	
    
    
endmodule

    

