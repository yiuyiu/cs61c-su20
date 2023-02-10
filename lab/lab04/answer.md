1. line 78 lw a1, 0(s1) 就直接mv s1 a1就行了，它a1是地址，不是要取值
2. 用t0计数会有问题，因为line 71 jalr s1调用后t0可能会发生变化，在调用后依然是用了t0. t1,t2也是同理.
3. 它是先执行再判断的，如果数组长度是0的话就有问题了。
4. line 77 la a0, 8(s0)语法错误，没有这种写法就直接mv a0 s0就行了
5. load the value at that address into a0这一步是将node的array的地址放入a0，而不是array里的第一个值，因为node里的array是array地址
6. offset the array address by the count有问题，
t0是1，2，3，4这样的数字
t1存放的是array里每一项的地址