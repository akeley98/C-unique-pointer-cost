	.file	"unique_cost.cc"
	.intel_syntax noprefix
	.text
	.p2align 4,,15
	.globl	foo_raw
	.type	foo_raw, @function
foo_raw:
.LFB1936:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	cmp	DWORD PTR [rdi], 42
	mov	rbx, rdi
	jle	.L2
	call	bar@PLT
	mov	DWORD PTR [rbx], 42
.L2:
	mov	rdi, rbx
	pop	rbx
	.cfi_def_cfa_offset 8
	jmp	baz_raw@PLT
	.cfi_endproc
.LFE1936:
	.size	foo_raw, .-foo_raw
	.p2align 4,,15
	.globl	foo_talk
	.type	foo_talk, @function
foo_talk:
.LFB1937:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	mov	rbx, rdi
	mov	rdi, QWORD PTR [rdi]
	cmp	DWORD PTR [rdi], 42
	jle	.L6
	call	bar@PLT
	mov	rax, QWORD PTR [rbx]
	mov	DWORD PTR [rax], 42
.L6:
	mov	rdi, rbx
	pop	rbx
	.cfi_def_cfa_offset 8
	jmp	baz_talk@PLT
	.cfi_endproc
.LFE1937:
	.size	foo_talk, .-foo_talk
	.p2align 4,,15
	.globl	foo_my_impl
	.type	foo_my_impl, @function
foo_my_impl:
.LFB1941:
	.cfi_startproc
	push	rbx
	.cfi_def_cfa_offset 16
	.cfi_offset 3, -16
	cmp	DWORD PTR [rdi], 42
	mov	rbx, rdi
	jle	.L9
	call	bar@PLT
	mov	DWORD PTR [rbx], 42
.L9:
	mov	rdi, rbx
	pop	rbx
	.cfi_def_cfa_offset 8
	jmp	baz_my_impl@PLT
	.cfi_endproc
.LFE1941:
	.size	foo_my_impl, .-foo_my_impl
	.ident	"GCC: (Ubuntu 7.4.0-1ubuntu1~18.04.1) 7.4.0"
	.section	.note.GNU-stack,"",@progbits
