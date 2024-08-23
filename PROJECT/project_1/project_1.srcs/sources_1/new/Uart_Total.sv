`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2024 01:18:33 PM
// Design Name: 
// Module Name: Uart_Total
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


module Uart_Total(
    input clock,
    input buttonLoad,
    input sendData,
    input logic[7:0] data_to_Transfer,
    //output logic[7:0] data_received,
    output logic[7:0] data_receivedOldest,
    output logic[7:0] discarded,
    input rx,
    output tx
    );
    
    Uart_tx sender1(clock, data_to_Transfer, buttonLoad,sendData, tx, discarded);
    Uart_rx receiver1(rx, clock, data_receivedOldest);
    
    
    
endmodule
