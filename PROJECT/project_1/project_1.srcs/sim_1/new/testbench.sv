    `timescale 1ns / 1ps
    
    module testbench;
    
        reg [7:0] data_to_Transfer;
        reg data_ready;
        reg loadButton;
        reg clock;
        wire tx;
        wire[7:0] mostRecent;  // Assuming this is also an output now
    
        
        Uart_tx uart_tx_inst (
            .data_to_Transfer(data_to_Transfer),
            .data_ready(data_ready),
            .loadButton(loadButton),
            .clock(clock),
            .tx(tx),
            .mostRecent(mostRecent)          // Assuming these are correctly declared as outputs in the Uart_tx
        );
    
        // Clock generation
        initial begin
            clock = 0;
            forever #5 clock = ~clock; 
        end
    
        // Test sequence
        initial begin
            // Initialize inputs
            data_to_Transfer = 0;
            data_ready = 0;
            loadButton = 0;
    
            
            #100;
    
            // Test 1: Load data into FIFO
            @(posedge clock);
            data_to_Transfer = 8'hAA; // Example data
            loadButton = 1;
            @(posedge clock);
            loadButton = 0;
    
            // Test 2: Load another data
            @(posedge clock);
            data_to_Transfer = 8'hBB; // Example data
            loadButton = 1;
            @(posedge clock);
            loadButton = 0;
            
            // Test 3: Load additional data while sending
            repeat(10) @(posedge clock);  // Wait for some transmission to potentially happen
            data_to_Transfer = 8'hDD;
            loadButton = 1;
            @(posedge clock);
            loadButton = 0;
    
            // Test 4: Simulate rapid consecutive loads
            repeat(5) @(posedge clock);
            data_to_Transfer = 8'hEE;
            loadButton = 1;
            @(posedge clock);
            data_to_Transfer = 8'hFF;
            @(posedge clock);
            loadButton = 0;
    
            // Trigger data_ready signal
            repeat(10) @(posedge clock);  // Allow some operations before triggering data_ready
            data_ready = 1;
            @(posedge clock);
            data_ready = 0;
        
            #100
            @(posedge clock);
            loadButton = 1;
            @(posedge clock);
            loadButton = 0;
            // Continue simulation to observe full behavior
            #200;
    
            // End simulation
            $finish;
        end
    
        // Monitor changes in memory and other signals
        
    
    endmodule
