global _ft_atoi_base

section .text

;args order: [rdi, rsi, rdx, rcx, r8, r9]


; ft_atoi_base(char *str, char *base)
_ft_atoi_base:

push rdi ; save rdi
mov rdi, rsi ; move base to first arg for is_valid_base
call is_valid_base
pop rdi

cmp rax, 0 ; if (!is_valid_base)
je return_error ; return(0)

mov rax, 123456
ret



; bool is_valid_base(char *base)
is_valid_base:
; base is the same arg we want in count_char (str) so no need to push
mov rcx, 0 ; i = 0

is_valid_base_loop:
cmp BYTE [rdi + rcx], 0 ; if (base[i] != 0)
jne is_valid_base_loop_2 ; check if length is <= to 1, if so return 0, else return 1

return_if_valid: ; only executed if str[i] == '\0' and nothing is wrong yet
cmp rcx, 1 ; if (i <= 1)
jle return_error ; return(0)
jmp return_success ; return(1)

is_valid_base_loop_2:
mov sil, BYTE [rdi + rcx] ; char c = base[i] (sil = rsi last byte)

push rcx
call count_char ; count_char(base, c)
pop rcx

cmp sil, ' ' ; if (c == ' ')
je return_error ; return(0)
cmp sil, 9
je return_error
cmp sil, 10
je return_error
cmp sil, 11
je return_error
cmp sil, 12
je return_error
cmp sil, 13
je return_error

cmp rax, 1 ; if (count_char > 1)
jg return_error ; return(0)

inc rcx ; i++
jmp is_valid_base_loop





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