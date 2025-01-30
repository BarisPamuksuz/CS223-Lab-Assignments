module displayMemory(
    input logic clock,
    input logic rightButtonOut,
    input logic leftButtonOut,
    input logic [31:0] txMemory,
    input logic [31:0] rxMemory,
    output reg [3:0] anodes,
    output logic [6:0] segments,
    input logic r_is_true
);

logic [1:0] case_index = 0;
logic [1:0] counter;
logic [19:0] refresh = 20'b0;
logic [1:0] bit_index_tx;
logic [1:0] bit_index_rx;
logic [7:0] regDisplay;


reg [3:0] digit0;
reg [3:0] digit1;
reg [3:0] digit2;
reg [4:0] digit3;
reg [4:0] led = 0;

always @(posedge clock)
begin
    digit0 <= regDisplay[3:0];
    digit1 <= regDisplay[7:4];
    if(r_is_true)begin
        digit2 <= bit_index_rx;
        digit3 <= 16;
    end
    else begin
        digit2 <= bit_index_tx;
        digit3 <= 17;
    end
    if(r_is_true && (bit_index_rx == 0))begin
        regDisplay[7:0] <= rxMemory[7:0];
    end
    if(r_is_true && (bit_index_rx == 1))begin
        regDisplay[7:0] <= rxMemory[15:8];
    end
    if(r_is_true && (bit_index_rx == 2))begin
        regDisplay[7:0] <= rxMemory[23:16];
    end
    if(r_is_true && (bit_index_rx == 3))begin
        regDisplay[7:0] <= rxMemory[31:24];
    end
    if(!r_is_true && (bit_index_tx == 0))begin
        regDisplay[7:0] <= txMemory[7:0];
    end
    if(!r_is_true && (bit_index_tx == 1))begin
        regDisplay[7:0] <= txMemory[15:8];
    end
    if(!r_is_true && (bit_index_tx == 2))begin
        regDisplay[7:0] <= txMemory[23:16];
    end
    if(!r_is_true && (bit_index_tx == 3))begin
        regDisplay[7:0] <= txMemory[31:24];
    end
    if(r_is_true && rightButtonOut)begin
        bit_index_rx <= bit_index_rx+1;
    end
    if(!r_is_true && rightButtonOut)begin
        bit_index_tx <= bit_index_tx+1;
    end
    if(r_is_true && leftButtonOut)begin
        bit_index_rx <= bit_index_rx-1;
    end
    if(!r_is_true && leftButtonOut)begin
        bit_index_tx <= bit_index_tx-1;
    end
end



always @(posedge clock)
begin
    if (counter > 1)
        counter <= 2'b00;
    else
        counter <= counter + 1;
    refresh <= refresh + 1;
    case_index <= refresh[19:18];
end

always_ff @(posedge clock)
begin
    case (case_index)
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
        default : segments = 7'b1111111;
    endcase
end
endmodule