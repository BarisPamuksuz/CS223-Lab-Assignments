module son(
    input logic clock,
    input logic rightButtonOut,
    input logic leftButtonOut,
    input logic [31:0] tx_memory4Byte,
    input logic [31:0] rx_memory4Byte,
    output reg [3:0] anodes,
    output logic [6:0] segments,
    input logic upButton
);

logic [1:0] index = 0;
logic [1:0] count;
logic [19:0] regenerate = 20'b0;
logic [1:0] indexOfBit_tx;
logic [1:0] indexOfBit_rx;
logic [7:0] displayed_out;


reg [3:0] digit0;
reg [3:0] digit1;
reg [3:0] digit2;
reg [4:0] digit3;
reg [4:0] led = 0;

always @(posedge clock)
begin
    digit0 <= displayed_out[3:0];
    digit1 <= displayed_out[7:4];
    if(upButton)begin
        digit2 <= indexOfBit_rx;
        digit3 <= 16;
    end
    else begin
        digit2 <= indexOfBit_tx;
        digit3 <= 17;
    end
    if(upButton && (indexOfBit_rx == 0))begin
        displayed_out[7:0] <= rx_memory4Byte[7:0];
    end
    if(upButton && (indexOfBit_rx == 1))begin
        displayed_out[7:0] <= rx_memory4Byte[15:8];
    end
    if(upButton && (indexOfBit_rx == 2))begin
        displayed_out[7:0] <= rx_memory4Byte[23:16];
    end
    if(upButton && (indexOfBit_rx == 3))begin
        displayed_out[7:0] <= rx_memory4Byte[31:24];
    end
    if(!upButton && (indexOfBit_tx == 0))begin
        displayed_out[7:0] <= tx_memory4Byte[7:0];
    end
    if(!upButton && (indexOfBit_tx == 1))begin
        displayed_out[7:0] <= tx_memory4Byte[15:8];
    end
    if(!upButton && (indexOfBit_tx == 2))begin
        displayed_out[7:0] <= tx_memory4Byte[23:16];
    end
    if(!upButton && (indexOfBit_tx == 3))begin
        displayed_out[7:0] <= tx_memory4Byte[31:24];
    end
    if(upButton && rightButtonOut)begin
        indexOfBit_rx <= indexOfBit_rx+1;
    end
    if(!upButton && rightButtonOut)begin
        indexOfBit_tx <= indexOfBit_tx+1;
    end
    if(upButton && leftButtonOut)begin
        indexOfBit_rx <= indexOfBit_rx-1;
    end
    if(!upButton && leftButtonOut)begin
        indexOfBit_tx <= indexOfBit_tx-1;
    end
end
always @(posedge clock)
begin
    if (count > 1)
        count <= 2'b00;
    else
        count <= count + 1;
    regenerate <= regenerate + 1;
    index <= regenerate[19:18]; // continuous assignment
end
always_ff @(posedge clock)
begin
    case (index)
        0: begin anodes = 4'b1110; led = digit0; end
        1: begin anodes = 4'b1101; led = digit1; end
        2: begin anodes = 4'b1011; led = digit2; end
        3: begin anodes = 4'b0111; led = digit3; end
    endcase
end
always_ff @(posedge clock)
begin
    case (led)
        0 : segments = 7'b0000001;
        1 : segments = 7'b1001111;
        2 : segments = 7'b0010010;
        3 : segments = 7'b0000110;
        4 : segments = 7'b1001100;
        5 : segments = 7'b0100100;
        6 : segments = 7'b0100000;
        7 : segments = 7'b0001111;
        8 : segments = 7'b0000000;
        9 : segments = 7'b0000100;
        10 : segments = 7'b0001000; // A
        11 : segments = 7'b1100000; // B
        12 : segments = 7'b1110010; // C
        13 : segments = 7'b1000010; // D
        14 : segments = 7'b0110000; // E
        15 : segments = 7'b0111000; // F
        16 : segments = 7'b1111010; // r
        17 : segments = 7'b1110000; // t
        default : segments = 7'b1111111; // Blank (invalid input)
    endcase
end
endmodule