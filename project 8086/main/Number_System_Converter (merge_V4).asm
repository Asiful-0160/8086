.MODEL SMALL
.STACK 100H
.DATA
     
     first_prompt db 0
     
     intro_b2d  db "BINARY TO DECIMAL$"
     intro_b2h  db "BINARY TO HEXA-DECIMAL$"
     intro_b2o  db "BINARY TO OCTAL$"   
     intro_d2b  db "DECIMAL TO BINARY$"
     intro_d2h  db "DECIMAL TO HEXA-DECIMAL$"
     intro_d2o  db "DECIMAL TO OCTAL$"  
     intro_h2b  db "HEX TO BINARY$"
     intro_h2d  db "HEX TO DECIMAL$"
     intro_h2o  db "HEX TO OCTAL$"   
     intro_o2b  db "OCTAL TO BINARY$"
     intro_o2d  db "OCTAL TO DECIMAL$"
     intro_o2h  db "OCTAL TO HEX$"         
     limit_bi   db "CONVERSION LIMIT - MAXIMUM 15-BIT BINARY VALUE$" 
     limit_dec  db "CONVERSION LIMIT - MAXIMUM 32767 DECIMAL VALUE$"  
     limit_hex  db "CONVERSION LIMIT - MAXIMUM 7FFF HEX VALUE$"     
     limit_oct  db "CONVERSION LIMIT - MAXIMUM 77777 OCTAL VALUE$"  
     input_bi   db "Insert a binary value: $"
     input_dec  db "Insert a decimal value: $"
     input_hex  db "Insert a hex value: $"
     input_oct  db "Insert a octal value: $"                                                  
     output_bi  db "Binary equivalent is: $"                                              
     output_dec db "Decimal equivalent is: $"
     output_hex db "Hex equivalent is: $"
     output_oct db "Octal equivalent is: $"     
     wrong_input_str db "Invalid input.$"
     try_again_str db "Try again? [1/0]$"
     range_out_of_bound_str db "Input exceeds program's limitation.$"
     outro db "THANK YOU$"     
     option db "WHICH CONVERTER PROGRAM DO YOU WANT TO USE?$"          
     b2d db "1. B 2 D$"
     b2h db "2. B 2 H$"
     b2o db "3. B 2 O$"  
     d2b db "4. D 2 B$"
     d2h db "5. D 2 H$"
     d2o db "6. D 2 O$"     
     h2b db "7. H 2 B$"
     h2d db "8. H 2 D$"
     h2o db "9. H 2 O$"
     o2b db "A. O 2 B$"
     o2d db "B. O 2 D$"
     o2h db "C. O 2 H$"
     exit db "0. EXIT$"
        
     arr db 255 dup(?)
     dec_arr db 5 dup(0)
     hex_arr db 4 dup(0)
     oct_arr db 5 dup(0)
     
     two dw 2
     ten dw 10
          
     sum dw ?
     len dw 0
     offset dw ?
     temp dw ?
     
     flag db 0
     fifth_bit db ?
     fourth_bit db ?
     third_bit db ?
     second_bit db ?
     first_bit db ?
     fifth_bit_oct dw 8
     fourth_bit_oct dw 8
     third_bit_oct dw 8
     second_bit_oct dw 8
     first_bit_oct dw 8 
     
