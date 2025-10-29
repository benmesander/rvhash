
.macro MUL12 reg, tmp1
	slli	\tmp1, \reg, 1
	add	\tmp1, \tmp1, \reg
	slli	\reg, \tmp1, 2
.endm
	
.macro MUL16 reg
	slli	\reg, \reg, 4
.endm
