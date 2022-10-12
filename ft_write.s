global _ft_write

section .text

; syscalls: /Library/Developer/CommandLineTools/SDKs/MacOSX10.14.sdk/usr/include/sys/syscall.h
; UPDATE: it's not, see https://stackoverflow.com/questions/69857083/step-by-step-hello-world-in-assembly-for-mac-os
; it seems that we need 0x200000X

_ft_write:
	;args order: [rdi, rsi, rdx, rcx, r8, r9]
	; https://www.tutorialspoint.com/assembly_programming/assembly_system_calls.htm

	mov rax, 0x2000004 ; put syscall number in rax / eax
	syscall ; call writes, args are already set since it's the same for ft_write and write
	ret ; I think that value -1 is already set by syscall on error so just return