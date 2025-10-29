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
