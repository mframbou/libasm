global _ft_atoi_base

extern _ft_strlen

section .text

;args order: [rdi, rsi, rdx, rcx, r8, r9]


; ft_atoi_base(char *str, char *base)
_ft_atoi_base:

	; check if base or str is null
	cmp rdi, 0
	je return_error

	cmp rsi, 0
	je return_error

	push rdi ; save rdi
	push rsi
	mov rdi, rsi ; move base to first arg for is_valid_base
	call is_valid_base
	pop rsi
	pop rdi

	cmp rax, 0 ; if (!is_valid_base)
	je return_error ; return(0)

	; rcx = index, rdx = char
	mov rcx, 0 ; i = 0
	mov rax, 0 ; init res = 0 (probably useless)
	mov r8, 1 ; sign is 1 at start

while_isspace:
	cmp BYTE [rdi + rcx], 0 ; if (str[i] == 0) return
	je return

	; while (isspace(str[i]) i++
	movzx rdx, BYTE [rdi + rcx] ; c = str[i]

	; if(isspace) continue
	push rdi
	movzx rdi, dl ; move only last byte of rdx
	call ft_isspace
	pop rdi ; retrieve rdi
	cmp rax, 1 ; if (!ft_isspace(c)) continue
	jne while_plus_or_minus;

	; else
	inc rcx ;i++
	jmp while_isspace ; continue


while_plus_or_minus:
	cmp BYTE [rdi + rcx], 0 ; if (str[i] == 0) return
	je return

	movzx rdx, BYTE [rdi + rcx] ; c = str[i]

check_minus_sign:
	; r8 saves sign (1 or -1)
	cmp rdx, '-' ; if (c == '-') sign *= -1 (no need to check for '+' because *1 doesnt do anything)
	jne check_plus_sign ; check + if not -
	imul r8, -1
	inc rcx ; i++
	jmp while_plus_or_minus ; continue

check_plus_sign:
	cmp rdx, '+' ; if + just continue, else go to convert number function
	jne base_to_dec
	inc rcx
	jmp while_plus_or_minus

base_to_dec:
	; here r8 is either 1 or -1, rcx is index and r9 is base length
	push rcx
	push r8
	push rdi
	mov rdi, rsi
	; ft_strlen(base)
	call _ft_strlen
	mov r9, rax

	pop rdi
	; ft_strlen(str)
	call _ft_strlen
	mov r11, rax

	pop r8
	pop rcx

	mov rax, 0

	; r8 = sign, rcx = i (start of str), r9 = bsize, rax = res(=0), r11 = i (end of str)
	; while(--i)
base_to_dec_loop:
	; while (i (rcx) < strlen(str))
	cmp rcx, r11
	jge return_atoi_base ; (if > strlen (r11) return)

	imul rax, r9 ; res *= bsize (so on first iteration it's always 0)

	; r10 = index_of_char
	push r8
	push rcx
	push r9
	push rax
	push r11
	push rdi
	push rsi

	mov dil, BYTE [rdi + rcx]
	mov rsi, rsi ; nice :)

	; char c, char *str
	call index_of_char_in_str

	mov r10, rax

	pop rsi
	pop rdi
	pop r11
	pop rax
	pop r9
	pop rcx
	pop r8

	; if (index == -1) return 0
	cmp r10, -1
	je return_error

	; res += index_of_char
	add rax, r10
	inc rcx

	jmp base_to_dec_loop ; return res * sign



return_atoi_base:
	imul rax, r8 ; return res * sign
	ret

; int index_of_char_in_str(char *str, char c), -1 if not found
index_of_char_in_str:
	mov rax, 0 ; i = 0

index_of_char_loop:
	cmp BYTE [rsi + rax], 0 ; if (str[i] == 0) return (should never happen with previous checks)
	jne yes_sir
	mov rax, -1
	ret

yes_sir:
	cmp BYTE [rsi + rax], dil ; only cmp last byte of reg
	je return

	inc rax ; i++

	jmp index_of_char_loop


; bool is_valid_base(char *base)
is_valid_base:
	; base is the same arg we want in count_char (str) so no need to push
	mov rcx, 0 ; i = 0

is_valid_base_loop:
	cmp BYTE [rdi + rcx], 0 ; if (base[i] != 0)
	jne is_valid_base_loop_2 ; check if length is <= to 1, if so return 0, else return 1

	; only executed if str[i] == '\0' and nothing is wrong yet
	cmp rcx, 1 ; if (i <= 1)
	jle return_error ; return(0)
	jmp return_success ; return(1)

is_valid_base_loop_2:
	mov sil, BYTE [rdi + rcx] ; char c = base[i] (sil = rsi last byte)
	push rsi
	;if (duplicate) return(0)
	push rcx
	call count_char ; count_char(base, c)
	pop rcx
	pop rsi
	cmp rax, 1 ; if (count_char > 1)
	jg return_error ; return(0)

	; if(isspace) return(1)
	push rdi ; save rdi
	movzx rdi, sil ; move sil (char c) to arg #1, add padding with 0 cause we only want one byte
	call ft_isspace
	pop rdi ; retrieve rdi
	cmp rax, 1 ; if (ft_isspace(c))
	je return_error;

	; only comp 1 byte and not whole registry
	cmp sil, '+' ; if (c == '+')
	je return_error
	cmp sil, '-' ; if (c == '-')
	je return_error

	inc rcx ; i++
	jmp is_valid_base_loop


;; ft_isspace(char c)
ft_isspace: ; dil is last byte of rdi
	cmp rdi, ' ' ; if (c == ' ')
	je return_success ; return (1)
	cmp rdi, 9
	je return_success
	cmp rdi, 10
	je return_success
	cmp rdi, 11
	je return_success
	cmp rdi, 12
	je return_success
	cmp rdi, 13
	je return_success

	jmp return_error ; return(0)


; int count_char(char *str, char c) // counts char occurences in string
count_char:
	mov rcx, 0 ; i = 0
	mov rax, 0 ; count = 0

count_char_loop:
	cmp BYTE [rdi + rcx], 0  ; if (str[i] == 0) return
	je return

	cmp BYTE [rdi + rcx], sil  ; if (str[i] == c) count++ (sil = last byte of rsi)

	jne dont_increment_count_char
	inc rax ; count ++

dont_increment_count_char:
	inc rcx  ; i++
	jmp count_char_loop  ; while



return:
	ret

return_success:
	mov rax, 1
	ret

return_error:
	mov rax, 0
	ret