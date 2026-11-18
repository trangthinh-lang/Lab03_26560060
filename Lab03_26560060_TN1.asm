# Name:Trang Nhu Thinh
# Student ID: 26560060
# Purpose: Print a formatted score report using leaf procedures stars and sep.

.data
title:    .asciiz "SCORE REPORT\n"
endMsg:   .asciiz "END\n"
line:     .asciiz "----------\n"
starLine: .asciiz "**********\n"

.text
.globl main
main:
    jal  stars              # print top border of stars
    li   $v0, 4
    la   $a0, title         # print "SCORE REPORT\n"
    syscall
    jal  sep                # print dashed separator line
    li   $v0, 4
    la   $a0, endMsg        # print "END\n"
    syscall
    jal  stars              # print bottom border of stars
    li   $v0, 10            # exit program
    syscall

# sep(): prints a dashed separator line ("----------\n")
sep:
    li   $v0, 4
    la   $a0, line
    syscall
    jr   $ra                # return to the caller

# stars(): prints a star separator line ("**********\n")
stars:
    li   $v0, 4
    la   $a0, starLine
    syscall
    jr   $ra                # return to the caller