%macro io 4
    mov rax, %1
    mov rdi, %2
    mov rsi, %3
    mov rdx, %4
    syscall
%endmacro

%macro close_file 1
    mov rax, 3
    mov rdi, %1
    syscall
%endmacro

%macro fileopen 1
    mov rax, 2
    mov rdi, %1
    mov rsi, 42h
    mov rdx, 644o
    syscall
    mov r8,rax
%endmacro

%macro fileread 2
    mov rax, 0
    mov rdi, %1             ;file descriptor
    mov rsi, %2             ;buffer address
    mov rdx, 100            ;buffer size
    syscall
    mov r9, rax             ;number of characters read from file
%endmacro

%macro filewrite 3
    mov rax, 1
    mov rdi, %1
    mov rsi, %2
    mov rdx, %3
    syscall
%endmacro

%macro filedelete 1
    mov rax, 87
    mov rdi, %1             ;filename
    syscall
%endmacro

%macro exit 0
    mov rax, 60
    mov rdi, 0
    syscall
%endmacro

section .data
    menu db "1. TYPE",10,"2. COPY",10,"3. DELETE",10
    menulen equ $-menu

    done db "DONE",10
    donel equ $-done

    txt db "Write this to file",10
    textlen equ $-txt

section .bss
    fname1 resb 20
    fname2 resb 20
    buffer resb 100
    choice resb 2

section .text
global _start
_start:
    mov rsi, [rsp+16]
    mov rdi, fname1
    call getarg
    
    mov rsi, [rsp+24]
    mov rdi, fname2
    call getarg

    io 1,1,menu,menulen
    io 0,0,choice,2

    cmp byte[choice], "1"
    je case1

    cmp byte[choice], "2"
    je case2

    cmp byte[choice], "3"
    je case3

    case1:
        call type
        exit

    case2:
        call copy
        exit

    case3:
        call delete
        exit
    exit

type:
    fileopen fname1
    fileread r8,buffer
    io 1,1,buffer,r9
    close_file r8
    ret

copy:
    fileopen fname1
    fileread r8, buffer
    close_file r8
    fileopen fname2
    filewrite r8, buffer, r9
    close_file r8
    ret

delete:
    filedelete fname1
    ret

;put arg in rsi
;put buffer where to transfer arg in rdi
;length of arg string is in rcx
getarg:
    mov rcx,0
    next1:
        mov al,[rsi]
        mov [rdi], al
        cmp al,0
        je endloop
        inc rsi
        inc rdi
        inc rcx
        jmp next1
    endloop:
        ret
