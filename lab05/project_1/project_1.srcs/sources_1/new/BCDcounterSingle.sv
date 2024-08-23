module BCDcounterSingle2(
    input logic clk,          
    input logic reset,        
    input logic enable,   
    input logic load,         
    input logic[3:0] d,       
    output logic[3:0] q       
    );
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            q <= 4'b0000;  
        end else if (enable) begin
            if (load) begin
                q <= d; 
            end else begin
                if (q == 4'b1001) begin
                    q <= 4'b0000; 
                end else begin
                    q <= q + 1;
                end
            end
        end
    end
endmodule

