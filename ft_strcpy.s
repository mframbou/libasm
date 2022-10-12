global _ft_strcpy

section .text

_ft_strcpy:

	; https://stackoverflow.com/questions/16457109/passing-parameters-in-64-bit-assembly-function-from-c-language-which-register-r
	; we return dst so rdi (in order rdi, rsi, rdx, rcx, r8, and r9)

	mov rax, rdi
	mov rdx, 0; use rdx as index

	loop:
		mov cl, [rsi + rdx]; cl is in rcx so i love dsamain
		mov [rdi + rdx], cl
		cmp BYTE [rsi + rdx], 0
		je end
		inc rdx
		jmp loop
	end:
		ret