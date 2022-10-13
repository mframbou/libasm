global _ft_list_sort

extern _ft_list_size

section .text


; void	ft_list_sort(t_list **begin_list, int (*cmp)());
;                            rdi             rsi
_ft_list_sort:
	; rdx = current sorted index (from last to first)
	push rdi
	push rsi

	mov rdi, [rdi] ; dereference
	call _ft_list_size
	mov rdx, rax ; store size in rdx

	pop rsi
	pop rdi

	mov rcx, rsi ; save comp into rcx

bubble_sort_loop:
	cmp rdx, 1 ; return if we sorted everything (index = 1)
	jle return ; check for less also in case of empty list

	; r8 = curr, r9 = curr->next
	mov r8, [rdi]
	mov r9, [r8 + 8]


foreach_loop:
	cmp r9, 0 ; if curr->next == NULL
	je end_bubble_sort_loop

	push rdi
	push rsi
	push r8
	push r9
	push rdx
	push rcx

	mov rdi, [r8]
	mov rsi, [r9]
	call rcx ; comp function has been copied into rcx (because we need rsi for arguments)

	pop rcx
	pop rdx
	pop r9
	pop r8
	pop rsi
	pop rdi

	cmp rax, 0 ; if (res > 0) do bubble sort
	jle end_foreach_loop

	mov r10, [r9] ; r10 = tmp (store current->next->data)
	xchg r10, [r8] ; exchange (= swap)
	mov [r9], r10 ; we swapped curr->data and curr->next->data

end_foreach_loop:
	; curr = curr->next
	mov r8, r9
	mov r9, [r8 + 8]

	jmp foreach_loop

end_bubble_sort_loop:
	dec rdx
	jmp bubble_sort_loop


return:
	mov rax, 100
	ret
