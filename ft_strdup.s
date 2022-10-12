global _ft_strdup

; to tell that they are not in this file but linked with
extern _ft_strlen
extern _malloc
extern _ft_strcpy

section .text

_ft_strdup:
	;args order: [rdi, rsi, rdx, rcx, r8, r9]

	call _ft_strlen		; int size = strlen(arg) (stored in rax)
	inc rax				; size++

	push rdi			; save rdi (which is our string, we need rdi for malloc arg)
	mov rdi, rax		; set malloc arg to size
	call _malloc		; res (rax) = malloc(size)

	cmp rax, 0			; if (res == NULL)
	je end				; return (NULL / 0)

	mov rdi, rax		; dst = res
	pop rsi				; retrieve our string (which was pushed on stack) into rsi (src = 2nd arg)

	call _ft_strcpy		; ft_strcpy(dst, src)
	ret					; return

	end:
		ret

