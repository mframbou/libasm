global _ft_strcmp

section .text

_ft_strcmp:

	;args order: [rdi, rsi, rdx, rcx, r8, r9]

	mov rdx, 0 ; i = 0

	loop:
		; use al instead of rax (al = last byte or rax) to read only 1 byte instead of 8 (which cause very long number instead of just character)
		; cl = last byte of rcx
		; movzx to move only one byte (asm knows it because we typed BYTE) into bigger registry by filling with 0 (so we only copy 1 byte instead of 8)
		movzx rax, BYTE [rdi + rdx] ; char from s1
		movzx rcx, BYTE [rsi + rdx] ; char from s2

		sub rax, rcx ; s1[i] - s2[i]

		cmp rax, 0 ; check if s1[i] != s2[i]
		jne end ; if != return

		cmp BYTE [rsi + rdx], 0 ; if (s1[i] == 0)
		je end

		cmp BYTE [rdi + rdx], 0 ; if (s2[i] == 0)
		je end

		inc rdx ; i++
		jmp loop
	end:
		ret