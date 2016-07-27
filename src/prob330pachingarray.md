# problem 330. Patching Array

[题目链接](https://leetcode.com/problems/patching-array/)

## 方法

看到greedy的标签，我只想到了在发现某个数不能得到的情况下应该贪心地往里面添加这个数，因为前面的数已经可以得到了，所以不用添加，而后面的数还有到，所以最优的方法就是添加这个数。


接下里的问题就是如何判断某个数能够得到——我以为是用以前做过的——判断集合中的数能不能构成某个数——递归方法。

然而看了题解却发现原来这里还有一个贪心的想法——

我们始终维持一个集合，使得该集合能够覆盖 [0, k] , 初始时k为0。

然后只要能覆盖的最大数k小于给定的n值

比较最大能覆盖的数k与当前给定集合的第一个数x

1. 如果k恰好比x小1，那么把这个数放入集合，可以覆盖到[1, x] , 不仅如此！**该x还能够与之前覆盖[1, k]相组合**，即其实真正可以覆盖的范围是[1, 2x - 1\] (即是 [1, x + k ])，更新范围，开始比较集合中下一个数; 

2. 如果k大于等于x，那么说明当前的范围以及覆盖了x，但是同样x的加入还是可以把覆盖的范围拓广到 x + k ;  更新范围为[1, x+k], 开始比较x+k与下一个数；

3. 如果 k比x小1以上，说明k+1是不能被达到了，那么就往集合中添加 k+1 , 同样添加之后范围拓广为 k + k + 1, 那么更新范围为[1, 2k+1], 继续与该数比较；


这道题，有点像Jump Game啊，不过遇到是基本不会的了。

## 代码

```C++
class Solution {
public:
    int minPatches(vector<int>& nums, int n) {
        int cnt = 0;
        size_t sz = nums.size(),
               pos = 0;
        long long nextToGet = 1; // avoid overflow 
        long long liftN = n;
        while(nextToGet <= liftN)
        {
            if(pos < sz && nextToGet >= nums[pos])
            {
                // put to continues sequence
                nextToGet += nums[pos];
                ++pos;
            }
            else
            {
                // next num can't get from current given list
                // add it in greedy .
                nextToGet += nextToGet; // !! may be overflow .
                ++cnt;
            }
        }
        return cnt;
    }
};
```

