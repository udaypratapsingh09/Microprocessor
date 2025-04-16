    io 1,1,msg2,msg2len

    print_dest:
        mov rdi,dest
        mov rcx,5
        next2:
            mov rbx,rdi
            push rcx
            push rdi
            call hex_ascii64
            io 1,1,arrow,arrowlen
            pop rdi
            mov bl,[rdi]
            push rdi
            call hex_ascii8
            io 1,1,newline,1
            pop rdi
            pop rcx
            inc rdi
            loop next2