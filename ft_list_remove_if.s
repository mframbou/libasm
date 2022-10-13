global _ft_list_remove_if

extern _free

section .text

;args order: [rdi, rsi, rdx, rcx, r8, r9]

; void	ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
;                               rdi                 rsi              rdx             rcx
_ft_list_remove_if:
	; r8 = prev, r9 = curr, r10 = next

	mov r9, [rdi]
	mov r8, 0
	mov r10, 0

loop:
	cmp r9, 0
	je return

	mov r10, [r9 +8]

	push rdi
	push rsi
	push rdx
	push rcx
	push r8
	push r9
	push r10

	mov rdi, [r9]
	mov rsi, rsi ; just so i know i did it and you know bing chilling

	call rdx

	pop r10
	pop r9
	pop r8
	pop rcx
	pop rdx
	pop rsi
	pop rdi

	cmp rax, 0
	je if
	jmp else

if:
	; free(data)
	push rdi
	push rsi
	push rdx
	push rcx
	push r8
	push r9
	push r10

	mov rdi, [r9]
	call rcx

	pop r10
	pop r9
	pop r8
	pop rcx
	pop rdx
	pop rsi
	pop rdi

	; free(current)
	push rdi
	push rsi
	push rdx
	push rcx
	push r8
	push r9
	push r10

	mov rdi, r9
	call _free

	pop r10
	pop r9
	pop r8
	pop rcx
	pop rdx
	pop rsi
	pop rdi


	cmp r8, 0
	je prev_null
	jmp prev_not_null

prev_null:
	mov [rdi], r10
	jmp after_prev_null_or_not

prev_not_null:
	mov [r8 + 8], r10
	jmp after_prev_null_or_not

after_prev_null_or_not:
	jmp after_if_else

else:
	mov r8, r9
	jmp after_if_else

after_if_else:
	mov r9, r10
	jmp loop


return:
	ret