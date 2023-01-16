## The register representing the variable k.
t0
## The register representing the variable sum.
s0
## The registers acting as pointers to the source and dest arrays.
s1 s2
## The assembly code for the loop found in the C code.
loop label
## How the pointers are manipulated in the assembly code.
slli s3, t0, 2 t0里存放的是k，s3里存放的是k*4也就是offset.
通过s1 + s3的值可以得到source数组的某一项
s2+ + s3可以得到dest数组的某一项
