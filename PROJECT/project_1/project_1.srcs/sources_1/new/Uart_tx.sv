`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2024 05:43:19 PM
// Design Name: 
// Module Name: Uart_tx
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Uart_tx(
    input logic clock,
    input logic[7:0] data_to_Transfer,
    input logic loadButton,
    input logic data_ready, 
    output logic tx,
    output logic[7:0] data_to_send
    );
    reg[7:0] data_transmittedREG[3:0];
    integer numberOf1s = 0;
    integer i = 0;
    const integer CLKS_PER_BIT = 868;
    //state encoding
    parameter IDLE_STATE = 3'b000, START_STATE = 3'b001, SEND_BIT = 3'b010, STOP_STATE = 3'b011, PARITY_STATE = 3'b100;
    reg properLoadButton;
    reg properSendButton;
//    buttonDebouncer debouncer(loadButton, clock, properButton);
//    buttonDebouncer debouncer2(data_ready, clock, data_ready_proper); 
    buttonDebouncer debouncer(clock, loadButton, properLoadButton);
    buttonDebouncer debouncer2(clock, data_ready, properSendButton);
    reg dataLoaded;
    reg[2:0] state = 3'b0;
    reg[9:0] counter = 10'b0;
    reg[3:0] bit_index = 4'b0;
    
   

     always@(posedge clock) begin
        case(state)
            IDLE_STATE:
                begin
                tx <= 1;
                dataLoaded = 0;
                numberOf1s <= 0;
                counter <= 0;
                bit_index = 4'b0;
                if(properLoadButton == 1) begin
                    data_transmittedREG[3] <= data_transmittedREG[2];
                    data_transmittedREG[2] <= data_transmittedREG[1];
                    data_transmittedREG[1] <= data_transmittedREG[0];
                    data_transmittedREG[0] <= data_to_Transfer[7:0]; 
                end                         
                if(properSendButton == 1) begin
                    data_to_send <= data_transmittedREG[3];
                    state <= START_STATE; end
                else begin
                    state <= IDLE_STATE;
                end
            end
            START_STATE:
            begin
                tx <= 0;
                if(counter < (CLKS_PER_BIT)-1) begin
                    counter <= counter + 10'b1;
                    state <= START_STATE;
                    end 
                else begin
                    counter <= 0;
                    state <= SEND_BIT;
                end
            end
            SEND_BIT:
            begin
                tx <= data_to_send[bit_index];
                if(counter < CLKS_PER_BIT-1) begin
                    counter <= counter + 10'b1;
                    state <= SEND_BIT;
                end 
                else if (bit_index < 7) begin
                counter <= 0;
                if(tx == 1) numberOf1s <= numberOf1s + 1;
                bit_index <= bit_index + 4'b1;
                state <= SEND_BIT;
                end
                else begin
                    counter <= 0;
                    state <= PARITY_STATE;                
                end 
            end
            PARITY_STATE:
                begin
                if(numberOf1s % 2 == 0)
                tx <= 0;
                else 
                tx <= 1; 
                if(counter < CLKS_PER_BIT-1) begin
                    counter <= counter + 1;
                    state <= PARITY_STATE; end
                else begin
                counter <= 0;
                numberOf1s <= 0;
                state <= STOP_STATE; end
            end
                
            STOP_STATE:
                begin
                tx <= 1;
                bit_index <= 0;
                if(counter<CLKS_PER_BIT-1) begin
                    counter <= counter + 1;
                    state <= STOP_STATE;end
                else begin  
                    counter <= 0;
                    state <= IDLE_STATE;   
                end
                end
        endcase
    end     
endmodule