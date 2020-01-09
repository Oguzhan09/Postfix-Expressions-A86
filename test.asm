myread:
 mov cx,0 ;assign 0 to cx reg
morechar: ;this function 
 mov ah,01h
 int 21H
 mov dx,0 ;assign 0 to dx reg
 mov dl,al ;assign al to dl
 mov ax,cx ;assign cx reg to ax reg
 
 cmp dl,20H ;compare input equal "space" or not equal
 je pushing ;jump pushing function
 
 mov bp,dx ;assign dx to bp
 
 cmp dl,2Bh ;compare input equal '+' or not 
 je addition ;jump addition function
 
 cmp dl,'*' ;compare input equal '*' or not
 je multiplication ;jump multiplication function
 
 cmp dl,2Fh ;compare input equal '/' or not
 je division ;jump division function
 
 cmp dl,5eh ;compare input equal '^' or not
 je xor1 ;jump xor1 function
 
 cmp dl,26h ;compare input equal '&' or not
 je and1 ;jump and1 function
 
 cmp dl,7Ch ;compare input equal '|' or not
 je or1 ;jump or1 function
 
 cmp dl,0D ;compare input equal "enter" or not
 je myprint ;jump myprint function
 
 cmp dx,41H ;compare input equal 'A' or not 
 jge letter ; if char value of input greater than A jump letter function

 sub dx,48d ;else subtract 48
 jmp shift ;jump shift function 
 
letter: ;if input is letter like A,B,C etc. 
 sub dx,55d ;subtract 55

shift: ;this function takes input and create its hex value 
 mov bp,dx
 mov ax,cx
 mov cx,16d
 mul cx
 add ax,bp ;
 mov cx,ax
 jmp morechar
  
pushing: ;this function push all inputs to stack if inputs are numbers (not operation sign, space, enter, etc.)
 cmp bp,2Bh
 je myread
 cmp bp,2Ah
 je myread
 cmp bp,2Fh
 je myread
 cmp bp,5eh
 je myread
 cmp bp,26h
 je myread
 cmp bp,7Ch
 je myread
 push cx
 jmp myread
 
addition: ;this function take 2 value from stack and make addition
 pop ax
 pop cx
 add cx,ax
 push cx
 jmp myread

multiplication: ;this function take 2 value from stack and make multiplication
 pop cx
 pop ax
 mul cx
 push ax
 jmp myread

division: ;this function take 2 value from stack and make division
 mov dx,0
 pop cx
 pop ax
 idiv cx
 push ax
 jmp myread
 
xor1: ;this function take 2 value from stack and make xor operation
 pop ax
 pop cx
 xor ax,cx
 push ax
 jmp myread

and1: ;this function take 2 value from stack and make and operation
 pop ax
 pop cx
 and ax,cx
 push ax
 jmp myread

or1: ;this function take 2 value from stack and make or operation
 pop ax
 pop cx
 or ax,cx
 push ax
 jmp myread
 
myprint: ;this function print output
 pop ax  ;take last value from stack
 mov bx,ax
 mov cx,4h
 mov ah,2h

loop1: ;take step by step number and convert hex from the decimal
 mov dx,0fh
 rol bx,4h
 and dx,bx
 cmp dl,0ah
 jae hexdigit
 add dl,'0'
 jmp output

hexdigit:
 add dl,'A'
 sub dl,0ah

output: ;create output 
 int 21h
 dec cx
 jnz loop1

endloop2: ;finish the execution
 int 20h
