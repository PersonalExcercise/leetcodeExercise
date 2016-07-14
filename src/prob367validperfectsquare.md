# problem 367. Valid Perfect Square

[题目链接](https://leetcode.com/problems/valid-perfect-square/)

## 方法

懵逼，开始先不断除二找平方比它小的数，然而从这个数开始挨个加，直到大于等于这个数。结果第一个问题，除以0出现了！考虑不周！加入限制条件后应该逻辑没有问题了，但是TLE。说明还是太慢。

看了DISCUSS。

一种方法是，真正的二分——

定义low 为 1（题目中说明输入是正数），定义high为 num / 2;

然后在此区间中根据 mid * mid 与 num的关系来找mid。真的是标准的二分。自己没有想到。这个还是有些拓展的，因为我们是把搜索区间当作二分搜索的空间，同时用mid的平方与target比较。还是自己懵逼吧。

第二种方法，就是用牛顿逼近算法，[维基百科](https://en.wikipedia.org/wiki/Integer_square_root#Using_only_integer_division)中的公式：

```
X_{k+1} = { X_{k} + num / X_{k} } / 2
X_0 = num 
stop when X_{k} - X{k+1} < 1 (维基百科中是绝对值，但是这里，这样写也通过了。X_{k} 是大于等于 X_{k+1}) 
```

## 代码

二分搜索版；判断了溢出。

```C++
class Solution {
public:
    bool isPerfectSquare(int num) {
        if(num <= 0){return false;} // positive number ! 
        int low = 1,
            high = num / 2;
        while(low <= high)
        {
            int mid = low + (high - low) / 2;
            int power = mid * mid;
            if(power / mid != mid)
            {
                // overflow
                high = mid - 1;
                continue;
            }
            if(power < num)
            {
                low = mid + 1;
            }
            else{ high = mid - 1; }
        }
        return low * low == num;
    }
};
```