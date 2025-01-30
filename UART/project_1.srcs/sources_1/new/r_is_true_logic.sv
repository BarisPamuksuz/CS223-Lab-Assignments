module r_is_true_logic(
input logic clock, 
input logic btn_out,
output logic t_is_true
    );
    
    always_ff @(posedge clock)begin
        if(btn_out)begin
            t_is_true <= !t_is_true;
        end
    end
    
endmodule