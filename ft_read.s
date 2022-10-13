global _ft_read

extern ___error

section .text

_ft_read:
	mov rax, 0x2000003
	syscall
	jc handle_error
	ret

handle_error:
	push rax
	call ___error
	mov rdx, rax
	pop rax
	mov [rdx], rax
	mov rax, -1 ; return -1
	ret