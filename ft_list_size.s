global _ft_list_size

section .text

_ft_list_size:
	mov rax, 0 ; i = 0

loop:
	cmp rdi, 0
	je return

	mov rdi, [rdi + 8]
	inc rax
	jmp loop

return:
	ret