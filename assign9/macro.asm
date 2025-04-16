; macro.asm - Macros for Linux syscalls

%macro Print 2
    mov rax, 1          ; syscall: write
    mov rdi, 1          ; stdout
    mov rsi, %1         ; buffer
    mov rdx, %2         ; length
    syscall
%endmacro

%macro Accept 2
    mov rax, 0          ; syscall: read
    mov rdi, 0          ; stdin
    mov rsi, %1
    mov rdx, %2
    syscall
%endmacro

%macro fopen 1
    mov rax, 2          ; syscall: open
    mov rdi, %1         ; filename pointer
    mov rsi, 0          ; read-only
    syscall
%endmacro

%macro fread 3
    mov rax, 0          ; syscall: read
    mov rdi, %1         ; file descriptor
    mov rsi, %2         ; buffer
    mov rdx, %3         ; size
    syscall
%endmacro

%macro fwrite 3
    mov rax, 1          ; syscall: write
    mov rdi, %1         ; file descriptor
    mov rsi, %2         ; buffer
    mov rdx, %3         ; size
    syscall
%endmacro

%macro fclose 1
    mov rax, 3          ; syscall: close
    mov rdi, %1
    syscall
%endmacro

%macro fcreate 1
    mov rax, 2              ; syscall: open
    mov rdi, %1             ; filename
    mov rsi, 577o           ; O_WRONLY | O_CREAT | O_TRUNC
    mov rdx, 0644o          ; permissions
    syscall
%endmacro

%macro fdelete 1
    mov rax, 87             ; syscall: unlink
    mov rdi, %1
    syscall
%endmacro

