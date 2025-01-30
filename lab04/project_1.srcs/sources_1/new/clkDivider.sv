module clkDivider(
    input logic clk,
    output logic clk_out
);
    integer counter = 0;
    always_ff@(posedge clk) begin
        counter = counter + 1;
        if(counter >= 50000000) begin
            clk_out <= ~clk_out;
            counter <= 0;
        end
    end
endmodule    