# Single_cycle_MIPS
<img width="1931" height="1082" alt="image" src="https://github.com/user-attachments/assets/10642aa7-d86f-485c-9c29-07f06b3a97e6" />
指令暫存器的值會是固定的，一開始就決定好的\
開始後會執行以下指令\
//addi $1,$0,8 $1=8   \     
//ori $2,$0,12 $2=12    \  
//add $3,$1,$2 $3=20\
//sub $4,$2,$1 $4=4\
//and $5,$1,$2\
//or $6,$1,$2\
//bne $1,$2,2 （電路沒有實現此功能）                                     
                                                  
                                                  
// beq $1,$2,2
// J 0D
                                                  
                                                  
// sw $2 10($8) memory[$8+10]=12
//lw $4 10($8) $4=12
//beq $2,$4,3
