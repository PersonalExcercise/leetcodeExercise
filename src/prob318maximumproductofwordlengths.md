# problem 318. Maximum Product of Word Lengths

[题目链接](https://leetcode.com/problems/maximum-product-of-word-lengths/)

## 方法

拿到题分析了一下，觉得复杂度应该就是`O(n^2)`, 看了题解，想不到确实如此啊。

然后，题目的优化就在于单词的表示了——自己的确没有想到啊，之前值想到26个vector来表示了。这里用bit位来表示，一则大大节省空间，二则大大提高`交`运算的速度。

还是非常巧妙的。

## 代码

```C++
class Solution {
public:
    int maxProduct(vector<string>& words) {
        int nrWords = words.size();
        vector<unsigned> bitRepresentList(nrWords, 0);
        
        // build bit represents
        for(int i = 0; i < nrWords; ++i)
        {
            const string &word = words[i];
            for( const auto &c : word){ bitRepresentList[i] |= 1 << (c-'a'); }
        }
        // calculate
        int maxProductVal = 0;
        for(int i = 0; i < nrWords - 1; ++i)
        {
            for(int j = i + 1; j < nrWords; ++j)
            {
                if((bitRepresentList[i] & bitRepresentList[j]) == 0)
                {
                    maxProductVal = max(maxProductVal, static_cast<int>(words[i].size() * words[j].size()) );
                }
            }
        }
        return maxProductVal;
    }
};
```

## 后记

首先，尝试过使用bitset, 结果耗时是376ms。上述位操作耗时是128ms。虽然在这种级别比较时间意义不大，不过基于类封装的bitset还是不如内置的操作啊。

其次，一定要记得 `&`的优先级啊！！！比`==`都要低，所以一定要加`()`.