.CODE
     MAIN PROC
     MOV AX,@DATA
     MOV DS,AX
     
     option_start:
     
     cmp first_prompt,0
     je different_converters
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     different_converters:
     mov first_prompt,1
     
     lea dx,option
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,b2d
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,b2h
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,b2o
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,d2b
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,d2h
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,d2o
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h 
     lea dx,h2b
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,h2d
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,h2o
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,o2b
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,o2d
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,o2h
     mov ah,9
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     lea dx,exit
     mov ah,9
     int 21h
     mov ah,2
     mov dl,20h
     int 21h
     
     mov ah,1
     int 21h
     sub al,30h
     cmp al,0
     je end  
     jl error
     cmp al,1
     je start_b2d
     cmp al,2
     je start_b2h
     cmp al,3
     je start_b2o
     cmp al,4
     je start_d2b
     cmp al,5
     je start_d2h
     cmp al,6
     je start_d2o
     cmp al,7
     je start_h2b
     cmp al,8
     je start_h2d
     cmp al,9
     je start_h2o
     cmp al,11h
     je start_o2b
     cmp al,31h
     je start_o2b
     cmp al,12h
     je start_o2d
     cmp al,32h
     je start_o2d
     cmp al,13h
     je start_o2h
     cmp al,33h
     je start_o2h
     jne error
     
     
     start_b2d:
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,intro_b2d
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_bi
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     start_input_b2d:
     
     lea dx,input_bi
     mov ah,9
     int 21h
     
     mov ah,1  
     mov si,0
     
     input_loop_b2d:
          int 21h         
          cmp al,0dh
          je exit_input_loop_b2d
          sub al,30h
          cmp al,0
          je proper_b2d
          cmp al,1
          je proper_b2d
          jne error
          proper_b2d:
          mov arr[si],al
          inc si
          inc len
          cmp len,15
          jg range_out_of_bound
          jmp input_loop_b2d
     
     exit_input_loop_b2d:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h      
          
     b2d_conversion:
     
     mov bx,len
     dec bx
     lea si,arr
     mov offset,si
     add offset,bx
     
     b2d_calculation_loop:
     
          mov dl,[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_b2d_calculation_loop
          mov ax,1
          mov cx,bx
          cmp cx,0
          je two_power_zero_b2d
          jmp multiply_b2d
          two_power_zero_b2d:
               mov ax,1
               jmp LSB_done_b2d
          
          multiply_b2d:
               mul two
               loop multiply_b2d     
          
          LSB_done_b2d:
          mul temp
          dec bx
          
          adding_b2d:
               add sum,ax
          
          inc si
          jmp b2d_calculation_loop                 
     
     exit_b2d_calculation_loop:
     
     b2d_value_assign_b2d:
     
     lea dx,output_dec
     mov ah,9
     int 21h
     mov dx,0
     
     cmp sum,10000
     jl less_than_10000_b2d
     mov ax,sum
     mov bx,10000
     div bx
     mov fifth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_10000_b2d:
     
     cmp sum,1000
     jl less_than_1000_b2d
     mov ax,sum
     mov bx,1000
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_1000_b2d:
     
     cmp sum,100
     jl less_than_100_b2d
     mov ax,sum
     mov bx,100
     div bx
     mov third_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_100_b2d:
     
     cmp sum,10
     jl less_than_10_b2d     
     mov ax,sum
     mov bx,10
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
     
     less_than_10_b2d:
     
     mov ax,sum
     mov first_bit,al
      
     add fifth_bit,30h
     add fourth_bit,30h
     add third_bit,30h
     add second_bit,30h
     add first_bit,30h
     
     fifth_b2d:
     
     cmp fifth_bit,30h
     je fourth_b2d
     mov dl,fifth_bit
     mov ah,2
     int 21h
     inc flag
     
     fourth_b2d:
     
     cmp flag,0
     jne skip_4_b2d
     cmp fourth_bit,30h
     je third_b2d
     skip_4_b2d:
     mov dl,fourth_bit
     mov ah,2
     int 21h
     inc flag
     
     third_b2d:
     
     cmp flag,0
     jne skip_3_b2d
     cmp third_bit,30h
     je second_b2d
     skip_3_b2d:
     mov dl,third_bit
     mov ah,2
     int 21h
     inc flag
     
     second_b2d:
     
     cmp flag,0
     jne skip_2_b2d
     cmp second_bit,30h
     je first_b2d
     skip_2_b2d:
     mov dl,second_bit
     mov ah,2
     int 21h
     inc flag
     
     first_b2d:
     
     cmp flag,0
     jne skip_1_b2d
     cmp first_bit,30h
     je sum_is_zero_b2d
     skip_1_b2d:
     mov dl,first_bit
     mov ah,2
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again   
     
     sum_is_zero_b2d:
     
     mov ah,2
     mov dl,30h
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
          
     jmp try_again
     
               
               
     start_b2h:
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
      
     lea dx,intro_b2h
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_bi
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     start_input_b2h:
     
     lea dx,input_bi
     mov ah,9
     int 21h
     
     mov ah,1  
     mov si,0
     
     input_loop_b2h:
          int 21h         
          cmp al,0dh
          je exit_input_loop_b2h
          sub al,30h
          cmp al,0
          je proper_b2h
          cmp al,1
          je proper_b2h
          jne error
          proper_b2h:
          mov arr[si],al
          inc si
          inc len
          cmp len,15
          jg range_out_of_bound
          jmp input_loop_b2h
     
     exit_input_loop_b2h:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h      
     
     b2h_conversion:
     
     mov bx,len
     dec bx
     lea si,arr
     mov offset,si
     add offset,bx
     
     b2h_calculation_loop:
     
          mov dl,[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_b2h_calculation_loop
          mov ax,1
          mov cx,bx
          cmp cx,0
          je two_power_zero_b2h
          jmp multiply_b2h
          two_power_zero_b2h:
               mov ax,1
               jmp LSB_done_b2h
          
          multiply_b2h:
               mul two
               loop multiply_b2h     
          
          LSB_done_b2h:
          mul temp
          dec bx
          
          adding_b2h:
               add sum,ax
          
          inc si
          jmp b2h_calculation_loop                 
     
     exit_b2h_calculation_loop:
     
     
     b2h_value_assign:
     
     lea dx,output_hex
     mov ah,9
     int 21h
     mov dx,0
     
     mov dx,0
     cmp sum,1000h
     jl less_than_1000h
     mov ax,sum
     mov bx,1000h
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_1000h:
     
     cmp sum,100h
     jl less_than_100h
     mov ax,sum
     mov bx,100h
     div bx
     mov third_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_100h:
     
     cmp sum,10h
     jl less_than_10h
     mov ax,sum
     mov bx,10h
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_10h:
     
     cmp sum,1h
     mov ax,sum
     mov first_bit,al     
     
     lea si,hex_arr
     
     placement_b2h:
     mov al,fourth_bit
     mov [si],al
     inc si
     mov al,third_bit
     mov [si],al
     inc si
     mov al,second_bit
     mov [si],al
     inc si
     mov al,first_bit
     mov [si],al
     
     cmp fourth_bit,0
     jne b2h_result_is_not_zero
     cmp third_bit,0
     jne b2h_result_is_not_zero
     cmp second_bit,0
     jne b2h_result_is_not_zero
     cmp first_bit,0
     jne b2h_result_is_not_zero
     
     b2h_result_is_zero:
     mov dl,30h
     mov ah,2
     int 21h
     jmp printing_done_b2h  
     
     b2h_result_is_not_zero:
     
     lea si,hex_arr
     mov cx,4
     
     print_b2h:
          mov ah,2
          cmp [si],9
          jle less_than_9
          cmp [si],0AH
          je A
          cmp [si],0BH
          je B
          cmp [si],0CH
          je C
          cmp [si],0DH
          je D
          cmp [si],0EH
          je E
          cmp [si],0FH
          je F
          
          less_than_9:
          mov dl,[si]
          add dl,30h
          cmp dl,30h
          jne printing_b2h
          cmp flag,0
          je skip_b2h
          printing_b2h:
          int 21h
          inc flag
          skip_b2h:
          inc si
          loop print_b2h
          jmp printing_done_b2h
          
          A:
          mov dl,41H
          int 21h
          inc si
          inc flag
          loop print_b2h
          jmp printing_done_b2h
          
          B:
          mov dl,42H
          int 21h
          inc si
          inc flag
          loop print_b2h
          jmp printing_done_b2h
          
          C:
          mov dl,43H
          int 21h
          inc si
          inc flag
          loop print_b2h
          jmp printing_done_b2h
          
          D:
          mov dl,44H
          int 21h
          inc si
          inc flag
          loop print_b2h
          jmp printing_done_b2h
          
          E:
          mov dl,45H
          int 21h
          inc si
          inc flag
          loop print_b2h
          jmp printing_done_b2h
          
          F:
          mov dl,46H
          int 21h
          inc si
          inc b2h
          loop print_b2h
              
     printing_done_b2h:
     
     mov ah,2
     mov dl,'h'
     int 21h
     
     b2h_end:
         
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
          
     jmp try_again     
     
     
     
     start_b2o:
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
     
     lea dx,intro_b2o
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_bi
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     start_input_b2o:
     
     lea dx,input_bi
     mov ah,9
     int 21h
     
     mov ah,1  
     mov si,0
     
     input_loop_b2o:
          int 21h         
          cmp al,0dh
          je exit_input_loop_b2o
          sub al,30h
          cmp al,0
          je proper_b2o
          cmp al,1
          je proper_b2o
          jne error
          proper_b2o:
          mov arr[si],al
          inc si
          inc len
          cmp len,15
          jg range_out_of_bound
          jmp input_loop_b2o
     
     exit_input_loop_b2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     b2o_conversion:    
     
     mov bx,len
     dec bx
     mov si,0
     mov offset,si
     add si,bx
     mov bx,3 
     
     b2o_calculation_loop:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jl exit_b2o_calculation_loop
          mov ax,1
          
          cmp bx,2 
          je cx_is_1_b2o
          cmp bx,1
          je cx_is_2_b2o
          jmp bx_is_3_b2o
          cx_is_1_b2o:
          mov cx,1
          
          jmp next_line_b2o
          cx_is_2_b2o:
          mov cx,2
          
          next_line_b2o:    
          bx_is_3_b2o:
          cmp bx,3
          

          je two_power_zero_b2o
          jmp multiply_b2o
          two_power_zero_b2o:
               mov ax,1
               dec bx
               jmp LSB_done_b2o
          
          multiply_b2o:
               mul two
               loop multiply_b2o
               
          dec bx
          LSB_done_b2o:
          mul temp
          
          adding_b2o:
               add sum,ax
          
          dec si
          cmp bx,0
          je assign_bx_3_b2o
          jmp pass_assign_b2o
          assign_bx_3_b2o:
          mov bx,3
          
          assigning_first_bit_b2o:
          cmp first_bit_oct,8
          je assign_first_bit_b2o
          jne assigning_second_bit_b2o
          assign_first_bit_b2o:
          mov dx,sum
          mov first_bit_oct,dx
          mov sum,0
          jmp pass_assign_b2o
          
          assigning_second_bit_b2o:
          cmp second_bit_oct,8
          je assign_second_bit_b2o
          jne assigning_third_bit_b2o
          assign_second_bit_b2o:
          mov dx,sum
          mov second_bit_oct,dx
          mov sum,0
          jmp pass_assign_b2o
          
          assigning_third_bit_b2o:
          cmp third_bit_oct,8
          je assign_third_bit_b2o
          jne assigning_fourth_bit_b2o
          assign_third_bit_b2o:
          mov dx,sum
          mov third_bit_oct,dx
          mov sum,0
          jmp pass_assign_b2o
          
          assigning_fourth_bit_b2o:
          cmp fourth_bit_oct,8
          je assign_fourth_bit_b2o
          jne assigning_fifth_bit_b2o
          assign_fourth_bit_b2o:
          mov dx,sum
          mov fourth_bit_oct,dx
          mov sum,0
          jmp pass_assign_b2o
          
          assigning_fifth_bit_b2o:
          cmp first_bit_oct,8
          je assign_fifth_bit_b2o
          assign_fifth_bit_b2o:
          mov dx,sum
          mov fifth_bit_oct,dx
          mov sum,0
          
          
          pass_assign_b2o:
          jmp b2o_calculation_loop                 
     
     exit_b2o_calculation_loop:
     
     replacing_unused_bits_to_zero_b2o: 
     assign_first_bit_oct_zero_b2o:
     cmp first_bit_oct,8
     je first_bit_oct_zero_b2o
     jne assign_second_bit_oct_zero_b2o
     first_bit_oct_zero_b2o:
     mov dx,sum
     mov sum,0
     mov first_bit_oct,dx
     
     assign_second_bit_oct_zero_b2o:
     cmp second_bit_oct,8
     je second_bit_oct_zero_b2o
     jne assign_third_bit_oct_zero_b2o
     second_bit_oct_zero_b2o:
     mov dx,sum
     mov sum,0
     mov second_bit_oct,dx
     
     assign_third_bit_oct_zero_b2o:
     cmp third_bit_oct,8
     je third_bit_oct_zero_b2o
     jne assign_fourth_bit_oct_zero_b2o
     third_bit_oct_zero_b2o:
     mov dx,sum
     mov sum,0
     mov third_bit_oct,dx
     
     assign_fourth_bit_oct_zero_b2o:
     cmp fourth_bit_oct,8
     je fourth_bit_oct_zero_b2o
     jne assign_fifth_bit_oct_zero_b2o
     fourth_bit_oct_zero_b2o:
     mov dx,sum
     mov sum,0
     mov fourth_bit_oct,dx
     
     assign_fifth_bit_oct_zero_b2o:
     cmp fifth_bit_oct,8
     je fifth_bit_oct_zero_b2o
     jne octal_value_assign_and_print_b2o
     fifth_bit_oct_zero_b2o:
     mov dx,sum
     mov sum,0
     mov fifth_bit_oct,dx
     
     octal_value_assign_and_print_b2o:
     
     lea dx,output_oct
     mov ah,9
     int 21h
     mov dx,0
     
     cmp fifth_bit_oct,0
     je check_fourth_bit_b2o
     print_fifth_b2o:
     mov dx,fifth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_fourth_bit_b2o:
     cmp flag,0
     jne skip_04_b2o 
     cmp fourth_bit_oct,0
     je check_third_bit_b2o
     skip_04_b2o:
     mov dx,fourth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_third_bit_b2o:
     cmp flag,0
     jne skip_03_b2o 
     cmp third_bit_oct,0
     je check_second_bit_b2o
     skip_03_b2o:
     mov dx,third_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_second_bit_b2o:
     cmp flag,0
     jne skip_02_b2o 
     cmp second_bit_oct,0
     je check_first_bit_b2o
     skip_02_b2o:
     mov dx,second_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_first_bit_b2o:
     cmp flag,0
     jne skip_01_b2o 
     cmp first_bit_oct,0
     je sum_is_zero_oct_b2o
     skip_01_b2o:
     mov dx,first_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     jmp printing_done_oct_b2o
     
     sum_is_zero_oct_b2o:
     mov dl,30h
     mov ah,2
     int 21h
     
     printing_done_oct_b2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again      
           
     
           
     start_d2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_intro_d2b:
     
     lea dx,intro_d2b
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_dec
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,input_dec
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_d2b:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_d2b
          sub al,30h
          cmp al,0
          jl invalid_input_d2b
          cmp al,9
          jle proper_d2b
          jg invalid_input_d2b
          proper_d2b:
          mov ah,0
          push ax
          inc len
          cmp len,5
          jg invalid_input_d2b
          jmp input_loop_d2b
     
     invalid_input_d2b:
     cmp len,0
     je error
     mov cx,len
     clear_stacK_d2b:
     pop dx
     loop clear_stack_d2b
     cmp len,5
     jg range_out_of_bound
     jmp error
          
     exit_input_loop_d2b:
                
      
     d2b_conversion:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     inserted_value_assign_d2b:
     cmp len,0
     je done_assigning_binary_value_to_arr_d2b
     mov cx,len
     mov bx,len
     dec bx
     mov si,bx
     assign_d2b:
          pop bx
          mov dec_arr[si],bl
          dec si
          loop assign_d2b
          
     mov bx,len
     dec bx
     lea si,dec_arr
     mov offset,si
     add offset,bx
     
     assigned_decimal_calculation_loop_d2b:
     
          mov dl,[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_assigned_decimal_calculation_loop_d2b
          mov ax,1
          mov cx,bx
          cmp cx,0
          je ten_power_zero_d2b
          jmp multiply_d2b
          ten_power_zero_d2b:
               mov ax,1
               jmp LSB_done_d2b
          
          multiply_d2b:
               mul ten
               cmp dx,0
               jne range_out_of_bound
               loop multiply_d2b     
          
          LSB_done_d2b:
          mul temp
          cmp ax,0
          jl range_out_of_bound
          cmp dx,0
          jne range_out_of_bound
          dec bx
          
          adding_d2b:
               add sum,ax
               cmp sum,0
               jl range_out_of_bound
          
          inc si
          jmp assigned_decimal_calculation_loop_d2b                 
     
     exit_assigned_decimal_calculation_loop_d2b:
     
     cmp sum,0
     jl range_out_of_bound
     
     cmp sum,32767
     jg range_out_of_bound
     
     d2b_calculation:
     
     mov len,0
     mov ax,sum
     mov dx,0
     obtaining_the_binary_value_d2b:
     cmp ax,0
     jle done_obtaining_the_binary_value_d2b     
     div two
     push dx
     mov dx,0
     inc len
     jmp obtaining_the_binary_value_d2b
     
     done_obtaining_the_binary_value_d2b:
     
     cmp len,0
     je done_assigning_binary_value_to_arr_d2b:
     
     assigning_binary_value_to_arr_d2b: 
     mov si,0
     mov cx,len
     binary_value_in_array_d2b:
     pop bx
     mov arr[si],bl
     inc si
     loop binary_value_in_array_d2b
     
     done_assigning_binary_value_to_arr_d2b:
     
     lea dx,output_bi
     mov ah,9
     int 21h
     mov cx,len
     mov si,0
     mov ah,2
          
     cmp len,0
     je sum_is_0_d2b
     jmp print_d2b
     sum_is_0_d2b:
     mov ah,2
     mov dl,30h
     int 21h
     jmp print_done_d2b
             
     print_d2b:
     mov dl,arr[si]
     add dl,30h
     int 21h
     inc si
     loop print_d2b
     
     print_done_d2b:        
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
               
     jmp try_again
     
     
     
     start_d2h:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_intro_d2h:
     
     lea dx,intro_d2h
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_dec
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,input_dec
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_d2h:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_d2h
          sub al,30h
          cmp al,0
          jl invalid_input_d2h
          cmp al,9
          jle proper_d2h
          jg invalid_input_d2h
          proper_d2h:
          mov ah,0
          push ax
          inc len
          cmp len,5
          jg range_out_of_bound
          jmp input_loop_d2h
     
     invalid_input_d2h:
     cmp len,0
     je error
     mov cx,len
     clear_stacK_d2h:
     pop dx
     loop clear_stack_d2h
     jmp error
          
     exit_input_loop_d2h:
      
     d2h_conversion:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     inserted_value_assign_d2h:
     cmp len,0
     je hex_result_is_zero_d2h
     mov cx,len
     mov bx,len
     dec bx
     mov si,bx
     assign_d2h:
          pop bx
          mov dec_arr[si],bl
          dec si
          loop assign_d2h
          
     mov bx,len
     dec bx
     lea si,dec_arr
     mov offset,si
     add offset,bx
     
     assigned_decimal_calculation_loop_d2h:
     
          mov dl,[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_assigned_decimal_calculation_loop_d2h
          mov ax,1
          mov cx,bx
          cmp cx,0
          je ten_power_zero_d2h
          jmp multiply_d2h
          ten_power_zero_d2h:
               mov ax,1
               jmp LSB_done_d2h
          
          multiply_d2h:
               mul ten
               cmp dx,0
               jne range_out_of_bound
               loop multiply_d2h     
          
          LSB_done_d2h:
          mul temp
          cmp ax,0
          jl range_out_of_bound
          cmp dx,0
          jne range_out_of_bound
          dec bx
          
          adding_d2h:
               add sum,ax
               cmp sum,0
               jl range_out_of_bound
          
          inc si
          jmp assigned_decimal_calculation_loop_d2h               
     
     exit_assigned_decimal_calculation_loop_d2h:
     
     cmp sum,0
     jl range_out_of_bound
     
     cmp sum,32767
     jg range_out_of_bound
     
     hexa_decimal_value_assign_d2h:
     
     mov dx,0
     cmp sum,1000h
     jl less_than_1000h_d2h
     mov ax,sum
     mov bx,1000h
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_1000h_d2h:
     
     cmp sum,100h
     jl less_than_100h_d2h
     mov ax,sum
     mov bx,100h
     div bx
     mov third_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_100h_d2h:
     
     cmp sum,10h
     jl less_than_10h_d2h
     mov ax,sum
     mov bx,10h
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_10h_d2h:
     
     cmp sum,1h
     mov ax,sum
     mov first_bit,al     
     
     lea si,hex_arr
     
     placement_d2h:
     mov al,fourth_bit
     mov [si],al
     inc si
     mov al,third_bit
     mov [si],al
     inc si
     mov al,second_bit
     mov [si],al
     inc si
     mov al,first_bit
     mov [si],al
     
     cmp fourth_bit,0
     jne hex_result_is_not_zero_d2h
     cmp third_bit,0
     jne hex_result_is_not_zero_d2h
     cmp second_bit,0
     jne hex_result_is_not_zero_d2h
     cmp first_bit,0
     jne hex_result_is_not_zero_d2h
     
     hex_result_is_zero_d2h:
     lea dx,output_hex
     mov ah,9
     int 21h
     mov dx,0
     mov dl,30h
     mov ah,2
     int 21h
     jmp printing_done_hex_d2h  
     
     hex_result_is_not_zero_d2h:
     lea dx,output_hex
     mov ah,9
     int 21h
     mov dx,0
     
     lea si,hex_arr
     mov cx,4
     
     print_hex_d2h:
          mov ah,2
          cmp [si],9
          jle less_than_9_d2h
          cmp [si],0AH
          je A_d2h
          cmp [si],0BH
          je B_d2h
          cmp [si],0CH
          je C_d2h
          cmp [si],0DH
          je D_d2h
          cmp [si],0EH
          je E_d2h
          cmp [si],0FH
          je F_d2h
          
          less_than_9_d2h:
          mov dl,[si]
          add dl,30h
          cmp dl,30h
          jne printing_hex_d2h
          cmp flag,0
          je skip_hex_d2h
          printing_hex_d2h:
          int 21h
          inc flag
          skip_hex_d2h:
          inc si
          loop print_hex_d2h
          jmp printing_done_hex_d2h
          
          A_d2h:
          mov dl,41H
          int 21h
          inc si
          inc flag
          loop print_hex_d2h
          jmp printing_done_hex_d2h
          
          B_d2h:
          mov dl,42H
          int 21h
          inc si
          inc flag
          loop print_hex_d2h
          jmp printing_done_hex_d2h
          
          C_d2h:
          mov dl,43H
          int 21h
          inc si
          inc flag
          loop print_hex_d2h
          jmp printing_done_hex_d2h
          
          D_d2h:
          mov dl,44H
          int 21h
          inc si
          inc flag
          loop print_hex_d2h
          jmp printing_done_hex_d2h
          
          E_d2h:
          mov dl,45H
          int 21h
          inc si
          inc flag
          loop print_hex_d2h
          jmp printing_done_hex_d2h
          
          F_d2h:
          mov dl,46H
          int 21h
          inc si
          inc flag
          loop print_hex_d2h
              
     printing_done_hex_d2h:
     
     mov ah,2
     mov dl,'h'
     int 21h
     
     d2h_end:
         
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
          
     jmp try_again
     
     
          
     start_d2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_d2o:
     
     lea dx,intro_d2o
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_dec
     mov ah,9
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,input_dec
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_d2b2o:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_d2b2o
          sub al,30h
          cmp al,0
          jl invalid_input_d2b2o
          cmp al,9
          jle proper_d2b2o
          jg invalid_input_d2b2o
          proper_d2b2o:
          mov ah,0
          push ax
          inc len
          cmp len,5
          jg range_out_of_bound
          jmp input_loop_d2b2o
     
     invalid_input_d2b2o:
     cmp len,0
     je error
     mov cx,len
     clear_stacK_d2b2o:
     pop dx
     loop clear_stack_d2b2o
     jmp error
          
     exit_input_loop_d2b2o:
                 
     d2b_later_b2o_conversion:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
            
     inserted_value_assign_d2b_later_b2o:
     cmp len,0
     je octal_value_assign_and_print_d2o
     mov cx,len
     mov bx,len
     dec bx
     mov si,bx
     assign_d2b_later_b2o:
          pop bx
          mov dec_arr[si],bl
          dec si
          loop assign_d2b_later_b2o
          
     mov bx,len
     dec bx
     lea si,dec_arr
     mov offset,si
     add offset,bx
     
     assigned_decimal_calculation_loop_d2b_later_b2o:
     
          mov dl,[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_assigned_decimal_calculation_loop_d2b_later_b2o
          mov ax,1
          mov cx,bx
          cmp cx,0
          je ten_power_zero_d2b_later_b2o
          jmp multiply_d2b_later_b2o
          ten_power_zero_d2b_later_b2o:
               mov ax,1
               jmp LSB_done_d2b_later_b2o
          
          multiply_d2b_later_b2o:
               mul ten
               cmp dx,0
               jne range_out_of_bound
               loop multiply_d2b_later_b2o     
          
          LSB_done_d2b_later_b2o:
          mul temp
          cmp ax,0
          jl range_out_of_bound
          cmp dx,0
          jne range_out_of_bound
          dec bx
          
          adding_d2b_later_b2o:
               add sum,ax
               cmp sum,0
               jl range_out_of_bound
          
          inc si
          jmp assigned_decimal_calculation_loop_d2b_later_b2o               
     
     exit_assigned_decimal_calculation_loop_d2b_later_b2o:
     
     cmp sum,0
     jl range_out_of_bound
     
     cmp sum,32767
     jg range_out_of_bound
     
     binary_calculation_d2o:
     
     mov len,0
     mov ax,sum
     mov dx,0
     obtaining_the_binary_value_d2o:
     cmp ax,0
     jle done_obtaining_the_binary_value_d2o     
     div two
     push dx
     mov dx,0
     inc len
     jmp obtaining_the_binary_value_d2o
     
     done_obtaining_the_binary_value_d2o:
     
     cmp len,0
     je done_assigning_binary_value_to_arr_d2o:
     
     assigning_binary_value_to_arr_d2o: 
     mov si,0
     mov cx,len
     binary_value_in_array_d2o:
     pop bx
     mov arr[si],bl
     inc si
     loop binary_value_in_array_d2o
     
     done_assigning_binary_value_to_arr_d2o:
      
     done_assigning_binary_value_to_arr_d2b_later_b2h_d2o:
      
     mov sum,0
     mov bx,len
     dec bx
     mov si,0
     mov offset,si
     add si,bx
     mov bx,3 
     
     octal_calculation_loop_d2o:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jl exit_octal_calculation_loop_d2o
          mov ax,1
          
          cmp bx,2 
          je cx_is_1
          cmp bx,1
          je cx_is_2
          jmp bx_is_3
          cx_is_1:
          mov cx,1
          
          jmp next_line_d2o
          cx_is_2:
          mov cx,2

          next_line_d2o:    
          bx_is_3:
          cmp bx,3
          
          je two_power_zero_d2o
          jmp multiply_d2o
          two_power_zero_d2o:
               mov ax,1
               dec bx
               jmp LSB_done_d2o
          
          multiply_d2o:
               mul two
               loop multiply_d2o
               
          dec bx
          LSB_done_d2o:
          mul temp
          
          adding_d2o:
               add sum,ax
          
          dec si
          cmp bx,0
          je assign_bx_3_d2o
          jmp pass_assign_d2o
          assign_bx_3_d2o:
          mov bx,3
          
          assigning_first_bit_d2o:
          cmp first_bit_oct,8
          je assign_first_bit_d2o
          jne assigning_second_bit_d2o
          assign_first_bit_d2o:
          mov dx,sum
          mov first_bit_oct,dx
          mov sum,0
          jmp pass_assign_d2o
          
          assigning_second_bit_d2o:
          cmp second_bit_oct,8
          je assign_second_bit_d2o
          jne assigning_third_bit_d2o
          assign_second_bit_d2o:
          mov dx,sum
          mov second_bit_oct,dx
          mov sum,0
          jmp pass_assign_d2o
          
          assigning_third_bit_d2o:
          cmp third_bit_oct,8
          je assign_third_bit_d2o
          jne assigning_fourth_bit_d2o
          assign_third_bit_d2o:
          mov dx,sum
          mov third_bit_oct,dx
          mov sum,0
          jmp pass_assign_d2o
          
          assigning_fourth_bit_d2o:
          cmp fourth_bit_oct,8
          je assign_fourth_bit_d2o
          jne assigning_fifth_bit_d2o
          assign_fourth_bit_d2o:
          mov dx,sum
          mov fourth_bit_oct,dx
          mov sum,0
          jmp pass_assign_d2o
          
          assigning_fifth_bit_d2o:
          cmp first_bit_oct,8
          je assign_fifth_bit_d2o
          assign_fifth_bit_d2o:
          mov dx,sum
          mov fifth_bit_oct,dx
          mov sum,0
          
          
          pass_assign_d2o:
          jmp octal_calculation_loop_d2o                 
     
     exit_octal_calculation_loop_d2o:
     
     replacing_unused_bits_to_zero_d2o: 
     assign_first_bit_oct_zero_d2o:
     cmp first_bit_oct,8
     je first_bit_oct_zero_d2o
     jne assign_second_bit_oct_zero_d2o
     first_bit_oct_zero_d2o:
     mov dx,sum
     mov sum,0
     mov first_bit_oct,dx
     
     assign_second_bit_oct_zero_d2o:
     cmp second_bit_oct,8
     je second_bit_oct_zero_d2o
     jne assign_third_bit_oct_zero_d2o
     second_bit_oct_zero_d2o:
     mov dx,sum
     mov sum,0
     mov second_bit_oct,dx
     
     assign_third_bit_oct_zero_d2o:
     cmp third_bit_oct,8
     je third_bit_oct_zero_d2o
     jne assign_fourth_bit_oct_zero_d2o
     third_bit_oct_zero_d2o:
     mov dx,sum
     mov sum,0
     mov third_bit_oct,dx
     
     assign_fourth_bit_oct_zero_d2o:
     cmp fourth_bit_oct,8
     je fourth_bit_oct_zero_d2o
     jne assign_fifth_bit_oct_zero_d2o
     fourth_bit_oct_zero_d2o:
     mov dx,sum
     mov sum,0
     mov fourth_bit_oct,dx
     
     assign_fifth_bit_oct_zero_d2o:
     cmp fifth_bit_oct,8
     je fifth_bit_oct_zero_d2o
     jne octal_value_assign_and_print_d2o
     fifth_bit_oct_zero_d2o:
     mov dx,sum
     mov sum,0
     mov fifth_bit_oct,dx
     
     octal_value_assign_and_print_d2o:
     
     lea dx,output_oct
     mov ah,9
     int 21h
     mov dx,0
     
     cmp len,0
     je sum_is_zero_oct_d2o
     
     cmp fifth_bit_oct,0
     je check_fourth_bit_d2o
     print_fifth_d2o:
     mov dx,fifth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_fourth_bit_d2o:
     cmp flag,0
     jne skip_04_d2o 
     cmp fourth_bit_oct,0
     je check_third_bit_d2o
     skip_04_d2o:
     mov dx,fourth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_third_bit_d2o:
     cmp flag,0
     jne skip_03_d2o 
     cmp third_bit_oct,0
     je check_second_bit_d2o
     skip_03_d2o:
     mov dx,third_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_second_bit_d2o:
     cmp flag,0
     jne skip_02_d2o 
     cmp second_bit_oct,0
     je check_first_bit_d2o
     skip_02_d2o:
     mov dx,second_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_first_bit_d2o:
     cmp flag,0
     jne skip_01_d2o 
     cmp first_bit_oct,0
     je sum_is_zero_oct_d2o
     skip_01_d2o:
     mov dx,first_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     jmp printing_done_oct_d2o
     
     sum_is_zero_oct_d2o:
     mov dl,30h
     mov ah,2
     int 21h
     
     printing_done_oct_d2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again
     
     

     start_h2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_h2b:
     
     lea dx,intro_h2b
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_hex
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_h2b_conversion:
     
     lea dx,input_hex
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_h2b:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_h2b
          sub al,30h
          cmp al,0
          jl error
          cmp al,9
          jle proper_hex_lt9_h2b
          cmp al,11h
          je A_h2b
          cmp al,31h
          je A_h2b
          cmp al,12h
          je B_h2b
          cmp al,32h
          je B_h2b
          cmp al,13h
          je C_h2b
          cmp al,33h
          je C_h2b
          cmp al,14h
          je D_h2b
          cmp al,34h
          je D_h2b
          cmp al,15h
          je E_h2b
          cmp al,35h
          je E_h2b
          cmp al,16h
          je F_h2b
          cmp al,36h
          je F_h2b
          jg error
          proper_hex_lt9_h2b:
          mov arr[si],al
          jmp point_h2b
          
          A_h2b:
          mov arr[si],10
          jmp point_h2b
          
          B_h2b:
          mov arr[si],11
          jmp point_h2b
          
          C_h2b:
          mov arr[si],12
          jmp point_h2b
          
          D_h2b:
          mov arr[si],13
          jmp point_h2b
          
          E_h2b:
          mov arr[si],14
          jmp point_h2b
          
          F_h2b:
          mov arr[si],15
          jmp point_h2b
          
          point_h2b:
          inc si
          inc len
          cmp len,4
          jg range_out_of_bound
          jmp input_loop_h2b
     
     exit_input_loop_h2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     cmp len,0
     je printing_start_h2b
     
     mov ax,len
     mov bx,4
     sub bx,ax
     mov si,bx
     mov di,0
     mov cx,len 
     hex_value_assign_to_hex_arr_h2b:
     mov al,arr[di]
     mov hex_arr[si],al
     inc di
     inc si
     loop hex_value_assign_to_hex_arr_h2b
     
     cmp hex_arr[0],7
     jg range_out_of_bound  
     
     binary_calculation_from_hex_h2b:
     mov cx,4
     mov si,0
     mov di,0
     mov dh,8
     mov bh,4
     mov bl,2
          
     hex_to_bi_h2b:
     mov ah,0
     mov al,hex_arr[si]
     div dh
     mov arr[di],al
     mov al,ah
     mov ah,0
     inc di     
     div bh
     mov arr[di],al
     mov al,ah
     mov ah,0
     inc di
     div bl
     mov arr[di],al
     inc di
     mov arr[di],ah
     inc di
     inc si
     loop hex_to_bi_h2b
     
     printing_start_h2b:
     
     lea dx,output_bi
     mov ah,9
     int 21h
     
     mov cx,4
     mov si,0
     is_h2b_sum_zero_loop_h2b:
     mov ah,hex_arr[si]
     cmp ah,0
     jne h2b_sum_is_not_zero_h2b
     inc si
     loop is_h2b_sum_zero_loop_h2b
     mov dl,30h
     mov ah,2
     int 21h
     jmp h2b_printing_done_h2b
     
     h2b_sum_is_not_zero_h2b:
     
     mov cx,16
     mov si,0
     printing_h2b:
     mov ah,2 
     mov dl,arr[si]
     cmp flag,0
     jne skipping_skip_h2b
     cmp dl,0
     je skip_prining_h2b
     skipping_skip_h2b:
     add dl,30h
     int 21h
     inc flag
     skip_prining_h2b:
     inc si
     loop printing_h2b
     
     h2b_printing_done_h2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again   
     
     

     start_h2d:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_h2d:
     
     lea dx,intro_h2d
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_hex
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_h2d_conversion:
     
     lea dx,input_hex
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_h2d:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_h2d
          sub al,30h
          cmp al,0
          jl error
          cmp al,9
          jle proper_hex_lt9_h2d
          cmp al,11h
          je A_h2d
          cmp al,31h
          je A_h2d
          cmp al,12h
          je B_h2d
          cmp al,32h
          je B_h2d
          cmp al,13h
          je C_h2d
          cmp al,33h
          je C_h2d
          cmp al,14h
          je D_h2d
          cmp al,34h
          je D_h2d
          cmp al,15h
          je E_h2d
          cmp al,35h
          je E_h2d
          cmp al,16h
          je F_h2d
          cmp al,36h
          je F_h2d
          jg error
          proper_hex_lt9_h2d:
          mov arr[si],al
          jmp point_h2d
          
          A_h2d:
          mov arr[si],10
          jmp point_h2d
          
          B_h2d:
          mov arr[si],11
          jmp point_h2d
          
          C_h2d:
          mov arr[si],12
          jmp point_h2d
          
          D_h2d:
          mov arr[si],13
          jmp point_h2d
          
          E_h2d:
          mov arr[si],14
          jmp point_h2d
          
          F_h2d:
          mov arr[si],15
          jmp point_h2d
          
          point_h2d:
          inc si
          inc len
          cmp len,4
          jg range_out_of_bound
          jmp input_loop_h2d
     
     exit_input_loop_h2d:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     cmp len,0
     je printing_start_h2d
     
     mov ax,len
     mov bx,4
     sub bx,ax
     mov si,bx
     mov di,0
     mov cx,len 
     hex_value_assign_to_hex_arr_h2d:
     mov al,arr[di]
     mov hex_arr[si],al
     inc di
     inc si
     loop hex_value_assign_to_hex_arr_h2d  
     
     cmp hex_arr[0],7
     jg range_out_of_bound
     
     binary_calculation_from_hex_h2d:
     mov cx,4
     mov si,0
     mov di,0
     mov dh,8
     mov bh,4
     mov bl,2
     mov dl,0
          
     hex_to_bi_h2d:
     mov ah,0
     mov al,hex_arr[si]
     div dh
     mov arr[di],al
     inc dl
     mov al,ah
     mov ah,0
     inc di     
     div bh
     mov arr[di],al
     inc dl
     mov al,ah
     mov ah,0
     inc di
     div bl
     mov arr[di],al
     inc dl
     inc di
     mov arr[di],ah
     inc dl
     inc di
     inc si
     loop hex_to_bi_h2d
     
     mov bx,0
     mov len,0
     len_count_h2d:
     mov si,0
     mov cl,dl
     mov ch,0
     len_count_loop_h2d: 
          cmp arr[si],0
          je check_bx_h2d
          skipping_check_bx_h2d:
          mov bx,1
          inc len
          inc si
          loop len_count_loop_h2d
          cmp cx,0
          je h2b2d_conversion 
          check_bx_h2d:
          cmp bx,0
          jne skipping_check_bx_h2d
          inc si
          loop len_count_loop_h2d
         
         
     h2b2d_conversion:
     
     mov bx,len
     dec bx
     mov cx,16
     sub cx,len
     mov si,cx
     mov offset,si
     add offset,bx
     
     h2d_calculation_loop:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_h2d_calculation_loop
          mov ax,1
          mov cx,bx
          cmp cx,0
          je two_power_zero_h2d
          jmp multiply_h2d
          two_power_zero_h2d:
               mov ax,1
               jmp LSB_done_h2d
          
          multiply_h2d:
               mul two
               loop multiply_h2d     
          
          LSB_done_h2d:
          mul temp
          dec bx
          
          adding_h2d:
               add sum,ax
          
          inc si
          jmp h2d_calculation_loop                 
     
     exit_h2d_calculation_loop:
     
     h2d_value_assign:
     
     printing_start_h2d:
     
     lea dx,output_dec
     mov ah,9
     int 21h
     mov dx,0
     
     cmp sum,10000
     jl less_than_10000_h2d
     mov ax,sum
     mov bx,10000
     div bx
     mov fifth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_10000_h2d:
     
     cmp sum,1000
     jl less_than_1000_h2d
     mov ax,sum
     mov bx,1000
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_1000_h2d:
     
     cmp sum,100
     jl less_than_100_h2d
     mov ax,sum
     mov bx,100
     div bx
     mov third_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_100_h2d:
     
     cmp sum,10
     jl less_than_10_h2d     
     mov ax,sum
     mov bx,10
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
     
     less_than_10_h2d:
     
     mov ax,sum
     mov first_bit,al
      
     add fifth_bit,30h
     add fourth_bit,30h
     add third_bit,30h
     add second_bit,30h
     add first_bit,30h
     
     fifth_h2d:
     
     cmp fifth_bit,30h
     je fourth_h2d
     mov dl,fifth_bit
     mov ah,2
     int 21h
     inc flag
     
     fourth_h2d:
     
     cmp flag,0
     jne skip_4_h2d
     cmp fourth_bit,30h
     je third_h2d
     skip_4_h2d:
     mov dl,fourth_bit
     mov ah,2
     int 21h
     inc flag
     
     third_h2d:
     
     cmp flag,0
     jne skip_3_h2d
     cmp third_bit,30h
     je second_h2d
     skip_3_h2d:
     mov dl,third_bit
     mov ah,2
     int 21h
     inc flag
     
     second_h2d:
     
     cmp flag,0
     jne skip_2_h2d
     cmp second_bit,30h
     je first_h2d
     skip_2_h2d:
     mov dl,second_bit
     mov ah,2
     int 21h
     inc flag
     
     first_h2d:
     
     cmp flag,0
     jne skip_1_h2d
     cmp first_bit,30h
     je sum_is_zero_h2d
     skip_1_h2d:
     mov dl,first_bit
     mov ah,2
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again   
     
     sum_is_zero_h2d:
     
     mov ah,2
     mov dl,30h
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
          
     jmp try_again
     
          
          
     start_h2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_h2o:
     
     lea dx,intro_h2o
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_hex
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_h2o_conversion:
     
     lea dx,input_hex
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_h2o:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_h2o
          sub al,30h
          cmp al,0
          jl error
          cmp al,9
          jle proper_hex_lt9_h2o
          cmp al,11h
          je A_h2o
          cmp al,31h
          je A_h2o
          cmp al,12h
          je B_h2o
          cmp al,32h
          je B_h2o
          cmp al,13h
          je C_h2o
          cmp al,33h
          je C_h2o
          cmp al,14h
          je D_h2o
          cmp al,34h
          je D_h2o
          cmp al,15h
          je E_h2o
          cmp al,35h
          je E_h2o
          cmp al,16h
          je F_h2o
          cmp al,36h
          je F_h2o
          jg error
          proper_hex_lt9_h2o:
          mov arr[si],al
          jmp point_h2o
          
          A_h2o:
          mov arr[si],10
          jmp point_h2o
          
          B_h2o:
          mov arr[si],11
          jmp point_h2o
          
          C_h2o:
          mov arr[si],12
          jmp point_h2o
          
          D_h2o:
          mov arr[si],13
          jmp point_h2o
          
          E_h2o:
          mov arr[si],14
          jmp point_h2o
          
          F_h2o:
          mov arr[si],15
          jmp point_h2o
          
          point_h2o:
          inc si
          inc len
          cmp len,4
          jg range_out_of_bound
          jmp input_loop_h2o
     
     exit_input_loop_h2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     cmp len,0
     je exit_octal_calculation_loop_h2o
     
     mov ax,len
     mov bx,4
     sub bx,ax
     mov si,bx
     mov di,0
     mov cx,len 
     hex_value_assign_to_hex_arr_h2o:
     mov al,arr[di]
     mov hex_arr[si],al
     inc di
     inc si
     loop hex_value_assign_to_hex_arr_h2o
     
     cmp hex_arr[0],7
     jg range_out_of_bound  
     
     binary_calculation_from_hex_h2o:
     mov cx,4
     mov si,0
     mov di,0
     mov dh,8
     mov bh,4
     mov bl,2
     mov dl,0
          
     hex_to_bi_h2o:
     mov ah,0
     mov al,hex_arr[si]
     div dh
     mov arr[di],al
     inc dl
     mov al,ah
     mov ah,0
     inc di     
     div bh
     mov arr[di],al
     inc dl
     mov al,ah
     mov ah,0
     inc di
     div bl
     mov arr[di],al
     inc dl
     inc di
     mov arr[di],ah
     inc dl
     inc di
     inc si
     loop hex_to_bi_h2o
     
     mov bx,0
     mov len,0
     len_count_h2o:
     mov si,0
     mov cl,dl
     mov ch,0
     len_count_loop_h2o: 
          cmp arr[si],0
          je check_bx_h2o
          skipping_check_bx_h2o:
          mov bx,1
          inc len
          inc si
          loop len_count_loop_h2o
          cmp cx,0
          je h2b2o_conversion 
          check_bx_h2o:
          cmp bx,0
          jne skipping_check_bx_h2o
          inc si
          loop len_count_loop_h2o
          
      
     
     h2b2o_conversion:
     
     mov sum,0
     mov bx,len
     dec bx
     mov cx,16
     sub cx,len
     mov si,cx
     mov offset,si
     add si,bx  
     mov bx,3
       
     octal_calculation_loop_h2o:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jl exit_octal_calculation_loop_h2o
          mov ax,1
          
          cmp bx,2 
          je cx_is_1_h2o
          cmp bx,1
          je cx_is_2_h2o
          jmp bx_is_3_h2o
          cx_is_1_h2o:
          mov cx,1
          
          jmp next_line_h2o
          cx_is_2_h2o:
          mov cx,2

          
          next_line_h2o:    
          bx_is_3_h2o:
          cmp bx,3
          

          je two_power_zero_oct_h2o
          jmp multiply_oct_h2o
          two_power_zero_oct_h2o:
               mov ax,1
               dec bx
               jmp LSB_done_oct_h2o
          
          multiply_oct_h2o:
               mul two
               loop multiply_oct_h2o
               
          dec bx
          LSB_done_oct_h2o:
          mul temp
          
          adding_oct_h2o:
               add sum,ax
          
          dec si
          cmp bx,0
          je assign_bx_3_h2o
          jmp pass_assign_h2o
          assign_bx_3_h2o:
          mov bx,3
          
          assigning_first_bit_oct_h2o:
          cmp first_bit_oct,8
          je assign_first_bit_oct_h2o
          jne assigning_second_bit_oct_h2o
          assign_first_bit_oct_h2o:
          mov dx,sum
          mov first_bit_oct,dx
          mov sum,0
          jmp pass_assign_h2o
          
          assigning_second_bit_oct_h2o:
          cmp second_bit_oct,8
          je assign_second_bit_oct_h2o
          jne assigning_third_bit_oct_h2o
          assign_second_bit_oct_h2o:
          mov dx,sum
          mov second_bit_oct,dx
          mov sum,0
          jmp pass_assign_h2o
          
          assigning_third_bit_oct_h2o:
          cmp third_bit_oct,8
          je assign_third_bit_oct_h2o
          jne assigning_fourth_bit_oct_h2o
          assign_third_bit_oct_h2o:
          mov dx,sum
          mov third_bit_oct,dx
          mov sum,0
          jmp pass_assign_h2o
          
          assigning_fourth_bit_oct_h2o:
          cmp fourth_bit_oct,8
          je assign_fourth_bit_oct_h2o
          jne assigning_fifth_bit_oct_h2o
          assign_fourth_bit_oct_h2o:
          mov dx,sum
          mov fourth_bit_oct,dx
          mov sum,0
          jmp pass_assign_h2o
          
          assigning_fifth_bit_oct_h2o:
          cmp first_bit_oct,8
          je assign_fifth_bit_oct_h2o
          assign_fifth_bit_oct_h2o:
          mov dx,sum
          mov fifth_bit_oct,dx
          mov sum,0
          
          
          pass_assign_h2o:
          jmp octal_calculation_loop_h2o                 
     
     exit_octal_calculation_loop_h2o:
     
     replacing_unused_bits_to_zero_h2o: 
     assign_first_bit_oct_zero_h2o:
     cmp first_bit_oct,8
     je first_bit_oct_zero_h2o
     jne assign_second_bit_oct_zero_h2o
     first_bit_oct_zero_h2o:
     mov dx,sum
     mov sum,0
     mov first_bit_oct,dx
     
     assign_second_bit_oct_zero_h2o:
     cmp second_bit_oct,8
     je second_bit_oct_zero_h2o
     jne assign_third_bit_oct_zero_h2o
     second_bit_oct_zero_h2o:
     mov dx,sum
     mov sum,0
     mov second_bit_oct,dx
     
     assign_third_bit_oct_zero_h2o:
     cmp third_bit_oct,8
     je third_bit_oct_zero_h2o
     jne assign_fourth_bit_oct_zero_h2o
     third_bit_oct_zero_h2o:
     mov dx,sum
     mov sum,0
     mov third_bit_oct,dx
     
     assign_fourth_bit_oct_zero_h2o:
     cmp fourth_bit_oct,8
     je fourth_bit_oct_zero_h2o
     jne assign_fifth_bit_oct_zero_h2o
     fourth_bit_oct_zero_h2o:
     mov dx,sum
     mov sum,0
     mov fourth_bit_oct,dx
     
     assign_fifth_bit_oct_zero_h2o:
     cmp fifth_bit_oct,8
     je fifth_bit_oct_zero_h2o
     jne octal_value_assign_and_print_h2o
     fifth_bit_oct_zero_h2o:
     mov dx,sum
     mov sum,0
     mov fifth_bit_oct,dx
     
     octal_value_assign_and_print_h2o:
     
     lea dx,output_oct
     mov ah,9
     int 21h
     mov dx,0
     
     cmp fifth_bit_oct,0
     je check_fourth_bit_h2o
     print_fifth_h2o:
     mov dx,fifth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_fourth_bit_h2o:
     cmp flag,0
     jne skip_04_h2o 
     cmp fourth_bit_oct,0
     je check_third_bit_h2o
     skip_04_h2o:
     mov dx,fourth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_third_bit_h2o:
     cmp flag,0
     jne skip_03_h2o 
     cmp third_bit_oct,0
     je check_second_bit_h2o
     skip_03_h2o:
     mov dx,third_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_second_bit_h2o:
     cmp flag,0
     jne skip_02_h2o 
     cmp second_bit_oct,0
     je check_first_bit_h2o
     skip_02_h2o:
     mov dx,second_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_first_bit_h2o:
     cmp flag,0
     jne skip_01_h2o 
     cmp first_bit_oct,0
     je sum_is_zero_oct_h2o
     skip_01_h2o:
     mov dx,first_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     jmp printing_done_oct_h2o
     
     sum_is_zero_oct_h2o:
     mov dl,30h
     mov ah,2
     int 21h
     
     printing_done_oct_h2o:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again    
          
          
          
     start_o2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_o2b:
     
     lea dx,intro_o2b
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_oct
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_oct_input_o2b:
     
     lea dx,input_oct
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_o2b:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_o2b
          sub al,30h
          cmp al,0
          jl error
          cmp al,7
          jle proper_o2b
          jg error
          proper_o2b:
          mov arr[si],al
          inc si
          inc len
          cmp len,5
          jg range_out_of_bound
          jmp input_loop_o2b
     
     exit_input_loop_o2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     cmp len,0
     je o2b_printing_start_o2b
     
     mov ax,len
     mov bx,5
     sub bx,ax
     mov si,bx
     mov di,0
     mov cx,len 
     oct_value_assign_to_oct_arr_o2b:
     mov al,arr[di]
     mov oct_arr[si],al
     inc di
     inc si
     loop oct_value_assign_to_oct_arr_o2b
     
     binary_calculation_from_oct_o2b:
     mov cx,5
     mov si,0
     mov di,0
     mov bh,4
     mov bl,2
          
     oct_to_bi_o2b:
     mov ah,0
     mov al,oct_arr[si]     
     div bh
     mov arr[di],al
     mov al,ah
     mov ah,0
     inc di
     div bl
     mov arr[di],al
     inc di
     mov arr[di],ah
     inc di
     inc si
     loop oct_to_bi_o2b
     
     o2b_printing_start_o2b:
     
     lea dx,output_bi
     mov ah,9
     int 21h 
     
     mov cx,5
     mov si,0
     is_o2b_sum_zero_loop_o2b:
     mov ah,oct_arr[si]
     cmp ah,0
     jne o2b_sum_is_not_zero_o2b
     inc si
     loop is_o2b_sum_zero_loop_o2b
     mov dl,30h
     mov ah,2
     int 21h
     jmp o2b_printing_done_o2b
     
     o2b_sum_is_not_zero_o2b:
     
     mov cx,15
     mov si,0
     printing_oct_o2b:
     mov ah,2 
     mov dl,arr[si]
     cmp flag,0
     jne skipping_skip_o2b
     cmp dl,0
     je skip_prining_oct_o2b
     skipping_skip_o2b:
     add dl,30h
     int 21h
     inc flag
     skip_prining_oct_o2b:
     inc si
     loop printing_oct_o2b
     
     o2b_printing_done_o2b:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again
     
     
     start_o2d:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_o2d:
     
     lea dx,intro_o2d
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_oct
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_oct_input_o2d:
     
     lea dx,input_oct
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_oct_o2d:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_oct_o2d
          sub al,30h
          cmp al,0
          jl error
          cmp al,7
          jle proper_oct_o2d
          jg error
          proper_oct_o2d:
          mov arr[si],al
          inc si
          inc len
          cmp len,5
          jg range_out_of_bound
          jmp input_loop_oct_o2d
     
     exit_input_loop_oct_o2d:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     cmp len,0
     je printing_start_o2d
     
     mov ax,len
     mov bx,5
     sub bx,ax
     mov si,bx
     mov di,0
     mov cx,len 
     oct_value_assign_to_oct_arr_o2d:
     mov al,arr[di]
     mov oct_arr[si],al
     inc di
     inc si
     loop oct_value_assign_to_oct_arr_o2d
     
     binary_calculation_from_oct_o2d:
     mov cx,5
     mov si,0
     mov di,0
     mov bh,4
     mov bl,2
     mov dl,0
          
     oct_to_bi_o2d:
     mov ah,0
     mov al,oct_arr[si]     
     div bh
     mov arr[di],al
     inc dl
     mov al,ah
     mov ah,0
     inc di
     div bl
     mov arr[di],al
     inc dl
     inc di
     mov arr[di],ah
     inc dl
     inc di
     inc si
     loop oct_to_bi_o2d
        
     mov bx,0
     mov len,0
     len_count_o2d:
     mov si,0
     mov cl,dl
     mov ch,0
     len_count_loop_o2d: 
          cmp arr[si],0
          je check_bx_o2d
          skipping_check_bx_o2d:
          mov bx,1
          inc len
          inc si
          loop len_count_loop_o2d
          cmp cx,0
          je o2b2d_conversion 
          check_bx_o2d:
          cmp bx,0
          jne skipping_check_bx_o2d
          inc si
          loop len_count_loop_o2d
          
          
     o2b2d_conversion:
     
     mov sum,0
     mov bx,len
     dec bx
     mov cx,15
     sub cx,len
     mov si,cx
     mov offset,si
     add offset,bx  
       
     o2d_calculation_loop:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_o2d_calculation_loop
          mov ax,1
          mov cx,bx
          cmp cx,0
          je two_power_zero_o2d
          jmp multiply_o2d
          two_power_zero_o2d:
               mov ax,1
               jmp LSB_done_o2d
          
          multiply_o2d:
               mul two
               loop multiply_o2d     
          
          LSB_done_o2d:
          mul temp
          dec bx
          
          adding_o2d:
               add sum,ax
          
          inc si
          jmp o2d_calculation_loop                 
     
     exit_o2d_calculation_loop:
     
     o2d_value_assign:
     
     printing_start_o2d:
     
     lea dx,output_dec
     mov ah,9
     int 21h
     mov dx,0
     
     cmp sum,10000
     jl less_than_10000_o2d
     mov ax,sum
     mov bx,10000
     div bx
     mov fifth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_10000_o2d:
     
     cmp sum,1000
     jl less_than_1000_o2d
     mov ax,sum
     mov bx,1000
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_1000_o2d:
     
     cmp sum,100
     jl less_than_100_o2d
     mov ax,sum
     mov bx,100
     div bx
     mov third_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_100_o2d:
     
     cmp sum,10
     jl less_than_10_o2d     
     mov ax,sum
     mov bx,10
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
     
     less_than_10_o2d:
     
     mov ax,sum
     mov first_bit,al
      
     add fifth_bit,30h
     add fourth_bit,30h
     add third_bit,30h
     add second_bit,30h
     add first_bit,30h
     
     fifth_o2d:
     
     cmp fifth_bit,30h
     je fourth_o2d
     mov dl,fifth_bit
     mov ah,2
     int 21h
     inc flag
     
     fourth_o2d:
     
     cmp flag,0
     jne skip_4_o2d
     cmp fourth_bit,30h
     je third_o2d
     skip_4_o2d:
     mov dl,fourth_bit
     mov ah,2
     int 21h
     inc flag
     
     third_o2d:
     
     cmp flag,0
     jne skip_3_o2d
     cmp third_bit,30h
     je second_o2d
     skip_3_o2d:
     mov dl,third_bit
     mov ah,2
     int 21h
     inc flag
     
     second_o2d:
     
     cmp flag,0
     jne skip_2_o2d
     cmp second_bit,30h
     je first_o2d
     skip_2_o2d:
     mov dl,second_bit
     mov ah,2
     int 21h
     inc flag
     
     first_o2d:
     
     cmp flag,0
     jne skip_1_o2d
     cmp first_bit,30h
     je sum_is_zero_o2d
     skip_1_o2d:
     mov dl,first_bit
     mov ah,2
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     jmp try_again   
     
     sum_is_zero_o2d:
     
     mov ah,2
     mov dl,30h
     int 21h
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
          
     jmp try_again
     
     
     
     start_o2h:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     start_intro_o2h:
     
     lea dx,intro_o2h
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit_oct
     mov ah,9
     int 21h       
            
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     start_oct_input_o2h:
     
     lea dx,input_oct
     mov ah,9
     int 21h
       
     mov si,0
     
     input_loop_oct_o2h:
          mov ah,1
          int 21h         
          cmp al,0dh
          je exit_input_loop_oct_o2h
          sub al,30h
          cmp al,0
          jl error
          cmp al,7
          jle proper_oct_o2h
          jg error
          proper_oct_o2h:
          mov arr[si],al
          inc si
          inc len
          cmp len,5
          jg range_out_of_bound
          jmp input_loop_oct_o2h
     
     exit_input_loop_oct_o2h:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     cmp len,0
     je printing_start_o2h
     
     mov ax,len
     mov bx,5
     sub bx,ax
     mov si,bx
     mov di,0
     mov cx,len 
     oct_value_assign_to_oct_arr_o2h:
     mov al,arr[di]
     mov oct_arr[si],al
     inc di
     inc si
     loop oct_value_assign_to_oct_arr_o2h
     
     binary_calculation_from_oct_o2h:
     mov cx,5
     mov si,0
     mov di,0
     mov bh,4
     mov bl,2
     mov dl,0
          
     oct_to_bi_o2h:
     mov ah,0
     mov al,oct_arr[si]     
     div bh
     mov arr[di],al
     inc dl
     mov al,ah
     mov ah,0
     inc di
     div bl
     mov arr[di],al
     inc dl
     inc di
     mov arr[di],ah
     inc dl
     inc di
     inc si
     loop oct_to_bi_o2h
        
     mov bx,0
     mov len,0
     len_count_o2h:
     mov si,0
     mov cl,dl
     mov ch,0
     len_count_loop_o2h: 
          cmp arr[si],0
          je check_bx_o2h
          skipping_check_bx_o2h:
          mov bx,1
          inc len
          inc si
          loop len_count_loop_o2h
          cmp cx,0
          je o2b2h_conversion 
          check_bx_o2h:
          cmp bx,0
          jne skipping_check_bx_o2h
          inc si
          loop len_count_loop_o2h
          
          
     o2b2h_conversion:
     
     mov sum,0
     mov bx,len
     dec bx
     mov cx,15
     sub cx,len
     mov si,cx
     mov offset,si
     add offset,bx  
       
     o2h_calculation_loop:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jg exit_o2h_calculation_loop
          mov ax,1
          mov cx,bx
          cmp cx,0
          je two_power_zero_o2h
          jmp multiply_o2h
          two_power_zero_o2h:
               mov ax,1
               jmp LSB_done_o2h
          
          multiply_o2h:
               mul two
               loop multiply_o2h     
          
          LSB_done_o2h:
          mul temp
          dec bx
          
          adding_o2h:
               add sum,ax
          
          inc si
          jmp o2h_calculation_loop                 
     
     exit_o2h_calculation_loop:
     
     o2h_value_assign:
     
     printing_start_o2h:
     
     lea dx,output_hex
     mov ah,9
     int 21h
     mov dx,0
     
     mov dx,0
     cmp sum,1000h
     jl less_than_1000h_o2h
     mov ax,sum
     mov bx,1000h
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_1000h_o2h:
     
     cmp sum,100h
     jl less_than_100h_o2h
     mov ax,sum
     mov bx,100h
     div bx
     mov third_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_100h_o2h:
     
     cmp sum,10h
     jl less_than_10h_o2h
     mov ax,sum
     mov bx,10h
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_10h_o2h:
     
     cmp sum,1h
     mov ax,sum
     mov first_bit,al     
     
     lea si,hex_arr
     
     placement_o2h:
     mov al,fourth_bit
     mov [si],al
     inc si
     mov al,third_bit
     mov [si],al
     inc si
     mov al,second_bit
     mov [si],al
     inc si
     mov al,first_bit
     mov [si],al
     
     cmp fourth_bit,0
     jne result_is_not_zero_o2h
     cmp third_bit,0
     jne result_is_not_zero_o2h
     cmp second_bit,0
     jne result_is_not_zero_o2h
     cmp first_bit,0
     jne result_is_not_zero_o2h
     
     result_is_zero_o2h:
     mov dl,30h
     mov ah,2
     int 21h
     jmp printing_done_o2h  
     
     result_is_not_zero_o2h:
     
     lea si,hex_arr
     mov cx,4
     
     print_o2h:
          mov ah,2
          cmp [si],9
          jle less_than_9_o2h
          cmp [si],0AH
          je A_o2h
          cmp [si],0BH
          je B_o2h
          cmp [si],0CH
          je C_o2h
          cmp [si],0DH
          je D_o2h
          cmp [si],0EH
          je E_o2h
          cmp [si],0FH
          je F_o2h
          
          less_than_9_o2h:
          mov dl,[si]
          add dl,30h
          cmp dl,30h
          jne printing_o2h
          cmp flag,0
          je skip_o2h
          printing_o2h:
          int 21h
          inc flag
          skip_o2h:
          inc si
          loop print_o2h
          jmp printing_done_o2h
          
          A_o2h:
          mov dl,41H
          int 21h
          inc si
          inc flag
          loop print_o2h
          jmp printing_done_o2h
          
          B_o2h:
          mov dl,42H
          int 21h
          inc si
          inc flag
          loop print_o2h
          jmp printing_done_o2h
          
          C_o2h:
          mov dl,43H
          int 21h
          inc si
          inc flag
          loop print_o2h
          jmp printing_done_o2h
          
          D_o2h:
          mov dl,44H
          int 21h
          inc si
          inc flag
          loop print_o2h
          jmp printing_done_o2h
          
          E_o2h:
          mov dl,45H
          int 21h
          inc si
          inc flag
          loop print_o2h
          jmp printing_done_o2h
          
          F_o2h:
          mov dl,46H
          int 21h
          inc si
          inc b2h
          loop print_o2h
              
     printing_done_o2h:
     
     mov ah,2
     mov dl,'h'
     int 21h
     
     o2h_end:
         
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
          
     jmp try_again          
     
     error:
     
          mov ah,2
          mov dl,0ah
          int 21h
          mov dl,0dh
          int 21h
          
          lea dx, wrong_input_str
          mov ah,9
          int 21h
          
          mov ah,2
          mov dl,0ah
          int 21h
          mov dl,0dh
          int 21h
          jmp try_again
          
          range_out_of_bound:
          
          mov ah,2
          mov dl,0ah
          int 21h
          mov dl,0dh
          int 21h
          
          lea dx, range_out_of_bound_str
          mov ah,9
          int 21h
          
          mov ah,2
          mov dl,0ah
          int 21h
          mov dl,0dh
          int 21h
          
          try_again:
          
          lea dx, try_again_str
          mov ah,9
          int 21h
          
          mov ah,2
          mov dl,20h
          int 21h
               
          mov ah,1
          int 21h
          
          cmp al,'1'
          je reset_all_vars
          cmp al,'0'
          je end
          jne error
          
          reset_all_vars:
          mov cx,5
          mov si,0
          resetting_oct_arr:
          mov dl,0
          mov oct_arr[si],dl
          inc si
          loop resetting_oct_arr
          
          mov cx,4
          mov si,0
          resetting_hex_arr:
          mov dl,0
          mov hex_arr[si],dl
          inc si
          loop resetting_hex_arr
          
          mov len,0
          mov sum,0h
          mov fifth_bit,0
          mov fourth_bit,0
          mov third_bit,0
          mov second_bit,0
          mov first_bit,0
          mov fifth_bit_oct,8
          mov fourth_bit_oct,8
          mov third_bit_oct,8
          mov second_bit_oct,8
          mov first_bit_oct,8
          mov flag,0
          mov offset,0000
          jmp option_start:          
     
     end:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov ah,2
     mov dl,1h
     int 21h
     mov dl,20h
     int 21h
     mov ah,2
     mov dl,1h
     int 21h
     mov ah,2
     mov dl,20h
     int 21h        
     lea dx,outro
     mov ah,9
     int 21h
     mov ah,2
     mov dl,20h
     int 21h
     mov ah,2
     mov dl,1h
     int 21h
     mov dl,20h
     int 21h
     mov ah,2
     mov dl,1h
     int 21h
     
     MAIN ENDP
END MAIN 
