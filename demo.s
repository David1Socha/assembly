addi r9, r0, 50 --IO addresses are stored in mif
addi r9, r9, 50 -- (at address 100)
addi r7, r0, 5 --hex debug

lw r11, 0(r9) --load GLED address into r11
lw r12, 1(r9) --load BUTTON/KEY address into r12
lw r13, 2(r9) --load HEX DISPLAY address into r13
lw r14, 3(r9) --load SWITCH address into r14

LOOP: lw r8, 0(r12) --load input from keys into r8
lw r10, 0(r14) --load input from switches into r10

addi r4, r0, 7 --load LHS key code into r4
cmp r4, r8
beq LHS

addi r4, r0, 11 --load RHS key code into r4
cmp r4, r8
beq RHS

addi r4, r0, 13 --load EXEC key code into r4
cmp r4, r8
beq EXEC

b LOOP

--execute region

EXEC: addi r4, r0, 1 --load ADD switch code into r4
cmp r10, r4 --check if switches match ADD code
beq ADD -- branch to ADD if match

addi r4, r0, 2 --load SUB switch code into r4
cmp r10, r4 --check if switches match SUB code
beq SUB -- branch to SUB if match

addi r4, r0, 4 --load AND switch code into r4
cmp r10, r4 --check if switches match AND code
beq AND -- branch to AND if match

addi r4, r0, 8 --load OR switch code into r4
cmp r10, r4 --check if switches match OR code
beq OR -- branch to OR if match

addi r4, r0, 16 --load XOR switch code into r4
cmp r10, r4 --check if switches match XOR code
beq XOR -- branch to XOR if match

b LOOP

--end execute region

--add region
ADD: add r2, r1, r3 --Add RHS and LHS, storing result into ANS
b DISPLAY
--end add region

--sub region
SUB: sub r2, r1, r3 --SUB RHS and LHS, storing result into ANS
b DISPLAY
--end sub region

--and region
AND: and r2, r1, r3 --AND RHS and LHS, storing result into ANS
b DISPLAY
--end and region

--or region
OR: or r2, r1, r3 --OR RHS and LHS, storing result into ANS
b DISPLAY
--end or region

--xor region
XOR: xor r2, r1, r3 --XOR RHS and LHS, storing result into ANS
b DISPLAY
--end xor region

--lhs region

LHS: lw r10, 0(r14) --load input from switches into r10
addi r1, r10, 0
sw r1, 0(r11) --output LHS to GLED
b LOOP

--end lhs region

--rhs region

RHS: lw r10, 0(r14) --load input from switches into r10
addi r2, r10, 0
sw r2, 0(r11) --output LHS to GLED
b LOOP

--end rhs region

--display region

DISPLAY: sw r3, 0(r11) -- output ANS to green led
b LOOP

--end display region