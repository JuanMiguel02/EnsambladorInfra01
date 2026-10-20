default rel

section .data
    mensaje db "Nombre: "
    len_mensaje equ $ - mensaje
    salto db 10

section .bss
    nombre resb 16

section .text
    global _start

_start:

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel mensaje]
    mov rdx, len_mensaje
    syscall


    mov rax, 0
    mov rdi, 0
    lea rsi, [rel nombre]
    mov rdx, 16
    syscall

    test rax, rax
    jle .sin_nombre
    cmp byte [rsi + rax - 1], 10
    jne .longitud_lista
    dec rax

.longitud_lista:
    mov rdx, rax
    jmp .mostrar_nombre

.sin_nombre:
    xor edx, edx

.mostrar_nombre:

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel nombre]
    syscall

    mov rax, 1
    mov rdi, 1
    lea rsi, [rel salto]
    mov rdx, 1
    syscall

    mov rax, 60
    mov rdi, 0
    syscall
