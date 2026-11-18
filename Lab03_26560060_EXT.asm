# Name: Trang Nhu Thinh
# Student ID:26560060
# Purpose: Find and print both minimum ($v0) and maximum ($v1) of Class A and Class B.

.data
classA:  .word 72, 55, 90, 48, 63, 85, 39, 77, 60, 94
classB:  .word 45, 81, 66, 50, 92, 38, 70, 59
minMsgA: .asciiz "Class A min: "
maxMsgA: .asciiz "Class A max: "
minMsgB: .asciiz "Class B min: "
maxMsgB: .asciiz "Class B max: "
nl:      .asciiz "\n"

.text
.globl main
main:
    # --- Class A min and max ---
    la   $a0, classA            # argument 1: address of classA[0]
    addi $a1, $zero, 10         # argument 2: length = 10
    jal  min_max                # $v0 = min (39), $v1 = max (94)
    add  $s0, $v0, $zero        # save min in $s0
    add  $s1, $v1, $zero        # save max in $s1

    la   $a0, minMsgA
    add  $a1, $s0, $zero
    jal  show

    la   $a0, maxMsgA
    add  $a1, $s1, $zero
    jal  show

    # --- Class B min and max ---
    la   $a0, classB            # argument 1: address of classB[0]
    addi $a1, $zero, 8          # argument 2: length = 8
    jal  min_max                # $v0 = min (38), $v1 = max (92)
    add  $s0, $v0, $zero        # save min in $s0
    add  $s1, $v1, $zero        # save max in $s1

    la   $a0, minMsgB
    add  $a1, $s0, $zero
    jal  show

    la   $a0, maxMsgB
    add  $a1, $s1, $zero
    jal  show

    li   $v0, 10                # exit
    syscall

# min_max(addr = $a0, n = $a1): returns minimum in $v0 and maximum in $v1
min_max:
    lw   $v0, 0($a0)            # min = array[0]
    add  $v1, $v0, $zero        # max = array[0]
    addi $t0, $zero, 1          # i = 1
mm_loop:
    slt  $t1, $t0, $a1          # $t1 = 1 if i < n
    beq  $t1, $zero, mm_end     # exit loop if i >= n
    sll  $t2, $t0, 2            # $t2 = 4 * i
    add  $t2, $t2, $a0          # $t2 = address of array[i]
    lw   $t3, 0($t2)            # $t3 = array[i]

    slt  $t1, $t3, $v0          # $t1 = 1 if array[i] < min
    beq  $t1, $zero, check_max
    add  $v0, $t3, $zero        # update min = array[i]

check_max:
    slt  $t1, $v1, $t3          # $t1 = 1 if max < array[i] (array[i] > max)
    beq  $t1, $zero, mm_next
    add  $v1, $t3, $zero        # update max = array[i]

mm_next:
    addi $t0, $t0, 1            # i = i + 1
    j    mm_loop
mm_end:
    jr   $ra

# show(msg = $a0, value = $a1): prints msg, value and a new line
show:
    li   $v0, 4
    syscall
    li   $v0, 1
    add  $a0, $a1, $zero
    syscall
    li   $v0, 4
    la   $a0, nl
    syscall
    jr   $ra