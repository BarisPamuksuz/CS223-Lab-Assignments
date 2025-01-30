module tx #(parameter CLKS_PER_BIT = 868, itemIndex = 3)(
input logic clock,
input logic sendSeri,
input logic btn_load_out,
input logic transmit_button,
input logic [7:0] loaded_data,
output logic tx,
output logic [7:0] sent_data,
output logic [31:0] txMemory
    );
    logic parity_bit;
    reg [15:0] counter = 0;
    reg [8:0] sent2_data = 0;
    logic[1:0] waitForAnotherCycle = 0;
    logic isContinue = 0;
    localparam IDLE_STATE = 2'b00;
    localparam START_STATE = 2'b01;
    localparam SEND_BIT = 2'b10;
    localparam STOP_STATE = 2'b11;
    
    reg [1:0] state = 0;
    reg [3:0] bit_index = 0;
    
    always @(posedge clock) begin
        case(state)
        IDLE_STATE: begin
            tx <=1;
            counter <= 0;
            bit_index <= 0;
            
            if(btn_load_out)begin
                txMemory[31:24] <= txMemory[23:16];
                txMemory[23:16] <= txMemory[15:8];
                txMemory[15:8] <= txMemory[7:0];
                txMemory[7:0] <= loaded_data[7:0];   
            end
            
            if(transmit_button && !sendSeri) begin  
               sent2_data[7:0] <= txMemory[31:24];
               sent_data[7:0] <= sent2_data[7:0];
               parity_bit = sent2_data[0]^sent2_data[1]^sent2_data[2]^sent2_data[3]^
               sent2_data[4]^sent2_data[5]^sent2_data[6]^sent2_data[7];
               sent2_data[8] <= parity_bit; 
               txMemory[31:24] <= txMemory[23:16];
               txMemory[23:16] <= txMemory[15:8];
               txMemory[15:8] <= txMemory[7:0];
               txMemory[7:0] <= 0;
               state <= START_STATE;
            end else if((transmit_button && sendSeri)|| isContinue) begin
               sent2_data[7:0] <= txMemory[31:24];
               sent_data[7:0] <= sent2_data[7:0];
               parity_bit = sent2_data[0]^sent2_data[1]^sent2_data[2]^sent2_data[3]^
               sent2_data[4]^sent2_data[5]^sent2_data[6]^sent2_data[7];
               sent2_data[8] <= parity_bit; 
               txMemory[31:24] <= txMemory[23:16];
               txMemory[23:16] <= txMemory[15:8];
               txMemory[15:8] <= txMemory[7:0];
               txMemory[7:0] <= 0;
               waitForAnotherCycle <= waitForAnotherCycle + 1;     
                if(waitForAnotherCycle == 0)
                    isContinue = 0;
                else
                    isContinue = 1;
                state <=    START_STATE;
            end
            
            else begin
                state <= IDLE_STATE;
            end
            end
         START_STATE: begin 
            tx <= 0;
            if(counter < (CLKS_PER_BIT - 1)) begin
                counter = counter + 1;
                state <= START_STATE;
            end 
            else begin 
                counter <= 0;
                state <= SEND_BIT;
            end 
         end  
         SEND_BIT: begin
            tx <= sent2_data[bit_index];
            
            if(counter < (CLKS_PER_BIT - 1)) begin
                counter <= counter + 1;
                state <= SEND_BIT;
            end 
            else begin
                counter <= 0;
                if(bit_index < 8) begin
                    bit_index <= bit_index + 3'b1;
                    state <= SEND_BIT;
                end
                else begin
                    bit_index <= 0;
                    state <= STOP_STATE;
                end
            end 
        end
 
        STOP_STATE: begin
            tx <= 1;
            if(counter < (CLKS_PER_BIT - 1)) begin
                counter= counter + 1;
                state <= STOP_STATE;
            end
            else begin
                state <= IDLE_STATE;
            end 
        end
        default: 
            state <= IDLE_STATE;
        endcase
    end       
endmodule