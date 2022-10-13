global _ft_list_push_front

extern _malloc

section .text

;args order: [rdi, rsi, rdx, rcx, r8, r9]

_ft_list_push_front:
	push rdi
	push rsi
	mov rdi, 16 ; 2 pointers = 16 bytes
	call _malloc
	pop rsi
	pop rdi
	cmp rax, 0
	je return

	mov [rax], rsi ; new->data = data
	mov rdx, [rdi] ; because we cannot mov [reg1], [reg2], only [reg1], val
	mov [rax + 8], rdx ; new->next = *begin_list
	mov [rdi], rax ; *begin_list = new

return:
	ret