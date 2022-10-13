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
	cmp rxa, 0
	je return

	mov [rxa], rsi ; new->data = data
	mov [rxa + 8], [rdi] ; new->next = *begin_list
	mov [rdi], rxa ; *begin_list = new

return:
	ret