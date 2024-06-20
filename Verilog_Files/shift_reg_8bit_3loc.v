`timescale 1ns / 1ps

module shift_reg_8bit_3loc(
    input wire clock,
    input wire reset,
    input wire enable,
    input wire [7:0] data_in,
    //output wire [7:0] data_out1,
    //output wire [7:0] data_out2,
    output wire [7:0] data_out3,
    //output wire [7:0] data_out4,
    output wire verify
);
/*  SE MAI DECLARA UN OUT NECESAR PT FIECARE JOC IN PARTE DUPA NEVOIE
    SI VA FI CONECTAT UNU LA REG[1] UNU LA REG[0] 
    !!! A NU SE COMBINA MAI MULT DE DOUA TASTE PT UN JOC CA DUPA MA DOARE CAPU LA IMPLEMENTARE
    SI ASA NU STIU DACA O SA IMI IASA DA I OK 
    
    =========> MERGI LA INDICATIILE DIN VERIFICATION MODULE 
    
*/ 

    reg [7:0] register [2:0];  
   

    always @(posedge clock) begin
        if (reset) begin
            register[0] <= 8'b00000000;  
            register[1] <= 8'b00000000; 
            register[2] <= 8'b00000000;
        end else if (enable) begin
            register[0] <= data_in;       
            register[1] <= register[0];
            register[2] <= register[1];    
        end
    end

    
    //assign data_out1 = (register[1] == 8'b11110000) ? 1 : 0;  
    //assign data_out2 = (register[0] == 8'b00011100) ? 1 : 0;
    //assign data_out1 = register[0]; 
    //assign data_out2 = register[1];
    assign data_out3 = register[0]; 
    //assign data_out4 = register[1];  // PENTRU MONITOR VGA DE SCHIMBAT DIN REG[2] IN REG[0] PT A REZOLVA PROBLEMA CU ECRANU(SE APRINDE PT PUTIN TIMP IN CULOAREA PRECEDENTA CELEI PE CARE SE APASA IN MOMENTUL RESPECTIV) 
    assign verify = (register[1] == 8'b11110000) ? 0 : 1;
endmodule





