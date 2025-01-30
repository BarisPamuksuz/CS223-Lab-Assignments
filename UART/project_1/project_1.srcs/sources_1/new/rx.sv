module rx#(parameter CLKS_PER_BIT = 868)(
    input logic clock,
    input logic input_rx,
    output logic [7:0] rx_out,
    output logic [31:0] memory_rx
    );
    
    logic parityBit;
    
    localparam IDLE = 2'b00;
    localparam START = 2'b01;
    localparam GET_BIT_STATE = 2'b10;
    localparam STOP_STATE = 2'b11;
    
    reg rxBuff = 1'b1;
    reg rx =  1'b1;
    reg [1:0] state = 0;
    reg [15:0] counter = 0;
    reg [8:0] data_received = 0; 
    reg [3:0] bit_index = 0;
    
    always @(posedge clock) begin
        rxBuff <= input_rx;
        rx <= rxBuff;
    end 
    always @(posedge clock) begin 
    case(state)
    IDLE: begin
        counter <= 0;
        bit_index <= 0;
        if(rx == 0)
            state <= START;
        else
            state <= IDLE;
        end
        START: begin 
            if(counter == (CLKS_PER_BIT-1)/2) begin
                if(rx == 0) begin
                    counter <= 0;
                    state <=GET_BIT_STATE;
                end
                else begin
                    state <= IDLE;
                end 
            end
            else begin 
                counter <= counter + 1;
                state <= START;
            end
         end
         GET_BIT_STATE: begin
             data_received[bit_index] <= input_rx;
             if(counter < (CLKS_PER_BIT-1)) begin
                counter <= counter + 1;
                state <= GET_BIT_STATE;
             end 
             else begin 
                counter <= 0;
                if(bit_index < 8) begin
                    bit_index <= bit_index +3'b1;
                    state <= GET_BIT_STATE;
                end 
                else begin
                    memory_rx[31:24] <= memory_rx[23:16];
                    memory_rx[23:16] <= memory_rx[15:8];
                    memory_rx[15:8] <= memory_rx[7:0];
                    memory_rx[7:0] <= data_received[7:0];
                    rx_out[7:0] <= data_received[7:0];
                    parityBit = data_received[0]^data_received[1]^data_received[2]^data_received[3]^
                    data_received[4]^data_received[5]^data_received[6]^data_received[7];
                    if(parityBit != data_received[8])begin 
                        data_received <= 0;
                    end
                    bit_index <= 0;
                    state <= STOP_STATE;
                end 
           end 
      end
      STOP_STATE: begin
           if(counter < CLKS_PER_BIT-1) begin   
                counter <= counter + 16'b1;
                state <= STOP_STATE;
           end
           else begin 
                counter <= 0;
                state <= IDLE;
           end
      end    
      default: state <= IDLE;
      endcase
      end
endmodule