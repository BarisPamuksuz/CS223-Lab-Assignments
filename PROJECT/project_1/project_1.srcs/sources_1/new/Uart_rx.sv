module Uart_rx#(parameter clk_per_bit = 868)(
    input logic clk,
    input logic input_rx,
    output logic [7:0] rx_out,
    output logic [31:0] memory_rx
    );
    
    logic parity_bit;
    
    localparam idle = 2'b00;
    localparam start = 2'b01;
    localparam get_bit = 2'b10;
    localparam stop = 2'b11;
    
    reg rx_medium = 1'b1;
    reg rx =  1'b1;
    reg [1:0] state = 0;
    reg [15:0] counter = 0;
    reg [8:0] data_received = 0; 
    reg [3:0] bit_index = 0;
    
    always @(posedge clk) begin
        rx_medium <= input_rx;
        rx <= rx_medium;
    end 
    always @(posedge clk) begin 
    case(state)
    idle: begin
        counter <= 0;
        bit_index <= 0;
        if(rx == 0)
            state <= start;
        else
            state <= idle;
        end
        start: begin 
            if(counter == (clk_per_bit-1)/2) begin
                if(rx == 0) begin
                    counter <= 0;
                    state <=get_bit;
                end
                else begin
                    state <= idle;
                end 
            end
            else begin 
                counter <= counter + 1;
                state <= start;
            end
         end
         get_bit: begin
             data_received[bit_index] <= input_rx;
             if(counter < (clk_per_bit-1)) begin
                counter <= counter + 1;
                state <= get_bit;
             end 
             else begin 
                counter <= 0;
                if(bit_index < 8) begin
                    bit_index <= bit_index +3'b1;
                    state <= get_bit;
                end 
                else begin
                    rx_out[7:0] <= data_received[7:0];
                    parity_bit = data_received[0]^data_received[1]^data_received[2]^data_received[3]^
                    data_received[4]^data_received[5]^data_received[6]^data_received[7];
                    if(parity_bit != data_received[8])begin 
                        data_received <= 0;
                    end
                    bit_index <= 0;
                    state <= stop;
                end 
           end 
      end
      stop: begin
           if(counter < clk_per_bit-1) begin   
                counter <= counter + 16'b1;
                state <= stop;
           end
           else begin 
                memory_rx[31:24] <= memory_rx[23:16];
                memory_rx[23:16] <= memory_rx[15:8];
                memory_rx[15:8] <= memory_rx[7:0];
                memory_rx[7:0] <= data_received[7:0];
                counter <= 0;
                state <= idle;
           end
      end    
      default: state <= idle;
      endcase
      end
endmodule