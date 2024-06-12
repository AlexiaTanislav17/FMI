.data

sir : .space 404
sir_2 : .space 404
afisare: .ascii "%s\n"
len: .space 4
.text
.globl main
main:

 pushl $sir ;# adadugam ce este scris de la tastatura in sir
 call gets
 popl %ebx

pushl $sir  ;# adaugmam lungimea lui sir
call strlen
popl %ecx
mov %eax, len

lea sir, %edi
lea sir_2, %esi
decl len
movl $0, %ecx
for_invers:
    cmp $-1, len
    je exit_for

    movl len, %ebx

    movb (%edi, %ebx, 1), %dl # in dl avem un caracter

    movb %dl, (%esi, %ecx, 1)

    incl %ecx
    decl len
    jmp for_invers

exit_for:

incl %ecx
movb $'\0', (%esi, %ecx, 1)

push $sir_2
push $afisare
call printf 
pop %ebx
pop %ebx

et_exit:
    movl $1, %eax
    xorl %ebx, %ebx
    int $0x80