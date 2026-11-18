# Name: Trang Nhu Thinh
# Student ID:26560060
# Purpose: Read an integer x and clamp it to the range [0, 100] using a leaf procedure.

.text
.globl main
main:
    li   $v0, 5                 # read an integer x into $v0
    syscall
    add  $a0, $v0, $zero        # argument 1: x
    addi $a1, $zero, 0          # argument 2: lo = 0
    addi $a2, $zero, 100        # argument 3: hi = 100
    jal  clamp
    add  $a0, $v0, $zero        # copy result first, then print it
    li   $v0, 1
    syscall
    li   $v0, 10                # exit
    syscall

# clamp(x = $a0, lo = $a1, hi = $a2): returns x limited to [lo, hi] in $v0
clamp:
    slt  $t0, $a0, $a1          # $t0 = 1 if x < lo
    bne  $t0, $zero, clamp_lo   # if x < lo, result is lo
    slt  $t0, $a2, $a0          # $t0 = 1 if hi < x (x > hi)
    bne  $t0, $zero, clamp_hi   # if x > hi, result is hi
    add  $v0, $a0, $zero        # otherwise result is x
    j    clamp_end
clamp_lo:
    add  $v0, $a1, $zero        # result = lo
    j    clamp_end
clamp_hi:
    add  $v0, $a2, $zero        # result = hi
clamp_end:
    jr   $ra