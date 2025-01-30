module ButtonUpLogic(
input logic clock, 
input logic btn_out,
output logic InTMemory
    );
    
    always_ff @(posedge clock)begin
        if(btn_out)begin
            InTMemory <= !InTMemory;
        end
    end
    
endmodule