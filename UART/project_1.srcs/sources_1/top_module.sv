module top_module(
input logic clock,
input logic loadButton,
input logic sendSeri,
input logic transmitButton,
input logic rightButton,
input logic leftButton,
input logic inRDisplay,
input logic [7:0] loaded_data,
output logic [7:0] received_first,
output logic [7:0] loadOutput,
output logic [3:0] anodes,
output logic [6:0] seg,
input dataTaker,
output dataSend
    );
    
    
    logic [31:0] rxMemory;
    logic [31:0] txMemory;
    
    logic LoadButtonOut;
    logic TransmitButtonOut;
    logic RightButtonOut;
    logic LeftButtonOut;
    
    debounce d1(clock, loadButton, LoadButtonOut);
    debounce d2(clock,transmitButton,TransmitButtonOut);
    debounce d3(clock, leftButton, LeftButtonOut);
    debounce d4(clock,rightButton,RightButtonOut);
    debounce d5(clock,inRDisplay,inRDisplay_out);
    
    ButtonUpLogic buttonUpLog(clock,inRDisplay_out,ButtonUpLogic);
    
    displayMemory s1(clock, RightButtonOut , LeftButtonOut , txMemory, rxMemory, anodes, seg, ButtonUpLogic);
    
    tx sender(clock, sendSeri, LoadButtonOut, TransmitButtonOut, loaded_data, dataSend, loadOutput, txMemory);
    rx receiver(clock, dataTaker, received_first, rxMemory);
    
endmodule