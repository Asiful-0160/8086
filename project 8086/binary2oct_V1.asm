.MODEL SMALL
.STACK 100H
.DATA
     
     first_prompt db 0
     intro db "BINARY TO OCTAL CONVERTER$"
     limit db "THIS PROGRAM CAN CONVERT UPTO 15-BIT BINARY VALUE$"
     input db "Insert a binary value: $"
     output db "Decimal equivalent value is: $"
     wrong_input_str db "Please insert 1s' and 0s' only.$"
     try_again_str db "Do you want to try again? [1/0]$"
     range_out_of_bound_str db "Sorry, input range out of bound.$"
     outro db "THANK YOU$"
     
     arr db 255 dup(?)
     oct_arr db 5 dup(0)
     
     two dw 2
          
     sum dw ?
     len dw 0
     offset dw ?
     temp dw ?
     bx_alt dw ?
     
     flag db 0
     fifth_bit_oct dw 8
     fourth_bit_oct dw 8
     third_bit_oct dw 8
     second_bit_oct dw 8
     first_bit_oct dw 8  
     
.CODE
     MAIN PROC
     MOV AX,@DATA
     MOV DS,AX
     
     code_start:
     
     cmp first_prompt,0
     je option_part
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
                 
     option_part:
     mov first_prompt,1
     
     lea dx,intro
     mov ah,9
     int 21h

     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h
     
     lea dx,limit
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
     
     start_bi_input:
     
     lea dx,input
     mov ah,9
     int 21h
     
     mov ah,1  
     mov si,0
     
     input_loop:
          int 21h         
          cmp al,0dh
          je exit_input_loop
          sub al,30h
          cmp al,0
          je proper
          cmp al,1
          je proper
          jne error
          proper:
          mov arr[si],al
          inc si
          inc len
          cmp len,15
          jg range_out_of_bound
          jmp input_loop
     
     exit_input_loop:
     
     mov ah,2
     mov dl,0ah
     int 21h
     mov dl,0dh
     int 21h     
     
     mov bx,len
     dec bx
     mov si,0
     mov offset,si
     add si,bx
     mov bx,3 
     
     octal_calculation_loop:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jl exit_octal_calculation_loop
          mov ax,1
          
          cmp bx,2 
          je cx_is_1
          cmp bx,1
          je cx_is_2
          jmp bx_is_3
          cx_is_1:
          mov cx,1
          
          jmp next_line
          cx_is_2:
          mov cx,2

          
          next_line:    
          bx_is_3:
          cmp bx,3
          

          je two_power_zero
          jmp multiply
          two_power_zero:
               mov ax,1
               dec bx
               jmp LSB_done
          
          multiply:
               mul two
               loop multiply
               
          dec bx
          LSB_done:
          mul temp
          
          adding:
               add sum,ax
          
          dec si
          cmp bx,0
          je assign_bx_3
          jmp pass_assign
          assign_bx_3:
          mov bx,3
          
          assigning_first_bit_oct:
          cmp first_bit_oct,8
          je assign_first_bit_oct
          jne assigning_second_bit_oct
          assign_first_bit_oct:
          mov dx,sum
          mov first_bit_oct,dx
          mov sum,0
          jmp pass_assign
          
          assigning_second_bit_oct:
          cmp second_bit_oct,8
          je assign_second_bit_oct
          jne assigning_third_bit_oct
          assign_second_bit_oct:
          mov dx,sum
          mov second_bit_oct,dx
          mov sum,0
          jmp pass_assign
          
          assigning_third_bit_oct:
          cmp third_bit_oct,8
          je assign_third_bit_oct
          jne assigning_fourth_bit_oct
          assign_third_bit_oct:
          mov dx,sum
          mov third_bit_oct,dx
          mov sum,0
          jmp pass_assign
          
          assigning_fourth_bit_oct:
          cmp fourth_bit_oct,8
          je assign_fourth_bit_oct
          jne assigning_fifth_bit_oct
          assign_fourth_bit_oct:
          mov dx,sum
          mov fourth_bit_oct,dx
          mov sum,0
          jmp pass_assign
          
          assigning_fifth_bit_oct:
          cmp first_bit_oct,8
          je assign_fifth_bit_oct
          assign_fifth_bit_oct:
          mov dx,sum
          mov fifth_bit_oct,dx
          mov sum,0
          
          
          pass_assign:
          jmp octal_calculation_loop                 
     
     exit_octal_calculation_loop:
     
     replacing_unused_bits_to_zero: 
     assign_first_bit_oct_zero:
     cmp first_bit_oct,8
     je first_bit_oct_zero
     jne assign_second_bit_oct_zero
     first_bit_oct_zero:
     mov dx,sum
     mov sum,0
     mov first_bit_oct,dx
     
     assign_second_bit_oct_zero:
     cmp second_bit_oct,8
     je second_bit_oct_zero
     jne assign_third_bit_oct_zero
     second_bit_oct_zero:
     mov dx,sum
     mov sum,0
     mov second_bit_oct,dx
     
     assign_third_bit_oct_zero:
     cmp third_bit_oct,8
     je third_bit_oct_zero
     jne assign_fourth_bit_oct_zero
     third_bit_oct_zero:
     mov dx,sum
     mov sum,0
     mov third_bit_oct,dx
     
     assign_fourth_bit_oct_zero:
     cmp fourth_bit_oct,8
     je fourth_bit_oct_zero
     jne assign_fifth_bit_oct_zero
     fourth_bit_oct_zero:
     mov dx,sum
     mov sum,0
     mov fourth_bit_oct,dx
     
     assign_fifth_bit_oct_zero:
     cmp fifth_bit_oct,8
     je fifth_bit_oct_zero
     jne octal_value_assign_and_print
     fifth_bit_oct_zero:
     mov dx,sum
     mov sum,0
     mov fifth_bit_oct,dx
     
     octal_value_assign_and_print:
     
     lea dx,output
     mov ah,9
     int 21h
     mov dx,0
     
     cmp fifth_bit_oct,0
     je check_fourth_bit
     print_fifth:
     mov dx,fifth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_fourth_bit:
     cmp flag,0
     jne skip_04 
     cmp fourth_bit_oct,0
     je check_third_bit
     skip_04:
     mov dx,fourth_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_third_bit:
     cmp flag,0
     jne skip_03 
     cmp third_bit_oct,0
     je check_second_bit
     skip_03:
     mov dx,third_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_second_bit:
     cmp flag,0
     jne skip_02 
     cmp second_bit_oct,0
     je check_first_bit
     skip_02:
     mov dx,second_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     mov flag,1
     
     check_first_bit:
     cmp flag,0
     jne skip_01 
     cmp first_bit_oct,0
     je sum_is_zero
     skip_01:
     mov dx,first_bit_oct
     add dx,30h
     mov ah,2
     int 21h
     jmp printing_done
     
     sum_is_zero:
     mov dl,30h
     mov ah,2
     int 21h
     
     printing_done:
     
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
          jne range_out_of_bound
          
          reset_all_vars:
          mov len,0
          mov sum,0h
          mov fifth_bit_oct,8
          mov fourth_bit_oct,8
          mov third_bit_oct,8
          mov second_bit_oct,8
          mov first_bit_oct,8
          mov flag,0
          jmp code_start:
     
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
