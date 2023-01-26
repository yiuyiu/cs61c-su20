## What do the .data, .word, .text directives mean (i.e. what do you use them for)? Hint: think about the 4 sections of memory.
data表示以下是存储数据, .word表示存储的是32位的unsigned的数据 .text表示代码部分

## Run the program to completion. What number did the program output? What does this number represent?
34 represent a1

## At what address is n stored in memory? Hint: Look at the contents of the registers.
0x10000010 主要是这个la t3, n，看了好一会，它会拆分成 auipc x28 65536 以及 addi x28 x28 8. 
其中auipc x28 65536 会将PC地址加上n所在的内存地址的前二十位存入x28.
addi x28 x28 8 会将 x28的地址加上8.
这里我是没看懂，n是位于memory里的静态数据区域是, 地址是0x10000010, 前20位确实是65536,但是后12位是16啊，
这里加载这个地址为啥和PC有关系了😳，虽然结果是对的。
我估计是auipc那部分加到pc上的值，在addi那部分又减去了这样。
