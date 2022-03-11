.orig x3000
;this stack lab computes the polish notation of a set of calls
ld r1, base_ptr
ld r2, max_ptr
ld r3, base_ptr;
;push_val(4) pushes the value 4 onto the stack [4]
and r0,r0,#0
add r0,r0,#4;
ld r4 push_val_ptr;
jsrr r4



;push_val(3) pushes the value 3 onto the stack [4,3]
and r0,r0,#0
add r0,r0,#3;
ld r4 push_val_ptr;
jsrr r4


;push_val(2) pushes the value 2 onto the stack [4,3,2]
and r0,r0,#0
add r0,r0,#2;
ld r4 push_val_ptr;
jsrr r4


;add_val() pop 3,2 and push the result of 3+2 onto the stack [4,5]
and r0,r0,#0
ld r4 add_val_ptr
jsrr r4
ld r4 push_val_ptr
jsrr r4

;add_val() pop 4,5 and push the result of 4+5 onto the stack[9]
and r0,r0,#0
ld r4 add_val_ptr
jsrr r4
ld r4 push_val_ptr
jsrr r4

ldr r4, r3, #0


halt
base_ptr .fill xA000
max_ptr .fill xA00A
push_val_ptr .fill x3400
add_val_ptr .fill x3800
;move the top value of the stack into r4
.end




;-----------------------------
; subroutine, push_val
; parameter, r0 is the value to push
; r1 is the pointer to the base of the stack
; r2 is the pointer to the max of the stack
; r3 is the pointer to the current top of stack
; if the stack is full, aka r3 = r2, then we will not add
; return value is r3 which is the updated top of stack.
;-------------------------------------
.orig x3400 ;;push_val(int val)implement your push function that will push a value onto the stack
st r4 backup_r4_3400
st r2 backup_r2_3400
st r0 backup_r0_3400
st r7 backup_r7_3400
;check if stack is full
and r4,r4,#0
add r4,r4,r3;
not r4,r4
add r4,r4,#1
add r4,r4,r2 ;negative top of stack + max of stack, if they are equal then result will be 0
Brz stackFull
add r3,r3,#1
str r0,r3,#0 ;stores r0 in the spot at r3.
BRnzp pushComplete
stackFull
lea r0 overflowMSG
puts
pushComplete

ld r4 backup_r4_3400
ld r2 backup_r2_3400
ld r0 backup_r0_3400
ld r7 backup_r7_3400
ret
backup_r4_3400 .blkw #1
backup_r3_3400 .blkw #1
backup_r2_3400 .blkw #1
backup_r0_3400 .blkw #1
backup_r7_3400 .blkw #1
overflowMSG .stringz "stack is full. overflow error."
.end


;-----------------------------
; subroutine, add_val
; parameter, 
; r1 is the pointer to the base of the stack
; r2 is the pointer to the max of the stack
; r3 is the pointer to the current top of stack
; if the stack is empty, aka r3 = r1, then we will not pop
; return value is r3 which is the updated top of stack.
; and also r0 which is value of popped object
;-------------------------------------
.orig x3800 ;; add_val() pops two values from the top of the stack and pushes the result of adding the poppped value into the stack
st r4 backup_r4_3800
st r1 backup_r1_3800
st r7 backup_r7_3800
st r5 backup_r5_3800
and r4,r4,#0
add r4,r4, r3
not r4,r4
add r4, r4, #1
add r4 , r4, r1 ;adds negative curr to base, if the same then do not pop
BRz stackEmpty

and r5,r5,#0
ldr r0,r3,#0
add r3,r3,#-1
add r5,r0,#0;pops first value and adds to r5

and r4,r4,#0
add r4,r4, r3
not r4,r4
add r4, r4, #1
add r4 , r4, r1 ;adds negative curr to base, if the same then do not pop
BRz stackEmpty ;checks again if it is empty

ldr r0,r3,#0
add r3,r3,#-1
add r5,r0,r5
BRnzp endProg
stackEmpty
lea r0 EmptyError
puts

endProg
and r0,r0,#0
add r0,r5,r0 ;;moves sum to r0
ld r5 backup_r5_3800
ld r4 backup_r4_3800
ld r1 backup_r1_3800
ld r7 backup_r7_3800
ret
backup_r7_3800 .blkw #1
backup_r1_3800 .blkw #1
backup_r4_3800 .blkw #1
backup_r5_3800 .blkw #1
EmptyError .stringz "The stack is empty. Underflow Error."
.end

;-----------------------------
; subroutine, add sum
; parameter, r0 is the value to push
; r1 is the pointer to the base of the stack
; r2 is the pointer to the max of the stack
; r3 is the pointer to the current top of stack
; if the stack is full, aka r3 = r2, then we will not add
; return value is r3 which is the updated top of stack.
;-------------------------------------

.orig x4200 ;;data you might need




ret

.end


