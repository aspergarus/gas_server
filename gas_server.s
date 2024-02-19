    .data
addr:
    .hword 2
    .hword 0x1010
    .word 0
    .quad 0
buffer: .zero 256 
buffer2: .zero 256
path: .asciz "../index.html"

.text
.global _start
_start:
    mov $2,  %rdi # af_inet = 2
    mov $1,  %rsi # sock_stream = 1
    mov $0,  %rdx
    mov $41, %rax # socket = 41
    syscall

    mov %rax,  %r12 # ; socket fd
    mov %r12,  %rdi
    mov $addr, %rsi
    mov $16,   %rdx
    mov $49,   %rax # bind = 49
    syscall

    mov %r12, %rdi
    mov $10,  %rsi
    mov $50,  %rax # listen = 50
    syscall

accept_loop:

    mov %r12, %rdi
    mov $0,   %rsi
    mov $0,   %rdx
    mov $43,  %rax # accept = 43
    syscall

    mov %rax,    %r13 # ; client socket fd
    mov %r13,    %rdi
    mov $buffer, %rsi
    mov $256,    %rdx
    mov $0,      %rax # read = 0
    syscall

    mov $path, %rdi
    mov $0,    %rsi # o_rdonly = 0
    mov $2,    %rax # open = 2
    syscall

    mov %rax, %r14 #  ; save index.html fd

    mov %rax,     %rdi
    mov $buffer2, %rsi
    mov $256,     %rdx
    mov $0,       %rax # read = 0
    syscall

    mov %r13,     %rdi
    mov $buffer2, %rsi
    mov $256,     %rdx
    mov $1,       %rax # write = 1
    syscall

    mov %r13, %rdi
    mov $3,   %rax 
    syscall

    mov %r14, %rdi
    mov $3,   %rax
    syscall

    jmp accept_loop

    mov $0,  %rdi
    mov $60, %rax
    syscall
