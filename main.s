	.file	"main.c"
	.text
	.globl	fib
	.type	fib, @function
fib:
.LFB51:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	subq	$24, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	movl	%edi, %eax
	cmpl	$1, %edi
	jle	.L1
	movl	%edi, %ebx
	movw	$0, 2(%rsp)
	movw	$-1, 4(%rsp)
	movw	$0, 6(%rsp)
	leaq	2(%rsp), %rsi
	movl	$1, %edx
	movl	semid(%rip), %edi
	call	semop@PLT
	movslq	%ebx, %rax
	leaq	cache(%rip), %rdx
	cmpl	$0, (%rdx,%rax,4)
	je	.L7
.L3:
	movw	$1, 4(%rsp)
	leaq	2(%rsp), %rsi
	movl	$1, %edx
	movl	semid(%rip), %edi
	call	semop@PLT
	movslq	%ebx, %rbx
	leaq	cache(%rip), %rax
	movl	(%rax,%rbx,4), %eax
.L1:
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L8
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L7:
	.cfi_restore_state
	leal	-1(%rbx), %edi
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
.L8:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE51:
	.size	fib, .-fib
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"semget"
.LC1:
	.string	"fork"
.LC2:
	.string	"%d\n"
	.text
	.globl	main
	.type	main, @function
main:
.LFB52:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movl	$950, %edx
	movl	$1, %esi
	movl	$0, %edi
	call	semget@PLT
	movl	%eax, semid(%rip)
	cmpl	$-1, %eax
	je	.L20
	movl	%eax, %edi
	movl	$1, %ecx
	movl	$16, %edx
	movl	$0, %esi
	movl	$0, %eax
	call	semctl@PLT
	movl	$0, %ebx
.L14:
	call	fork@PLT
	testl	%eax, %eax
	js	.L21
	je	.L22
	addl	$1, %ebx
	cmpl	$4, %ebx
	jne	.L14
	movl	$0, %edi
	call	wait@PLT
	movl	$0, %edi
	call	wait@PLT
	movl	$0, %edi
	call	wait@PLT
	movl	$0, %edi
	call	wait@PLT
	leaq	4+cache(%rip), %rbx
	leaq	196(%rbx), %r12
	leaq	.LC2(%rip), %rbp
.L15:
	movl	(%rbx), %edx
	movq	%rbp, %rsi
	movl	$1, %edi
	movl	$0, %eax
	call	__printf_chk@PLT
	addq	$4, %rbx
	cmpq	%rbx, %r12
	jne	.L15
	movl	$0, %edx
	movl	$0, %esi
	movl	semid(%rip), %edi
	movl	$0, %eax
	call	semctl@PLT
	movl	$0, %eax
	popq	%rbx
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L20:
	.cfi_restore_state
	leaq	.LC0(%rip), %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L21:
	leaq	.LC1(%rip), %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L22:
	imull	$12, %ebx, %ebx
	leal	12(%rbx), %ebp
.L13:
	movl	%ebx, %edi
	call	fib
	addl	$1, %ebx
	cmpl	%ebx, %ebp
	jg	.L13
	movl	$0, %edi
	call	exit@PLT
	.cfi_endproc
.LFE52:
	.size	main, .-main
	.globl	semid
	.bss
	.align 4
	.type	semid, @object
	.size	semid, 4
semid:
	.zero	4
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
