module debounce(
input logic clock, 
input logic ButtonIn,
output logic Button_out
    );
    logic prevButtonIn = 0;
    always_ff @(posedge clock)begin
        prevButtonIn <= ButtonIn;
        if(ButtonIn && !prevButtonIn)begin
            Button_out <= 1;
        end
        else begin
            Button_out <= 0;
        end
    end
endmodule