	.file	"main.c"
	.text
	.globl	fib
	.type	fib, @function
fib:
.LFB23:
	.cfi_startproc
	endbr64
	movl	%edi, %eax
	cmpl	$1, %edi
	jle	.L6
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	%edi, %ebx
	movslq	%edi, %rax
	leaq	cache(%rip), %rdx
	cmpl	$0, (%rdx,%rax,4)
	je	.L9
.L3:
	movslq	%ebx, %rbx
	leaq	cache(%rip), %rax
	movl	(%rax,%rbx,4), %eax
	addq	$8, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L9:
	.cfi_restore_state
	leal	-1(%rdi), %edi
	call	fib
	movl	%eax, %ebp
	leal	-2(%rbx), %edi
	call	fib
	movl	%eax, %edx
	movslq	%ebx, %rax
	addl	%edx, %ebp
	leaq	cache(%rip), %rdx
	movl	%ebp, (%rdx,%rax,4)
	jmp	.L3
.L6:
	.cfi_def_cfa_offset 8
	.cfi_restore 3
	.cfi_restore 6
	ret
	.cfi_endproc
.LFE23:
	.size	fib, .-fib
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB24:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$8, %rsp
	.cfi_def_cfa_offset 32
	movl	$1, %ebx
	leaq	.LC0(%rip), %rbp

/*

цикл

.L11:
	movl	%ebx, %edi
	call	fib
	movl	%eax, %edx
	movq	%rbp, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addl	$1, %ebx
	cmpl	$40, %ebx
	jne	.L11

	Переменные:
    	 `%ebx` - счетчик цикла.
    	 `%rbp` - указатель на строку формата для вывода (`%d\n`).
    	 `%edi` - аргумент функции `fib`.

*/

.L11:
	movl	%ebx, %edi
	call	fib
	movl	%eax, %edx
	movq	%rbp, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addl	$1, %ebx
	cmpl	$40, %ebx
	jne	.L11
	movl	$0, %eax
	addq	$8, %rsp
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE24:
	.size	main, .-main
	.local	cache
	.comm	cache,200,32
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
