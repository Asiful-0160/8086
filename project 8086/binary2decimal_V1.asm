.MODEL SMALL
.STACK 100H
.DATA
     
     intro db "BINARY TO DECIMAL CONVERTER$"
     limit db "THIS PROGRAM CAN CONVERT UPTO 9-BIT BINARY VALUE$"
     input db "Insert a binary value: $"
     output db "Decimal equivalent value is: $"
     wrong_input_str db "Please insert 1s' or 0s' only.$"
     try_again_str db "Do you want to try again? [1/0]$"
     range_out_of_bound_str db "Sorry, input range out of bound.$"
     outro db "THANK YOU$"
     
     arr db 255 dup(?)
     
     two db 2     
     sum dw ?
     len dw 0
     offset dw ?
     temp dw ?
     
     MSB db ?
     MB db ?
     LSB db ? 
     
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
          cmp len,9
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
     mov ah,2
     lea si,arr
     mov offset,si
     add offset,bx
     
     output_loop:
     
          mov dl,[si]
          mov dh,0
          mov temp,dx
          ;add dl,30h
          cmp si,offset
          jg exit_output_loop
          ;mov ah,2
          ;int 21h
          mov al,1
          mov cx,bx
          cmp cx,0
          je two_power_zero
          jmp multiply
          two_power_zero:
               mov ax,1
               jmp LSB_done
          
          multiply:
               mul two
               loop multiply     
          
          LSB_done:
          mul temp
          dec bx
          
          adding:
               add sum,ax
          
          inc si
          jmp output_loop                 
     
     exit_output_loop:
     
     print:
     
     lea dx,output
     mov ah,9
     int 21h
     mov bx,sum
     cmp bx,100
     jl less_than_100
     mov ax,bx
     mov bl,100
     div bl
     mov MSB, al
     add MSB,30h
     mov bl,ah
          
     less_than_100:
     
     cmp bl,10
     jl less_than_10     
     mov al,bl
     mov ah,0
     mov bl,10
     div bl
     mov MB, al
     add MB,30h
     mov bl,ah
     
     less_than_10:
     
     mov LSB,bl
     add LSB,30h
     
     C_MSB:
     
     cmp MSB,0
     je C_MB
     mov dl,MSB
     mov ah,2
     int 21h
     
     C_MB:
     
     cmp MB,0
     je was_MSB_zero
     mov dl,MB
     mov ah,2
     int 21h
     
     C_LSB:
     
     cmp LSB,0
     je sum_is_zero
     mov dl,LSB
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
     
     was_MSB_zero:
     
     cmp MSB,0
     je C_LSB
     mov ah,2
     mov dl,30h
     int 21h
     jmp C_LSB
     
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
          mov MSB,0
          mov MB,0
          mov LSB,0
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
