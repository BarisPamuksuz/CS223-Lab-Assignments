module buttonDebouncer(
input logic clk, 
input logic btn,
output logic btn_out
    );
    logic prevbtn = 0;
    always_ff @(posedge clk)begin
        prevbtn <= btn;
        if(btn && !prevbtn)begin
            btn_out <= 1;
        end
        else begin
            btn_out <= 0;
        end
    end
endmodule