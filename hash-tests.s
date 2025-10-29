.include	"config.s"

.rodata

start_msg:	
	.asciz	"### Start of hash table ###\n"
start_msg_len:
	.word . - start_msg # .quad for 64 xxx
	

end_msg:	
	.asciz	"### End of hash table ###\n"
end_msg_len = . - end_msg

.globl	_start

.text

_start:
	jal print_table



_end:
        li	a0, 0		# exit code
        li	a7, 93		# exit syscall
        ecall


print_table:
	FRAME	1
	PUSH	ra, 0
	
	la	a1, start_msg
	la	t0, start_msg_len
	lw	a2, 0(t0)	# ld for 64 xxx
	jal	print
	la	a1, end_msg
	li	a2, end_msg_len
	jal	print

	POP	ra, 0
	EFRAME	1
	ret





# a1 - ptr to string to print
# a2 - # bytes to print
print:
	li	a0, 1		# stdout
	li	a7, 64		# write syscall
	ecall
	ret
