`timescale 1ns / 1ps


module verification_module
    
    (
        input verify,
        input [7:0] in,
        //input [7:0] in1, 
        
        output [7:0] data_out,
        output out_reset_lfsr_snake, 
        output out_reset_to_start_snake, 
        output out_reset_to_start_pong,
        output out_reset_to_checkpoint_pong,
        
        output paddle_1_move_up, 
        output paddle_1_move_down, 
        output paddle_2_move_up, 
        output paddle_2_move_down, 
        
        output jump_dino_button, 
        output reset_dino_button,
        
        output out_b 

    );
    
    /*  
        ACILEA DECLAR UNU/DOUA/MAXIM TREI INPUTURI SI ZIC IN FELU URMATOR 
        DACA APAS A SI S DE EX O SA IMI VINA
        1C 1B 1C 1B 1C 1B ....... SI O SA MA DOARA CAPU CU UN SINGUR INT CA NU FACE ECRANU BINE
        O SA FIE IN0 LEGAT LA REG0 
        IN1 LEGAT LA REG1 DIN SHIFT REGISTER
        ASTA HAI SA NU (IN2 LEGAT LA REG2 DIN SHIFT REGISTER) 
        ATENTIE DE INCERCAT DOAR CU DOUA BUTOANE MAXIM DACA MERGE CA DUPA O SA MA RUPA LA IMPLEMENTARE
        EU ZIC CA E DE BUN SIMT DACA MERG DOUA BUTOANE (ASTA PENTRU JOCURI STIL MARIO UNDE SA ZICEM CA SARI SI MERGI SI INTR O PARTE IN ACELASI TIMP) 
        SI O SA FIE ASSIGN OUT == ...... && IN == ..... || IN = ....... (SI O SA MEARGA PENTRU CA ATUNCI CAND APESI VEDE VALOAREA 
        ORI IN REG[0] ORI IN REG[1] IAR CAND NU APESI EL TOT VEDE VALOAREA IN REG[0] SI AR TREBUII SA FIE APRINS DAR IN REG[1] VA FI F0 BREAKCODE
        SI ATUNCI VA PICA VERIFY IN 0 SI N O SA SE MAI APRINDA 
        EU SPER CA MERGE ASA 
    
    */ 
    
    assign out_reset_lfsr_snake = ((verify == 1'b1) && (in == 8'b01000100)) ? 1'b1 : 1'b0;
    assign out_reset_to_start_snake = ((verify == 1'b1) && (in == 8'b01001101)) ? 1'b1 : 1'b0;
    
    assign out_reset_to_start_pong = ((verify == 1'b1) && (in == 8'h2C)) ? 1'b1 : 1'b0;
    assign out_reset_to_checkpoint_pong = ((verify == 1'b1) && (in == 8'h34)) ? 1'b1 : 1'b0;
    
    assign paddle_1_move_up = ((verify == 1'b1) && (in == 8'h25)) ? 1'b1 : 1'b0;
    assign paddle_1_move_down = ((verify == 1'b1) && (in == 8'h2B)) ? 1'b1 : 1'b0;
    assign paddle_2_move_up = ((verify == 1'b1) && (in == 8'h36)) ? 1'b1 : 1'b0;
    assign paddle_2_move_down = ((verify == 1'b1) && (in == 8'h33)) ? 1'b1 : 1'b0;
    
    assign jump_dino_button = ((verify == 1'b1) && (in == 8'h29)) ? 1'b1 : 1'b0;
    assign reset_dino_button = ((verify == 1'b1) && (in == 8'h32)) ? 1'b1 : 1'b0;
    
    assign out_b = ((verify == 1'b1) && (in == 8'h1C)) ? 1'b1 : 1'b0;
    assign data_out = in;                
    
endmodule
