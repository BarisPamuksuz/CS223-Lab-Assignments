`timescale 1ns / 1ps

module testbench2;

    reg i_rx;
    reg clock;
    reg [7:0] memoryR;  
    
    Uart_rx uart_rx_inst (
        .i_rx(i_rx),
        .clock(clock),
        .data_receivedOldest(memoryR)
    );

    // Clock generation
    initial begin
        clock = 0;
        forever #5 clock = ~clock; // 100 MHz clock
    end

    // Simulate incoming data bits
    initial begin
        memoryR = 8'b0;
        // Initialize
        i_rx = 1; 
        #100;  

        // START_STATE bit
        i_rx = 0;
        #86.8;  

        // Data bits for 0x55 -> 01010101
        i_rx = 1; #86.8;
        i_rx = 0; #86.8;
        i_rx = 1; #86.8;
        i_rx = 0; #86.8;
        i_rx = 1; #86.8;
        i_rx = 0; #86.8;
        i_rx = 1; #86.8;
        i_rx = 0; #86.8;
        i_rx = 1; #86.8;  // Parity (even)
        i_rx = 1; #86.8;  // STOP_STATE bit
        i_rx = 1; #173.6; 
        
        // Send 0xAA -> 10101010
        i_rx = 0; #86.8;  
        i_rx = 0; #86.8;  // Bit 0
        i_rx = 1; #86.8;  // Bit 1
        i_rx = 0; #86.8;  // Bit 2
        i_rx = 1; #86.8;  // Bit 3
        i_rx = 0; #86.8;  // Bit 4
        i_rx = 1; #86.8;  // Bit 5
        i_rx = 0; #86.8;  // Bit 6
        i_rx = 1; #86.8;  // Bit 7
        i_rx = 0; #86.8;  // Parity bit (odd)
        i_rx = 1; #86.8;  // STOP_STATE bit
        i_rx = 1; #173.6; // IDLE_STATE state
        
        // Send 0xFF -> 11111111 to test all high bits
        i_rx = 0; #86.8;  // START_STATE bit
        i_rx = 1; #86.8;  // Bit 0
        i_rx = 1; #86.8;  // Bit 1
        i_rx = 1; #86.8;  // Bit 2
        i_rx = 1; #86.8;  // Bit 3
        i_rx = 1; #86.8;  // Bit 4
        i_rx = 1; #86.8;  // Bit 5
        i_rx = 1; #86.8;  // Bit 6
        i_rx = 1; #86.8;  // Bit 7
        i_rx = 0; #86.8;  // Parity bit (even)
        i_rx = 1; #86.8;  // STOP_STATE bit
        i_rx = 1; #173.6; // IDLE_STATE state
        
        i_rx = 0; #86.8;  // START_STATE bit
        i_rx = 1; #86.8;  // Bit 0
        i_rx = 0; #86.8;  // Bit 1
        i_rx = 1; #86.8;  // Bit 2
        i_rx = 0; #86.8;  // Bit 3
        i_rx = 1; #86.8;  // Bit 4
        i_rx = 0; #86.8;  // Bit 5
        i_rx = 1; #86.8;  // Bit 6
        i_rx = 0; #86.8;  // Bit 7
        i_rx = 1; #86.8;  // Parity bit (even)
        i_rx = 1; #86.8;  // STOP_STATE bit
        i_rx = 1; #173.6; // IDLE_STATE state
        
        i_rx = 0; #86.8;  // START_STATE bit
        i_rx = 1; #86.8;  // Bit 0
        i_rx = 0; #86.8;  // Bit 1
        i_rx = 1; #86.8;  // Bit 2
        i_rx = 0; #86.8;  // Bit 3
        i_rx = 1; #86.8;  // Bit 4
        i_rx = 0; #86.8;  // Bit 5
        i_rx = 1; #86.8;  // Bit 6
        i_rx = 0; #86.8;  // Bit 7
        i_rx = 1; #86.8;  // Parity bit (even)
        i_rx = 1; #86.8;  // STOP_STATE bit
        i_rx = 1; #173.6; // IDLE_STATE state

        $finish;
    end
   
endmodule
