# problem 172. Factorial Trailing Zeroes 

[题目链接](https://leetcode.com/problems/factorial-trailing-zeroes/)

## 方法

哈哈，这个题感觉以前考数学时考过啊。

找了下规律，拿正确答案验证了下：

5以下有0个，

25以下对应 n / 5 , 

125 以下对应 n / 5 + n / 25 , 

...

所以算是不断乘以5，对区间有指数增长的划分。因此时间复杂度满足对数。

## 代码

```C++
class Solution {
public:
    int trailingZeroes(int n) {
        int stepLimit = numeric_limits<int>::max() / 5;
        int step = 1,
            cnt = 0;
        while(true)
        {
            int nextStep = step * 5;
            if(n < nextStep || step >= stepLimit)
            {
                break;
            }
            else
            {
                cnt += n / nextStep;
            }
            step = nextStep;
        }
        return cnt;
    }
};
```

## 后记

考虑了越界，不过最开始写错了... 话说，这样写耗时比较多啊, 可能用long long能够稍微快点。
