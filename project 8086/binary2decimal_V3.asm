.MODEL SMALL
.STACK 100H
.DATA
     
     intro db "BINARY TO DECIMAL CONVERTER$"
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
     fifth_bit db ?
     fourth_bit db ?
     third_bit db ?
     second_bit db ?
     first_bit db ? 
     
.CODE
     MAIN PROC
     MOV AX,@DATA
     MOV DS,AX
     
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
            
     start:
     
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
     mov bx,3 ;mov cx,3
     
     decimal_calculation_loop:
     
          mov dl,arr[si]
          mov dh,0
          mov temp,dx
          cmp si,offset
          jl exit_decimal_calculation_loop
          mov ax,1
          
          cmp bx,2 ;cmp cx,2
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
          je assign_cx_3
          jmp pass_assign
          assign_cx_3:
          mov bx,3
          pass_assign:
          
          
          jmp decimal_calculation_loop                 
     
     exit_decimal_calculation_loop:
     
     decimal_value_assign:
     
     lea dx,output
     mov ah,9
     int 21h
     mov dx,0
     
     cmp sum,10000
     jl less_than_10000
     mov ax,sum
     mov bx,10000
     div bx
     mov fifth_bit,al
     mov sum,dx
     mov dx,0
     
     less_than_10000:
     
     cmp sum,1000
     jl less_than_1000
     mov ax,sum
     mov bx,1000
     div bx
     mov fourth_bit,al
     mov sum,dx
     mov dx,0 
     
     less_than_1000:
     
     cmp sum,100
     jl less_than_100
     mov ax,sum
     mov bx,100
     div bx
     mov third_bit, al
     mov sum,dx
     mov dx,0
          
     less_than_100:
     
     cmp sum,10
     jl less_than_10     
     mov ax,sum
     mov bx,10
     div bx
     mov second_bit, al
     mov sum,dx
     mov dx,0
     
     less_than_10:
     
     mov ax,sum
     mov first_bit,al
      
     add fifth_bit,30h
     add fourth_bit,30h
     add third_bit,30h
     add second_bit,30h
     add first_bit,30h
     
     fifth:
     
     cmp fifth_bit,30h
     je fourth
     mov dl,fifth_bit
     mov ah,2
     int 21h
     inc flag
     
     fourth:
     
     cmp flag,0
     jne skip_4
     cmp fourth_bit,30h
     je third
     skip_4:
     mov dl,fourth_bit
     mov ah,2
     int 21h
     inc flag
     
     third:
     
     cmp flag,0
     jne skip_3
     cmp third_bit,30h
     je second
     skip_3:
     mov dl,third_bit
     mov ah,2
     int 21h
     inc flag
     
     second:
     
     cmp flag,0
     jne skip_2
     cmp second_bit,30h
     je first
     skip_2:
     mov dl,second_bit
     mov ah,2
     int 21h
     inc flag
     
     first:
     
     cmp flag,0
     jne skip_1
     cmp first_bit,30h
     je sum_is_zero
     skip_1:
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
     
     sum_is_zero:
     
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
          mov bl,al
          
          cmp bl,'1'
          mov ah,2
          mov dl,0ah
          int 21h
          mov dl,0dh
          int 21h
          mov len,0
          mov ah,2
          mov dl,0ah
          int 21h
          mov dl,0dh
          int 21h
          
          mov len,0
          mov sum,0h
          mov fifth_bit,0
          mov fourth_bit,0
          mov third_bit,0
          mov second_bit,0
          mov first_bit,0
          mov flag,0
          je start:
          
          cmp bl,'0'
          je end
     
     end:
     
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
