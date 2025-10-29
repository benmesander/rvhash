.include	"config.s"

.globl	hash_table



.data

# Align to 8 bytes for RV64, 4 bytes for RV32
.if CPU_BITS == 64
.align 3
.else
.align 2
.endif	

hash_table:
.rept HASHENTRIES
.space ELEMENTLEN, 0
.endr	


	


.text

################################################################################
# routine: hash_h1
#
# Primary hash function - computes initial probe position.
# Uses modulo by table size.
#
# input registers:
# a0 = key sum to hash
#
# output registers:
# a0 = initial probe position (0 to HASHENTRIES-1)
################################################################################
hash_h1:
	FRAME	1
	PUSH	ra, 0
	li	a1, HASHENTRIES		# Divisor for divremu
	jal	divremu			# a0=quotient, a1=remainder
	mv	a0, a1			# Return remainder in a0
	POP	ra, 0
	EFRAME	1
	ret

################################################################################
# routine: hash_h2
#
# Secondary hash function - computes probe step size.
# Uses modulo by (table size - 1) plus 1 to ensure coprime step size.
# Returns step already scaled by ELEMENTLEN to avoid repeated scaling.
#
# input registers:
# a0 = key sum to hash
#
# output registers:
# a0 = probe step size (ELEMENTLEN to ELEMENTLEN*(HASHENTRIES-1))
################################################################################
hash_h2:
	FRAME	1
	PUSH	ra, 0
	li	a1, HASHENTRIES-1	# Divisor for divremu
	jal	divremu		        # a0=quotient, a1=remainder (logical step is 0 to HASHEN
	addi	a0, a1, 1		# Logical step is 1 to HASHENTRIES-1
	POP	ra, 0
	EFRAME	1
	ret

