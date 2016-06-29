# problem 279. Perfect Squares

[题目链接](https://leetcode.com/problems/perfect-squares/)

## 方法

不会。不过是一道太有意思的题目了...

参见[Summary of 4 different solutions (BFS, DP, static DP and mathematics)](https://leetcode.com/discuss/58056/summary-of-different-solutions-bfs-static-and-mathematics).

首先是DP方法，设`R[i]`表示数`i`最少可由`R[i]`个数的完全平方和构成。那么递推关系可以写作：

```XML
R[i] = min( R[i-j*j] + 1 ), 0 < j*j <= i
R[0] = 0   
```

对我而言，是在是太巧妙了。`R[i]`的前一个状态，就是减掉一个数的平方和，结果值对应的那个状态。真是厉害啊。

接着是BFS。BFS首先把小于N的完全平方和作为图上的节点。每一步，对当前图的每一个节点向外扩展一步，就是将该节点与小于N的平方和挨个做加，如果等，则路径长度就是平方和的个数，如果小于，则产生一个新的节点；如果大于，则丢弃。迭代遍历，直到相等。

DFS，我自己想的... 没有写代码，不过应该可行。就是和之前的回溯一样的思想。同样产生小于N的所有平方和，然后把问题转化为找K个数，使得k个数的和为目标值。只不过为了保证是最少，需要从大往小遍历，且数可重复。遍历过程可剪枝。这么应该还是可行的。

最后，就是神奇的数学方法了。

1. [四平方和定理](https://zh.wikipedia.org/wiki/%E5%9B%9B%E5%B9%B3%E6%96%B9%E5%92%8C%E5%AE%9A%E7%90%86)：任意一个正整数都可以表示为4个数的平方和；

2. [三平方和定理](https://en.wikipedia.org/wiki/Legendre%27s_three-square_theorem): 如果一个正整数可以表示为`4^{a} * (8*b + 7)`，那么这个数一定*不能*表示为3个数的平方和。此时一定需要4个数的平方和相加才能表示(在维基百科上没有看到)。

3. 处理2数的平方和，只需`i`从`1` 到 `sqrt(n)` , 看 `n - i^2`是否是完全平方即可。

## 代码

只写了DP方法。

```C++
class Solution {
public:
    int numSquares(int n) {
        if(n <= 0){ return 0 ;}
        vector<int> leastNum(n+1, numeric_limits<int>::max());
        leastNum[0] = 0;
        for(int i = 1; i < n + 1; ++i)
        {
            for(int testNum = 1; testNum * testNum <= i; ++testNum)
            {
                int preStateIdx = i - testNum * testNum;
                leastNum[i] = min( leastNum[preStateIdx] + 1, leastNum[i]);
            }
        }
        return leastNum.back();
    }
};
```

## 后记

看到评论里说到了为何用static变量速度快这么多...原来果然是建一个Solution实例，然后不断调用，并记总时间。